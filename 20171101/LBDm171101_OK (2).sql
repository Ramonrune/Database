/* ===========================================
LBDm - Aula de 01 de novembro de 2017
-------------------------------------------------
01. Copie o LBDm171018_RA.fdb como LBDm171101_RA.fdb, registre-o e conecte-o
02. Salve o texto (.sql) do link 12 da WebPage de hoje como LBDm171101_RA.sql e abra-o
=============================================
STORED PROCEDURES:
=============================================
CREATE or ALTER PROCEDURE <NomedaProcedure>
	( <parâmetros de entrada> )
RETURNS 
	( <parâmetros de saída> )
AS
	<declaração de variáveis locais>
BEGIN
	<instruções SQL/DML/DQL_Somente>
END
===========================================
-- Parâmetros de entrada:	Valores iniciais, que servem para estabelecer o comportamento do procedimento (todos os tipos, exceto BLOB ou ARRAY).
-- Parâmetros de saída:	Valores que retornam os resultados desejados, executados pelo procedimento (idem ao acima).
-- Instruções SQL:		Conjunto de instruções SQL/DML e DQL.
=========================================== */
/*======================
32.1.	Criar o Stored Procedure, SP_00, para executar as instruções acima, porém, para o autor, cujo código será informado via parâmetro.
====================== */
-- Antes, mostrar o nome, data de nascimento e país do autor, cujo código é 501:
------
select  nome, nascim, pais
from    Autor
where   matricula = 501
--------------------------------------------
set term^;
CREATE or ALTER PROCEDURE SP_00
    (i_matricula    smallint)
RETURNS
    (o_nome     varchar (80),
     o_nascim   date,
     o_pais     char (02)
     )
AS
BEGIN
    select  nome, nascim, pais
    from    Autor
    where   matricula = :i_matricula
    INTO    :o_nome, :o_nascim, :o_pais;
    SUSPEND;
END^     
set term;^
commit;
-------------------------------------------- Executando...
EXECUTE PROCEDURE SP_00 (502);-- Experimente com outros códigos, válidos ou não...
SELECT  * from SP_00 (501);	-- Experimente com outros códigos, válidos ou não...
/*======================
32.2.	Criar o Stored Procedure, SP_01, para mostrar os nomes, datas de nascimento e países dos autores do país, cuja sigla será informada.
======================*/
select  nome, nascim, pais
from    Autor
where   UPPER (pais) = UPPER ('br')
--------------------------------------------
set term^;
CREATE or ALTER Procedure SP_01
    (i_pais char (02))
RETURNS
    (o_nome varchar (80),
     o_pais   char (02),
     o_data  date
    )
AS
BEGIN
    select  nome, nascim, pais
    from    Autor
    where   UPPER (pais) = UPPER (:i_pais)
    INTO    :o_nome, :o_data, :o_pais;
    SUSPEND;
END^
set term;^
commit;
-------------------------------------------- Executando...
SELECT  * from SP_01 ('us');
-- ERRO! Como há a possibilidade de haver muitos autores deste país, deve-se usar "FOR/DO"...
-------------------------------------------- Refazendo, com "FOR/DO"...
set term^;
CREATE or ALTER Procedure SP_01
    (i_pais char (02))
RETURNS
    (o_nome varchar (80),
     o_pais   char (02),
     o_data  date
    )
AS
BEGIN
 FOR                                            -- Permitirá várias tuplas de resposta (até "DO")
    select  nome, nascim, pais
    from    Autor
    where   UPPER (pais) = UPPER (:i_pais)
    INTO    :o_nome, :o_data, :o_pais   -- Por causa do "FOR/DO", perde-se o ";"!
 DO                                             -- Encerra-se a repetição "FOR/DO"
 SUSPEND;
