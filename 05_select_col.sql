SELECT idCliente,
        -- qtdePontos + 10 AS QtdePontosPlus10
        DtCriacao,
        datetime(DtCriacao)

FROM clientes