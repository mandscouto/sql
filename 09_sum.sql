SELECT sum(QtdePontos),
    sum(CASE 
        WHEN QtdePontos > 0 THEN QtdePontos
    END) AS qtdePontosPos,
    sum(CASE 
        WHEN QtdePontos < 0 THEN QtdePontos
    END) AS qtdePontosNeg
FROM transacoes
WHERE DtCriacao >= '2025-07-01'
AND DtCriacao < '2025-08-01'
