-- Lista de transações com apenas um ponto
SELECT IdTransacao, QtdePontos FROM transacoes WHERE QtdePontos = 1;

-- Lista de pedidos realizados no fim de semana

SELECT IdTransacao,
        DtCriacao,
        datetime(DtCriacao) AS dt_DataCriacao,
        strftime('%w', datetime(DtCriacao)) AS diaSemana
FROM transacoes
WHERE diaSemana IN ('6','0');

-- Lista de clientes com zero pontos
SELECT idCliente, qtdePontos FROM clientes WHERE qtdePontos = 0;

-- Lista de clientes com 100 a 200 pontos (inclusive ambos)
SELECT idCliente, qtdePontos FROM clientes 
WHERE qtdePontos >= 100 AND qtdePontos <= 200;
-- WHERE qtdePontos BETWEEN 100 AND 200

-- Lista de produtos com nome que começa com "Venda de"
SELECT * FROM produtos WHERE DescNomeProduto LIKE 'Venda de%';

-- Lista de produtos com nome que termina com "Lover"
SELECT * FROM produtos WHERE DescNomeProduto LIKE '%Lover';

-- Lista de produtos que são "chapéu"
SELECT * FROM produtos WHERE DescNomeProduto LIKE '%chapéu%';

-- Lista de transações com o produto "Resgatar Ponei"
SELECT * FROM transacao_produto WHERE IdProduto = 15;

/* Listar todas as transações adicionando uma coluna nova
sinalizando "alto", "médio" e "baixo" para o valor dos pontos [<10; <500; >=500] */
SELECT IdTransacao, QtdePontos,
        CASE
            WHEN QtdePontos < 10 THEN 'Baixo'
            WHEN QtdePontos < 500 THEN 'Médio'
            ELSE 'Alto'
        END AS nivelPontos
FROM transacoes;