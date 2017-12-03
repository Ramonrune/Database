/* ------------------------------------
DQL (Data Query Language) é uma porção de SQL, destinada às consultas aos dados, tanto em tabelas individuais, quanto em relações entre tabelas (duas ou mais). 
É importante salientar que as instruções DQL NÃO afetam os dados, nem sequer as estruturas! Por esta razão, não utiliza-se COMMIT ou ROLLBACK, ok?
---------------------------------------
select	[DISTINCT | ALL] [*] [UPPER/LOWER] <atributo1>, <atributo2>, …, <atributoN>
	[COUNT | SUM | AVG | MIN | MAX]  (<atributo_a_agrupar>)	(agrupadas)
from	<Relação>	--  Predicado
where	<condições>	--  Seleção
[GROUP BY 	<atributos_a_agrupar]	-- apenas os atributos não agrupados
[HAVING] 	<condição_de_grupo>
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
-- 01.02.	Mostrar apenas os códigos e nomes de todos os autores
------------------------------------ */
SELECT  matricula, nome
FROM    Autor
/* ------------------------------------
-- 01.03.	Mostrar os cpfs, nomes, datas de nascimento e países de todos os autores
------------------------------------ */
select  cpf, nome, nascim, pais
from    Autor
/* ------------------------------------
-- 01.04.	Mostrar os códigos de países dos autores, mas sem repetição
------------------------------------ */
select  pais
from    Autor

select  DISTINCT pais
from    Autor
----------------------------------------

-- Condicionais (predicado WHERE):
/* ------------------------------------
-- 01.05.	Mostrar todos os dados dos autores não brasileiros
------------------------------------ */
-- 1º ) Todos os dados de Autor, sem dinstinção...
select  *
from    Autor
-- 2º) Idem, mas só do Brasil...
select  *
from    Autor
WHERE   pais = BR   -- ERRO! BR não é variável ou atributo!
-- 3º) Idem, mas só do Brasil...
select  * 
from    Autor
WHERE   pais = 'BR'
-- 4º) Idem, mas exceto do Brasil...
select  * 
from    Autor
WHERE   pais <> 'BR'
-- 5º) Igual ao anterior, porém com "operador" "!="
select  * 
from    Autor
WHERE   pais != 'BR'
/* ------------------------------------
-- 01.06.	Mostrar os cpfs, nomes, datas de nascimento e país dos autores dos EUA e Brasil
------------------------------------ */
select  cpf, nome, nascim, pais
from    Autor
where   pais = 'BR' and 'US'    -- Não há como ser do Brasil "E" dos EUA...
--
select  cpf, nome, nascim, pais
from    Autor
where   pais = 'BR' or 'US'    -- Cada conteúdo deve ser comparado separadamente!
--
select  cpf, nome, nascim, pais
from    Autor
where   pais = 'BR' or
            pais = 'US'    
