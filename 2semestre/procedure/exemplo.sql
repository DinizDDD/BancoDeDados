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

--> criação da tabela 'locais'

CREATE TABLE locais (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome_cliente VARCHAR(100),
    cidade VARCHAR(50),
    estado VARCHAR(50),
    regiao VARCHAR(50)
);

--> criação de procedimento armazenando dos dados.

DELIMITER $$

CREATE PROCEDURE inserir_local(
    IN p_nome_cliente VARCHAR(50),
    IN p_cidade VARCHAR(50),
    IN p_estado VARCHAR(50),
    IN p_regiao VARCHAR(50)
);
BEGIN
    INSERT locais (nome_cliente, cidade, estado, regiao) VALUES 
    (p_nome_cliente, p_cidade, p_estado, p_regiao);
END $$

DELIMITER ; 

--> exemplo de chamada do procedimento

CALL inserir_local('Maria Silva', 'São Paulo', 'SP', 'Sudeste');

CALL inserir_local('João Silva', 'Rio de Janeiro', 'RJ', 'Sudeste');

CALL inserir_local('Maria Pereira', 'São Paulo', 'SP', 'Sudeste');

CALL inserir_local('Carlos Souza', 'Rio de Janeiro', 'RJ' 'Sudeste');

CALL inserir_local('Ana Lima', 'Belo Horizonte', 'MG' 'Sudeste');

CALL inserir_local('Pedro Rocha', 'São Paulo', 'SP' 'Sudeste');

CALL inserir_local('Luciana Alves', 'Rio de Janeiro', 'SP' 'Sudeste');

--> consulta para verificar dados inseridos

SELECT * FROM locais;

DELIMITER $$

CREATE PROCEDURE SelecionaClientesPorCidade(IN p_cidade VARCHAR(50))
BEGIN
    SELECT *
    FROM locais
    WHERE cidade = p_cidade;
END $$

DELIMITER ;

CALL SelecionaClientesPorCidade('São Paulo')

-- 5 Criar procedimento ContaClientes

DELIMITER $$

CREATE PROCEDURE ContaClientesPorCidade(
	IN p_cidade VARCHAR(50)
	OUT total INT
)
BEGIN
	SELECT COUNT(8) INTO total
	FROM locais
	WHERE cidade = p_cidade;
END $$

DELIMITER ;

-- Exemplo de chamada do procedimento

CALL ContaClientesPorCidade ('Rio de Janeiro', @qtd);
SELECT @qtd;

-- 6 Exemplo IF: Verificar em que região está uma cidade.

DELIMITER $$

CREATE PROCEDURE verificar_regiao(
    IN p_cidade VARCHAR(50),
    OUT mensagem VARCHAR(100)
)
BEGIN
    DECLARE reg VARCHAR(50);

    SELECT regiao INTO reg FROM locais WHERE cidade = p_cidade LIMIT 1;

    IF reg IS NULL THEN
        SET mensagem = 'Cidade não encontrada';
    ELSEIF reg = 'Sudeste' THEN
        SET mensagem = CONTAT('A cidade ', p_cidade, ' está na região Sudeste.');
    ELSE
        SET mensagem = CONTAT('A cidade ', p_cidade, ' está em outra região.');
    END IF;
END $$

DELIMITER ;

-- Chamada para Verificar_regiao.

CALL verificar_regiao('São Paulo', @msg);
SELECT @msg;

DELIMITER $$

CREATE PROCEDURE contar_locais_regiao(
    IN p_regiao VARCHAR(50),
    OUT total INT
)
BEGIN
    DECLARE contador INT DEFAULT 0;
    DECLARE atual INT DEFAULT 0;

    SELECT COUNT(*) INTO total FROM locais WHERE regiao = p_regiao;

    SET contador = total;
    SET atual = 0;

    WHILE atual < contador DO
        SET atual = atual + 1;
    END WHILE;
END $$

DELIMITER ;

CALL contar_locais_regiao('Sudeste', @total);
SELECT @total;