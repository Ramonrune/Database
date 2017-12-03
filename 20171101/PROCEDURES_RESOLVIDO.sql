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
SELECT nome, nascim, pais 
FROM Autor
WHERE matricula = 501;


SET TERM^;
CREATE OR ALTER PROCEDURE SP_00
    (i_matricula SMALLINT)
RETURNS
    (
     o_nome VARCHAR(80),
     o_nascim DATE,
     o_pais CHAR(2)
    )
AS
BEGIN
    SELECT nome, nascim, pais
    FROM Autor WHERE matricula = :i_matricula
    INTO :o_nome, :o_nascim, :o_pais;
    SUSPEND;
END^
SET TERM;^
COMMIT;

-------------------------------------------- Executando...
EXECUTE PROCEDURE SP_00(502);-- Experimente com outros códigos, válidos ou não...
EXECUTE PROCEDURE SP_00(5012);
SELECT * FROM SP_00(501);

/*======================
32.2.	Criar o Stored Procedure, SP_01, para mostrar os nomes, datas de nascimento e países dos autores do país, cuja sigla será informada.
======================*/

SELECT nome, nascim, pais FROM Autor WHERE UPPER(pais) = UPPER('BR');

SET TERM^;
CREATE OR ALTER PROCEDURE SP_01
    (i_pais CHAR(02))
RETURNS
    (
     o_nome VARCHAR(80),
     o_nascim DATE,
     o_pais CHAR(02)
    )
AS
BEGIN
    SELECT nome, nascim, pais FROM Autor WHERE UPPER(pais) = UPPER(:i_pais) 
    INTO :o_nome, :o_nascim, :o_pais;
    SUSPEND;
END^
SET TERM;^
COMMIT;

-------------------------------------------- Executando...
SELECT * FROM SP_01('us'); 
-- ERRO! Como há a possibilidade de haver muitos autores deste país, deve-se usar "FOR/DO"...
-------------------------------------------- Refazendo, com "FOR/DO"...
SET TERM^;
CREATE OR ALTER PROCEDURE SP_01
    (i_pais CHAR(02))
RETURNS
    (
     o_nome VARCHAR(80),
     o_nascim DATE,
     o_pais CHAR(02)
    )
AS
BEGIN
    FOR
        SELECT nome, nascim, pais FROM Autor WHERE UPPER(pais) = UPPER(:i_pais) 
        INTO :o_nome, :o_nascim, :o_pais
    DO
    SUSPEND;
END^
SET TERM;^
COMMIT;

-------------------------------------------- Executando...
SELECT * FROM SP_01('us');
SELECT * FROM SP_01('no');
SELECT * FROM SP_01('fr');
SELECT * FROM SP_01('US');

/*======================
32.3.	Mostre os códigos e nomes dos livros, e nomes das editoras que os publicaram, porém somente dos livros publicados a partir de uma data informada como argumento de entrada no Stored Procedure
====================== */
-- 1º) Mostrar todos os dados dos livros lançados após uma determinada data
------
--SELECT L.codlivro, L.titulo, L.lancamento, E.nome FROM Livro L INNER JOIN Editora E ON L.codedit = E.codedit
--WHERE EXTRACT(YEAR FROM L.lancamento) >= EXTRACT(YEAR FROM CAST('2013/10/10' AS DATE));
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

SET TERM^;
CREATE OR ALTER PROCEDURE SP_02
    (i_data DATE)
RETURNS
    (
     o_nomedit VARCHAR(80),
     o_idlivro SMALLINT,
     o_titlivro VARCHAR(80)
    )
AS
BEGIN
    FOR
        Select	L.codlivro, L.titulo, E.nome
        From	Livro L INNER JOIN Editora E ON L.codedit = E.codedit
        Where	lancamento > :i_data
        INTO :o_idlivro, :o_titlivro, :o_nomedit
    DO
    SUSPEND;
END^
SET TERM;^
COMMIT;