/* ------------------------------------
-- 01.06b.	Idem ao 01.06, mas dos autores dos EUA, Brasil, Argentina, Noruega e França
------------------------------------ */
select  cpf, nome, nascim, pais
from    Autor
where   pais = 'BR' or pais = 'US' or pais = 'AR' or pais = 'NO' or pais = 'FR'
-- OU, aplicando CONTIDO EM (IN), de teoria de conjunto...
select  cpf, nome, nascim, pais
from    Autor
where   pais IN ('BR','US','AR','NO','FR')
/* ------------------------------------
-- 01.07.	Mostre os cpfs, códigos, nomes e países de todos os autores cujo país pode ter sido digitado em maiúsculas, minúsculas ou misturadas em qualquer caractere.
------------------------------------ */
select  cpf, matricula, nome, pais
from    Autor
where   pais = :PaisDigitado    -- FlameRobin não testa variável externa.
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
where   UPPER(pais) = UPPER(:PaisDigitado)    -- PaisDigitado = variável externa
/* ------------------------------------
-- 01.08.	Mostre todos os dados dos livros, cujos nomes iniciam-se por "Sistema"
------------------------------------ */
select  * from Livro
--
select  * from Livro
WHERE   titulo = 'Sistema'  -- Oops! Não há livro com título completo = "Sistema"!
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
-- 01.10.	Mostre todos os dados dos livros, cujos nomes contêm "Dados" em alguma posição
------------------------------------ */
select * from Livro
--
select  * from Livro
WHERE   titulo LIKE '%Dados%'
/* ------------------------------------ 
-- 01.11.	Mostre todos os dados dos livros, cujos nomes contêm "Dados" em qualquer caixa e em alguma posição
------------------------------------ */
select * from Livro -- Mostra tudo...
--
select  * from Livro
WHERE   titulo LIKE '%dados%'   -- Não há títulos com a "dados" em minúsculas
-- Agora, comparando maiúsculas, tanto da tabela, quanto do valor externo
select  * from Livro
WHERE   UPPER (titulo)  LIKE UPPER('%dados%')
/* ------------------------------------
-- 01.12.	Mostre todos os dados dos livros, cujos nomes contêm a palavra digitada em qualquer caixa
------------------------------------ */
-- Com IBExpert, ok, mas não com FlameRobin…
/* ------------------------------------
-- 01.13.	Mostre todos os dados dos livros, cujos nomes contêm a palavra digitada em qualquer caixa
------------------------------------ */
-- Com IBExpert, ok, mas não com FlameRobin…
/* ------------------------------------
-- 01.14.	Mostre os títulos dos livros, antecedidos pela e concatenados com a palavra “Livro:”
------------------------------------ */
select  'Livro:', titulo    -- Mostra em duas colunas
from    Livro
--
select  'Livro: ' || titulo AS "Título do livro"    -- Mostra em uma única coluna
from    Livro
/* ------------------------------------
-- 01.15.	Mostre os códigos, títulos, preços e quanto significam 10% deste preço
------------------------------------ */
select  codlivro, titulo, preco, preco * 10/100 AS "10%"
from    Livro
--
select  codlivro, titulo, preco, preco * 0.1 "10%"
from    Livro
/* ------------------------------------
-- 01.16.	Mostre os códigos, títulos, preços e quanto significa este preço com 27,5% de aumento
------------------------------------ */
select  codlivro, titulo, preco, preco + preco * 27.5/100 AS "27.5%"
from    Livro
-- OU
select  codlivro, titulo, preco, preco * 1.275 AS "27.5%"
from    Livro
/* ------------------------------------
-- 01.17.	Mostre os códigos, títulos, preços e quanto significa este preço com 27,5% de redução
------------------------------------ */
select  codlivro, titulo, preco, preco - preco * 27.5/100 AS "-27.5%"
from    Livro
-- OU
select  codlivro, titulo, preco, preco * 0.725 AS "-27.5%"
from    Livro
/* ------------------------------------
-- 01.18.	Mostre os assuntos armazenados na tabela Livro, porém sem repetição
------------------------------------ */
select  sigla from Livro    -- As siglas se repetem
--
select  DISTINCT sigla from Livro
/* ------------------------------------
-- 01.19.	Mostre todos os atributos de todos os livros que não foram publicados (aceitos) por alguma editora
------------------------------------ */
select  * from Livro    -- ...para ver tudo...
--
select  * from Livro
WHERE   codedit = NULL  -- ERRO! NULL está sendo tratado como atributo
-- Agora, o correto:
select  * from Livro
WHERE   codedit IS NULL
/* ------------------------------------
-- 01.20.	Mostre todos os atributos de todos os livros que foram publicados por alguma editora
------------------------------------ */
select  * from Livro
WHERE   codedit IS NOT NULL
/* ------------------------------------
-- 01.21.	Mostre todos os atributos dos livros que não foram lançados por qualquer editora
------------------------------------ */
select  * from Livro
WHERE   lancamento IS NULL
/* ------------------------------------
-- 01.22.	Mostre todos os atributos dos livros que foram lançados por qualquer editora
------------------------------------ */
select  * from Livro
WHERE   lancamento IS NOT NULL
/* ------------------------------------
-- 01.23.	Mostre os títulos e datas de lançamento dos livros lançados antes de 2015
------------------------------------ */
select titulo, lancamento from Livro
WHERE   lancamento < '2015/01/01'
-- OU
select titulo, lancamento from Livro
WHERE   lancamento <= '2014/12/31'
/* ------------------------------------
-- 01.24.	Mostre os títulos e datas de lançamento dos livros lançados antes de 2015
------------------------------------ */

/* ------------------------------------
-- 01.25.	Mostre os títulos e datas de lançamento dos livros lançados entre 12/Jan/2013 e 25/Mai/2015
------------------------------------ */
select  titulo, lancamento
from    Livro
WHERE   lancamento >= '2013/01/12' and lancamento <= '2015/05/25'
-- OU
select  titulo, lancamento
from    Livro
WHERE   lancamento BETWEEN '2013/01/12' and '2015/05/25'
/* ------------------------------------
-- 01.26.	Mostre os títulos e datas de lançamento dos livros lançados, exceto entre 12/Jan/2013 e 25/Mai/2015
------------------------------------ */
select  titulo, lancamento
from    Livro
WHERE   lancamento < '2013/01/12' OR lancamento > '2015/05/25'
-- OU
select  titulo, lancamento
from    Livro
WHERE   lancamento NOT BETWEEN '2013/01/12' and '2015/05/25'
