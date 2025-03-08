# ACMED - Sistema de Gerenciamento de Consultas Médicas

## Descrição
ACMED é um sistema de banco de dados para gerenciamento de consultório médico, permitindo o registro de pacientes, médicos, especialidades e consultas. O sistema controla agendamentos, consultas realizadas e canceladas, além de manter prontuários médicos.

## Integrantes

<table>
  <tr>
    <td align="center">
      <a href="https://github.com/joaopedrodevl">
        <img src="https://github.com/joaopedrodevl.png" width="100px;" alt="Foto do Joaopedrodevl"/>
        <br />
        <sub><b>Joaopedrodevl</b></sub>
      </a>
    </td>
    <td align="center">
      <a href="https://github.com/Je1pi">
        <img src="https://github.com/Je1pi.png" width="100px;" alt="Foto do Je1pi"/>
        <br />
        <sub><b>Je1pi</b></sub>
      </a>
    </td>
  </tr>
</table>

## Tecnologias Utilizadas
- MySQL - Sistema de Gerenciamento de Banco de Dados
- Docker - Para containerização e fácil implantação
- Docker Compose - Para orquestração de containers

## Estrutura do Banco de Dados

### Diagrama Entidade-Relacionamento (Resumido)
```
Paciente (1) ------- (N) Consulta (N) ------ (1) Médico
                        |
                        |
                        v
                    Prontuário
                    
Médico (N) --------- (N) Especialidade
                        
Usuário (1) --------- (1) Paciente/Médico
```

### Tabelas Principais
- **Paciente**: Armazena informações de pacientes
- **Medico**: Armazena informações de médicos
- **Especialidade**: Catálogo de especialidades médicas
- **Medico_Especialidade**: Associação entre médicos e suas especialidades
- **Consulta**: Registros de consultas agendadas, realizadas ou canceladas
- **Prontuario**: Registros médicos das consultas
- **Usuario**: Dados de autenticação para acesso ao sistema

## Como Configurar e Executar

### Pré-requisitos
- Docker e Docker Compose instalados

### Instruções
1. Clone o repositório
2. Navegue até a pasta do projeto
3. Execute o comando para iniciar o sistema:
   ```
   docker-compose up -d
   ```
4. O banco de dados MySQL estará disponível na porta 3306
   - Usuário: acmed
   - Senha: acmed

### Estrutura de Arquivos
```
projeto_bd/
├── sql-scripts/
│   └── init.sql       # Script de inicialização do banco
├── update.sql         # Script com operações de atualização
├── select.sql         # Script com consultas SQL
├── compose.yml        # Configuração do Docker Compose
└── README.md          # Este arquivo
```

## Scripts SQL

### init.sql
Cria o banco de dados, tabelas e insere dados iniciais para:
- 10 pacientes
- 10 médicos
- 10 especialidades médicas
- Diversas consultas (agendadas, realizadas e canceladas)
- Prontuários médicos

### update.sql
Contém exemplos de operações de:
- Inserção de novos médicos
- Associação de médicos a especialidades
- Exclusão de pacientes e suas dependências
- Atualização de status de consultas
- Atualização de informações de contato
- Atualização de diagnósticos em prontuários

### select.sql
Contém consultas avançadas para:
- Listar médicos por especialidade
- Mostrar pacientes com consultas agendadas
- Calcular total de consultas por médico
- Identificar médicos com mais consultas realizadas
- Mostrar pacientes sem consultas
- Identificar médico com mais consultas canceladas
- Estatísticas por especialidade
- Média de idade dos pacientes por especialidade
- Agendas diárias para médicos

## Funcionalidades do Sistema
- Gerenciamento completo de pacientes e médicos
- Agendamento, realização e cancelamento de consultas
- Gerenciamento de prontuários médicos
- Controle de especialidades médicas
- Autenticação de usuários (pacientes, médicos e administradores)

## Consultas Disponíveis
O sistema oferece diversas consultas para análise de dados, incluindo:
- Estatísticas de consultas por status
- Estatísticas de pacientes por idade e especialidade
- Agendamentos por período
- Controle de médicos e pacientes
- Relatórios de produtividade dos médicos
