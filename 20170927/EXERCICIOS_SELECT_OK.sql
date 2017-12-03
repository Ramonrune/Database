/* ------------------------------------
DQL (Data Query Language) � uma por��o de SQL, destinada �s consultas aos dados, tanto em tabelas individuais, quanto em rela��es entre tabelas (duas ou mais). 
� importante salientar que as instru��es DQL N�O afetam os dados, nem sequer as estruturas! Por esta raz�o, n�o utiliza-se COMMIT ou ROLLBACK, ok?
---------------------------------------
select	[DISTINCT | ALL] [*] [UPPER/LOWER] <atributo1>, <atributo2>, �, <atributoN>
	[COUNT | SUM | AVG | MIN | MAX]  (<atributo_a_agrupar>)	(agrupadas)
from	<Rela��o>	--  Predicado
where	<condi��es>	--  Sele��o
[GROUP BY 	<atributos_a_agrupar]	-- apenas os atributos n�o agrupados
[HAVING] 	<condi��o_de_grupo>
[ORDER BY]	<atributo1>,<atributo2>...  [ASC[ENDING] | DESC[ENDING]]
------------------------------------ */

/* ------------------------------------
-- 01.01.	Mostrar todos os dados de todos os autores
------------------------------------ */
SELECT  matricula , nome, cpf, endereco, nascim, pais   -- todos os atributos
FROM    Autor   -- ... da tabela Autor

SELECT  *
FROM    Autor
/* ------------------------------------
-- 01.02.	Mostrar apenas os c�digos e nomes de todos os autores
------------------------------------ */
SELECT  matricula, nome
FROM    Autor
/* ------------------------------------
-- 01.03.	Mostrar os cpfs, nomes, datas de nascimento e pa�ses de todos os autores
------------------------------------ */
select  cpf, nome, nascim, pais
from    Autor
/* ------------------------------------
-- 01.04.	Mostrar os c�digos de pa�ses dos autores, mas sem repeti��o
------------------------------------ */
select  pais
from    Autor

select  DISTINCT pais
from    Autor
----------------------------------------

-- Condicionais (predicado WHERE):
/* ------------------------------------
-- 01.05.	Mostrar todos os dados dos autores n�o brasileiros
------------------------------------ */
-- 1� ) Todos os dados de Autor, sem dinstin��o...
select  *
from    Autor
-- 2�) Idem, mas s� do Brasil...
select  *
from    Autor
WHERE   pais = BR   -- ERRO! BR n�o � vari�vel ou atributo!
-- 3�) Idem, mas s� do Brasil...
select  * 
from    Autor
WHERE   pais = 'BR'
-- 4�) Idem, mas exceto do Brasil...
select  * 
from    Autor
WHERE   pais <> 'BR'
-- 5�) Igual ao anterior, por�m com "operador" "!="
select  * 
from    Autor
WHERE   pais != 'BR'
/* ------------------------------------
-- 01.06.	Mostrar os cpfs, nomes, datas de nascimento e pa�s dos autores dos EUA e Brasil
------------------------------------ */
select  cpf, nome, nascim, pais
from    Autor
where   pais = 'BR' and 'US'    -- N�o h� como ser do Brasil "E" dos EUA...
--
select  cpf, nome, nascim, pais
from    Autor
where   pais = 'BR' or 'US'    -- Cada conte�do deve ser comparado separadamente!
--
select  cpf, nome, nascim, pais
from    Autor
where   pais = 'BR' or
            pais = 'US'    
