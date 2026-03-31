-- CTE: COMMON TABLE EXPRESSION

-- SELECT count(DISTINCT idCliente)
-- FROM transacoes AS t1
-- WHERE t1.idCliente IN (
--     SELECT DISTINCT idCliente
--     FROM transacoes
--     WHERE substr(DtCriacao, 1, 10) = '2025-08-25'
-- )
-- AND substr(t1.DtCriacao, 1, 10) = '2025-08-29';

-- Clientes que fizeram transação no primeiro dia de curso
WITH tb_cliente_primeiro_dia AS (
    
    SELECT DISTINCT idCliente
    FROM transacoes
    where substr(DtCriacao, 1, 10) = '2025-08-25'
),

tb_cliente_ultimo_dia AS (
    SELECT DISTINCT idCliente
    FROM transacoes
    where substr(DtCriacao, 1, 10) = '2025-08-29'
),

tb_join AS (
    SELECT t1.idCliente AS primCliente,
            t2.idCliente AS ultCliente
    FROM tb_cliente_primeiro_dia AS t1
    LEFT JOIN tb_cliente_ultimo_dia AS t2
    ON t1.idCliente = t2.idCliente
)

SELECT count(DISTINCT primCliente), count(DISTINCT ultCliente),
       1. * count(ultCliente) / count(primCliente)
FROM tb_join;


-- Exemplo: Join + CTE - Quem iniciou o curso no primeiro dia, em média assistiu quantas aulas?
WITH tb_primeiro_dia AS (
    SELECT DISTINCT idCliente
    FROM transacoes
    WHERE substr(DtCriacao, 1, 10) = '2025-08-25'
),

tb_dias_curso AS (
    SELECT DISTINCT idCliente, substr(DtCriacao,1,10) AS presenteDia
    FROM transacoes
    WHERE substr(DtCriacao,1,10) >= '2025-08-25'
    AND substr(DtCriacao, 1, 10) < '2025-08-30'

    ORDER by idCliente, presenteDia
),

tb_cliente_dias AS (
    SELECT t1.idCliente, count(DISTINCT t2.presenteDia) as qtdeDias
    FROM tb_primeiro_dia AS t1
    LEFT JOIN tb_dias_curso AS t2
    ON t1.idCliente = t2.idCliente
    GROUP BY t1.idCliente
)

SELECT avg(qtdeDias) as mediaDias FROM tb_cliente_dias;