-- Qual foi a taxa de retenção e a curva de Churn do curso de SQL?
WITH tb_d1 AS (
    SELECT DISTINCT idCliente
    FROM transacoes
    WHERE DtCriacao >= '2025-08-25'
    AND DtCriacao < '2025-08-26'
),

tb_join AS (
    SELECT
        substr(t2.DtCriacao,1,10) AS dataDia,
        count(DISTINCT t1.idCliente) AS qtdeClientes,
        1. * count(DISTINCT t1.idCliente) / (SELECT count(*) FROM tb_d1) AS retencao,
        1 - 1. * count(DISTINCT t1.idCliente) / (SELECT count(*) FROM tb_d1) AS churn
    FROM tb_d1 AS t1
    LEFT JOIN transacoes AS t2
    ON t1.idCliente = t2.idCliente
    WHERE t2.DtCriacao >= '2025-08-25'
    AND t2.DtCriacao < '2025-08-30'
    GROUP BY dataDia
)

SELECT * FROM tb_join;

-- Qual o dia com maior engajamento de cada aluno que iniciou o curso no dia 01?
WITH alunos_d1 AS (
    SELECT DISTINCT idCliente
    FROM transacoes
    WHERE substr(DtCriacao,1,10) = '2025-08-25'
),

tb_engajamento AS (
    SELECT t1.idCliente,
        substr(t2.DtCriacao,1,10) AS dataDia,
        count(*) AS qtdeInteracoes
    FROM alunos_d1 AS t1
    LEFT JOIN transacoes AS t2
    ON t1.idCliente = t2.idCliente
    AND t2.DtCriacao >= '2025-08-25'
    AND t2.DtCriacao < '2025-08-30'
    GROUP BY t1.idCliente, substr(t2.DtCriacao, 1,10)
    ORDER BY t1.idCliente, dataDia
),

max_inter AS (
    SELECT max(qtdeInteracoes) AS maxInter, idCliente
    FROM tb_engajamento
    GROUP by idCliente
),

tb_join AS (
    SELECT DISTINCT t1.idCliente, max(t2.dataDia) as maxDia, max(maxInter)
    FROM max_inter AS t1
    LEFT JOIN tb_engajamento AS t2
    ON t1.idCliente = t2.idCliente
    AND t1.maxInter = t2.qtdeInteracoes
    GROUP BY t1.idCliente
    ORDER BY t1.idCliente, t2.dataDia
),

tb_rn AS (
    SELECT *,
        row_number() OVER (PARTITION BY idCliente ORDER BY qtdeInteracoes) AS rn
    FROM tb_engajamento
)

SELECT * FROM tb_rn WHERE rn = 1;
-- Dentre os clientes de janeiro/2025, quantos assistiram o curso de SQL?

WITH tb_clientes_janeiro AS (
    SELECT idCliente
    FROM transacoes
    WHERE substr(DtCriacao,1,10) >= '2025-01-01'
    AND substr(DtCriacao,1,10) < '2025-02-01'
),

tb_clientes_sql AS (
    SELECT DISTINCT idCliente
    FROM transacoes
    WHERE DtCriacao >= '2025-08-25'
    AND DtCriacao < '2025-08-30'
),

tb_join AS (
    SELECT count(DISTINCT t1.idCliente) AS clientesJaneiro,
        count(DISTINCT t2.idCliente) AS clientesCurso
    FROM tb_clientes_janeiro AS t1
    LEFT JOIN tb_clientes_sql AS t2
    ON t1.idCliente = t2.idCliente
)

SELECT * from tb_join;