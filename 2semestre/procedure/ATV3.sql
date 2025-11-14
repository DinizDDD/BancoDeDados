DROP DATABASE SistemaHospitalar;

CREATE DATABASE SistemaHospitalar;

USE SistemaHospitalar;

CREATE TABLE Especialidade (
    IdEspecialidade INT IDENTITY(1,1) PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL
);

CREATE TABLE Medico (
    IdMedico INT IDENTITY(1,1) PRIMARY KEY,
    Nome VARCHAR(150) NOT NULL,
    IdEspecialidade INT NOT NULL,
    CONSTRAINT FK_Medico_Especialidade FOREIGN KEY (IdEspecialidade) REFERENCES Especialidade(IdEspecialidade)
);

CREATE TABLE Paciente (
    IdPaciente INT IDENTITY(1,1) PRIMARY KEY,
    Nome VARCHAR(150) NOT NULL,
    DataNascimento DATE NULL
);

CREATE TABLE Atendimento (
    IdAtendimento INT IDENTITY(1,1) PRIMARY KEY,
    IdMedico INT NOT NULL,
    IdPaciente INT NOT NULL,
    DataAtendimento DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Atendimento_Medico FOREIGN KEY (IdMedico) REFERENCES Medico(IdMedico),
    CONSTRAINT FK_Atendimento_Paciente FOREIGN KEY (IdPaciente) REFERENCES Paciente(IdPaciente)
);

INSERT INTO Especialidade (Nome) VALUES
('Cardiologia'), ('Pediatria'), ('Dermatologia');

INSERT INTO Medico (Nome, IdEspecialidade) VALUES
('Dr. Marcos Silva', 1),
('Dra. Ana Costa', 1),
('Dr. João Pereira', 2);

INSERT INTO Paciente (Nome, DataNascimento) VALUES
('Carlos Almeida', '1990-05-18'),
('Maria Fernanda', '2010-09-22'),
('João Lucas', '1985-03-12');

INSERT INTO Atendimento (IdMedico, IdPaciente, DataAtendimento) VALUES
(1, 1, '2025-01-10'),
(1, 2, '2025-01-11'),
(2, 3, '2025-01-12'),
(3, 2, '2025-02-01');

DELIMITER $$

CREATE PROCEDURE Proc_AtendimentosPorEspecialidade(IN especialidadeNome VARCHAR(100))
BEGIN
    SELECT 
        e.Nome AS Especialidade,
        m.IdMedico,
        m.Nome AS Medico,
        p.IdPaciente,
        p.Nome AS Paciente,
        a.DataAtendimento
    FROM Atendimento a
    INNER JOIN Medico m ON a.IdMedico = m.IdMedico
    INNER JOIN Especialidade e ON m.IdEspecialidade = e.IdEspecialidade
    INNER JOIN Paciente p ON a.IdPaciente = p.IdPaciente
    WHERE e.Nome = especialidadeNome
    ORDER BY a.DataAtendimento DESC;
END $$

DELIMITER ;



