-- Qual o dia com maior engajamento de cada aluno que iniciou o curso no dia 01?

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