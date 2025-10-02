-- Criar banco de dados 

CREATE DATABASE IF NOT EXISTS Autenticacao;

use Autenticacao;

-- Tabela usuarios

CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    usuario VARCHAR(50),
    senha  VARCHAR(100)
);

-- Stored Procedure autenticação
-- Parâmetros de entrada: p_usuario e p_senha (dados digitados).
-- Parâmetros de saída> p_autenticado, que será 1 e se combinação existir ou o se não existir

DELIMITER $$

CREATE PROCEDURE autentica_usuario (
    IN p_usuario VARCHAR(50),
    IN p_senha VARCHAR(100),
    OUT usuario = p_autenticado INT
)
BEGIN
    SELECT COUNT(*) INTO p_autenticado
    FROM usuarios
    WHERE usuario = p_usuario AND senha = p_senha;
END $$

DELIMITER ;

-- inserir dados de teste

CALL autentica_usuario('exemplo', 'minhasenha', @resultado);

SELECT @resultado;

INSERT INTO usuarios (nome, usuario, senha)
VALUES ('Maria Oliveira', 'mariao', 'senha@2025');

INSERT INTO usuarios (nome, usuario, senha)
VALUES ('João Silva', 'joaos', '123456');

CALL autentica_usuario('mariao', 'senha@2025', @resultado);

SELECT @resultado;