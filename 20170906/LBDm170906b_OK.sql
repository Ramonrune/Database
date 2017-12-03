/* ===================================
LBDm - Aula de 06 de setembro de 2017
Structured Query Language – SQL/DML
Prof. MS Wagner Siqueira Cavalcante
===================================
Inserção de dados em tabela:
INSERT INTO <TABELA> [(<atrib_1>, <atrib_2>, ..., <atrib_n>)]
    VALUES ( <conteudo_atrib_1>, <conteudo_atrib_2>, ..., <conteudo_atrib_n> ) ;
===================================
Algumas dicas:
01. Usar os nomes de atributos quando:
    01.1. Não estiverem na mesma ordem da estrutura
    01.2. Alguns atributos estiverem sem valor
02. Os conteúdos serão compatíveis com a definição!
03. Pode-se entrar com conteúdo via janela de diálogo, acrescentando-se ":<legenda_do_atributo>"...
------------------------------------------------------------------ */
-- 22.1. Inserir a informação de que o autor 502 escreveu o livro 1000, na tabela Escreve:
    INSERT INTO Escreve (matricula , codlivro ) 
    VALUES (502 , 1000);
-- ERRO! Deveria haver o Livro e o Autor ANTES!
------------------------------------------------------------------
/* 22.2. Inserir o Livro "Análise Estruturada de Dados", de código 1000, 
            com preço de R$ 74,00, lançado em 10/10/1994, de assunto "A", 
            pela Editora "13"
*/
    INSERT INTO LIVRO 
    VALUES (1000, 'Análise Estruturada de Dados', 74, '1994-10-10', 'A', 13);
	COMMIT;
-- ERRO! Deveria haver a Editora 13 antes!
-- Inserir o mesmo livro, mas sem Editora...
    INSERT INTO LIVRO 
    VALUES (1000, 'Análise Estruturada de Dados', 74, '1994-10-10', 'A', NULL);
	COMMIT;
-- ERRO! Deveria haver o assunto "A" antes!
===================================
-- 22.2b. Inserir o Assunto "A", que é "Análise de Sistemas":
    INSERT INTO Assunto
    values ('A', "Análise de Sistemas");
-- ERRO! Deveria estar entre apóstrofes (' Análise de Sistemas')!
    INSERT INTO Assunto
    values ('A', 'Análise de Sistemas');
    SELECT * FROM Assunto;
-- Aspas delimitam apelido (para atributo, por exemplo)
    SELECT sigla, descricao from Assunto;   -- Observe o título DESCRICAO
    SELECT sigla, descricao AS "Descrição" from Assunto;    -- Agora, Descrição
    SELECT sigla, descricao AS "Nhonho" from Assunto;   -- Agora, Nhonho...
===================================
-- Agora, sim, insira o livro sugerido...
    INSERT INTO LIVRO 
    VALUES (1000, 'Análise Estruturada de Dados', 74, '1994-10-10', 'A', NULL);
	COMMIT;
    select * from Livro;    -- Agora, sim!
-- Insira o mesmo livro, porém com código 1001 e assunto "a"
    INSERT INTO LIVRO 
    VALUES (1001, 'Análise Estruturada de Dados', 74, '1994-10-10', 'a', NULL);
	COMMIT;
-- ERRO! A sigla cadastrada é "A", e não "a".
-- Observe que pode haver livros com o mesmo título, mas não com o mesmo código!
===================================
-- 22.2d. Inserir o mesmo livro, mas com código 1001 e sem NULL em editora
    INSERT INTO LIVRO 
    VALUES (1001, 'Análise Estruturada de Dados', 74, '1994-10-10', 'A');
	COMMIT;
-- ERRO! Está tentando inserir 5 colunas, mas há 6 em Livro...
    INSERT INTO LIVRO (codlivro, titulo, preco, lancamento, sigla)
    VALUES (1001, 'Análise Estruturada de Dados', 74, '1994-10-10', 'A');
	COMMIT;
	select * from Livro;
===================================
-- 22.2d. Idem ao anterior, mas com código 1002 e título como primeiro atributo
    INSERT INTO LIVRO (titulo, codlivro, preco, lancamento, sigla)
    VALUES ('Análise Estruturada de Dados', 1002, 74, '1994-10-10', 'A');
	COMMIT;
	select * from Livro;
