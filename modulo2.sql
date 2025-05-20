INSERT INTO autor (id_autor, nome, nacionalidade) VALUES
    (1,"Clarice Lispector", "Brasil"),
    (2,"Machado de Aasisis", "Brasil"),
    (3,"Carlos Dummond", "Brasil"),
    (4,"Willian Shakespeare", "Grã-Bretanha"),
    (5,"Maario Quintana", "Brasil");
 
INSERT INTO livro (id_livro,titulo, ano_publicacao, id_autor, preco) VALUES
    (1,"Atlas Mundial", 1910, 1, 4.00),
    (2,"Tomo Amplificador", 1950, 2, 4.00),
    (3,"Códice Demoniaco", 1990, 3, 8.50),
    (4,"Ladrão de Almas de Mejai", 2000, 4, 15.00),
    (5,"Morellonomicon", 2010, 5, 29.50),
    (6,"Vontade dos Antigos", 1940, 1, 23.00),
    (7,"Pox Arcana", 1930, 2, 30.00),
    (8,"Rito da Ruína", 1920, 3, 25.00);
 
INSERT INTO cliente (id_cliente,nome, email, cidade) VALUES
    (1,"Galio", "galiozin@gmail.com", "Demacia"),
    (2,"Aurora", "rorinha@gmail.com", "Freljord"),
    (3,"Diana", "didi@gmail.com", "Monte Targon"),
    (4,"Lillia", "lilizinha@gmail.com", "Ionia"),
    (5,"Nunu e Willup", "nuwillup@gmail.com", "Freljord");

INSERT INTO venda (id_venda, id_cliente, id_livro, data_venda, quantidade) VALUES
    (1, 1, 1, '2024-05-01', 2),
    (2, 2, 3, '2024-05-03', 1),
    (3, 3, 5, '2024-05-05', 1),
    (4, 4, 2, '2024-05-06', 3),
    (5, 5, 4, '2024-05-07', 1),
    (6, 1, 6, '2024-05-10', 1),
    (7, 2, 7, '2024-05-11', 2),
    (8, 3, 8, '2024-05-12', 1),
    (9, 4, 1, '2024-05-13', 1),
    (10, 5, 2, '2024-05-14', 2);

UPDATE livro SET preco = 5.00 WHERE id_livro = 2;

DELETE from cliente WHERE id_cliente = 4;