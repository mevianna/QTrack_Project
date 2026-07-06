-- =============================================================================
-- SCRIPT DDL (Data Definition Language) - QTRACK DATABASE
-- Disciplina: Banco de Dados I (TrabFinal)
-- =============================================================================

-- 1. RegistroAmbiente
CREATE TABLE RegistroAmbiente (
    id_registro_ambiente SERIAL PRIMARY KEY,
    data_hora_registro TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    temperatura NUMERIC(10,4),
    pressao NUMERIC(10,4),
    umidade NUMERIC(10,4),
    vibracao NUMERIC(10,4),
    campo_magnetico NUMERIC(10,4),
    observacoes TEXT
);

-- 2. Criostato
CREATE TABLE Criostato (
    id_criostato SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    fabricante VARCHAR(255),
    modelo VARCHAR(255),
    temperatura_nominal NUMERIC(10,4),
    status_operacional VARCHAR(255) DEFAULT 'Ativo'
);

-- 3. Pesquisador
CREATE TABLE Pesquisador (
    id_pesquisador SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE,
    instituicao VARCHAR(255),
    area_atuacao VARCHAR(255)
);

-- 4. Qpu
CREATE TABLE Qpu (
    id_qpu SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    fabricante VARCHAR(255),
    modelo VARCHAR(255),
    tecnologia VARCHAR(255),
    data_instalacao DATE,
    status_operacional VARCHAR(255) DEFAULT 'Ativo',
    id_criostato INT NOT NULL REFERENCES Criostato(id_criostato) ON DELETE RESTRICT
);

-- 5. Qubit
CREATE TABLE Qubit (
    id_qubit SERIAL PRIMARY KEY,
    indice_qubit INT,
    tipo_qubit VARCHAR(255),
    frequencia_ressonancia NUMERIC(10,4),
    status_qubit VARCHAR(255) DEFAULT 'Ativo',
    observacoes TEXT,
    id_qpu INT NOT NULL REFERENCES Qpu(id_qpu) ON DELETE CASCADE
);

-- 6. Experimento
CREATE TABLE Experimento (
    id_experimento SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    objetivo TEXT,
    data_hora_inicio TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    data_hora_fim TIMESTAMP WITHOUT TIME ZONE,
    status_execucao VARCHAR(255) DEFAULT 'Planejado',
    observacoes TEXT,
    id_pesquisador INT NOT NULL REFERENCES Pesquisador(id_pesquisador) ON DELETE RESTRICT,
    id_qpu INT NOT NULL REFERENCES Qpu(id_qpu) ON DELETE CASCADE,
    id_registro_ambiente INT REFERENCES RegistroAmbiente(id_registro_ambiente) ON DELETE SET NULL,
    UNIQUE (id_pesquisador, id_qpu, data_hora_inicio)
);

-- 7. Calibracao
CREATE TABLE Calibracao (
    id_calibracao SERIAL PRIMARY KEY,
    data_hora_inicio TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    data_hora_fim TIMESTAMP WITHOUT TIME ZONE,
    tipo_calibracao VARCHAR(255),
    versao_parametros VARCHAR(255),
    resultado VARCHAR(255),
    observacoes TEXT,
    id_pesquisador INT NOT NULL REFERENCES Pesquisador(id_pesquisador) ON DELETE RESTRICT,
    id_qpu INT NOT NULL REFERENCES Qpu(id_qpu) ON DELETE CASCADE,
    id_registro_ambiente INT REFERENCES RegistroAmbiente(id_registro_ambiente) ON DELETE SET NULL,
    UNIQUE (id_pesquisador, id_qpu, data_hora_inicio)
);

-- 8. Experimento_Qubit
CREATE TABLE Experimento_Qubit (
    id_experimento INT REFERENCES Experimento(id_experimento) ON DELETE CASCADE,
    id_qubit INT REFERENCES Qubit(id_qubit) ON DELETE CASCADE,
    nome_metrica VARCHAR(255) NOT NULL,
    valor NUMERIC(12,6),
    unidade VARCHAR(255),
    data_hora_medicao TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    metodo_obtencao VARCHAR(255),
    observacoes TEXT,
    PRIMARY KEY (id_experimento, id_qubit, nome_metrica)
);

