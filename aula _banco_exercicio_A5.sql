DROP DATABASE IF EXISTS aula_banco;
CREATE DATABASE aula_banco;
USE aula_banco;

CREATE TABLE estado(
id INT NOT NULL AUTO_INCREMENT
,nome VARCHAR(200) NOT NULL UNIQUE
,sigla CHAR(2) NOT NULL UNIQUE
,ativo ENUM('S','N') NOT NULL DEFAULT 'S'
,data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,CONSTRAINT pk_estado PRIMARY KEY (id)
);

CREATE TABLE cidade (
id INT NOT NULL AUTO_INCREMENT
,nome VARCHAR(200)  NOT NULL
,ativo ENUM('S','N') NOT NULL DEFAULT 'S'
,data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,estado_id INT NOT NULL
,CONSTRAINT pk_cidade PRIMARY KEY (id)
,CONSTRAINT fk_cidade_estado FOREIGN KEY (estado_id) REFERENCES estado (id)
,CONSTRAINT cidade_unica UNIQUE(nome, estado_id)
);

-- 5. Escreva o comando para inserir 3 registros da tabela estado com todas as colunas. */
INSERT INTO estado (id,nome,sigla,ativo,data_cadastro) VALUES (DEFAULT,'PARANÁ','PR','S','2022-09-01');
INSERT INTO estado (id,nome,sigla,ativo,data_cadastro) VALUES (DEFAULT,'ACRE','AC','S','2022-09-01');
INSERT INTO estado (id,nome,sigla,ativo,data_cadastro) VALUES (DEFAULT,'MATO GROSSO','MT','S','2022-09-01');

-- 6. Escreva o comando para inserir 2 registros da tabela estado, definindo todos os dados, exceto a chave  primária que é auto incremento.
INSERT INTO estado (nome,sigla,ativo,data_cadastro) VALUES ('SANTA CATARINA','SC','S','2022-09-01');
INSERT INTO estado (nome,sigla,ativo,data_cadastro) VALUES ('MATO GROSSO DO SUL','MS','S','2022-09-01');

-- 7. Escreva o comando para inserir 2 registros da tabela estado, definindo somente os dados necessários.
INSERT INTO estado (nome,sigla) VALUES ('SÃO PAULO','SP');
INSERT INTO estado (nome,sigla) VALUES ('PIAUI','PI');

-- 8. Escreva o comando para inserir registros da tabela cidade das 3 formas apresentadas nos exercícios  anteriores.  
INSERT INTO cidade (id,nome,estado_id,ativo,data_cadastro) VALUES (DEFAULT, 'PARANAVAÍ',1,'S','2021-04-28'); 
INSERT INTO cidade (nome,estado_id,ativo,data_cadastro) VALUES ('SÃO PAULO',6,'S','2021-03-14'); 
INSERT INTO cidade (nome,estado_id) VALUES ('RIO BRANCO',2);

-- 9. Faça a inserção de 2 registros de cliente.  
CREATE TABLE cliente (
id INT NOT NULL AUTO_INCREMENT
,nome VARCHAR(200)  NOT NULL
,cpf CHAR(11) NOT NULL UNIQUE
,telefone CHAR(11) NOT NULL 
,contato CHAR(11) NOT NULL
,ativo ENUM('S','N') NOT NULL DEFAULT 'S'
,data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,cidade_id INT NOT NULL
,CONSTRAINT pk_cliente PRIMARY KEY (id)
,CONSTRAINT fk_cliente_cidade FOREIGN KEY (cidade_id) REFERENCES cidade (id)
);

INSERT INTO cliente (nome,cpf,telefone,contato,cidade_id)VALUES ('Mateus Back', '00000000000','44988888888','44988888888',1);
INSERT INTO cliente (nome,cpf,telefone,contato,cidade_id)VALUES ('Hélio', '99999999999','44999999999','44999999999',2);

-- 10. DESAFIO!!! Tente fazer todas as inserções necessárias para que se tenha um item de caixa. Na medida  que esteja digitando o código, tente associar os dados inseridos com o contexto real.
CREATE TABLE fornecedor (
id INT NOT NULL AUTO_INCREMENT
,nome VARCHAR(200)  NOT NULL
,cnpj CHAR(14) NOT NULL UNIQUE 
,telefone CHAR(11) NOT NULL 
,contato CHAR(11) NOT NULL
,ativo ENUM('S','N') NOT NULL DEFAULT 'S'
,data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,cidade_id INT NOT NULL
,CONSTRAINT pk_fornecedor PRIMARY KEY (id)
,CONSTRAINT fk_fornecedor_cidade FOREIGN KEY (cidade_id) REFERENCES cidade (id)
);

CREATE TABLE compra (
id INT NOT NULL AUTO_INCREMENT
,desconto DOUBLE NOT NULL DEFAULT 0
,total_com_desconto DOUBLE NOT NULL UNIQUE
,ativo ENUM('S','N') NOT NULL DEFAULT 'S'
,data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,fornecedor_id INT NOT NULL
,CONSTRAINT pk_compra PRIMARY KEY (id)
,CONSTRAINT fk_compra_fonecedor FOREIGN KEY (fornecedor_id) REFERENCES fornecedor (id)
);

