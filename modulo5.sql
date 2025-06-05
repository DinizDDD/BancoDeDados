SELECT 
    livro.titulo,
    autor.nome AS nome_autor
FROM livro
JOIN autor ON livro.id_autor = autor.id_autor;

SELECT 
    cliente.nome AS nome_cliente,
    livro.titulo AS titulo_livro,
    venda.data_venda
FROM venda
JOIN cliente ON venda.id_cliente = cliente.id_cliente
JOIN livro ON venda.id_livro = livro.id_livro;

SELECT DISTINCT 
    cliente.nome
FROM venda
JOIN cliente ON venda.id_cliente = cliente.id_cliente
JOIN livro ON venda.id_livro = livro.id_livro
JOIN autor ON livro.id_autor = autor.id_autor
WHERE autor.nacionalidade <> 'Brasil';




