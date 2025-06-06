-- Livros publicados após 2015
SELECT * FROM livro WHERE ano_publicacao > 2015;

-- Autores brasileiros
SELECT * FROM autor WHERE nacionalidade = 'Brasil';

-- Clientes cuja cidade começa com "S" (nenhum resultado esperado nesse caso)
SELECT * FROM cliente WHERE cidade LIKE 'S%';

-- Livros com preço entre 30.00 e 50.00
SELECT * FROM livro WHERE preco BETWEEN 30.00 AND 50.00;