-- 9. PortaQuantica
CREATE TABLE PortaQuantica (
    id_porta SERIAL PRIMARY KEY,
    nome_porta VARCHAR(255) NOT NULL,
    categoria VARCHAR(255),
    numero_qubits_alvo SMALLINT DEFAULT 1,
    descricao TEXT
);

-- 10. Experimento_Porta
CREATE TABLE Experimento_Porta (
    id_experimento INT REFERENCES Experimento(id_experimento) ON DELETE CASCADE,
    id_porta INT REFERENCES PortaQuantica(id_porta) ON DELETE CASCADE,
    nome_metrica VARCHAR(255) NOT NULL,
    valor NUMERIC(12,6),
    unidade VARCHAR(255),
    data_hora_medicao TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    metodo_obtencao VARCHAR(255),
    observacoes TEXT,
    PRIMARY KEY (id_experimento, id_porta, nome_metrica)
);

-- 11. SequenciaPulso
CREATE TABLE SequenciaPulso (
    id_sequencia SERIAL PRIMARY KEY,
    nome VARCHAR(255),
    finalidade VARCHAR(255),
    versao VARCHAR(255),
    descricao TEXT
);

-- 12. Pulso
CREATE TABLE Pulso (
    id_pulso SERIAL PRIMARY KEY,
    ordem INT,
    tipo_pulso VARCHAR(255),
    amplitude NUMERIC(10,4),
    duracao NUMERIC(10,4),
    frequencia NUMERIC(10,4),
    fase NUMERIC(10,4),
    forma_onda VARCHAR(255),
    id_sequencia INT NOT NULL REFERENCES SequenciaPulso(id_sequencia) ON DELETE CASCADE
);

-- 13. SequenciaPulso_Porta
CREATE TABLE SequenciaPulso_Porta (
    id_sequencia INT REFERENCES SequenciaPulso(id_sequencia) ON DELETE CASCADE,
    id_porta INT REFERENCES PortaQuantica(id_porta) ON DELETE CASCADE,
    PRIMARY KEY (id_sequencia, id_porta)
);

-- 14. Porta_Qubit
CREATE TABLE Porta_Qubit (
    id_porta INT REFERENCES PortaQuantica(id_porta) ON DELETE CASCADE,
    id_qubit INT REFERENCES Qubit(id_qubit) ON DELETE CASCADE,
    PRIMARY KEY (id_porta, id_qubit)
);

-- 15. SequenciaPulso_Calibracao
CREATE TABLE SequenciaPulso_Calibracao (
    id_calibracao INT REFERENCES Calibracao(id_calibracao) ON DELETE CASCADE,
    id_sequencia INT REFERENCES SequenciaPulso(id_sequencia) ON DELETE CASCADE,
    PRIMARY KEY (id_calibracao, id_sequencia)
);

-- 16. SequenciaPulso_Experimento
CREATE TABLE SequenciaPulso_Experimento (
    id_experimento INT REFERENCES Experimento(id_experimento) ON DELETE CASCADE,
    id_sequencia INT REFERENCES SequenciaPulso(id_sequencia) ON DELETE CASCADE,
    PRIMARY KEY (id_experimento, id_sequencia)
);

-- 17. Calibracao_Qubit
CREATE TABLE Calibracao_Qubit (
    id_calibracao INT REFERENCES Calibracao(id_calibracao) ON DELETE CASCADE,
    id_qubit INT REFERENCES Qubit(id_qubit) ON DELETE CASCADE,
    parametro_ajustado VARCHAR(255),
    valor_antes NUMERIC(12,6),
    valor_depois NUMERIC(12,6),
    PRIMARY KEY (id_calibracao, id_qubit)
);
