SELECT * FROM  produtos WHERE DescCategoriaProduto = 'rpg' LIMIT 10;

-- Selecione todos os clientes com e-mail cadastrado:
SELECT * FROM clientes WHERE flEmail <> 0 LIMIT 11;

-- Selecione todas as transações de 50 pontos (exatos):
SELECT * FROM transacoes WHERE QtdePontos = 50 LIMIT 10;

-- Selecione todos os clientes com mais de 500 pontos:
SELECT idCliente, qtdePontos FROM clientes WHERE qtdePontos > 500 LIMIT 10;

-- Selecione produtos que contêm 'churn' no nome:
SELECT * FROM produtos WHERE DescNomeProduto LIKE 'Churn%';