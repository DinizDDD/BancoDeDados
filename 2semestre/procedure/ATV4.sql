DROP DATABASE IF EXISTS SistemaVendasOnline;
CREATE DATABASE SistemaVendasOnline;
USE SistemaVendasOnline;

CREATE TABLE Cliente (
    IdCliente INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(150) NOT NULL,
    Email VARCHAR(150)
);

CREATE TABLE Vendedor (
    IdVendedor INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(150) NOT NULL
);

CREATE TABLE Categoria (
    IdCategoria INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL
);

CREATE TABLE Produto (
    IdProduto INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(150) NOT NULL,
    Preco DECIMAL(10,2) NOT NULL,
    IdCategoria INT NOT NULL,
    FOREIGN KEY (IdCategoria) REFERENCES Categoria(IdCategoria)
);

CREATE TABLE Pedido (
    IdPedido INT AUTO_INCREMENT PRIMARY KEY,
    IdCliente INT NOT NULL,
    IdVendedor INT NOT NULL,
    DataPedido DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (IdCliente) REFERENCES Cliente(IdCliente),
    FOREIGN KEY (IdVendedor) REFERENCES Vendedor(IdVendedor)
);

CREATE TABLE ItemPedido (
    IdItem INT AUTO_INCREMENT PRIMARY KEY,
    IdPedido INT NOT NULL,
    IdProduto INT NOT NULL,
    Quantidade INT NOT NULL,
    ValorUnitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (IdPedido) REFERENCES Pedido(IdPedido),
    FOREIGN KEY (IdProduto) REFERENCES Produto(IdProduto)
);

INSERT INTO Categoria (Nome) VALUES
('Eletrônicos'),
('Roupas'),
('Livros'),
('Acessórios'),
('Móveis');

INSERT INTO Produto (Nome, Preco, IdCategoria) VALUES
('Smartphone X10', 2500.00, 1),
('Notebook Pro 15', 5400.00, 1),
('Tablet Maxi', 1200.00, 1),
('Mouse Óptico Pro', 79.90, 1),
('Camiseta Algodão', 49.90, 2),
('Jaqueta Jeans', 159.90, 2),
('Calça Sarja Masculina', 129.90, 2),
('Romance - A Casa do Lago', 38.50, 3),
('Programação Avançada em Python', 89.90, 3),
('Fone Bluetooth', 129.90, 4),
('Relógio Digital', 199.90, 4),
('Carteira de Couro', 89.90, 4),
('Cadeira Gamer', 850.00, 5),
('Mesa Escritório', 650.00, 5),
('Criado-Mudo Madeira', 290.00, 5);

INSERT INTO Cliente (Nome, Email) VALUES
('Ana Pereira', 'ana.pereira@email.com'),
('João Silva', 'joao.silva@email.com'),
('Carla Mendes', 'carla.mendes@email.com'),
('Bruno Castro', 'bruno.castro@email.com');

INSERT INTO Vendedor (Nome) VALUES
('Marcos Andrade'),
('Fernanda Souza'),
('Lucas Oliveira');

INSERT INTO Pedido (IdCliente, IdVendedor, DataPedido) VALUES
(1, 1, '2025-01-10 14:30:00'),
(2, 2, '2025-01-15 10:45:00'),
(3, 1, '2025-02-05 09:20:00'),
(1, 3, '2025-02-20 16:50:00'),
(4, 2, '2025-03-01 11:00:00'),
(2, 1, '2025-03-10 13:00:00'),
(3, 3, '2025-03-15 15:20:00');

INSERT INTO ItemPedido (IdPedido, IdProduto, Quantidade, ValorUnitario) VALUES
(1, 1, 1, 2500.00),
(1, 4, 2, 79.90),
(2, 5, 2, 49.90),
(2, 6, 1, 159.90),
(2, 10, 1, 129.90),
(3, 2, 1, 5400.00),
(3, 8, 1, 38.50),
(3, 9, 1, 89.90),
(4, 13, 1, 850.00),
(4, 11, 1, 199.90),
(4, 12, 1, 89.90),
(5, 14, 1, 650.00),
(5, 15, 1, 290.00),
(6, 9, 1, 89.90),
(6, 3, 1, 1200.00),
(7, 5, 1, 49.90),
(7, 7, 1, 129.90);

DELIMITER $$

CREATE PROCEDURE Relatorio_Pedidos_Por_Periodo (
    IN DataInicio DATETIME,
    IN DataFim DATETIME
)
BEGIN
    SELECT 
        P.IdPedido,
        P.DataPedido,
        C.Nome AS NomeCliente,
        V.Nome AS NomeVendedor
    FROM Pedido P
        INNER JOIN Cliente C ON P.IdCliente = C.IdCliente
        INNER JOIN Vendedor V ON P.IdVendedor = V.IdVendedor
    WHERE P.DataPedido BETWEEN DataInicio AND DataFim
    ORDER BY P.DataPedido;
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE Relatorio_Produtos_Por_Categoria (
    IN CategoriaId INT
)
BEGIN
    SELECT 
        P.IdProduto,
        P.Nome AS Produto,
        P.Preco,
        C.Nome AS Categoria
    FROM Produto P
        INNER JOIN Categoria C ON P.IdCategoria = C.IdCategoria
    WHERE P.IdCategoria = CategoriaId;
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE Relatorio_Equipe_Projeto (
    IN PedidoId INT
)
BEGIN
    SELECT 
        P.IdPedido,
        C.Nome AS Cliente,
        V.Nome AS Vendedor,
        P.DataPedido,
        SUM(I.Quantidade * I.ValorUnitario) AS ValorTotal
    FROM Pedido P
        INNER JOIN Cliente C ON P.IdCliente = C.IdCliente
        INNER JOIN Vendedor V ON P.IdVendedor = V.IdVendedor
        INNER JOIN ItemPedido I ON I.IdPedido = P.IdPedido
    WHERE P.IdPedido = PedidoId
    GROUP BY 
        P.IdPedido, C.Nome, V.Nome, P.DataPedido;
END $$

DELIMITER ;

CALL Relatorio_Pedidos_Por_Periodo('2025-01-01', '2025-12-31');
CALL Relatorio_Produtos_Por_Categoria(3);
CALL Relatorio_Equipe_Projeto(10);

