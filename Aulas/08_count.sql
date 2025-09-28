SELECT count(*) FROM clientes;
SELECT DISTINCT flTwitch, flEmail FROM clientes;
SELECT COUNT(DISTINCT DescNomeProduto) FROM produtos;

-- Contar valores distintos em um intervalo de tempo:
SELECT
    COUNT(*),
    COUNT(DISTINCT IdTransacao),
    COUNT(DISTINCT IdCliente)
FROM transacoes
WHERE DtCriacao >= '2025-07-01' AND DtCriacao < '2025-08-01'
ORDER BY DtCriacao DESC