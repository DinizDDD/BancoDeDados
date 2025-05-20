-- criei o banco de dados
create database Livraria;

-- entrei dentro do banco de dados
use Livraria;

-- criei a tabela autores
create table autor(
    id_autor int PRIMARY KEY not null,
    nome varchar(255) not null,
    nacionalidade varchar(255) not null
);

-- criei a tabela livros
create table livro(
    id_livro int PRIMARY KEY not null,
    titulo varchar(255) not null,
    ano_publicacao int not null,
    id_autor int not null,
    FOREIGN KEY (id_autor) REFERENCES autor(id_autor),
    preco decimal not null
);

-- criei a tabela clientes
create table cliente(
    id_cliente int PRIMARY KEY not null,
    nome varchar(255) not null,
    email varchar(255) not null,
    cidade varchar(255) not null
);

-- creiei a tabela vendas
create table venda(
    id_venda int PRIMARY KEY not null,
    id_cliente int not null,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    id_livro int not null,
    FOREIGN KEY (id_livro) REFERENCES livro(id_livro),
    data_venda date not null,
    quantidade int not null
);