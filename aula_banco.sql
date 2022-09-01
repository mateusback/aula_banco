DROP DATABASE IF EXISTS aula_banco;
CREATE DATABASE aula_banco;

USE aula_banco;

DROP TABLE IF EXISTS estado;

CREATE TABLE estado( -- As Regras de uma tabela são definidas pelas regras de negócio
id INT NOT NULL AUTO_INCREMENT -- Regras definidas na linha = CONSTRAINT INLINE
,nome VARCHAR(200) NOT NULL UNIQUE
,sigla CHAR(2) NOT NULL UNIQUE
,ativo CHAR(1) NOT NULL DEFAULT 'S' -- Definindo um valor padrão
,data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP -- Variavel que pega a data atual
/* ,CHECK (ativo IN ('S','N') ) 
Está é uma regra SEM NOME para a definição de valores de ativos. 
Regras definidas fora da linha = CONSTRAINT OUT OF LINE */
,CONSTRAINT pk_estado PRIMARY KEY (id)
,CONSTRAINT estado_ativo_deve_ser_S_ou_N CHECK (ativo IN ('S','N') ) -- Regra com nome, diferente da anterior
);

/*
INSERT INTO estado (id,nome,sigla,ativo,data_cadastro) 
VALUES (1, 'Paraná', 'PR', 'S', '2022-08-31') -- datetime no formato (aaaa-mm--dd)
*/
INSERT INTO estado (nome,sigla) VALUES ('Paraná', 'PR');
INSERT INTO estado (nome,sigla) VALUES ('Santa Catarina', 'SC');

SELECT * FROM estado; 

CREATE TABLE cidade(
id INT NOT NULL AUTO_INCREMENT 
,nome VARCHAR(200) NOT NULL UNIQUE
,estado_id INT NOT NULL
,ativo CHAR(1) NOT NULL DEFAULT 'S' 
,data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP 
,CONSTRAINT pk_cidade PRIMARY KEY (id)
,CONSTRAINT fk_cidade_estado FOREIGN KEY (estado_id) REFERENCES estado (id) -- uma fk sempre referencia uma pk
,CONSTRAINT cidade_ativo_deve_ser_S_ou_N CHECK (ativo IN ('S','N') )
,CONSTRAINT cidade_unica UNIQUE(nome, estado_id) -- Regra que define que a combinação do nome da cidade e do id de um estado sejam unicas.
);

INSERT INTO cidade (nome, estado_id) VALUES ('Paranavaí', '1');
INSERT INTO cidade (nome, estado_id) VALUES ('Criciúma', '2');

SELECT * FROM cidade; 
