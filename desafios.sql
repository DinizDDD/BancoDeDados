SELECT 
    a.nome AS autor,
    SUM(v.quantidade) AS total_livros_vendidos
FROM venda v
JOIN livro l ON v.id_livro = l.id_livro
JOIN autor a ON l.id_autor = a.id_autor
GROUP BY a.nome
ORDER BY total_livros_vendidos DESC;

SELECT 
    c.nome AS cliente,
    SUM(v.quantidade) AS total_comprado
FROM venda v
JOIN cliente c ON v.id_cliente = c.id_cliente
GROUP BY c.nome
HAVING SUM(v.quantidade) > 2
ORDER BY total_comprado DESC;

SELECT 
    l.titulo
FROM livro l
LEFT JOIN venda v ON l.id_livro = v.id_livro
WHERE v.id_venda IS NULL;