END^
set term;^
commit;
-------------------------------------------- Executando...
SELECT  * from SP_01 ('us');
SELECT  * from SP_01 ('no');
SELECT  * from SP_01 ('fr');
SELECT  * from SP_01 ('US');
/*======================
32.3.	Mostre os códigos e nomes dos livros, e nomes das editoras que os publicaram, porém somente dos livros publicados a partir de uma data informada como argumento de entrada no Stored Procedure
====================== */
-- 1º) Mostrar todos os dados dos livros lançados após uma determinada data
------
Select	* 
from 	livro
where	lancamento > '2013/10/10'
--------------------------------------------
-- 2º) Idem, mas deve-se também mostrar o nome da editora correspondente
------
Select	*
From	Livro L INNER JOIN Editora E ON L.codedit = E.codedit
Where	lancamento > '2013/10/10'
--------------------------------------------
-- 3º) Destes, mostrar somente o código e nome do livro, e nome da Editora
------
Select	L.codlivro, L.titulo, E.nome
From	Livro L INNER JOIN Editora E ON L.codedit = E.codedit
Where	lancamento > '2013/10/10'
--------------------------------------------
-- 4º) Por fim, criar a SP_02, utilizando esta lógica...
------
set term^;
Create or Alter Procedure SP_02
    (i_data date)
RETURNS
    (o_nomedit  varchar (80),
     o_idlivro     smallint,
     o_titlivro    varchar (80)
    )
AS
BEGIN
    FOR
        Select	L.codlivro, L.titulo, E.nome
        From	Livro L INNER JOIN Editora E ON L.codedit = E.codedit
        Where	lancamento > :i_data
        
        INTO    :o_idlivro, :o_titlivro, :o_nomedit
    DO
    SUSPEND;
END^
set term;^
commit;
--------------------------------------------
-- Experimente, com "2013/10/10" e outras datas...
------
Select  * from SP_02 ('2013/10/10');
--------------------------------------------
32.4.	Crie o SP para mostrar os nomes, datas de nascimento dos autores de algum país
------
select  nome, nascim , pais
from    Autor
where   pais = 'BR'
--------------------------------------------
select  *
from    SP_Dados_Autor2 ('BR'); 	-- Oops! Há mais que 1 Autor de 'BR'
--------------------------------------------
-- Corrigir, pois há mais que 1 autor de 'BR'.
-- Usar o conjunto "FOR...DO…"
--------------------------------------------
…
BEGIN
    FOR
    select  nome, nascim, pais
    from    Autor
    where   pais = :i_pais
    INTO    :o_nome , :o_nascim , :o_pais 	-- Retirar o ";"!
    DO
    SUSPEND;
…
        
select  *
from    SP_Dados_Autor2 ('BR'); 
--------------------------------------------
-- Experimente com 'us'
-- Faça funcionar com 'US', em qualquer caixa (maiúsculas ou minúsculas), sempre.
/* ============================    
32.5.	Crie o procedimento "SP_AVGLivro" para calcular o preço médio dos livros publicados pela editora, cujo nome será informado externamente
============================ */
-- 1º) Encontrar o preço médio dos livros publicados pela editora, cujo nome é informado
------
select  avg(preco) from    Livro
where   codedit = 
    (select codedit from Editora
      where nome = 'Marketing Books')
--------------------------------------------
-- 2º) Criar o SP correspondente...
--------------------------------------------
set term^;
Create or Alter Procedure SP_AVGLivro
    (i_nomedit    varchar (80))
RETURNS
    (o_precomed   numeric (10,2))
AS
BEGIN
    select  avg(preco) from    Livro
    where   codedit = 
        (select codedit from Editora
         where nome = :i_nomedit)
    INTO    :o_precomed;
    SUSPEND;
END^
set term;^
commit;
-------------------------------------------- Executando...
SELECT  * from SP_AVGLivro ('Marketing Books');
select  * from editora; -- para ver outros nomes de editoras...
-- Experimente com "Pearson Education"
SELECT  o_precomedio from SP_AVGLivro ('Marketing Books');
/* ============================    
32.6.	Mostre os títulos, datas de lançamento e valores de todos os livros, cujos preços sejam superiores ao preço médio, encontrado no Procedimento "AVGLivro" 	*/
============================ */
Select      titulo, lancamento, preco
from    Livro
where   preco >
    (SELECT  o_precomedio from AVGLivro ('Marketing Books'))
--------------------------------------------
...
        where   preco >
        (SELECT  o_precomedio from AVGLivro (:i_nomeEditora))

--------------------------------------------
SELECT  * from SP_03 ('Marketing Books');
 /* ============================
32.7.	Crie o Stored Procedure "SP_Busca_Livros" para mostrar os códigos, títulos, datas de lançamento (se vazia, mostrar "-- não lançado") e preço, por ordem de preço decrescente, de todos os livros, cujos títulos contenham uma determinada palavra informada, em qualquer caixa, em qualquer posição do título.
    -- Sugestão: Faça o SELECT primeiramente...
============================*/
