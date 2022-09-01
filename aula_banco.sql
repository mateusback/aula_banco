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

/*
A alteração de tabelas é normal nas fases inicais do projeto, quando o cliente ainda não tem acesso.
Nesse caso, é só alterar direto no script da tabela.
 - Se a base de dados já estiver sendo utilizada, deve-se usar o ALTER TABLE
*/

ALTER TABLE estado ADD COLUMN regiao VARCHAR(100) NOT NULL; -- adicionado uam coluna na tabela estado


-- ALTER TABLE estado MODIFY COLUMN regiao VARCHAR(100) NOT NULL; -- mudando o tipo de uma coluna já existente. 
-- ALTER TABLE estado DROP COLUMN regiao;
ALTER TABLE estado MODIFY COLUMN regiao VARCHAR(100) NOT NULL DEFAULT 'valor não informado' AFTER NOME;
/*
O AFTER é referente a posição da coluna na tabela, para colocar em primeiro lugar, usar FIRST
*/
ALTER TABLE estado MODIFY COLUMN regiao VARCHAR(100) NOT NULL AFTER sigla;
ALTER TABLE estado CHANGE regiao regiao_estado VARCHAR(100) NOT NULL; -- alterando o nome de uma coluna
ALTER TABLE estado DROP CONSTRAINT estado_ativo_deve_ser_S_ou_N; -- dropando uma regra > importancia de nomear uma regra
ALTER TABLE estado MODIFY COLUMN ativo ENUM('S','N') NOT NULL; -- ENUM retringe um conjunto de valores
DESCRIBE estado; -- descreve os detalhes da tabela
/*
definir que uma coluna não pode ter valores nulos, quando já existem gera erro. Levando a duas possibilidades:
eliminar os valores nulos
eliminar toda a coluna CASO NÃO TENHA NENHUM VALOR.
*/
UPDATE estado SET nome = 'PARANA' WHERE id = 1; -- Mudando o nome pelo ID porque ele é único
UPDATE estado SET nome = 'PARANÁ', ativo = 'N' WHERE id = 1; -- mundando duas colunas de uma tabela
UPDATE estado SET ativo = 'N'; -- mudando todos os ativos de uma vez, se o sistema não estiver em modo de segurança
UPDATE cidade SET ativo = 'N' WHERE estado_id = 1; -- mudando dados da tabela cidade com o id do estado

DELETE FROM cidade WHERE id = 1; -- Deletando com o ID porque ele é único; 
DELETE FROM cidade WHERE estado_id = 1; -- Deletando todas as cidades de um estado (BOMBA)