--------------------------------------------
-- Experimente, com "2013/10/10" e outras datas...
------
SELECT * FROM SP_02('2013/10/10');

--------------------------------------------
--32.4.	Crie o SP para mostrar os nomes, datas de nascimento dos autores de algum país
------
--FEITO LÁ ENCIMA


/* ============================    
32.5.	Crie o procedimento "SP_AVGLivro" para calcular o preço médio dos livros publicados pela editora, cujo nome será informado externamente
============================ */
-- 1º) Encontrar o preço médio dos livros publicados pela editora, cujo nome é informado
------
SELECT * FROM Livro L INNER JOIN Editora E ON L.codedit = E.codedit WHERE E.nome LIKE '%Brasport%';
SELECT AVG(L.preco) FROM Livro L INNER JOIN Editora E ON L.codedit = E.codedit
WHERE E.nome = 'Marketing Books';
select  avg(preco) from    Livro
where   codedit = 
    (select codedit from Editora
      where nome = 'Marketing Books')
      
set term^;
CREATE OR ALTER PROCEDURE SP_AVGLivro
    (i_nomedit VARCHAR(80))
RETURNS 
    (o_precomed NUMERIC(10,2))
AS 
BEGIN 
    SELECT AVG(L.preco) FROM Livro L INNER JOIN Editora E ON L.codedit = E.codedit
    WHERE E.nome = :i_nomedit INTO :o_precomed;
    SUSPEND;
END^
SET TERM;^
COMMIT;


SELECT  * from SP_AVGLivro ('Marketing Books');
select  * from editora; -- para ver outros nomes de editoras...
-- Experimente com "Pearson Education"
select o_precomed FROM SP_AVGLivro('Marketing Books');

/* ============================    
32.6.	Mostre os títulos, datas de lançamento e valores de todos os livros, cujos preços sejam superiores ao preço médio,
 encontrado no Procedimento "AVGLivro" 	
============================ */

set term^;
CREATE OR ALTER PROCEDURE SP_04
    (i_nomedit VARCHAR(80))
RETURNS 
    (o_titulo VARCHAR(80),
     o_lancamento DATE,
     o_preco NUMERIC(10,2))
AS 
BEGIN 
    FOR
        SELECT titulo, lancamento, preco FROM Livro WHERE preco >= (SELECT  * from SP_AVGLivro (:i_nomedit))
        INTO :o_titulo, :o_lancamento, :o_preco
    DO
    SUSPEND;
END^
SET TERM;^
COMMIT;

SELECT * from SP_04('Marketing Books');
 /* ============================
32.7.	Crie o Stored Procedure "SP_Busca_Livros" para mostrar os códigos, títulos, 
datas de lançamento (se vazia, mostrar "-- não lançado") e preço,
 por ordem de preço decrescente, de todos os livros, 
 cujos títulos contenham uma determinada palavra informada, em qualquer caixa, em qualquer posição do título.
    -- Sugestão: Faça o SELECT primeiramente...
============================*/

SELECT codlivro, titulo, COALESCE(lancamento, 'Não lançado'), preco FROM Livro 
WHERE UPPER(titulo) LIKE UPPER('%C++%')
ORDER BY preco DESC;

set term^;
CREATE OR ALTER PROCEDURE SP_05
    (i_nomelivro VARCHAR(80))
RETURNS 
    (o_codlivro SMALLINT,
     o_titulo VARCHAR(80),
     o_lancamento VARCHAR(20),
     o_preco NUMERIC(10,2))
AS 
BEGIN 
    FOR
       SELECT codlivro, titulo, CAST(COALESCE(lancamento, 'Nao lancado') AS VARCHAR(20)), preco FROM Livro 
       WHERE UPPER(titulo) LIKE UPPER('%' || :i_nomelivro || '%')
       INTO :o_codlivro, :o_titulo, :o_lancamento, :o_preco
    DO
    SUSPEND;
END^
SET TERM;^
COMMIT;


SELECT * FROM SP_05('');