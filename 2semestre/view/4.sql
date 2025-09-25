CREATE VIEW Boletim_Pedidos AS
SELECT 
    p.cod_pedido,
    c.nome AS nome_cliente,
    p.data,
    p.valor_total,
    c.cidade
FROM Pedidos p
JOIN Clientes c ON p.cod_cliente = c.cod_cliente;

CREATE VIEW Produto_Categoria AS
SELECT 
    pr.nome AS nome_produto,
    cat.nome AS nome_categoria
FROM Produtos pr
JOIN Categorias cat ON pr.cod_categoria = cat.cod_categoria;

CREATE VIEW Vendedor_Pedido AS
SELECT 
    v.nome AS nome_vendedor,
    p.cod_pedido,
    c.nome AS nome_cliente,
    p.data
FROM Vendedores v
JOIN Pedidos p ON v.cod_vendedor = p.cod_vendedor
JOIN Clientes c ON p.cod_cliente = c.cod_cliente;

CREATE VIEW Cliente_MaiorCompra AS
SELECT 
    c.nome AS nome_cliente,
    p.data,
    p.valor_total
FROM Pedidos p
JOIN Clientes c ON p.cod_cliente = c.cod_cliente
WHERE p.valor_total > 5000;

CREATE VIEW Categoria_MaisVendida AS
SELECT 
    cat.nome AS nome_categoria,
    SUM(ip.quantidade) AS quantidade_total_vendida
FROM Itens_Pedido ip
JOIN Produtos pr ON ip.cod_produto = pr.cod_produto
JOIN Categorias cat ON pr.cod_categoria = cat.cod_categoria
GROUP BY cat.nome
ORDER BY quantidade_total_vendida DESC;
