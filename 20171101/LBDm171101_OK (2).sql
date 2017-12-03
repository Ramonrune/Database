/* ===========================================
LBDm - Aula de 01 de novembro de 2017
-------------------------------------------------
01. Copie o LBDm171018_RA.fdb como LBDm171101_RA.fdb, registre-o e conecte-o
02. Salve o texto (.sql) do link 12 da WebPage de hoje como LBDm171101_RA.sql e abra-o
=============================================
STORED PROCEDURES:
=============================================
CREATE or ALTER PROCEDURE <NomedaProcedure>
	( <par�metros de entrada> )
RETURNS 
	( <par�metros de sa�da> )
AS
	<declara��o de vari�veis locais>
BEGIN
	<instru��es SQL/DML/DQL_Somente>
END
===========================================
-- Par�metros de entrada:	Valores iniciais, que servem para estabelecer o comportamento do procedimento (todos os tipos, exceto BLOB ou ARRAY).
-- Par�metros de sa�da:	Valores que retornam os resultados desejados, executados pelo procedimento (idem ao acima).
-- Instru��es SQL:		Conjunto de instru��es SQL/DML e DQL.
=========================================== */
/*======================
32.1.	Criar o Stored Procedure, SP_00, para executar as instru��es acima, por�m, para o autor, cujo c�digo ser� informado via par�metro.
====================== */
-- Antes, mostrar o nome, data de nascimento e pa�s do autor, cujo c�digo � 501:
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
EXECUTE PROCEDURE SP_00 (502);-- Experimente com outros c�digos, v�lidos ou n�o...
SELECT  * from SP_00 (501);	-- Experimente com outros c�digos, v�lidos ou n�o...
/*======================
32.2.	Criar o Stored Procedure, SP_01, para mostrar os nomes, datas de nascimento e pa�ses dos autores do pa�s, cuja sigla ser� informada.
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
-- ERRO! Como h� a possibilidade de haver muitos autores deste pa�s, deve-se usar "FOR/DO"...
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
 FOR                                            -- Permitir� v�rias tuplas de resposta (at� "DO")
    select  nome, nascim, pais
    from    Autor
    where   UPPER (pais) = UPPER (:i_pais)
    INTO    :o_nome, :o_data, :o_pais   -- Por causa do "FOR/DO", perde-se o ";"!
 DO                                             -- Encerra-se a repeti��o "FOR/DO"
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
32.3.	Mostre os c�digos e nomes dos livros, e nomes das editoras que os publicaram, por�m somente dos livros publicados a partir de uma data informada como argumento de entrada no Stored Procedure
====================== */
-- 1�) Mostrar todos os dados dos livros lan�ados ap�s uma determinada data
------
Select	* 
from 	livro
where	lancamento > '2013/10/10'
--------------------------------------------
-- 2�) Idem, mas deve-se tamb�m mostrar o nome da editora correspondente
------
Select	*
From	Livro L INNER JOIN Editora E ON L.codedit = E.codedit
Where	lancamento > '2013/10/10'
--------------------------------------------
-- 3�) Destes, mostrar somente o c�digo e nome do livro, e nome da Editora
------
Select	L.codlivro, L.titulo, E.nome
From	Livro L INNER JOIN Editora E ON L.codedit = E.codedit
Where	lancamento > '2013/10/10'
--------------------------------------------
-- 4�) Por fim, criar a SP_02, utilizando esta l�gica...
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
32.4.	Crie o SP para mostrar os nomes, datas de nascimento dos autores de algum pa�s
------
select  nome, nascim , pais
from    Autor
where   pais = 'BR'
--------------------------------------------
select  *
from    SP_Dados_Autor2 ('BR'); 	-- Oops! H� mais que 1 Autor de 'BR'
--------------------------------------------
-- Corrigir, pois h� mais que 1 autor de 'BR'.
-- Usar o conjunto "FOR...DO�"
--------------------------------------------
�
BEGIN
    FOR
    select  nome, nascim, pais
    from    Autor
    where   pais = :i_pais
    INTO    :o_nome , :o_nascim , :o_pais 	-- Retirar o ";"!
    DO
    SUSPEND;
�
        
select  *
from    SP_Dados_Autor2 ('BR'); 
--------------------------------------------
-- Experimente com 'us'
-- Fa�a funcionar com 'US', em qualquer caixa (mai�sculas ou min�sculas), sempre.
/* ============================    
32.5.	Crie o procedimento "SP_AVGLivro" para calcular o pre�o m�dio dos livros publicados pela editora, cujo nome ser� informado externamente
============================ */
-- 1�) Encontrar o pre�o m�dio dos livros publicados pela editora, cujo nome � informado
------
select  avg(preco) from    Livro
where   codedit = 
    (select codedit from Editora
      where nome = 'Marketing Books')
--------------------------------------------
-- 2�) Criar o SP correspondente...
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
32.6.	Mostre os t�tulos, datas de lan�amento e valores de todos os livros, cujos pre�os sejam superiores ao pre�o m�dio, encontrado no Procedimento "AVGLivro" 	*/
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
32.7.	Crie o Stored Procedure "SP_Busca_Livros" para mostrar os c�digos, t�tulos, datas de lan�amento (se vazia, mostrar "-- n�o lan�ado") e pre�o, por ordem de pre�o decrescente, de todos os livros, cujos t�tulos contenham uma determinada palavra informada, em qualquer caixa, em qualquer posi��o do t�tulo.
    -- Sugest�o: Fa�a o SELECT primeiramente...
============================*/
