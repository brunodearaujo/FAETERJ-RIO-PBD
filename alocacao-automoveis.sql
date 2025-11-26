-- Criação do Banco de Dados
CREATE DATABASE IF NOT EXISTS locadora_db;
USE locadora_db;

-- 1. Tabelas Independentes (sem FKs obrigatórias na criação)

CREATE TABLE TB_LOJA (
    id_loja INT AUTO_INCREMENT PRIMARY KEY,
    nome_loja VARCHAR(100) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    endereco VARCHAR(200)
);

CREATE TABLE TB_CLIENTE (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE, -- 14 considerando pontuação
    cnh VARCHAR(20) NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100)
);

CREATE TABLE TB_FUNCIONARIO (
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    funcao VARCHAR(50) NOT NULL -- Ex: Atendente, Motorista
);

CREATE TABLE TB_MODELO (
    id_modelo INT AUTO_INCREMENT PRIMARY KEY,
    marca VARCHAR(50) NOT NULL,
    nome_modelo VARCHAR(50) NOT NULL,
    ano_fabricacao INT NOT NULL,
    valor_diaria_padrao DECIMAL(10,2) NOT NULL,
    categoria VARCHAR(30) -- Ex: SUV, Compacto
);

CREATE TABLE TB_SEGURO (
    id_seguro INT AUTO_INCREMENT PRIMARY KEY,
    tipo_seguro VARCHAR(50) NOT NULL,
    valor_diaria DECIMAL(10,2) NOT NULL
);

CREATE TABLE TB_CUPOM (
    id_cupom INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    desconto_percentual DECIMAL(5,2) NOT NULL,
    validade DATE NOT NULL
);

-- 2. Tabelas Dependentes (possuem FKs)

CREATE TABLE TB_MOTORISTA (
    id_motorista INT AUTO_INCREMENT PRIMARY KEY,
    cnh VARCHAR(20) NOT NULL,
    id_funcionario INT NOT NULL,
    FOREIGN KEY (id_funcionario) REFERENCES TB_FUNCIONARIO(id_funcionario)
);

CREATE TABLE TB_VEICULO (
    id_veiculo INT AUTO_INCREMENT PRIMARY KEY,
    placa CHAR(7) NOT NULL UNIQUE,
    cor VARCHAR(30),
    km_atual INT DEFAULT 0,
    status VARCHAR(20) DEFAULT 'DISPONIVEL', -- Disponivel, Alugado, Manutencao
    id_modelo INT NOT NULL,
    id_loja_atual INT NOT NULL,
    FOREIGN KEY (id_modelo) REFERENCES TB_MODELO(id_modelo),
    FOREIGN KEY (id_loja_atual) REFERENCES TB_LOJA(id_loja)
);

CREATE TABLE TB_LOCACAO (
    id_locacao INT AUTO_INCREMENT PRIMARY KEY,
    data_retirada DATETIME NOT NULL,
    data_devolucao DATETIME NOT NULL,
    km_inicial INT NOT NULL,
    km_final INT, -- Pode ser null se ainda não devolveu
    
    -- Chaves Estrangeiras
    id_cliente INT NOT NULL,
    id_veiculo INT NOT NULL,
    id_seguro INT NOT NULL,
    id_loja_retirada INT NOT NULL,
    id_loja_devolucao INT NOT NULL,
    id_cupom INT,      -- Opcional (NULL)
    id_motorista INT,  -- Opcional (NULL)

    FOREIGN KEY (id_cliente) REFERENCES TB_CLIENTE(id_cliente),
    FOREIGN KEY (id_veiculo) REFERENCES TB_VEICULO(id_veiculo),
    FOREIGN KEY (id_seguro) REFERENCES TB_SEGURO(id_seguro),
    FOREIGN KEY (id_loja_retirada) REFERENCES TB_LOJA(id_loja),
    FOREIGN KEY (id_loja_devolucao) REFERENCES TB_LOJA(id_loja),
    FOREIGN KEY (id_cupom) REFERENCES TB_CUPOM(id_cupom),
    FOREIGN KEY (id_motorista) REFERENCES TB_MOTORISTA(id_motorista)
);

-- 3. Tabelas Operacionais e Financeiras

CREATE TABLE TB_PAGAMENTO (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    id_locacao INT NOT NULL,
    data_emissao DATETIME DEFAULT CURRENT_TIMESTAMP,
    metodo_pagamento VARCHAR(50) NOT NULL, -- Pix, Crédito, etc.
    
    -- Detalhamento (Nota Fiscal)
    subtotal_diarias DECIMAL(10,2) NOT NULL,
    valor_total_final DECIMAL(10,2) NOT NULL,
    
    -- Campos Opcionais (Nullable)
    valor_servico_motorista DECIMAL(10,2),
    valor_seguro DECIMAL(10,2),
    valor_multas DECIMAL(10,2),
    valor_desconto DECIMAL(10,2),
    
    FOREIGN KEY (id_locacao) REFERENCES TB_LOCACAO(id_locacao)
);

CREATE TABLE TB_MANUTENCAO (
    id_manutencao INT AUTO_INCREMENT PRIMARY KEY,
    id_veiculo INT NOT NULL,
    data_entrada DATE NOT NULL,
    data_saida DATE,
    descricao TEXT,
    custo DECIMAL(10,2),
    FOREIGN KEY (id_veiculo) REFERENCES TB_VEICULO(id_veiculo)
);

CREATE TABLE TB_OCORRENCIA (
    id_ocorrencia INT AUTO_INCREMENT PRIMARY KEY,
    id_locacao INT NOT NULL,
    tipo VARCHAR(50) NOT NULL, -- Multa, Avaria
    descricao TEXT,
    valor DECIMAL(10,2),
    FOREIGN KEY (id_locacao) REFERENCES TB_LOCACAO(id_locacao)
);

CREATE TABLE TB_TRANSFERENCIA (
    id_transferencia INT AUTO_INCREMENT PRIMARY KEY,
    data_transferencia DATETIME NOT NULL,
    id_veiculo INT NOT NULL,
    id_loja_origem INT NOT NULL,
    id_loja_destino INT NOT NULL,
    FOREIGN KEY (id_veiculo) REFERENCES TB_VEICULO(id_veiculo),
    FOREIGN KEY (id_loja_origem) REFERENCES TB_LOJA(id_loja),
    FOREIGN KEY (id_loja_destino) REFERENCES TB_LOJA(id_loja)
);
