SELECT t1.*, t2.DescDescricaoProduto FROM transacao_produto AS t1
INNER JOIN produtos AS t2 ON t1.IdProduto = t2.IdProduto
LIMIT 10;

-- Qual categoria tem mais produtos vendidos
SELECT t2.DescCategoriaProduto,
    COUNT(DISTINCT t1.IdTransacao) AS qtdeVendas
FROM transacao_produto AS t1
LEFT JOIN produtos AS t2 ON t1.IdProduto = t2.IdProduto
GROUP BY t2.DescCategoriaProduto
ORDER BY qtdeVendas DESC
LIMIT 1;


-- Em 2024, quantas transações de Lovers tivemos?
SELECT t3.DescCategoriaProduto,
    COUNT(DISTINCT t2.IdTransacao) AS qtdeVendas
FROM transacoes AS t1
LEFT JOIN transacao_produto AS t2 ON t1.IdTransacao = t2.IdTransacao
LEFT JOIN produtos AS t3 ON t2.IdProduto = t3.IdProduto
WHERE t1.DtCriacao >= '2024-01-01' AND t1.DtCriacao < '2025-01-01' and t3.DescCategoriaProduto = 'lovers';


-- Qual mês tivemos mais lista de presença assinada?
SELECT 
    substr(t1.DtCriacao, 1, 7) AS mesAno,
    count(DISTINCT t1.IdTransacao) AS qtdeTransacao
FROM transacoes AS t1
LEFT JOIN transacao_produto AS t2 ON t1.IdTransacao = t2.IdTransacao
LEFT JOIN produtos AS t3 ON t2.IdProduto = t3.IdProduto
WHERE t3.DescNomeProduto = 'Lista de presença'
GROUP BY mesAno
ORDER BY qtdeTransacao DESC
LIMIT 1;


-- Qual o total de pontos trocados no Stream Elements em Junho 2025?
SELECT SUM(t1.QtdePontos)
FROM transacoes AS t1
LEFT JOIN transacao_produto AS t2 ON t1.IdTransacao = t2.IdTransacao
LEFT JOIN produtos AS t3 ON t2.IdProduto = t3.IdProduto
WHERE DtCriacao >= '2025-06-01' AND DtCriacao < '2025-07-01' AND t3.DescCategoriaProduto = 'streamelements';