-- Quais clientes mais perderam pontos por Lover?
SELECT t3.idCliente,
    SUM(t1.vlProduto) AS pontosPerdidos,
    t2.DescCategoriaProduto
FROM transacao_produto AS t1
LEFT JOIN produtos AS t2 ON t1.IdProduto = t2.IdProduto
LEFT JOIN transacoes AS t3 ON t1.IdTransacao = t3.IdTransacao
WHERE t2.DescCategoriaProduto = 'lovers' AND t1.vlProduto < 0
GROUP BY t3.idCliente
ORDER BY pontosPerdidos
LIMIT 5;


-- Quais clientes assinaram a lista de presença no dia 25 de agosto de 2025
SELECT t1.idCliente FROM transacoes AS t1
LEFT JOIN transacao_produto AS t2 ON t1.IdTransacao = t2.IdTransacao
LEFT JOIN produtos AS t3 ON t2.IdProduto = t3.IdProduto
WHERE t1.DtCriacao > '2025-08-24' AND t1.DtCriacao < '2025-08-26' AND t3.DescNomeProduto = 'Lista de presença'
GROUP BY t1.idCliente
LIMIT 10;


-- Do início ao fim do nosso curso (25/ago/2025 a 29/ago/2025), quantos clientes assinaram a lista de presença?
SELECT COUNT(DISTINCT t1.IdCliente) AS qtdePresencas
FROM transacoes AS t1
LEFT JOIN transacao_produto AS t2 ON t1.IdTransacao = t2.IdTransacao
LEFT JOIN produtos AS t3 ON t2.IdProduto = t3.IdProduto
LEFT JOIN clientes AS t4 ON t1.IdCliente = t4.idCliente
WHERE t1.DtCriacao >= '2025-08-25' AND t1.DtCriacao < '2025-08-30' AND t3.DescNomeProduto = 'Lista de presença';

