/* ===========================================
STORED PROCEDURES:
=============================================
CREATE or ALTER PROCEDURE <NomedaProcedure>
	( <parâmetros de entrada> )
RETURNS 
	( <parâmetros de saída> )
AS
	<declaração de variáveis locais>
BEGIN
	<instruções SQL>
END
===========================================
-- Parâmetros de entrada:	Valores iniciais, que servem para estabelecer o comportamento do procedimento (todos os tipos, exceto BLOB ou ARRAY).
-- Parâmetros de saída:	Valores que retornam os resultados desejados, executados pelo procedimento (idem ao acima).
-- Instruções SQL:		Conjunto de instruções SQL/DML e DQL.
=========================================== */
/*======================
32.1.	Criar o Stored Procedure, SP_00, para mostrar o nome, data de nascimento e país do autor, cujo código será informado via parâmetro.
====================== */
-- Antes, mostrar o nome, data de nascimento e país do autor, cujo código é 501:
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
commit;
-------------------------------------------- Executando...
EXECUTE PROCEDURE SP_00 (502);-- Experimente com outros códigos, válidos ou não...
SELECT  * from SP_00 (502);	-- Experimente com outros códigos, válidos ou não...
/*======================
32.2.	Criar o Stored Procedure, SP_01, para mostrar os nomes, datas de nascimento e países dos autores do país, cuja sigla será informada.
======================*/
select  nome, nascim, pais
from    Autor
where   UPPER (pais) = UPPER ('br')
--------------------------------------------

-------------------------------------------- Executando...
SELECT  * from SP_01 ('us'); 		-- Não encontra, pois deveria ser “US”
SELECT  * from SP_01 ('US'); 	-- Agora, sim! 
/*======================
32.3.	Mostre os códigos e nomes dos livros, e nomes das editoras que os publicaram, porém somente dos livros publicados a partir de uma data informada como argumento de entrada no Stored Procedure
====================== */
-- 1º) Mostrar todos os dados dos livros lançados após uma determinada data
Select	* 
from 	livro
where	lancamento > '2013/10/10'
--------------------------------------------
-- 2º) Idem, mas deve-se também mostrar o nome da editora correspondente
Select	*
From	Livro L INNER JOIN Editora E ON L.codedit = E.codedit
Where	lancamento > '2013/10/10'
--------------------------------------------
-- 3º) Destes, mostrar somente o código e nome do livro, e nome da Editora
Select	L.codlivro, L.titulo, E.nome
From	Livro L INNER JOIN Editora E ON L.codedit = E.codedit
Where	lancamento > '2013/10/10'
--------------------------------------------
-- 4º) Por fim, criar a SP_02, utilizando esta lógica...

--------------------------------------------
-- Experimente, com "2013/10/10" e outras datas...
Select  * from SP_02 ('2013/10/10');
--------------------------------------------
32.4.	Crie o SP para mostrar os nomes, datas de nascimento dos autores de algum país
select  nome, nascim , pais
from    Autor
where   pais = 'BR'
--------------------------------------------

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
32.5.	Crie o procedimento "AVGLivro" para calcular o preço médio dos livros publicados pela editora, cujo nome será informado externamente
============================ */
-- 1º) Encontrar o preço médio dos livros publicados por determinada editora
select  avg(preco) from    Livro
where   codedit = 
    (select codedit from Editora
      where nome = 'Marketing Books')
-- 2º) Criar o SP correspondente...
--------------------------------------------

-------------------------------------------- Executando...
SELECT  * from AVGLivro ('Marketing Books');
SELECT  o_precomedio from AVGLivro ('Marketing Books');
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
32.7.	Crie o Stored Procedure "SP_Busca_Livros" para mostrar o código, título e nome da respectiva editora (se o livro ainda não foi editado, mostrar), data de lançamento (se vazia, mostrar "-- não lançado") e preço, por ordem de preço decrescente, de todos os livros, cujos títulos contenham uma determinada palavra informada, em qualquer caixa, em qualquer posição do título.
    -- Sugestão: Faça o SELECT primeiramente...
============================*/
