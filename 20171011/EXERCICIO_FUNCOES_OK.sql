/* -------------------------------------------------------
LBDm - Aula de 11 de outubro de 2017
--
01. Abra o LBDm170927_RA.fdb (ou baixe-o do Site, do dia 27/09)
02. Baixe e abra o item 10 da aula de hoje, pelo Editor SQL
------------------------------------------------------- 

Fun��es de agrega��o:	
COUNT (<atrib>)	-> quantidade, contagem de <atrib>
SUM (<atrib>)	-> soma de valores de <atrib>
AVG (<atrib>)	-> m�dia aritm�tica de <atrib>
MIN (<atrib>)	-> menor valor de <atrib>
MAX  (<atrib>)	-> maior valor de <atrib>
GROUP BY <atributo_n�o_agregado>
------------------------------------------------------- */
-- 02.18.	Mostrar quantos livros est�o cadastrados
select * from Livro
--
select  COUNT (*) from Livro;
-----------------------------------------------------------
-- 02.19.	Mostrar quantos livros foram aceitos por editoras
select * from Livro
--
select  COUNT (*) 
from    Livro
where  codedit IS NOT NULL 
-----------------------------------------------------------
-- 02.20.	Mostrar a soma dos pre�os dos livros
select * from Livro
--
select  SUM (preco)
from    Livro
-----------------------------------------------------------
-- 02.20b.	Mostrar a soma dos pre�os dos livros lan�ados antes de 2015
select * from Livro
--
select  SUM (preco)
from    Livro
where   EXTRACT (YEAR FROM lancamento) < 2015
-----------------------------------------------------------
-- 02.21.	Mostrar o pre�o m�dio dos livros
select * from Livro
--
select  SUM (preco) / COUNT (*)
from    Livro
--
select  AVG (preco)
from    Livro
-----------------------------------------------------------
-- 02.22.	Mostrar quantos livros h�, qual a soma de seus pre�os e o pre�o m�dio
select  COUNT (*), SUM (preco), AVG (preco)
from    Livro
--
select  COUNT (*) "qtde", SUM (preco) "$ Total", AVG (preco) "$ M�dio"
from    Livro
-----------------------------------------------------------
-- 02.23.	Mostrar o menor pre�o, bem como o maior, o m�dio e a quantidade de livros (embora n�o signifique nada aqui, acrescente a soma):
select  MIN (preco), MAX (preco), AVG (preco), COUNT (*), SUM (preco)
from    Livro
--
-----------------------------------------------------------
-- 02.24.	Mostrar cada assunto, em ordem inversa, e quantos livros h� de cada
select  * from Livro;
--
select  sigla, COUNT (sigla)
from    Livro
--
select  sigla, COUNT (sigla)
from    Livro
GROUP BY sigla
--
select  sigla, COUNT (sigla)
from    Livro
GROUP BY sigla
ORDER BY sigla DESCENDING   -- ou apenas "DESC"
-----------------------------------------------------------
-- 02.25.	Mostrar quantos livros foram aceitos por cada editora
select  * from Livro
--
select  codedit, count (*)
from    Livro
group   by codedit
-----------------------------------------------------------
-- 02.25b.	Mostrar quantos livros foram aceitos por cada editora, apenas daqueles, cuja quantidade seja maior ou igual a 2
select  * from Livro
--
select  codedit, count (*)
from    Livro
where    count (*) >= 2
group   by codedit
--
select  codedit, count (*)
from    Livro
group   by codedit
HAVING    count (*) >= 2
-----------------------------------------------------------
-- 02.26.	Mostrar quantos livros foram lan�ados por ano
select  * from Livro
--
select  EXTRACT (YEAR from lancamento), count (*)
from    Livro
GROUP BY  EXTRACT (YEAR from lancamento)
-----------------------------------------------------------
-- 02.27.	Inserir o livro "Sistemas Operacionais", cujo c�digo � o imediatamente posterior ao �ltimo, aceito, mas n�o lan�ado pela Editora de c�digo = 11, com pre�o de R$ 173,95, e com assunto Sistemas Operacionais
-----------------------------------------------------------
-- 0a�) Mostrar todos os assuntos, para conferir a sigla de "Sistemas Operacionais"
select  * from Assunto
-- 0b�) Mostrar todos os livros, s� para entender o que se pede...
select  * from Livro
-- 1�) Mostrar o �ltimo c�digo de livro:
select  MAX (codlivro) from Livro
-- 2�) Mostrar o �ltimo c�digo de livro, +1:
select  MAX (codlivro) + 1 from Livro
-- 3�) Inserir o novo livro, com este c�digo encontrado:
INSERT INTO Livro (codlivro, titulo, preco, sigla, codedit)
VALUES ((select  MAX (codlivro) + 1 from Livro), 
            'Sistemas Operacionais', 173.95, 'S', 11);
