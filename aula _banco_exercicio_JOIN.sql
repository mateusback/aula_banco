/*
Responda as questões:
01 - O que é JOIN? Quando é necessário?*/
-- O JOIN é a junção de tabelas em um banco de dados relacional, é necessario quando queremos combinar linhas de diferentes tabelas de acordo com as relações existentes entre as colunas dessas tabelas. 
-- 02 - Qual a sintaxe do JOIN? Maiúscula ou minúscula faz diferença? Existe algum padrão? Explique.
/* Não existe padronização entre letras maisculas ou minusculas, tudo isso depende do contexto, porém existem dois pardrões de sintaxe para o JOIN, o SQL 89 e o SQL 92. Suas sintaxes são:
SQL 89:
SELECT *
FROM estado, cidade;
WHERE cidade.estado_id = estado.id;

SQL 92:
SELECT *
FROM estado
INNER JOIN cidade ON cidade.estado_id = estado.id;*/
-- 04 - O que é primordial para que o resultado tenha sentido em consultas com JOIN? Explique.
-- Acredito que sejem as condições bem montadas, para que a tabela aponte dados lógicos de forma correta.
-- 05 - Existe mais de uma maneira de realizar o JOIN? Quantas? Qual é a mais eficiente? 
-- Existem inúmeras formas de realizar o JOIN, porém, todas dependem do contexto, não há uma melhor que a outra.
-- 06 - Para realizar o JOIN de 1523 tabelas, quantas comparações de junções são necessárias? Explique.
-- 1522, este é o numero de tabelas que irá entrar na em uma unica tabela.
-- 07 - O que é análise semântica e de sintaxe? Qual a diferença? Para que serve?
-- A sixtaxe diz respeito a um comando. A semântica é a interpretação desta comando para projetar os seus objetivos.
-- 08 - Em uma consulta com JOIN, há casos em que seja necessário atribuir o nome da tabela na projeção das colunas? Explique.
-- Em alguns casos sim, pricipalmente em casos de junções muito grandes
-- 09 - De acordo com o estudo de caso, cite 4 exemplos em que seja possível utilizar o JOIN e 3 exemplos que não seja possível realizar o JOIN.
/* 
Possivel:
fucionario -> estado -> cidade
compra -> funcionário
produto -> marca
recebimento -> icaixa -> caixa

Não possivel:
venda -> estado
caixa -> cliente
categoria -> estado -> eidade
*/

/*
Conforme o estudo de caso, elabore as consultas solicitadas abaixo:
Link do DER: https://github.com/heliokamakawa/curso_bd/blob/master/00-estudo%20de%20caso%20loja%20-%20DER.png
Link do script: https://github.com/heliokamakawa/curso_bd/blob/master/00-estudo%20de%20caso%20%20loja%20-script.sql
obs: Para cada questão utilize o padrão SQL89 e SQL92 */
/*01 - Liste o id e o nome de todas as cidades e as respectivas siglas do estado.
SELECT cidade.id, cidade.nome, sigla
FROM cidade, estado
WHERE estado.id = estado_id;

SELECT cidade.id, cidade.nome, sigla
FROM estado
INNER JOIN cidade ON estado.id = estado_id;
*/

/*02 - Em relação ao resultado do exercício anterior,note que os nomes das colunas não estão claras. Refaça o comando para que torne mais claras.
SELECT 
	cidade.id 'Código da Cidade'
	, cidade.nome 'Nome da Cidade'
	, sigla 'Sigla do Estado'
FROM cidade, estado
WHERE estado.id = estado_id;

SELECT 
	cidade.id 'Código da Cidade'
	, cidade.nome 'Nome da Cidade'
	, sigla 'Sigla do Estado'
FROM estado
INNER JOIN cidade ON estado.id = estado_id
*/

/*03 - Refaça o exercício anterior atribuindo o nome completo da tabela em todos os atributos.
SELECT 
	cidade.id 'Código da Cidade'
	, cidade.nome 'Nome da Cidade'
	, estado.sigla 'Sigla do Estado'
FROM cidade, estado
WHERE estado.id = cidade.estado_id;

SELECT 
	cidade.id 'Código da Cidade'
	, cidade.nome 'Nome da Cidade'
	, estado.sigla 'Sigla do Estado'
FROM estado
INNER JOIN cidade ON estado.id = cidade.estado_id;
*/