===================================
-- 22.3. Inserir as tuplas em Autor:
    INSERT INTO AUTOR 
        VALUES (501, 'Rogério Luís de C. Costa', '11111111111', 
        'Rua Dom Pedro I, 111', '1971-01-01', 'BR');
    INSERT INTO AUTOR 
        VALUES (502, 'Chris Gane', '11111111111', 
        'Av La Rue, XV', '1952-02-02', 'US');
    select * from Autor;
-- ? Execute! -- Oops! Não poderia haver 2 CPFs iguais! 
-- Corrija a estrutura de Autor!
    ROLLBACK;   -- Como estava na RAM, apenas evita de ir para o HD
    select * from Autor;
-- Alterando a tabela Autor, para evitar CPFs iguais...
    ALTER TABLE Autor
        ADD CONSTRAINT UN_cpf UNIQUE (cpf);
    COMMIT;
-- Tente executar ambas as inserções em Autor
    INSERT INTO AUTOR 
        VALUES (501, 'Rogério Luís de C. Costa', '11111111111', 
        'Rua Dom Pedro I, 111', '1971-01-01', 'BR');
    INSERT INTO AUTOR 
        VALUES (502, 'Chris Gane', '11111111111', 
        'Av La Rue, XV', '1952-02-02', 'US');
-- Beleza! Evitou 2 CPFs iguais!
-- Corrigir, para CPF = "22222222222" (11 "doises")
    INSERT INTO AUTOR 
        VALUES (502, 'Chris Gane', '22222222222', 
        'Av La Rue, XV', '1952-02-02', 'US');
    select * from Autor;
===================================
-- 22.4. Inserir as tuplas em Editora:
    select * from Livro;
    select * from Editora;
-- Inserir a editora 11, ' Pearson', e 22, 'Makron'
    insert into Editora values (11,'Pearson');
    insert into Editora values (22,'Makron');
    select * from Editora;
===================================
/* --------------------------------------------------------------------------
Alteração de dados em tabela:
UPDATE <TABELA>
SET <atrib_1> = <conteudo_atrib_1>,
<atrib_2> = <conteudo_atrib_2>,
...,
<atrib_n> = <conteudo_atrib_n>
WHERE <condição>
-------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------
Exclusão de dados de uma tabela:
DELETE FROM <TABELA>
WHERE <condição> 
-- Atenção! A condição (“WHERE”) é fundamental! 
Sem ela, TODOS os dados serão apagados da tabela!
-------------------------------------------------------------------------- */
select * from assunto;
select * from Livro;
-- 22.5. Modifique o assunto "A" para "S"
    UPDATE  Assunto
    SET         sigla = 'S'
    WHERE   sigla = 'A';
    commit;
-- ERRO! Não consegue, pois há vários livros já com "A"
/* --------------------------------------------------------------------------
Provisoriamente:
    1. Remover todos os dados de Livros
    2. Atualizar a estrutura de Livro, com "ON UPDATE CASCADE" na FK sigla
    3. Reinserir os dados de Livros, com assunto "A" e mostrá-los
    4. Atualizar as siglas, de "A" para "S" em Assunto
    5. Mostrar os dados de Livros novamente
--------------------------------------------------------------------------*/
-- 1. Remover todos os dados de Livros
DELETE  FROM Livro; COMMIT;
--------------------------------------------------------------------------
-- 2. Atualizar a estrutura de Livro, com "ON UPDATE CASCADE" na FK sigla
ALTER TABLE Livro  
    DROP Constraint FK_Assunto,
    ADD Constraint FK_Assunto FOREIGN KEY (sigla)
    Assunto (sigla)
        ON UPDATE CASCADE;
COMMIT;        
--------------------------------------------------------------------------
-- 3. Reinserir os dados de Livros, com assunto "A" e mostrá-los
    INSERT INTO LIVRO 
    VALUES (1000, 'Análise Estruturada de Dados', 74, '1994-10-10', 'A', NULL);
	COMMIT;
    INSERT INTO LIVRO (codlivro, titulo, preco, lancamento, sigla)
    VALUES (1001, 'Análise Estruturada de Dados', 74, '1994-10-10', 'A');
	COMMIT;
	select * from Livro;
--------------------------------------------------------------------------
-- 4. Atualizar as siglas, de "A" para "S" em Assunto
    UPDATE  Assunto
    SET         sigla = 'S'
    WHERE   sigla = 'A';
    commit;
    select * from Assunto;  -- Observe que a sigla agora é "S"
--------------------------------------------------------------------------
-- 5. Mostrar os dados de Livro novamente
	select * from Livro;    -- Observe que a sigla também mudou-se em Livro
===================================
