
-- SIMULAÇÃO DE FUNCIONALIDADES - SISTEMA FALLS CAR
-- Cenário: Cliente 'Bruno de Araujo' quer alugar um carro no Rio

-- 1. CONSULTA DE DISPONIBILIDADE E LOCALIZAÇÃO
-- O atendente precisa saber onde o carro está e se está livre.
-- Aqui cruzamos Veículo com Modelo e Loja para ter a info completa.

SELECT 
    v.placa, 
    m.nome_modelo, 
    m.valor_diaria_padrao,
    l.nome_loja,
    l.cidade
FROM TB_VEICULO v
INNER JOIN TB_MODELO m ON v.id_modelo = m.id_modelo
INNER JOIN TB_LOJA l ON v.id_loja_atual = l.id_loja
WHERE v.status = 'DISPONIVEL'
AND l.cidade = 'Rio de Janeiro';



-- 2. REALIZANDO A ALOCAÇÃO (COM MOTORISTA)
-- O cliente escolheu o carro de ID 1 (Uno com Escada) e pediu motorista.
-- Vamos inserir a locação já vinculando o motorista de ID 1 (Jorge).

INSERT INTO TB_LOCACAO (
    data_retirada, 
    data_devolucao, 
    km_inicial, 
    id_cliente, 
    id_veiculo, 
    id_seguro, 
    id_loja_retirada, 
    id_loja_devolucao, 
    id_motorista -- Campo opcional preenchido, informando o motorista
) VALUES (
    NOW(), -- Retirou agora
    DATE_ADD(NOW(), INTERVAL 5 DAY), -- Vai ficar 5 dias
    350000, -- KM atual do Uno
    1, -- ID do Bruno de Araujo
    1, -- ID do Uno com Escada
    2, -- Seguro Premium
    1, -- Retira na Matriz
    1, -- Devolve na Matriz
    1  -- Com o motorista Jorge
);



-- 3. BAIXA NO ESTOQUE (ATUALIZAÇÃO DE STATUS)
-- O sistema precisa travar o carro para ninguém mais alugar.

UPDATE TB_VEICULO 
SET status = 'ALUGADO' 
WHERE id_veiculo = 1;



-- PASSARAM-SE 5 DIAS... HORA DA DEVOLUÇÃO E VISTORIA

-- 4. REGISTRANDO A DEVOLUÇÃO (O CLIENTE ENTREGOU A CHAVE)
-- Atualizamos a data real de entrega e o KM que conferimos no painel.

UPDATE TB_LOCACAO 
SET 
    data_devolucao = NOW(),
    km_final = 350500 -- Rodou 500km
WHERE id_veiculo = 1 AND km_final IS NULL;


-- 5. A VISTORIA
-- O funcionário checou o carro e percebeu um arranhão no para-choque.
-- Precisamos registrar isso na tabela de Ocorrências ANTES de fechar a conta.

INSERT INTO TB_OCORRENCIA (
    id_locacao,
    tipo,
    descricao,
    valor
) VALUES (
    (SELECT MAX(id_locacao) FROM TB_LOCACAO), -- Pega a locação atual
    'AVARIA',
    'Risco profundo no para-choque dianteiro direito',
    250.00 -- Valor cobrado pelo reparo
);



-- 6. DEFININDO O DESTINO DO VEÍCULO
-- Como houve avaria, o carro NÃO fica disponível. Vai para manutenção.
-- (Se estivesse tudo ok, o status seria 'DISPONIVEL')

UPDATE TB_VEICULO 
SET status = 'MANUTENCAO', km_atual = 350500 
WHERE id_veiculo = 1;



-- FINANCEIRO (AGORA COM A COBRANÇA DA AVARIA)

-- 7. GERAÇÃO DO PAGAMENTO FINAL
-- O sistema soma tudo, inclusive a avaria detectada na vistoria.
-- Diárias (750) + Seguro (500) + Motorista (200) - Desconto (50) + AVARIA (250)
-- NOVO TOTAL = 1.650,00

INSERT INTO TB_PAGAMENTO (
    id_locacao,
    metodo_pagamento,
    subtotal_diarias,
    valor_servico_motorista,
    valor_seguro,
    valor_desconto,
    valor_multas, -- Aqui entra o valor da Ocorrência
    valor_total_final
) VALUES (
    (SELECT MAX(id_locacao) FROM TB_LOCACAO),
    'Cartão de Crédito',
    750.00,
    200.00,
    500.00,
    50.00,
    250.00,  -- O valor do arranhão entra aqui
    1650.00  -- Total do pagamento
);
