/* -------------------------------------------------------
LBDm - Aula de 11 de outubro de 2017
--
01. Abra o LBDm170927_RA.fdb (ou baixe-o do Site, do dia 27/09)
02. Baixe e abra o item 10 da aula de hoje, pelo Editor SQL
------------------------------------------------------- 

Funções de agregação:	
COUNT (<atrib>)	-> quantidade, contagem de <atrib>
SUM (<atrib>)	-> soma de valores de <atrib>
AVG (<atrib>)	-> média aritmética de <atrib>
MIN (<atrib>)	-> menor valor de <atrib>
MAX  (<atrib>)	-> maior valor de <atrib>
GROUP BY <atributo_não_agregado>
------------------------------------------------------- */
-- 02.18.	Mostrar quantos livros estão cadastrados
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
-- 02.20.	Mostrar a soma dos preços dos livros
select * from Livro
--
select  SUM (preco)
from    Livro
-----------------------------------------------------------
-- 02.20b.	Mostrar a soma dos preços dos livros lançados antes de 2015
select * from Livro
--
select  SUM (preco)
from    Livro
where   EXTRACT (YEAR FROM lancamento) < 2015
-----------------------------------------------------------
-- 02.21.	Mostrar o preço médio dos livros
select * from Livro
--
select  SUM (preco) / COUNT (*)
from    Livro
--
select  AVG (preco)
from    Livro
-----------------------------------------------------------
-- 02.22.	Mostrar quantos livros há, qual a soma de seus preços e o preço médio
select  COUNT (*), SUM (preco), AVG (preco)
from    Livro
--
select  COUNT (*) "qtde", SUM (preco) "$ Total", AVG (preco) "$ Médio"
from    Livro
-----------------------------------------------------------
-- 02.23.	Mostrar o menor preço, bem como o maior, o médio e a quantidade de livros (embora não signifique nada aqui, acrescente a soma):
select  MIN (preco), MAX (preco), AVG (preco), COUNT (*), SUM (preco)
from    Livro
--
-----------------------------------------------------------
-- 02.24.	Mostrar cada assunto, em ordem inversa, e quantos livros há de cada
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
-- 02.26.	Mostrar quantos livros foram lançados por ano
select  * from Livro
--
select  EXTRACT (YEAR from lancamento), count (*)
from    Livro
GROUP BY  EXTRACT (YEAR from lancamento)
-----------------------------------------------------------
-- 02.27.	Inserir o livro "Sistemas Operacionais", cujo código é o imediatamente posterior ao último, aceito, mas não lançado pela Editora de código = 11, com preço de R$ 173,95, e com assunto Sistemas Operacionais
-----------------------------------------------------------
-- 0aº) Mostrar todos os assuntos, para conferir a sigla de "Sistemas Operacionais"
select  * from Assunto
-- 0bº) Mostrar todos os livros, só para entender o que se pede...
select  * from Livro
-- 1º) Mostrar o último código de livro:
select  MAX (codlivro) from Livro
-- 2º) Mostrar o último código de livro, +1:
select  MAX (codlivro) + 1 from Livro
-- 3º) Inserir o novo livro, com este código encontrado:
INSERT INTO Livro (codlivro, titulo, preco, sigla, codedit)
VALUES ((select  MAX (codlivro) + 1 from Livro), 
            'Sistemas Operacionais', 173.95, 'S', 11);
select  * from Livro;
-----------------------------------------------------------
-- 02.27b. Inserir o livro "Sistemas Operacionais Robustos", cujo código é o imediatamente posterior ao último, com preço R$ 20,00 acima do preço médio dos livros, aceito, mas não lançado pela Editora Brasport Editora, e assunto de Sistemas Operacionais
-----------------------------------------------------------
-- 0º) Encontre o último código de livro + 1
select  MAX (codlivro) + 1 from Livro
-- 1º) Encontre o preço médio, adicionado a R$ 20,00
select  AVG (preco) + 20 from Livro
-- 2º) Encontre o código da editora "Brasport Editora"
select  codedit 
from    Editora
where   UPPER (nome) = UPPER ('Brasport Editora')
-- 3º) Encontre a sigla do assunto "Sistemas Operacionais"
select  sigla
from    Assunto
where   UPPER (descricao) = UPPER ('Sistemas Operacionais')
-- 4º) Junte tudo e sirva com queijo parmesão ralado na hora...
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
“SUBSELECT” --> select de select…	
	SELECT	<atributo_1>, …, <atributo_n>
	FROM 	<Relação>
	WHERE	<atributo_x> [NOT] IN / <operador_lógico>
		(SELECT   …)
------------------------------------------------------- */
-- 02.28.	Mostrar os títulos e preços dos livros, cujo preços sejam superiores ao preço médio
--
-- 1º) Encontrar o preço médio
select  AVG (preco) from Livro
-- 0º) Mostre todos os livros, para se ter uma noção do que se quer...
select * from Livro
-- 2º) Mostrar, em função deste preço médio encontrado
select  titulo, preco
from    Livro
where   preco > 
            (select  AVG (preco) from Livro)
------------------------------------------------------- */
-- 02.28b. Mostrar os títulos e preços dos livros, cujos livros tenham sido aceitos pela editora "Pearson Education"
--
select  titulo, preco --, codedit
from    Livro
where   codedit = 
            (select codedit from Editora
             where UPPER (nome) = UPPER ('Pearson Education'))
------------------------------------------------------- */
-- 02.28c.	 Mostrar os títulos e preços dos livros, aceitos por alguma editora, cujo nome contém a palavra "Editora" em alguma posição, em qualquer caso.
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
-- 02.29.	Mostrar os dados dos livros lançados após o livro, cujo nome será informado externamente
--
-----------------------------------------------------------
-- 02.30.	Mostrar os dados dos livros lançados após o livro, cujo trecho de nome será informado
--
-----------------------------------------------------------
