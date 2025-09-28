-- Saldo de pontos total do sistema
SELECT SUM(QtdePontos) FROM transacoes;

-- Quantos pontos já foram subtraídos dos clientes?
SELECT SUM(CASE WHEN QtdePontos < 0 THEN QtdePontos END) FROM transacoes;

-- Quantos clientes tem twitch?
SELECT COUNT(IdCliente) FROM clientes WHERE flTwitch = 1;

-- Qual a média de saldo em carteira
SELECT idCliente, ROUND(AVG(qtdePontos), 2) FROM clientes;

-- Quantos clientes tem e-mail cadastrado?
SELECT COUNT(idCliente) FROM clientes WHERE flEmail = 1;

-- Qual cliente juntou mais pontos positivos em maio de 2025?
SELECT IdCliente,
        SUM(QtdePontos) AS pontosPositivos
FROM transacoes
WHERE DtCriacao >= '2025-05-01' AND DtCriacao < '2025-06-01' AND QtdePontos > 0
GROUP BY IdCliente
ORDER BY pontosPositivos DESC
LIMIT 1;

-- Qual cliente fez mais transações no ano de 2024?
SELECT IdCliente,
    count(*),
    count(DISTINCT IdTransacao)
FROM transacoes
WHERE DtCriacao >= '2024-01-01' AND DtCriacao < '2025-01-01'
GROUP BY IdCliente
ORDER BY count(*) DESC
LIMIT 1;

-- Quantos produtos são de rpg?
SELECT COUNT(IdProduto) FROM produtos WHERE DescCategoriaProduto = 'rpg';

-- Qual o valor médio de pontos positivos por dia?
SELECT sum(QtdePontos) AS totalPontos,
    count(DISTINCT date(DtCriacao)) AS qtdeDiasUnicos,
    sum(QtdePontos) / count(DISTINCT date(DtCriacao))
FROM transacoes
WHERE QtdePontos > 0;

-- Qual dia da semana tem mais pedidos em 2025?
SELECT strftime('%w', datetime(DtCriacao)) AS diaSemana,
    count(distinct IdTransacao) AS qtdeTransacao
FROM transacoes
WHERE substr(DtCriacao,1,4) = '2025'
GROUP BY 1
ORDER BY diaSemana;

-- Qual o produto mais transacionado?
SELECT IdProduto,
    COUNT(idTransacaoProduto) AS qtdeTransacoes
FROM transacao_produto
GROUP BY IdProduto
ORDER BY qtdeTransacoes DESC
LIMIT 1;

-- Qual o produto com mais pontos transacionados
SELECT IdProduto,
    SUM(vlProduto) AS valorProduto
FROM transacao_produto
GROUP BY IdProduto
ORDER BY valorProduto DESC
LIMIT 1;