/* 04 - Refaça o exercício anterior definindo o apelido na tabela.
SELECT 
	c.id 'Código da Cidade'
	, c.nome 'Nome da Cidade'
	, e.sigla 'Sigla do Estado'
FROM cidade c, estado e
WHERE e.id = c.estado_id;

-- SQL92
SELECT 
	c.id 'Código da Cidade'
	, c.nome 'Nome da Cidade'
	, e.sigla 'Sigla do Estado'
FROM estado e
INNER JOIN cidade c ON e.id = c.estado_id;
*/

/*05 - Explique a diferença entre o exercício 03 e 04. Qual é a melhor? Qual devemos estudar?
Novamente, tudo depende do contexto. no caso da sintaxe sem apelidos, fica mais facil para o entendimento do código, facilitando a manutenção. Porém, aumenta o trabalho na hora da digitação da sintaxe*/

/*06 - Quantos registros foram gerados no resultado do exercício 02? O comando do exercício anterior pode ser utilizado para descobrir as cidades da região sul? Justifique/explique o que ocorre.
mil registros.
Nesse caso, comando anterior deve ser modificado para que apareça APENAS as cidades da região sul, já que ao mostrar todas, já constam as cidades da região sul.
*/
/*07 - Liste o id e o nome de todas as cidades e as respectivas siglas do estado de São Paulo. 
SELECT 
	c.id
	, c.nome
	, e.sigla
FROM cidade c, estado e
WHERE e.id = c.estado_id
	AND e.nome = 'SÃO PAULO';

SELECT 
	c.id
	, c.nome 
	, e.sigla
FROM estado e
INNER JOIN cidade c ON e.id = c.estado_id
WHERE e.nome = 'SÃO PAULO';
*/
/* 08 - Liste o id e o nome de todas as cidades da região sudeste e as respectivas siglas do estado.
SELECT 
	c.id
	, c.nome
	, e.sigla
FROM cidade c, estado e
WHERE e.id = c.estado_id
	AND e.nome IN(SÃO PAULO','RIO DE JANEIRO','MINAS GERAIS','ESPÍRITO SANTO');

-- SQL92
SELECT 
	c.id
	, c.nome
	, e.sigla
FROM estado e
INNER JOIN cidade c ON e.id = c.estado_id
WHERE e.nome IN('SÃO PAULO','RIO DE JANEIRO','MINAS GERAIS','ESPÍRITO SANTO');
*/

/*09 - Escreva a consulta que liste o nome dos Funcionários do estado Paraná.
SELECT 
	f.nome
FROM funcionario f, cidade c, estado e
WHERE e.id = c.estado_id
	AND c.id = f.cidade_id
	AND e.nome = 'PARANÁ';

SELECT 
	f.nome
FROM estado e
INNER JOIN cidade c ON e.id = c.estado_id 
INNER JOIN funcionario f ON c.id = f.cidade_id
WHERE e.nome = 'PARANÁ';
*/

/*10 - Escreva a consulta que liste o nome e o telefone dos Fornecedores da cidade de São Paulo.
SELECT 
	f.nome, f.fone, f.fone_segundario
FROM fornecedor f, cidade c
WHERE 
	c.id = f.cidade_id
	AND c.nome = 'SÃO PAULO';

SELECT 
	f.nome, f.fone, f.fone_segundario 
FROM cidade c 
INNER JOIN fornecedor f ON c.id = f.cidade_id
WHERE c.nome = 'SÃO PAULO';
*/
/*
11 - Liste os produtos da categoria BEBEIDA NÃO ALCÓOLICA e da linha ALIMENTOS E BEBIDAS.
12 - Liste os produtos que possuem a unidade de medida em QUILOGRAMA. 
13 - Em qual categoria e linha pertence o produto REFRIGERANTE COCA-COLA GARRAFA PET 2 L?
14 - Qual o nome da linha onde estão todos os refrigentes? 
15 - Qual o produto (preço de venda) mais caro da categoria BEBEIDA NÃO ALCÓOLICA?
16 - Escreva o comando que apresente a quantidade de produtos líquidos?
17 - Escreva o comando que apresente a quantidade de BEBIDA ALCÓOLICA que estão cadastrados em produtos?
18 - Escreva o comando que liste o nome dos Refrigerantes de 2 L?
19 - Escreva o comando que apresente a média do preço de venda dos Refrigerantes de 2 L?
20 - Com base do estudo de caso, elabore um exercício de sua autoria que envolva pelo menos 3 tabelas, no qual, o resultado possa ajudar o usuário. Em seguida resolva o exercício elaborado.
*/
