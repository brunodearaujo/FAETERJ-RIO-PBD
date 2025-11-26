-- cadastrando um cliente novo
INSERT INTO TB_CLIENTE (nome, cpf, cnh, telefone, email) 
VALUES ('Aluno Atrasado', '999.999.999-99', '12345678900', '(21) 90000-0000', 'atrasado@faeterj.br');

-- buscando um cliente pelo nome
SELECT * FROM TB_CLIENTE 
WHERE nome LIKE '%Atrasado%';

-- atualizando o número do cliente
UPDATE TB_CLIENTE 
SET telefone = '(21) 98888-8888' 
WHERE cpf = '999.999.999-99';

-- excluindo o cadastro do cliente que desistiu de fazer o cadastro
DELETE FROM TB_CLIENTE 
WHERE cpf = '999.999.999-99';



-- listando carros disponíveis
SELECT placa, cor, km_atual 
FROM TB_VEICULO 
WHERE status = 'DISPONIVEL';

-- colocando um carro específico em manutenção
UPDATE TB_VEICULO 
SET status = 'MANUTENCAO' 
WHERE placa = 'BOM2003';

-- confirmando que ele mudou de status (é interessante observar todos antes de fazer a alteração pra ter uma comparação)
SELECT * FROM TB_VEICULO 
WHERE placa = 'BOM2003';


-- locação do cliente de id 1 pegando o carro 2, que no caso é o gol
INSERT INTO TB_LOCACAO (data_retirada, data_devolucao, km_inicial, id_cliente, id_veiculo, id_seguro, id_loja_retirada, id_loja_devolucao) 
VALUES (NOW(), '2025-12-01 10:00:00', 180000, 1, 2, 1, 1, 1);

-- ver locações que estão em andamento e não foram devolvidas (km_final é nulo)
SELECT * FROM TB_LOCACAO 
WHERE km_final IS NULL;

