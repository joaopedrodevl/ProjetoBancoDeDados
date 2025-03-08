-- Lista médicos da especialidade 'Cardiologia'.
SELECT m.Nome AS Nome_Medico, e.Nome_Especialidade
FROM Medico m
JOIN Medico_Especialidade me ON m.ID_Medico = me.ID_Medico
JOIN Especialidade e ON me.ID_Especialidade = e.ID_Especialidade
WHERE e.Nome_Especialidade = 'Cardiologia';

-- Mostra pacientes com consultas agendadas.
SELECT p.Nome AS Nome_Paciente, c.Data_Hora, c.Status
FROM Paciente p
JOIN Consulta c ON p.ID_Paciente = c.ID_Paciente
WHERE c.Status = 'Agendada';

-- Calcula o total de consultas realizadas por médico.
SELECT m.Nome AS Nome_Medico, COUNT(c.ID_Consulta) AS Total_Consultas
FROM Medico m
LEFT JOIN Consulta c ON m.ID_Medico = c.ID_Medico
WHERE c.Status = 'Realizada'
GROUP BY m.Nome;

-- Identifica médicos com mais de 1 consultas realizadas.
SELECT m.Nome AS Nome_Medico, COUNT(c.ID_Consulta) AS Total_Consultas
FROM Medico m
JOIN Consulta c ON m.ID_Medico = c.ID_Medico
WHERE c.Status = 'Realizada'
GROUP BY m.Nome
HAVING COUNT(c.ID_Consulta) > 1;

-- Mostra pacientes sem consultas.
SELECT p.Nome AS Nome_Paciente
FROM Paciente p
LEFT JOIN Consulta c ON p.ID_Paciente = c.ID_Paciente
WHERE c.ID_Consulta IS NULL;

-- Identifica o médico com mais consultas canceladas.
SELECT m.Nome AS Nome_Medico, COUNT(c.ID_Consulta) AS Total_Canceladas
FROM Medico m
JOIN Consulta c ON m.ID_Medico = c.ID_Medico
WHERE c.Status = 'Cancelada'
GROUP BY m.Nome
ORDER BY Total_Canceladas DESC
LIMIT 1;

-- Identifica especialidade com mais consultas.
SELECT e.Nome_Especialidade, COUNT(c.ID_Consulta) AS Total_Consultas
FROM Especialidade e
JOIN Medico_Especialidade me ON e.ID_Especialidade = me.ID_Especialidade
JOIN Medico m ON me.ID_Medico = m.ID_Medico
JOIN Consulta c ON m.ID_Medico = c.ID_Medico
GROUP BY e.Nome_Especialidade
ORDER BY Total_Consultas DESC;

-- Lista os pacientes com consultas agendadas para Março de 2025.
SELECT p.Nome AS Nome_Paciente, c.Data_Hora
FROM Paciente p
JOIN Consulta c ON p.ID_Paciente = c.ID_Paciente
WHERE c.Data_Hora BETWEEN '2025-03-01' AND '2025-03-31' AND c.Status = 'Agendada';

-- Calcula a média de idade dos pacientes por especialidade.
SELECT e.Nome_Especialidade, 
    FLOOR(AVG(YEAR(CURRENT_TIMESTAMP()) - YEAR(p.Data_Nascimento))) AS "Média idade", 
    COUNT(p.ID_Paciente) AS "Quantidade Pacientes" 
FROM Paciente p
JOIN Consulta c ON c.ID_Paciente = p.ID_Paciente 
JOIN Medico m ON m.ID_Medico = c.ID_Medico
JOIN Medico_Especialidade me ON me.ID_Medico = m.ID_Medico
JOIN Especialidade e ON e.ID_Especialidade = me.ID_Especialidade
GROUP BY e.Nome_Especialidade;

-- Identifica médicos cadastrados que estão sem consultas.
SELECT m.Nome AS Nome_Medico
FROM Medico m
LEFT JOIN Consulta c ON m.ID_Medico = c.ID_Medico
WHERE c.ID_Consulta IS NULL;

-- Lista pacientes com mais de 2 consulta agendada.
SELECT p.Nome AS Nome_Paciente, COUNT(c.ID_Consulta) AS Total_Consultas
FROM Paciente p
JOIN Consulta c ON p.ID_Paciente = c.ID_Paciente
WHERE c.Status = 'Agendada'
GROUP BY p.Nome
HAVING COUNT(c.ID_Consulta) > 2;

-- Mostra consultas realizada pelo o médico 2 em Março de 2025.
SELECT c.Data_Hora, p.Nome AS Nome_Paciente, c.Status
FROM Consulta c
JOIN Paciente p ON c.ID_Paciente = p.ID_Paciente
WHERE c.ID_Medico = 2 AND c.Data_Hora BETWEEN '2025-03-01' AND '2025-03-31' AND c.Status = 'Realizada';

-- Lista consultas de pacientes com observações de 'Rotina'.
SELECT p.Nome AS Nome_Paciente, c.Data_Hora, c.Observacoes
FROM Paciente p
JOIN Consulta c ON p.ID_Paciente = c.ID_Paciente
WHERE c.Observacoes LIKE '%Rotina%';

-- Calcula o total de consultas por status.
SELECT Status, COUNT(ID_Consulta) AS Total_Consultas
FROM Consulta
GROUP BY Status;

-- Lista médicos que possuem mais de 1 especialidade e que tenham média de idade dos pacientes atendidos maior que 30 anos.
SELECT m.Nome AS Nome_Medico, COUNT(DISTINCT me.ID_Especialidade) AS Total_Especialidades, 
    FLOOR(AVG(YEAR(CURRENT_TIMESTAMP()) - YEAR(p.Data_Nascimento))) AS "Média idade"
FROM Medico m
JOIN Medico_Especialidade me ON m.ID_Medico = me.ID_Medico
JOIN Consulta c ON m.ID_Medico = c.ID_Medico
JOIN Paciente p ON c.ID_Paciente = p.ID_Paciente
GROUP BY m.Nome
HAVING COUNT(DISTINCT me.ID_Especialidade) > 1 AND FLOOR(AVG(YEAR(CURRENT_TIMESTAMP()) - YEAR(p.Data_Nascimento))) > 30;

-- Monta a agenda do dia para um determinado médico.
SELECT c.Data_Hora, p.Nome AS Nome_Paciente, c.Status
FROM Consulta c
JOIN Paciente p ON c.ID_Paciente = p.ID_Paciente
WHERE c.ID_Medico = 2 AND c.Data_Hora BETWEEN '2025-03-10 00:00:00' AND '2025-03-10 23:59:59';