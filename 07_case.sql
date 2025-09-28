SELECT qtdePontos, idCliente
    CASE
        WHEN qtdePontos <= 500 THEN 'Ponei'
    END
FROM clientes
ORDER BY qtdePontos DESC
