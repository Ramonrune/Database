/* ========================================
LBDm - Aula de 23 de agosto de 2017

SQL = 	Structured Query Language 
	(Linguagem Estruturada de Consulta)
DDL =	Data Definition Language
	(Porção SQL para definição de estruturas)
...	CREATE / ALTER / DROP	DataBase/Schema/TABLE...
======================================== */
-- 2.3.1
-- DROP TABLE Editora;

CREATE TABLE Editora_0
(edit_codigo SMALLINT PRIMARY KEY, 
    edit_nome VARCHAR (80) 
);


-- 2.3.3.
-- DROP TABLE Editora_3;
-- COMMIT;

CREATE TABLE Editora_3 
(edit_codigo SMALLINT NOT NULL, 
    edit_nome VARCHAR (80),
    CONSTRAINT PK_Editora_1 PRIMARY KEY (edit_codigo)
); 
COMMIT;


-- 2.3.2.
-- DROP TABLE Editora_2;
-- COMMIT;

CREATE TABLE Editora_2 
(edit_codigo SMALLINT NOT NULL CONSTRAINT PK_Editora_2 PRIMARY KEY, 
    edit_nome VARCHAR (80)    
); 
COMMIT;

-- 2.3.4.
-- DROP TABLE Editora_4;
-- COMMIT;

CREATE TABLE Editora_4
(edit_codigo SMALLINT NOT NULL, 
    edit_nome VARCHAR (80)    
); 
COMMIT;
-- Observe, nas propriedades da tabela, que não há PK!
-- Alterar a tabela, para passar a ter PK...
ALTER TABLE Editora_4
  ADD CONSTRAINT PK_Editora_4 PRIMARY KEY (edit_codigo);
COMMIT;
-- Observe, nas propriedades da tabela, que agora há PK!
-------------------------
-- Tentativa de criação de 2 chaves primárias = ERRO!
-------------------------
CREATE TABLE Editora_X 
(edit_codigo SMALLINT NOT NULL PRIMARY KEY, 
    edit_nome VARCHAR (80) NOT NULL PRIMARY KEY   
); 
COMMIT;
-- ERRO! Não há como uma Tabela ter 2 PKs!
-------------------------- 
-- DROP TABLE Editora_X;
-- COMMIT;
-------------------------- 
-- Tentativa de criação de chave primária composta = Sucesso!
-- Obs.: edit_nome não comporia PK. Aqui, só para teste, ok?
-------------------------- 
CREATE TABLE Editora_X 
(edit_codigo SMALLINT NOT NULL, 
    edit_nome VARCHAR (80),
    CONSTRAINT PK_Editora_X PRIMARY KEY (edit_codigo , edit_nome)
); 
COMMIT;