/* ------------------------------------
-- 01.06b.	Idem ao 01.06, mas dos autores dos EUA, Brasil, Argentina, Noruega e Fran�a
------------------------------------ */
select  cpf, nome, nascim, pais
from    Autor
where   pais = 'BR' or pais = 'US' or pais = 'AR' or pais = 'NO' or pais = 'FR'
-- OU, aplicando CONTIDO EM (IN), de teoria de conjunto...
select  cpf, nome, nascim, pais
from    Autor
where   pais IN ('BR','US','AR','NO','FR')
/* ------------------------------------
-- 01.07.	Mostre os cpfs, c�digos, nomes e pa�ses de todos os autores cujo pa�s pode ter sido digitado em mai�sculas, min�sculas ou misturadas em qualquer caractere.
------------------------------------ */
select  cpf, matricula, nome, pais
from    Autor
where   pais = :PaisDigitado    -- FlameRobin n�o testa vari�vel externa.
--
select  cpf, matricula, nome, pais
from    Autor
where   pais = 'BR' or pais = 'Br' or pais = 'bR' or pais = 'br'
------------------------------------
-- Ou, comparando do livro e do valor externo
select  cpf, matricula, nome, pais
from    Autor
where   UPPER (pais) = UPPER('br')
--
select  cpf, matricula, nome, pais
from    Autor
where   UPPER(pais) = UPPER(:PaisDigitado)    -- PaisDigitado = vari�vel externa
/* ------------------------------------
-- 01.08.	Mostre todos os dados dos livros, cujos nomes iniciam-se por "Sistema"
------------------------------------ */
select  * from Livro
--
select  * from Livro
WHERE   titulo = 'Sistema'  -- Oops! N�o h� livro com t�tulo completo = "Sistema"!
--
select  * from Livro
WHERE   titulo LIKE 'Sistema%'
/* ------------------------------------
-- 01.09.	Mostre todos os dados dos livros, cujos nomes encerram-se por "Dados"
------------------------------------ */
select * from Livro
--
select  * from Livro
WHERE   titulo LIKE '%Dados'
/* ------------------------------------
-- 01.10.	Mostre todos os dados dos livros, cujos nomes cont�m "Dados" em alguma posi��o
------------------------------------ */
select * from Livro
--
select  * from Livro
WHERE   titulo LIKE '%Dados%'
/* ------------------------------------ 
-- 01.11.	Mostre todos os dados dos livros, cujos nomes cont�m "Dados" em qualquer caixa e em alguma posi��o
------------------------------------ */
select * from Livro -- Mostra tudo...
--
select  * from Livro
WHERE   titulo LIKE '%dados%'   -- N�o h� t�tulos com a "dados" em min�sculas
-- Agora, comparando mai�sculas, tanto da tabela, quanto do valor externo
select  * from Livro
WHERE   UPPER (titulo)  LIKE UPPER('%dados%')
/* ------------------------------------
-- 01.12.	Mostre todos os dados dos livros, cujos nomes cont�m a palavra digitada em qualquer caixa
------------------------------------ */
-- Com IBExpert, ok, mas n�o com FlameRobin�
/* ------------------------------------
-- 01.13.	Mostre todos os dados dos livros, cujos nomes cont�m a palavra digitada em qualquer caixa
------------------------------------ */
-- Com IBExpert, ok, mas n�o com FlameRobin�
/* ------------------------------------
-- 01.14.	Mostre os t�tulos dos livros, antecedidos pela e concatenados com a palavra �Livro:�
------------------------------------ */
select  'Livro:', titulo    -- Mostra em duas colunas
from    Livro
--
select  'Livro: ' || titulo AS "T�tulo do livro"    -- Mostra em uma �nica coluna
from    Livro
/* ------------------------------------
-- 01.15.	Mostre os c�digos, t�tulos, pre�os e quanto significam 10% deste pre�o
------------------------------------ */
select  codlivro, titulo, preco, preco * 10/100 AS "10%"
from    Livro
--
select  codlivro, titulo, preco, preco * 0.1 "10%"
from    Livro
/* ------------------------------------
-- 01.16.	Mostre os c�digos, t�tulos, pre�os e quanto significa este pre�o com 27,5% de aumento
------------------------------------ */
select  codlivro, titulo, preco, preco + preco * 27.5/100 AS "27.5%"
from    Livro
-- OU
select  codlivro, titulo, preco, preco * 1.275 AS "27.5%"
from    Livro
/* ------------------------------------
-- 01.17.	Mostre os c�digos, t�tulos, pre�os e quanto significa este pre�o com 27,5% de redu��o
------------------------------------ */
select  codlivro, titulo, preco, preco - preco * 27.5/100 AS "-27.5%"
from    Livro
-- OU
select  codlivro, titulo, preco, preco * 0.725 AS "-27.5%"
from    Livro
/* ------------------------------------
-- 01.18.	Mostre os assuntos armazenados na tabela Livro, por�m sem repeti��o
------------------------------------ */
select  sigla from Livro    -- As siglas se repetem
--
select  DISTINCT sigla from Livro
/* ------------------------------------
-- 01.19.	Mostre todos os atributos de todos os livros que n�o foram publicados (aceitos) por alguma editora
------------------------------------ */
select  * from Livro    -- ...para ver tudo...
--
select  * from Livro
WHERE   codedit = NULL  -- ERRO! NULL est� sendo tratado como atributo
-- Agora, o correto:
select  * from Livro
WHERE   codedit IS NULL
/* ------------------------------------
-- 01.20.	Mostre todos os atributos de todos os livros que foram publicados por alguma editora
------------------------------------ */
select  * from Livro
WHERE   codedit IS NOT NULL
/* ------------------------------------
-- 01.21.	Mostre todos os atributos dos livros que n�o foram lan�ados por qualquer editora
------------------------------------ */
select  * from Livro
WHERE   lancamento IS NULL
/* ------------------------------------
-- 01.22.	Mostre todos os atributos dos livros que foram lan�ados por qualquer editora
------------------------------------ */
select  * from Livro
WHERE   lancamento IS NOT NULL
/* ------------------------------------
-- 01.23.	Mostre os t�tulos e datas de lan�amento dos livros lan�ados antes de 2015
------------------------------------ */
select titulo, lancamento from Livro
WHERE   lancamento < '2015/01/01'
-- OU
select titulo, lancamento from Livro
WHERE   lancamento <= '2014/12/31'
/* ------------------------------------
-- 01.24.	Mostre os t�tulos e datas de lan�amento dos livros lan�ados antes de 2015
------------------------------------ */

/* ------------------------------------
-- 01.25.	Mostre os t�tulos e datas de lan�amento dos livros lan�ados entre 12/Jan/2013 e 25/Mai/2015
------------------------------------ */
select  titulo, lancamento
from    Livro
WHERE   lancamento >= '2013/01/12' and lancamento <= '2015/05/25'
-- OU
select  titulo, lancamento
from    Livro
WHERE   lancamento BETWEEN '2013/01/12' and '2015/05/25'
/* ------------------------------------
-- 01.26.	Mostre os t�tulos e datas de lan�amento dos livros lan�ados, exceto entre 12/Jan/2013 e 25/Mai/2015
------------------------------------ */
select  titulo, lancamento
from    Livro
WHERE   lancamento < '2013/01/12' OR lancamento > '2015/05/25'
-- OU
select  titulo, lancamento
from    Livro
WHERE   lancamento NOT BETWEEN '2013/01/12' and '2015/05/25'
