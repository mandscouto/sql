-- Qual o dia com maior engajamento de cada aluno que iniciou o curso no dia 01?
WITH tb_primeiro_dia AS (
    SELECT DISTINCT idCliente
    FROM transacoes
    WHERE substr(DtCriacao,1,10) = '2025-08-25'
),

tb_dias_curso AS (
    SELECT DISTINCT idCliente, substr(DtCriacao,1,10) AS diasCurso, IdTransacao
    FROM transacoes
    WHERE substr(DtCriacao,1,10) >= '2025-08-25'
    AND substr(DtCriacao, 1, 10) < '2025-08-30'
    ORDER by IdTransacao
),

tb_join AS (
    SELECT count(DISTINCT t2.IdTransacao) AS contagemTransacoes, t2.diasCurso, t1.idCliente
    FROM tb_primeiro_dia AS t1
    INNER JOIN tb_dias_curso AS t2
    ON t1.idCliente = t2.idCliente
    GROUP by t1.idCliente
)


SELECT *
FROM tb_join
GROUP by idCliente;


-- Dentre os clientes de janeiro/2025, quantos assistiram o curso de SQL?

WITH tb_clientes_janeiro AS (
    SELECT idCliente
    FROM clientes
    WHERE substr(DtCriacao,1,10) >= '2025-01-01'
    AND substr(DtCriacao,1,10) < '2025-02-01'
),

tb_clientes_sql AS (
    SELECT idCliente
    FROM transacoes
    WHERE substr(DtCriacao,1,10) >= '2025-08-25'
    AND substr(DtCriacao,1,10) < '2025-08-30'
),

tb_join AS (
    SELECT DISTINCT t1.idCliente
    FROM tb_clientes_janeiro AS t1
    INNER JOIN tb_clientes_sql AS t2
    ON t1.idCliente = t2.idCliente
)

SELECT count(*) as contagemClientes from tb_join;