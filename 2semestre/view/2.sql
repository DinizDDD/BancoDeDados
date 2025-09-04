CREATE TABLE Fornecedor (
    codigo_fornecedor INT PRIMARY KEY,
    nome_fornecedor VARCHAR(100) NOT NULL,
    telefone VARCHAR(15),
    endereco VARCHAR(200)
);

CREATE TABLE Compra (
    codigo_compra INT PRIMARY KEY,
    codigo_fornecedor INT,
    cpf_funcionario VARCHAR(11),
    data_compra DATE NOT NULL,
    valor_total DECIMAL(10,2),
    FOREIGN KEY (codigo_fornecedor) REFERENCES Fornecedor(codigo_fornecedor),
    FOREIGN KEY (cpf_funcionario) REFERENCES Funcionario(cpf)
);

CREATE TABLE Compra_Livro (
    codigo_compra INT,
    codigo_livro INT,
    quantidade INT NOT NULL,
    PRIMARY KEY (codigo_compra, codigo_livro),
    FOREIGN KEY (codigo_compra) REFERENCES Compra(codigo_compra),
    FOREIGN KEY (codigo_livro) REFERENCES Livro(codigo_livro)
);

INSERT INTO Fornecedor (codigo_fornecedor, nome_fornecedor, telefone, endereco) VALUES
(1, 'Editora Alfa', '11988887777', 'Rua das Letras, 100'),
(2, 'Livraria Beta Distribuidora', '11977776666', 'Av. dos Livros, 200');

INSERT INTO Compra (codigo_compra, codigo_fornecedor, cpf_funcionario, data_compra, valor_total) VALUES
(1, 1, '12345678901', '2024-04-10', 350.00),
(2, 2, '23456789012', '2024-04-12', 500.00);

INSERT INTO Compra_Livro (codigo_compra, codigo_livro, quantidade) VALUES
(1, 1, 5),  -- 5 exemplares de "Duna"
(1, 3, 3),  -- 3 exemplares de "SQL para Iniciantes"
(2, 2, 4),  -- 4 exemplares de "Orgulho e Preconceito"
(2, 4, 2);  -- 2 exemplares de "Steve Jobs: A Biografia"

CREATE VIEW Relatorio_Compras_Livros AS
SELECT 
    f.nome_fornecedor AS fornecedor,
    func.nome AS funcionario,
    c.codigo_compra,
    l.titulo AS titulo_livro,
    cl.quantidade,
    c.valor_total,
    c.data_compra
FROM Compra c
INNER JOIN Fornecedor f ON c.codigo_fornecedor = f.codigo_fornecedor
INNER JOIN Funcionario func ON c.cpf_funcionario = func.cpf
INNER JOIN Compra_Livro cl ON c.codigo_compra = cl.codigo_compra
INNER JOIN Livro l ON cl.codigo_livro = l.codigo_livro;

SELECT * FROM Relatorio_Compras_Livros;

SELECT * FROM Relatorio_Compras_Livros
WHERE valor_total > 400;
