DROP DATABASE SistemaBiblioteca;
CREATE DATABASE SistemaBiblioteca;
USE SistemaBiblioteca;


CREATE TABLE Categoria (
    codigo_categoria INT PRIMARY KEY,
    descricao VARCHAR(100) NOT NULL
);


CREATE TABLE Funcionario (
    cpf VARCHAR(11) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    endereco VARCHAR(200),
    telefone VARCHAR(15),
    funcao VARCHAR(50)
);


CREATE TABLE Usuario (
    cpf VARCHAR(11) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(15),
    endereco VARCHAR(200)
);


CREATE TABLE Livro (
    codigo_livro INT PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    codigo_categoria INT,
    autor VARCHAR(100),
    FOREIGN KEY (codigo_categoria) REFERENCES Categoria(codigo_categoria)
);


CREATE TABLE Emprestimo (
    codigo_emprestimo INT PRIMARY KEY,
    cpf_usuario VARCHAR(11),
    cpf_funcionario VARCHAR(11),
    codigo_livro INT,
    data_retirada DATE NOT NULL,
    data_devolucao_prevista DATE NOT NULL,
    data_devolucao_efetiva DATE,
    FOREIGN KEY (cpf_usuario) REFERENCES Usuario(cpf),
    FOREIGN KEY (cpf_funcionario) REFERENCES Funcionario(cpf),
    FOREIGN KEY (codigo_livro) REFERENCES Livro(codigo_livro)
);


INSERT INTO Categoria (codigo_categoria, descricao) VALUES
(1, 'Ficção Científica'),
(2, 'Romance'),
(3, 'Técnico'),
(4, 'Biografia');

INSERT INTO Funcionario (cpf, nome, endereco, telefone, funcao) VALUES
('12345678901', 'João Silva', 'Rua A, 123', '11999998888', 'Atendente'),
('23456789012', 'Maria Santos', 'Rua B, 456', '11999997777', 'Bibliotecária');

INSERT INTO Usuario (cpf, nome, telefone, endereco) VALUES
('34567890123', 'Carlos Oliveira', '11999996666', 'Rua C, 789'),
('45678901234', 'Ana Costa', '11999995555', 'Rua D, 101');

INSERT INTO Livro (codigo_livro, titulo, codigo_categoria, autor) VALUES
(1, 'Duna', 1, 'Frank Herbert'),
(2, 'Orgulho e Preconceito', 2, 'Jane Austen'),
(3, 'SQL para Iniciantes', 3, 'João Developer'),
(4, 'Steve Jobs: A Biografia', 4, 'Walter Isaacson');

INSERT INTO Emprestimo (codigo_emprestimo, cpf_usuario, cpf_funcionario, codigo_livro, data_retirada, data_devolucao_prevista, data_devolucao_efetiva) VALUES
(1, '34567890123', '12345678901', 1, '2024-01-15', '2024-01-29', '2024-01-28'),
(2, '45678901234', '23456789012', 2, '2024-02-01', '2024-02-15', '2024-02-14'),
(3, '34567890123', '12345678901', 3, '2024-03-10', '2024-03-24', NULL),
(4, '45678901234', '23456789012', 4, '2024-03-15', '2024-03-29', '2024-03-30');


CREATE VIEW Historico_Emprestimos AS
SELECT 
    u.nome AS nome_usuario,
    l.titulo AS titulo_livro,
    c.descricao AS descricao_categoria,
    f.nome AS nome_funcionario,
    e.data_retirada,
    e.data_devolucao_prevista,
    e.data_devolucao_efetiva
FROM Emprestimo e
INNER JOIN Usuario u ON e.cpf_usuario = u.cpf
INNER JOIN Livro l ON e.codigo_livro = l.codigo_livro
INNER JOIN Categoria c ON l.codigo_categoria = c.codigo_categoria
INNER JOIN Funcionario f ON e.cpf_funcionario = f.cpf;


SELECT * FROM Historico_Emprestimos;


SELECT * FROM Historico_Emprestimos 
WHERE data_devolucao_efetiva IS NULL;


SELECT * FROM Historico_Emprestimos 
WHERE data_devolucao_efetiva > data_devolucao_prevista 
OR (data_devolucao_efetiva IS NULL AND CURDATE() > data_devolucao_prevista);