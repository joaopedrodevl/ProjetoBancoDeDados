CREATE DATABASE IF NOT EXISTS acmed;
USE acmed;

CREATE TABLE Paciente (
    ID_Paciente INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    CPF CHAR(11) NOT NULL UNIQUE,
    Data_Nascimento DATE NOT NULL,
    Telefone VARCHAR(15),
    Email VARCHAR(100) UNIQUE
);

CREATE TABLE Medico (
    ID_Medico INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    CRM CHAR(10) NOT NULL UNIQUE,
    Telefone VARCHAR(15),
    Email VARCHAR(100) UNIQUE
);

CREATE TABLE Especialidade (
    ID_Especialidade INT AUTO_INCREMENT PRIMARY KEY,
    Nome_Especialidade VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Medico_Especialidade (
    ID_Medico INT NOT NULL,
    ID_Especialidade INT NOT NULL,
    PRIMARY KEY (ID_Medico, ID_Especialidade),
    FOREIGN KEY (ID_Medico) REFERENCES Medico(ID_Medico),
    FOREIGN KEY (ID_Especialidade) REFERENCES Especialidade(ID_Especialidade)
);

CREATE TABLE Consulta (
    ID_Consulta INT AUTO_INCREMENT PRIMARY KEY,
    Data_Hora DATETIME NOT NULL,
    Status ENUM('Agendada', 'Realizada', 'Cancelada') NOT NULL,
    Observacoes TEXT,
    ID_Paciente INT NOT NULL,
    ID_Medico INT NOT NULL,
    FOREIGN KEY (ID_Paciente) REFERENCES Paciente(ID_Paciente),
    FOREIGN KEY (ID_Medico) REFERENCES Medico(ID_Medico)
);

CREATE TABLE Prontuario (
    ID_Prontuario INT AUTO_INCREMENT PRIMARY KEY,
    Diagnostico TEXT,
    Prescricao TEXT,
    Data_Registro DATETIME NOT NULL,
    ID_Consulta INT NOT NULL,
    FOREIGN KEY (ID_Consulta) REFERENCES Consulta(ID_Consulta)
);

CREATE TABLE Usuario (
    ID_Usuario INT AUTO_INCREMENT PRIMARY KEY,
    Login VARCHAR(100) NOT NULL UNIQUE,
    Senha VARCHAR(255) NOT NULL,
    Tipo_Usuario ENUM('Paciente', 'Medico', 'Administrador') NOT NULL
);

ALTER TABLE Paciente
ADD COLUMN ID_Usuario INT NOT NULL UNIQUE,
ADD FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario);

ALTER TABLE Medico
ADD COLUMN ID_Usuario INT NOT NULL UNIQUE,
ADD FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario);

ALTER TABLE Consulta
ADD COLUMN ID_Especialidade INT NOT NULL,
ADD FOREIGN KEY (ID_Especialidade) REFERENCES Especialidade(ID_Especialidade);

INSERT INTO Usuario (Login, Senha, Tipo_Usuario)
VALUES 
('joao@gmail.com', SHA2('senha123', 256), 'Paciente'),
('maria@gmail.com', SHA2('senha456', 256), 'Paciente'),
('carlos@gmail.com', SHA2('senha789', 256), 'Paciente'),
('ana@gmail.com', SHA2('senhaabc', 256), 'Paciente'),
('pedro@gmail.com', SHA2('senhadef', 256), 'Paciente'),
('lucas@gmail.com', SHA2('senhalucas', 256), 'Paciente'),
('mariana@gmail.com', SHA2('senhamariana', 256), 'Paciente'),
('rafael@gmail.com', SHA2('senharafael', 256), 'Paciente'),
('juliana@gmail.com', SHA2('senhajuliana', 256), 'Paciente'),
('roberto@gmail.com', SHA2('senharoberto', 256), 'Paciente'),

