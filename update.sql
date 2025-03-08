-- Cria um novo usuário, médico.
INSERT INTO Usuario (Login, Senha, Tipo_Usuario)
VALUES ('roberto.dias@med.com', SHA2('mediconovo123', 256), 'Medico');

-- Cria um novo médico.
INSERT INTO Medico (Nome, CRM, Telefone, Email, ID_Usuario)
VALUES ('Dr. Roberto Dias', '6781212', '83888888888', 'roberto.dias@med.com', 22);

-- Associa o médico 6 à especialidade 3 (Ortopedia).
-- Associa o médico 6 à especialidade 1 (Cardiologia).
INSERT INTO Medico_Especialidade (ID_Medico, ID_Especialidade)
VALUES (6, 3);
INSERT INTO Medico_Especialidade (ID_Medico, ID_Especialidade) VALUES (6, 1);

-- Para excluir o paciente 1, primeiro remova as referências nas outras tabelas
-- Primeiro verifique e remova prontuários das consultas do paciente 1
DELETE FROM Prontuario 
WHERE ID_Consulta IN (SELECT ID_Consulta FROM Consulta WHERE ID_Paciente = 1);

-- Remove as consultas do paciente 1.
DELETE FROM Consulta WHERE ID_Paciente = 1;

-- Remove o paciente 1.
DELETE FROM Paciente WHERE ID_Paciente = 1;

-- Remove o usuário 1.
DELETE FROM Usuario WHERE ID_Usuario = 1;

-- Remove a associação entre médicos e a especialidade 5 (Ginecologia).
DELETE FROM Medico_Especialidade WHERE ID_Especialidade = 5;

-- Remove a especialidade 5.
DELETE FROM Especialidade WHERE ID_Especialidade = 5;

-- Remove o prontuário da consulta 4.
DELETE FROM Prontuario WHERE ID_Consulta = 4;

-- Remove a consulta 4.
DELETE FROM Consulta WHERE ID_Consulta = 4;

-- Atualiza o status da consulta 2 para 'Realizada'.
UPDATE Consulta
SET Status = 'Realizada'
WHERE ID_Consulta = 2;

-- Atualiza o telefone do médico com CRM 1234567.
UPDATE Medico
SET Telefone = '83999999999'
WHERE CRM = '1234567';

-- Atualiza o diagnóstico do prontuário da consulta 3 para 'Deslocamento anterior'.
UPDATE Prontuario
SET Diagnostico = 'Deslocamento anterior'
WHERE ID_Consulta = 3;

-- Atualiza o diagnóstico do prontuário com base no CRM do médico.
UPDATE Prontuario pr
JOIN Consulta c ON pr.ID_Consulta = c.ID_Consulta
JOIN Medico m ON m.ID_Medico = c.ID_Medico
SET pr.Diagnostico = CONCAT(pr.Diagnostico, ' - Consulta revisada pelo ', m.Nome)
WHERE m.CRM = '3456789';