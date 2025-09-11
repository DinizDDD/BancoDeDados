CREATE VIEW Equipe_Atendimento AS
SELECT
    e.codigo AS codigo_especialidade,
    e.nome AS nome_especialidade,
    m.nome AS nome_medico,
    m.email AS email_medico,
    a.codigo AS codigo_atendimento,
    a.nome_paciente,
    a.data_atendimento
FROM Atendimentos a
JOIN Medicos m ON a.codigo_medico = m.codigo
JOIN Especialidades e ON m.codigo_especialidade = e.codigo;
