SELECT * FROM livro ORDER BY preco DESC;

SELECT l.titulo, a.nome AS autor, 
    SUM(v.quantidade) AS total_vendas
FROM venda v
JOIN livro l ON v.id_livro = l.id_livro
JOIN autor a ON l.id_autor = a.id_autor
GROUP BY l.titulo, a.nome
ORDER BY total_vendas DESC;

SELECT a.nome AS autor, 
    AVG(l.preco) AS media_preco
FROM livro l
JOIN autor a ON l.id_autor = a.id_autor
GROUP BY a.nome 
ORDER BY media_preco DESC;

SELECT a.nome AS autor,
    COUNT(l.id_livro) AS quantidade_livros
FROM autor a
JOIN livro l ON a.id_autor = l.id_autor
GROUP BY a.nome
HAVING COUNT(l.id_livro) > 1
ORDER BY quantidade_livros DESC;