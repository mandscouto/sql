--SELECT IdProduto, count(*) FROM transacao_produto GROUP BY IdProduto;

SELECT IdCliente,
    sum(QtdePontos) AS pontos,
    count(IdTransacao) AS trancasoes
FROM transacoes
WHERE DtCriacao >= '2025-07-01' AND DtCriacao < '2025-08-01'
GROUP BY IdCliente

HAVING pontos >= 4000
ORDER BY pontos DESC;

-- Contar a quantidade de itens de cada categoria
SELECT DescCategoriaProduto,
    count(*)
FROM produtos
GROUP BY DescCategoriaProduto
ORDER BY count(*);