CREATE TABLE pagamento (
id INT NOT NULL AUTO_INCREMENT
,ativo ENUM('S','N') NOT NULL DEFAULT 'S'
,valor DOUBLE NOT NULL
,numero_parcela INT NOT NULL
,desconto DOUBLE NOT NULL DEFAULT 0
,juros DOUBLE NOT NULL DEFAULT 0
,total_final DOUBLE NOT NULL
,compra_id INT NOT NULL
,CONSTRAINT pk_pagamento PRIMARY KEY (id)
,CONSTRAINT fk_pagamento_compra FOREIGN KEY (compra_id) REFERENCES compra (id)
);

CREATE TABLE venda (
id INT NOT NULL AUTO_INCREMENT
,desconto DOUBLE DEFAULT 0
,total_com_desconto DOUBLE NOT NULL UNIQUE
,ativo ENUM('S','N') NOT NULL DEFAULT 'S'
,data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,cliente_id INT NOT NULL
,CONSTRAINT pk_venda PRIMARY KEY (id)
,CONSTRAINT fk_venda_cliente FOREIGN KEY (cliente_id) REFERENCES cliente (id)
);

CREATE TABLE recebimento (
id INT NOT NULL AUTO_INCREMENT
,ativo ENUM('S','N') NOT NULL DEFAULT 'S'
,valor DOUBLE NOT NULL
,numero_parcela INT NOT NULL
,desconto DOUBLE NOT NULL DEFAULT 0
,juros DOUBLE NOT NULL DEFAULT 0
,total_final DOUBLE NOT NULL
,venda_id INT NOT NULL
,CONSTRAINT pk_recebimento PRIMARY KEY (id)
,CONSTRAINT fk_recebimento_venda FOREIGN KEY (venda_id) REFERENCES venda (id)
);

CREATE TABLE funcionario(
id INT NOT NULL AUTO_INCREMENT
,nome VARCHAR(200)  NOT NULL
,cpf CHAR(11) NOT NULL UNIQUE 
,endereco VARCHAR(110) NOT NULL 
,ativo ENUM('S','N') NOT NULL DEFAULT 'S'
,data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,cidade_id INT NOT NULL
,CONSTRAINT pk_funcionario PRIMARY KEY (id)
,CONSTRAINT fk_funcionario_cidade FOREIGN KEY (cidade_id) REFERENCES cidade (id)
);

CREATE TABLE caixa(
id INT NOT NULL AUTO_INCREMENT
,data_caixa DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,ativo ENUM('S','N') NOT NULL DEFAULT 'S'
,saldo DOUBLE NOT NULL
,funcionario_id INT NOT NULL
,CONSTRAINT pk_recebimento PRIMARY KEY (id)
,CONSTRAINT fk_funcionario_caixa FOREIGN KEY (funcionario_id) REFERENCES funcionario (id)
);

CREATE TABLE item_de_caixa(
id INT NOT NULL AUTO_INCREMENT
,descricao VARCHAR(600) NOT NULL
,valor DOUBLE NOT NULL
,natureza VARCHAR(200) NOT NULL
,hora DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,caixa_id INT NOT NULL
,pagamento_id INT NOT NULL
,recebimento_id INT NOT NULL
,CONSTRAINT pk_item_de_caixa PRIMARY KEY (id)
,CONSTRAINT fk_item_de_caixa_caixa FOREIGN KEY (caixa_id) REFERENCES caixa (id)
,CONSTRAINT fk_item_de_caixa_pagamento FOREIGN KEY (pagamento_id) REFERENCES pagamento (id)
,CONSTRAINT fk_item_de_caixa_recebimento FOREIGN KEY (recebimento_id) REFERENCES recebimento (id)
);

INSERT INTO fornecedor (nome,cnpj,telefone,contato,cidade_id) VALUES ('MERCADO SÃO JOÃO','95862181000171','4422110564','4422110564',1);
INSERT INTO compra (desconto,total_com_desconto,fornecedor_id) VALUES (0.20,80.00,1);
INSERT INTO pagamento (valor,numero_parcela,desconto,juros,total_final,compra_id) VALUES (8.00,1,0.80,0,180.00,1);
INSERT INTO venda (desconto,total_com_desconto,cliente_id) VALUES (0,150.00,1);
INSERT INTO recebimento (valor,numero_parcela,desconto,juros,total_final,venda_id) VALUES (70.00,3,0,0,90.00,1);
INSERT INTO funcionario (nome,cpf,endereco,cidade_id)VALUES ('Marcia', '00000000000','Rua João Sem Braço, N° 121',1);
INSERT INTO caixa (saldo,funcionario_id) VALUES (200.60,'1');
INSERT INTO item_de_caixa (descricao,valor,natureza,caixa_id,pagamento_id,recebimento_id) VALUES ('Morangos Mofados',2.50,'Produtos naturais',1,1,1);

SELECT * FROM item_de_caixa;