select  * from Livro;
-----------------------------------------------------------
-- 02.27b. Inserir o livro "Sistemas Operacionais Robustos", cujo c�digo � o imediatamente posterior ao �ltimo, com pre�o R$ 20,00 acima do pre�o m�dio dos livros, aceito, mas n�o lan�ado pela Editora Brasport Editora, e assunto de Sistemas Operacionais
-----------------------------------------------------------
-- 0�) Encontre o �ltimo c�digo de livro + 1
select  MAX (codlivro) + 1 from Livro
-- 1�) Encontre o pre�o m�dio, adicionado a R$ 20,00
select  AVG (preco) + 20 from Livro
-- 2�) Encontre o c�digo da editora "Brasport Editora"
select  codedit 
from    Editora
where   UPPER (nome) = UPPER ('Brasport Editora')
-- 3�) Encontre a sigla do assunto "Sistemas Operacionais"
select  sigla
from    Assunto
where   UPPER (descricao) = UPPER ('Sistemas Operacionais')
-- 4�) Junte tudo e sirva com queijo parmes�o ralado na hora...
INSERT INTO Livro (codlivro, titulo, preco, sigla, codedit)
    VALUES (  (select  MAX (codlivro) + 1 from Livro),
                    'Sistemas Operacionais Robustos',
                    (select  AVG (preco) + 20 from Livro),
                    (select  sigla
                     from    Assunto
                     where   UPPER (descricao) = UPPER ('Sistemas Operacionais')),
                    (select  codedit 
                     from    Editora
                     where   UPPER (nome) = UPPER ('Brasport Editora'))
                );
select * from Livro;
/* -------------------------------------------------------
�SUBSELECT� --> select de select�	
	SELECT	<atributo_1>, �, <atributo_n>
	FROM 	<Rela��o>
	WHERE	<atributo_x> [NOT] IN / <operador_l�gico>
		(SELECT   �)
------------------------------------------------------- */
-- 02.28.	Mostrar os t�tulos e pre�os dos livros, cujo pre�os sejam superiores ao pre�o m�dio
--
-- 1�) Encontrar o pre�o m�dio
select  AVG (preco) from Livro
-- 0�) Mostre todos os livros, para se ter uma no��o do que se quer...
select * from Livro
-- 2�) Mostrar, em fun��o deste pre�o m�dio encontrado
select  titulo, preco
from    Livro
where   preco > 
            (select  AVG (preco) from Livro)
------------------------------------------------------- */
-- 02.28b. Mostrar os t�tulos e pre�os dos livros, cujos livros tenham sido aceitos pela editora "Pearson Education"
--
select  titulo, preco --, codedit
from    Livro
where   codedit = 
            (select codedit from Editora
             where UPPER (nome) = UPPER ('Pearson Education'))
------------------------------------------------------- */
-- 02.28c.	 Mostrar os t�tulos e pre�os dos livros, aceitos por alguma editora, cujo nome cont�m a palavra "Editora" em alguma posi��o, em qualquer caso.
select  titulo, preco
from    Livro
where  codedit = 
            (select codedit from Editora
            where   UPPER (nome) LIKE UPPER ('%editora%'))
-- ERRO!
select  titulo, preco
from    Livro
where  codedit IN
            (select codedit from Editora
            where   UPPER (nome) LIKE UPPER ('%editora%'))

-----------------------------------------------------------
-- 02.29.	Mostrar os dados dos livros lan�ados ap�s o livro, cujo nome ser� informado externamente
--
-----------------------------------------------------------
-- 02.30.	Mostrar os dados dos livros lan�ados ap�s o livro, cujo trecho de nome ser� informado
--
-----------------------------------------------------------
