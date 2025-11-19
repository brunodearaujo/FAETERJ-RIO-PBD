CREATE TABLE `TB_LOJA` (
  `id_loja` int PRIMARY KEY AUTO_INCREMENT,
  `nome_loja` varchar(255),
  `cidade` varchar(255)
);

CREATE TABLE `TB_CLIENTE` (
  `id_cliente` int PRIMARY KEY AUTO_INCREMENT,
  `nome` varchar(255),
  `cpf` varchar(255),
  `cnh` varchar(255)
);

CREATE TABLE `TB_FUNCIONARIO` (
  `id_funcionario` int PRIMARY KEY AUTO_INCREMENT,
  `nome` varchar(255),
  `cpf` varchar(255)
);

CREATE TABLE `TB_CARRO` (
  `id_carro` int PRIMARY KEY AUTO_INCREMENT,
  `modelo` varchar(255),
  `marca` varchar(255),
  `placa` varchar(255),
  `ano` int,
  `km_atual` int,
  `valor_diaria` decimal,
  `status` varchar(255),
  `id_loja_atual` int
);

CREATE TABLE `TB_SEGURO` (
  `id_seguro` int PRIMARY KEY AUTO_INCREMENT,
  `tipo_seguro` varchar(255),
  `valor_diaria` decimal
);

CREATE TABLE `TB_CUPOM` (
  `id_cupom` int PRIMARY KEY AUTO_INCREMENT,
  `codigo` varchar(255),
  `desconto_percentual` decimal,
  `validade` date
);

CREATE TABLE `TB_MOTORISTA` (
  `id_motorista` int PRIMARY KEY AUTO_INCREMENT,
  `cnh` varchar(255),
  `id_funcionario` int
);

CREATE TABLE `TB_LOCACAO` (
  `id_locacao` int PRIMARY KEY AUTO_INCREMENT,
  `data_retirada` datetime,
  `data_devolucao` datetime,
  `km_inicial` int,
  `km_final` int,
  `valor_total` decimal,
  `id_cliente` int,
  `id_carro` int,
  `id_seguro` int,
  `id_cupom` int,
  `id_motorista` int,
  `id_loja_retirada` int,
  `id_loja_devolucao` int
);

CREATE TABLE `TB_MANUTENCAO` (
  `id_manutencao` int PRIMARY KEY AUTO_INCREMENT,
  `data_entrada` date,
  `data_saida` date,
  `descricao` text,
  `custo` decimal,
  `id_carro` int
);

CREATE TABLE `TB_OCORRENCIA` (
  `id_ocorrencia` int PRIMARY KEY AUTO_INCREMENT,
  `tipo` varchar(255) COMMENT 'Multa, Dano, Limpeza',
  `descricao` text,
  `valor` decimal,
  `id_locacao` int
);

CREATE TABLE `TB_TRANSFERENCIA` (
  `id_transferencia` int PRIMARY KEY AUTO_INCREMENT,
  `data_transferencia` datetime,
  `id_carro` int,
  `id_loja_origem` int,
  `id_loja_destino` int
);

ALTER TABLE `TB_CARRO` ADD FOREIGN KEY (`id_loja_atual`) REFERENCES `TB_LOJA` (`id_loja`);

ALTER TABLE `TB_FUNCIONARIO` ADD FOREIGN KEY (`id_funcionario`) REFERENCES `TB_MOTORISTA` (`id_funcionario`);

ALTER TABLE `TB_LOCACAO` ADD FOREIGN KEY (`id_cliente`) REFERENCES `TB_CLIENTE` (`id_cliente`);

ALTER TABLE `TB_LOCACAO` ADD FOREIGN KEY (`id_carro`) REFERENCES `TB_CARRO` (`id_carro`);

ALTER TABLE `TB_LOCACAO` ADD FOREIGN KEY (`id_seguro`) REFERENCES `TB_SEGURO` (`id_seguro`);

ALTER TABLE `TB_LOCACAO` ADD FOREIGN KEY (`id_cupom`) REFERENCES `TB_CUPOM` (`id_cupom`);

ALTER TABLE `TB_LOCACAO` ADD FOREIGN KEY (`id_motorista`) REFERENCES `TB_MOTORISTA` (`id_motorista`);

ALTER TABLE `TB_LOCACAO` ADD FOREIGN KEY (`id_loja_retirada`) REFERENCES `TB_LOJA` (`id_loja`);

ALTER TABLE `TB_LOCACAO` ADD FOREIGN KEY (`id_loja_devolucao`) REFERENCES `TB_LOJA` (`id_loja`);

ALTER TABLE `TB_MANUTENCAO` ADD FOREIGN KEY (`id_carro`) REFERENCES `TB_CARRO` (`id_carro`);

ALTER TABLE `TB_OCORRENCIA` ADD FOREIGN KEY (`id_locacao`) REFERENCES `TB_LOCACAO` (`id_locacao`);

ALTER TABLE `TB_TRANSFERENCIA` ADD FOREIGN KEY (`id_carro`) REFERENCES `TB_CARRO` (`id_carro`);

ALTER TABLE `TB_TRANSFERENCIA` ADD FOREIGN KEY (`id_loja_origem`) REFERENCES `TB_LOJA` (`id_loja`);

ALTER TABLE `TB_TRANSFERENCIA` ADD FOREIGN KEY (`id_loja_destino`) REFERENCES `TB_LOJA` (`id_loja`);
