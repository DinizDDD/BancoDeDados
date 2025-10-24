CREATE DATABASE BibliotecaDB;
USE BibliotecaDB;

CREATE TABLE Usuarios (
    UsuarioID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Email VARCHAR(100),
    Telefone VARCHAR(20)
);

CREATE TABLE Funcionarios (
    FuncionarioID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Cargo VARCHAR(50)
);

CREATE TABLE Fornecedores (
    FornecedorID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    CNPJ VARCHAR(20),
    Contato VARCHAR(100)
);

CREATE TABLE Livros (
    LivroID INT AUTO_INCREMENT PRIMARY KEY,
    Titulo VARCHAR(150) NOT NULL,
    Autor VARCHAR(100),
    AnoPublicacao INT,
    FornecedorID INT,
    FOREIGN KEY (FornecedorID) REFERENCES Fornecedores(FornecedorID)
);

CREATE TABLE Emprestimos (
    EmprestimoID INT AUTO_INCREMENT PRIMARY KEY,
    UsuarioID INT,
    LivroID INT,
    DataEmprestimo DATE,
    DataDevolucaoPrevista DATE,
    DataDevolucaoReal DATE,
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID),
    FOREIGN KEY (LivroID) REFERENCES Livros(LivroID)
);

CREATE TABLE Compras (
    CompraID INT AUTO_INCREMENT PRIMARY KEY,
    FornecedorID INT,
    FuncionarioID INT,
    DataCompra DATE,
    ValorTotal DECIMAL(10,2),
    FOREIGN KEY (FornecedorID) REFERENCES Fornecedores(FornecedorID),
    FOREIGN KEY (FuncionarioID) REFERENCES Funcionarios(FuncionarioID)
);

CREATE TABLE ItensCompra (
    ItemID INT AUTO_INCREMENT PRIMARY KEY,
    CompraID INT,
    LivroID INT,
    Quantidade INT,
    PrecoUnitario DECIMAL(10,2),
    FOREIGN KEY (CompraID) REFERENCES Compras(CompraID),
    FOREIGN KEY (LivroID) REFERENCES Livros(LivroID)
);

DELIMITER //

CREATE PROCEDURE Proc_UsuariosComEmprestimosAtrasados()
BEGIN
    SELECT DISTINCT 
        u.UsuarioID,
        u.Nome AS NomeUsuario,
        u.Email,
        e.LivroID,
        l.Titulo AS Livro,
        e.DataEmprestimo,
        e.DataDevolucaoPrevista
    FROM Emprestimos e
    INNER JOIN Usuarios u ON e.UsuarioID = u.UsuarioID
    INNER JOIN Livros l ON e.LivroID = l.LivroID
    WHERE e.DataDevolucaoReal IS NULL 
      AND e.DataDevolucaoPrevista < CURDATE()
    ORDER BY e.DataDevolucaoPrevista;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE Proc_ComprasPorFornecedor(IN pFornecedorID INT)
BEGIN
    SELECT 
        c.CompraID,
        f.Nome AS NomeFornecedor,
        func.Nome AS FuncionarioResponsavel,
        c.DataCompra,
        c.ValorTotal,
        l.Titulo AS Livro,
        ic.Quantidade,
        ic.PrecoUnitario
    FROM Compras c
    INNER JOIN Fornecedores f ON c.FornecedorID = f.FornecedorID
    INNER JOIN Funcionarios func ON c.FuncionarioID = func.FuncionarioID
    INNER JOIN ItensCompra ic ON c.CompraID = ic.CompraID
    INNER JOIN Livros l ON ic.LivroID = l.LivroID
    WHERE c.FornecedorID = pFornecedorID
    ORDER BY c.DataCompra DESC;
END //

DELIMITER ;

CALL Proc_UsuariosComEmprestimosAtrasados();

CALL Proc_ComprasPorFornecedor(1);
    