('jose.almeida@med.com', SHA2('medico123', 256), 'Medico'),
('laura.mendes@med.com', SHA2('medico456', 256), 'Medico'),
('paulo.freitas@med.com', SHA2('medico789', 256), 'Medico'),
('fernanda.lima@med.com', SHA2('medicoabc', 256), 'Medico'),
('marcos.silva@med.com', SHA2('medicodef', 256), 'Medico'),
('renato.gomes@med.com', SHA2('medicorenato', 256), 'Medico'),
('camila.santos@med.com', SHA2('medicocamila', 256), 'Medico'),
('ricardo.oliveira@med.com', SHA2('medicoricardo', 256), 'Medico'),
('patricia.martins@med.com', SHA2('medicopatricia', 256), 'Medico'),
('andre.souza@med.com', SHA2('medicoandre', 256), 'Medico'),

('admin@acmed.com', SHA2('admin123', 256), 'Administrador');

INSERT INTO Paciente (Nome, CPF, Data_Nascimento, Telefone, Email, ID_Usuario)
VALUES 
('João Silva', '12345678901', '1990-05-15', '83999999999', 'joao@gmail.com', 1),
('Maria Souza', '23456789012', '2015-08-20', '83888888888', 'maria@gmail.com', 2),
('Carlos Lima', '34567890123', '1970-12-10', '83777777777', 'carlos@gmail.com', 3),
('Ana Costa', '45678901234', '1995-03-25', '83666666666', 'ana@gmail.com', 4),
('Pedro Santos', '56789012345', '1980-07-12', '83555555555', 'pedro@gmail.com', 5),
('Lucas Pereira', '67890123456', '1992-11-30', '83444444444', 'lucas@gmail.com', 6),
('Mariana Oliveira', '78901234567', '1988-04-18', '83333333333', 'mariana@gmail.com', 7),
('Rafael Almeida', '89012345678', '1993-09-22', '83222222222', 'rafael@gmail.com', 8),
('Juliana Costa', '90123456789', '1987-01-15', '83111111111', 'juliana@gmail.com', 9),
('Roberto Lima', '01234567890', '1991-06-05', '83000000000', 'roberto@gmail.com', 10);

INSERT INTO Medico (Nome, CRM, Telefone, Email, ID_Usuario)
VALUES 
('Dr. José Almeida', '1234567', '83333333333', 'jose.almeida@med.com', 11),
('Dra. Laura Mendes', '2345678', '83444444444', 'laura.mendes@med.com', 12),
('Dr. Paulo Freitas', '3456789', '83555555555', 'paulo.freitas@med.com', 13),
('Dra. Fernanda Lima', '4567890', '83666666666', 'fernanda.lima@med.com', 14),
('Dr. Marcos Silva', '5678901', '83777777777', 'marcos.silva@med.com', 15),
('Dr. Renato Gomes', '6789012', '83888888888', 'renato.gomes@med.com', 16),
('Dra. Camila Santos', '7890123', '83999999999', 'camila.santos@med.com', 17),
('Dr. Ricardo Oliveira', '8901234', '83000000000', 'ricardo.oliveira@med.com', 18),
('Dra. Patricia Martins', '9012345', '83111111111', 'patricia.martins@med.com', 19),
('Dr. Andre Souza', '0123456', '83222222222', 'andre.souza@med.com', 20);

INSERT INTO Especialidade (Nome_Especialidade)
VALUES 
('Cardiologia'),
('Pediatria'),
('Ortopedia'),
('Dermatologia'),
('Ginecologia'),
('Neurologia'),
('Psiquiatria'),
('Oftalmologia'),
('Endocrinologia'),
('Urologia');

INSERT INTO Medico_Especialidade (ID_Medico, ID_Especialidade)
VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(1, 2),
(2, 3),
(3, 4),
(5, 6),
(7, 8),
(8, 9),
(9, 10),
(10, 1);

