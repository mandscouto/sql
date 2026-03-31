-- Lista de transações com o produto "Resgatar Ponei";

SELECT *
FROM transacao_produto AS t1
WHERE t1.IdProduto IN (
    SELECT IdProduto
    FROM produtos
    WHERE DescNomeProduto = "Resgatar Ponei"
)
LIMIT 10;


-- Dos clientes que começaram SQL no primeiro dia, quantos chegaram ao quinto dia?

SELECT COUNT(DISTINCT idCliente)
FROM transacoes AS t1


WHERE t1.idCliente IN (
    SELECT DISTINCT IdCliente
    FROM transacoes
    WHERE substr(DtCriacao,1,10) = '2025-08-25'
)
AND substr(t1.DtCriacao,1,10) = '2025-08-29';