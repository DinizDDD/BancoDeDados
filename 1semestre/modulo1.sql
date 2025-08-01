    -- Criação do banco de dados
    CREATE DATABASE Livraria;

    -- Seleção do banco de dados
    USE Livraria;

    -- Criação da tabela autor
    CREATE TABLE autor (
        id_autor INT PRIMARY KEY NOT NULL,
        nome VARCHAR(255) NOT NULL,
        nacionalidade VARCHAR(255) NOT NULL
    );

    -- Criação da tabela livro
    CREATE TABLE livro (
        id_livro INT PRIMARY KEY NOT NULL,
        titulo VARCHAR(255) NOT NULL,
        ano_publicacao INT NOT NULL,
        id_autor INT NOT NULL,
        preco DECIMAL(10,2) NOT NULL,
        FOREIGN KEY (id_autor) REFERENCES autor(id_autor)
    );

    -- Criação da tabela cliente
    CREATE TABLE cliente (
        id_cliente INT PRIMARY KEY NOT NULL,
        nome VARCHAR(255) NOT NULL,
        email VARCHAR(255) NOT NULL,
        cidade VARCHAR(255) NOT NULL
    );

    -- Criação da tabela venda
    CREATE TABLE venda (
        id_venda INT PRIMARY KEY NOT NULL,
        id_cliente INT NOT NULL,
        id_livro INT NOT NULL,
        data_venda DATE NOT NULL,
        quantidade INT NOT NULL,
        FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
        FOREIGN KEY (id_livro) REFERENCES livro(id_livro)
    );