INSERT INTO Consulta (Data_Hora, Status, Observacoes, ID_Paciente, ID_Medico, ID_Especialidade)
VALUES 
('2025-04-10 09:00:00', 'Agendada', 'Consulta de rotina', 1, 1, 1),
('2025-03-10 10:00:00', 'Realizada', 'Acompanhamento pediátrico', 2, 2, 2),
('2025-03-11 14:00:00', 'Realizada', 'Exame ortopédico', 3, 3, 3),
('2025-04-12 16:00:00', 'Cancelada', 'Consulta dermatológica', 4, 4, 4),
('2025-03-13 08:00:00', 'Realizada', 'Consulta ginecológica', 5, 5, 5),
('2025-03-25 11:30:00', 'Realizada', 'Revisão cardíaca', 1, 1, 1),
('2025-04-03 14:45:00', 'Cancelada', 'Consulta preventiva', 3, 2, 2),
('2025-04-15 09:15:00', 'Agendada', 'Tratamento de pele', 2, 4, 4),
('2025-03-20 16:00:00', 'Cancelada', 'Dor nas costas', 4, 3, 3),
('2025-04-22 10:30:00', 'Agendada', 'Exame de rotina', 5, 1, 1),
('2025-03-18 13:00:00', 'Realizada', 'Prevenção anual', 2, 5, 5),
('2025-05-05 15:30:00', 'Agendada', 'Alergia sazonal', 1, 4, 4), 
('2025-04-30 08:45:00', 'Agendada', 'Acompanhamento ortopédico', 3, 3, 3),
('2025-03-29 12:00:00', 'Realizada', 'Checkup completo', 5, 2, 2),
('2025-05-10 09:00:00', 'Cancelada', 'Consulta de rotina', 1, 6, 6),
('2025-05-11 10:00:00', 'Cancelada', 'Acompanhamento neurológico', 2, 7, 7),
('2025-05-12 14:00:00', 'Realizada', 'Exame psiquiátrico', 3, 8, 7),
('2025-05-13 16:00:00', 'Cancelada', 'Consulta oftalmológica', 4, 9, 8),
('2025-05-14 08:00:00', 'Realizada', 'Consulta endocrinológica', 5, 10, 9),
('2025-05-15 08:30:00', 'Agendada', 'Revisão neurológica', 1, 7, 6),
('2025-05-15 10:45:00', 'Agendada', 'Consulta preventiva', 3, 6, 6),
('2025-05-15 14:15:00', 'Agendada', 'Tratamento oftalmológico', 2, 9, 8),
('2025-05-18 16:00:00', 'Cancelada', 'Dor nas costas', 4, 8, 8),
('2025-05-20 08:30:00', 'Agendada', 'Exame de rotina', 5, 6, 6),
('2025-05-20 13:00:00', 'Agendada', 'Prevenção anual', 2, 10, 10),
('2025-05-20 15:30:00', 'Agendada', 'Alergia sazonal', 1, 9, 9), 
('2025-05-22 08:45:00', 'Agendada', 'Acompanhamento psiquiátrico', 3, 8, 7),
('2025-05-22 12:00:00', 'Agendada', 'Checkup completo', 5, 7, 7),
('2025-03-10 09:00:00', 'Realizada', 'Consulta de rotina', 4, 2, 2),
('2025-03-10 11:00:00', 'Agendada', 'Exame de retorno', 7, 2, 2),
('2025-03-10 14:00:00', 'Agendada', 'Consulta de acompanhamento', 8, 2, 2);

INSERT INTO Prontuario (Diagnostico, Prescricao, Data_Registro, ID_Consulta)
VALUES 
('Desenvolvimento normal para a idade', 'Suplemento vitamínico infantil - 1 gota ao dia', '2025-03-10 10:45:00', 2),
('Entorse de tornozelo grau 1', 'Ibuprofeno 400mg 8/8h por 5 dias, repouso e compressas frias', '2025-03-11 14:40:00', 3),
('Exame preventivo normal', 'Exames laboratoriais de rotina e retorno em 6 meses', '2025-03-13 08:50:00', 5),
('Hipertensão controlada', 'Manter Losartana 50mg 1x ao dia e atividade física regular', '2025-03-25 12:10:00', 6),
('Parâmetros vitais normais', 'Manter dieta balanceada e atividade física regular', '2025-03-18 13:45:00', 11),
('Colesterol LDL limítrofe', 'Dieta com redução de gorduras saturadas, retorno em 3 meses', '2025-03-29 12:50:00', 14),
('Transtorno de ansiedade generalizada', 'Escitalopram 10mg 1x ao dia e terapia semanal', '2025-05-12 15:00:00', 17),
('Hipotireoidismo subclínico', 'Levotiroxina 25mcg em jejum, retorno com exames em 45 dias', '2025-05-14 08:55:00', 19),
('Torção de tornozelo grau 2', 'Ibuprofeno 600mg 8/8h por 7 dias, repouso e compressas frias', '2025-03-10 09:45:00', 29);