
-- inserindo lojas
-- omitindo o id pois é autoincrement, então nos aproveitaremos dessa automatização
INSERT INTO TB_LOJA (nome_loja, cidade, endereco) VALUES 
('Matriz Aeroporto', 'Rio de Janeiro', 'Galeão'),
('Filial Centro', 'São Paulo', 'Av Paulista');

-- inserindo o Catálogo de Modelos
INSERT INTO TB_MODELO (marca, nome_modelo, ano_fabricacao, valor_diaria_padrao, categoria) VALUES 
('Fiat', 'Uno Mille (Com Escada)', 1994, 150.00, 'Super Esportivo'),
('Volkswagen', 'Gol Quadrado GTI', 1993, 120.00, 'Clássico'),
('Chevrolet', 'Opala Diplomata', 1992, 200.00, 'Banheira de Luxo'),
('Fiat', 'Marea Turbo', 2003, 80.00, 'Emoção/Perigo'),
('Chevrolet', 'Chevette Tubarão', 1978, 90.00, 'Drift'),
('Jeep', 'Compass', 2024, 350.00, 'SUV Nutella');

-- inserindo a Frota de Veículos
INSERT INTO TB_VEICULO (placa, cor, km_atual, status, id_modelo, id_loja_atual) VALUES 
('ESCADA1', 'Branco', 350000, 'DISPONIVEL', 1, 1), -- Uno
('GOL1993', 'Azul', 180000, 'DISPONIVEL', 2, 1),   -- Gol
('OPL6666', 'Preto', 120000, 'DISPONIVEL', 3, 1),   -- Opala
('BOM2003', 'Prata', 85000, 'MANUTENCAO', 4, 1),    -- Marea
('DRIFT78', 'Bege', 200000, 'DISPONIVEL', 5, 1),    -- Chevette
('SUV2024', 'Prata', 10000, 'DISPONIVEL', 6, 1);    -- Compass

-- inserindo Seguros e Cupons
INSERT INTO TB_SEGURO (tipo_seguro, valor_diaria) VALUES 
('Básico', 50.00), 
('Premium', 100.00);

-- cupom em homenagem à nossa faculdade
INSERT INTO TB_CUPOM (codigo, desconto_percentual, validade) VALUES 
('FAETERJ10', 10.00, '2025-12-31');

-- inserindo Funcionários
INSERT INTO TB_FUNCIONARIO (nome, cpf, funcao) VALUES 
('Carlos Atendente', '111.222.333-44', 'Atendente'),
('Jorge Motorista', '555.666.777-88', 'Motorista');

-- aqui vinculamos o Jorge (que foi o 2º inserido)
INSERT INTO TB_MOTORISTA (cnh, id_funcionario) VALUES ('12345678900', 2);

-- inserindo Clientes (homenagem aos colegas de classe)
INSERT INTO TB_CLIENTE (nome, cpf, cnh, telefone, email) VALUES 
('Bruno de Araujo', '000.000.000-01', 'CNH001', '9999-0001', 'bruno@faeterj.br'),
('Arthur Aleksandravicius', '000.000.000-02', 'CNH002', '9999-0002', 'arthur@faeterj.br'),
('Kaua Contiero Duarte', '000.000.000-03', 'CNH003', '9999-0003', 'kaua@faeterj.br'),
('Pedro de Araujo Botelho', '000.000.000-04', 'CNH004', '9999-0004', 'pedro@faeterj.br'),
('Raul de Souza Fiel Faria', '000.000.000-05', 'CNH005', '9999-0005', 'raul@faeterj.br'),
('Thalles Ferreira Costa', '000.000.000-06', 'CNH006', '9999-0006', 'thalles@faeterj.br'),
('Luiz Guilherme Ferreira', '000.000.000-07', 'CNH007', '9999-0007', 'luiz@faeterj.br'),
('Pedro Heringer Valerio', '000.000.000-08', 'CNH008', '9999-0008', 'pedro.h@faeterj.br'),
('João Victor Martins', '000.000.000-09', 'CNH009', '9999-0009', 'joao.v@faeterj.br'),
('Joao Mateus Leite', '000.000.000-10', 'CNH010', '9999-0010', 'joao.m@faeterj.br'),
('Joao Pedro Silva', '000.000.000-11', 'CNH011', '9999-0011', 'joao.p@faeterj.br'),
('Kleuber Rodrigues', '000.000.000-12', 'CNH012', '9999-0012', 'kleuber@faeterj.br'),
('Thiago Tavares', '000.000.000-13', 'CNH013', '9999-0013', 'thiago@faeterj.br'),
('Isabela Vieira', '000.000.000-14', 'CNH014', '9999-0014', 'isabela@faeterj.br'),
('Bilbo o Bolseiro', '777.777.777-77', 'CNH999', '9999-9999', 'bilbo@condado.com'),
('Gandalf o Cinzento', '888.888.888-88', 'CNH888', '9999-8888', 'gandalf@mago.com');
