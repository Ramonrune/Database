/* -------------------------------------------------------
Algumas funções:
-----------------------------------
CONVERSÃO DE TIPOS:	http://www.firebirdsql.org/refdocs/langrefupd20-cast.html
-----------------------------------
CAST (<atributo> AS <tipo>)
------------------------------------------------------- */
-- 02.01.	Mostrar as datas de lançamento como configuradas (dd/mm/aaaa):
select lancamento from Livro
-----------------------------------------------------------
-- 02.02.	Mostrar as datas de lançamento como strings:
select CAST (lancamento AS char (08)) from Livro
-- ERRO! Faltam as barras ("?")
select CAST (lancamento AS char (10)) from Livro
-----------------------------------------------------------
/* -------------------------------------------------------
Quantidade de caracteres em string:	
CHAR_LENGTH (<atributo_String>)
------------------------------------------------------- */
-- 02.03.	Mostrar os títulos dos livros e a quantidade de caracteres em cada
select  titulo, CHAR_LENGTH (titulo)
from    Livro
-----------------------------------------------------------
/* -------------------------------------------------------
Trecho de uma string:	
SUBSTRING (<atributo_string> FROM <1ª_posição> FOR <qtd_caracteres>) 
------------------------------------------------------- */
-- 02.04.	Mostrar apenas os primeiros 10 caracteres dos títulos dos livros
select  titulo, SUBSTRING (titulo FROM 1 FOR 10)
from    Livro
-- 02.04b.	Mostrar apenas os primeiros 10 caracteres dos títulos dos livros, a partir do 3º
select  titulo, SUBSTRING (titulo FROM 3 FOR 10)
from    Livro
-----------------------------------------------------------
-- 02.05.	Mostrar os últimos 10 caracteres dos títulos dos livros
select  titulo, 
    SUBSTRING (titulo FROM CHAR_LENGTH (titulo) - 10 FOR CHAR_LENGTH (titulo))
from    Livro
-- Oops! Mostrou os 11 caracteres finais!
select  titulo, 
    SUBSTRING (titulo FROM CHAR_LENGTH (titulo) - 9 FOR CHAR_LENGTH (titulo))
from    Livro
--
select  titulo, 
    SUBSTRING (titulo FROM CHAR_LENGTH (titulo) - 10 FOR 10)
from    Livro
-- Oops! Faltou mostrar o último caractere!
select  titulo, 
    SUBSTRING (titulo FROM CHAR_LENGTH (titulo) - 9 FOR 10)
from    Livro
/* -------------------------------------------------------
Funções de data:	
DATE, CURRENT_DATE, 'TODAY'
------------------------------------------------------- */
-- 02.06.	Mostrar a data de hoje:
select  CURRENT_DATE from RDB$DATABASE
-----------------------------------------------------------
-- 02.07.	Mostrar a diferença (em dias) entre duas datas -> (mm/dd/aaaa):
select  '28/09/2017' - '01/09/2017'
from    RDB$DATABASE
-- ERRO! Está tentando subtrair duas strings!
select  CAST ('28/09/2017' AS DATE) - CAST ('01/09/2017' AS DATE)
from    RDB$DATABASE
-- ERRO! As datas deveriam ser expressas em 'mm/dd/aaaa' ou 'aaaa/mm/dd'!
select  CAST ('09/28/2017' AS DATE) - CAST ('09/01/2017' AS DATE)
from    RDB$DATABASE
-- OU
select  CAST ('2017/09/28' AS DATE) - CAST ('2017/09/01' AS DATE)
from    RDB$DATABASE
-----------------------------------------------------------
-- 02.08.	Mostrar a quantidade de dias decorridos de uma data até hoje
select  CURRENT_DATE - 01/10/2017
from RDB$DATABASE 

select  CURRENT_DATE - '01/10/2017'
from RDB$DATABASE 

select  CURRENT_DATE - CAST ('01/10/2017' AS DATE)
from RDB$DATABASE 
-- Oops!
select  CURRENT_DATE - CAST ('10/01/2017' AS DATE)
from RDB$DATABASE 

select  CURRENT_DATE - CAST ('2017/10/01' AS DATE)
from RDB$DATABASE 

-----------------------------------------------------------
-- 02.09.	Mostrar quantos dias tens de vida
select  CURRENT_DATE - CAST ('1996/10/31' AS DATE)
from    RDB$DATABASE
-----------------------------------------------------------
-- 02.10.	Mostrar tua idade atual (aproximadamente; divida os dias por 365)
select  (CURRENT_DATE - CAST ('1996/10/31' AS DATE)) / 365
from    RDB$DATABASE
-----------------------------------------------------------
-- 02.11.	Mostrar, separadamente, o dia, mês, ano, dia da semana e do ano das datas de lançamento dos livros
select  lancamento,
           EXTRACT (DAY FROM lancamento) "dia",
           EXTRACT (MONTH FROM lancamento) "mês",
           EXTRACT (YEAR FROM lancamento) "ano",
           EXTRACT (WEEKDAY FROM lancamento) "dia sem",
           EXTRACT (YEARDAY FROM lancamento) "dia ano"
from    Livro
where   lancamento IS NOT NULL
-----------------------------------------------------------
-- 02.12.	Idem ao anterior, porém usando tua data de nascimento, ao invés de data de lançamento do livro
select  CAST ('1885/10/31' AS DATE) "Nascim",
           EXTRACT (DAY FROM CAST ('1885/10/31' AS DATE)) "dia",
           EXTRACT (MONTH FROM CAST ('1885/10/31' AS DATE)) "mês",
           EXTRACT (YEAR FROM CAST ('1885/10/31' AS DATE)) "ano",
           EXTRACT (WEEKDAY FROM CAST ('1885/10/31' AS DATE)) "dia sem",
           EXTRACT (YEARDAY FROM CAST ('1885/10/31' AS DATE)) "dia ano"
from    RDB$DATABASE
-----------------------------------------------------------
-- 02.13.	Idem ao anterior, todavia com títulos apropriados
    
/* -------------------------------------------------------
Cláusula CASE:	
	SELECT	<atributo_1>, …, <atributo_n>,
		CASE
			when <condição1> then <informação1>
			…
			when <condiçãoN> then <informaçãoN>
			else <informação3>
		END [[AS] "<nome para este campo>"]
	From	<Relação>
------------------------------------------------------- */
-- 02.14.	Projete os nomes e preços dos livros e, em uma nova coluna, quando tiverem o seu preço superior a R$110, informe "Caro"; quando inferiores a R$80, informe "Barato"; senão, informe "Normal".
select  titulo, preco
from    Livro

select  titulo, preco,
        CASE
            WHEN preco > 110 THEN 'Caro'
            WHEN preco < 80 THEN 'Barato'
            ELSE 'Normal'
        END "Opinião"
from    Livro
-----------------------------------------------------------
-- 02.15.	Projete as datas válidas de lançamento e seus nomes de dias de semana
select  lancamento
from    Livro
where   lancamento IS NOT NULL

select  lancamento,
    CASE
        WHEN EXTRACT (WEEKDAY FROM lancamento) = 0 then 'Domingo'
        WHEN EXTRACT (WEEKDAY FROM lancamento) = 1 then 'Segunda-feira'
        WHEN EXTRACT (WEEKDAY FROM lancamento) = 2 then 'Terça-feira'
        WHEN EXTRACT (WEEKDAY FROM lancamento) = 3 then 'Quarta-feira'
        WHEN EXTRACT (WEEKDAY FROM lancamento) = 4 then 'Quinta-feira'
        WHEN EXTRACT (WEEKDAY FROM lancamento) = 5 then 'Sexta-feira'
        ELSE 'Sábado'
    END "Dia de semana"
from    Livro
where   lancamento IS NOT NULL
/* -------------------------------------------------------
Cláusula COALESCE:	
COALESCE (<atributo_1> , “Informação, se <atributo_1> for nulo”)
------------------------------------------------------- */
-- 02.16.	Mostrar o título e data de lançamento de cada livro, porém se estiver vazia, o código da editora e, se ambos vazios, vazio:
select  titulo, lancamento
from    Livro

select  titulo, COALESCE (lancamento , 'Não lançado')
from    Livro
--
select  titulo, COALESCE (CAST(lancamento AS CHAR (10)) , codedit)
from    Livro
--
select  titulo, COALESCE (CAST(lancamento AS CHAR (10)) , 
                    COALESCE (codedit , 'Nem foi aceito'))
from    Livro
-----------------------------------------------------------
-- 02.17.	Mostrar o título do livro e o código da editora, porém se estiver vazio, a data de lançamento e, se ambos vazios, "Não foi aceito":
select  titulo, codedit
from    Livro
--
select  titulo, COALESCE (codedit , 
                   COALESCE (CAST (lancamento AS CHAR (10)) , 'Não foi aceito'))
from    Livro
/* -------------------------------------------------------
Funções de agregação:	
COUNT (<atrib>)	-> quantidade, contagem de <atrib>
SUM (<atrib>)	-> soma de valores de <atrib>
AVG (<atrib>)	-> média aritmética de <atrib>
MIN (<atrib>)	-> menor valor de <atrib>
MAX  (<atrib>)	-> maior valor de <atrib>
GROUP BY <atributo_não_agregado>
------------------------------------------------------- */
-- 02.18.	Mostrar quantos livros estão cadastrados

-----------------------------------------------------------
-- 02.19.	Mostrar quantos livros foram aceitos por editoras

-----------------------------------------------------------
-- 02.20.	Mostrar a soma dos preços dos livros

-----------------------------------------------------------
-- 02.21.	Mostrar o preço médio dos livros

-----------------------------------------------------------
-- 02.22.	Mostrar quantos livros há, qual a soma de seus preços e o preço médio
--
-----------------------------------------------------------
-- 02.23.	Mostrar o menor preço, bem como o maior, o médio e a quantidade de livros (embora não signifique nada aqui, acrescente a soma):
--
-----------------------------------------------------------
-- 02.24.	Mostrar cada assunto, em ordem inversa, e quantos livros há de cada
--
-----------------------------------------------------------
-- 02.25.	Mostrar quantos livros foram aceitos por cada editora
--
-----------------------------------------------------------
-- 02.26.	Mostrar quantos livros foram lançados por ano
--
-----------------------------------------------------------
-- 02.27.	Inserir o livro "Sistemas Operacionais", cujo código é o imediatamente posterior ao último, aceito, mas não lançado pela Editora de código = 11, e com assunto Sistemas Operacionais
-----------------------------------------------------------
-- 1º) Mostrar o último código de livro:
-- 2º) Mostrar o último código de livro, +1:
-- 2º) Inserir o novo livro, com este código encontrado:
-----------------------------------------------------------
-- 02.27b. Inserir o livro "Sistemas Operacionais Robustos", cujo código é o imediatamente posterior ao último, com preço R$ 20,00 acima do preço médio dos livros, aceito, mas não lançado pela Editora Brasport Editora, e assunto de Sistemas Operacionais
-----------------------------------------------------------
-- 1º) Encontre o preço médio, adicionado a R$ 20,00
-- 2º) Encontre o código da editora "Brasport Editora"
-- 3º) Encontre a sigla do assunto "Sistemas Operacionais"
-- 4º) Junte tudo e sirva com queijo parmesão ralado na hora...
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
--
-- 2º) Mostrar, em função deste preço médio encontrado
--
------------------------------------------------------- */
-- 02.28b. Mostrar os títulos e preços dos livros, cujos livros tenham sido aceitos pela editora "Pearson Education"
--
------------------------------------------------------- */
-- 02.28c.	 Mostrar os títulos e preços dos livros, aceitos por alguma editora, cujo nome contém a palavra "Editora" em alguma posição, em qualquer caso.
--
-----------------------------------------------------------
-- 02.29.	Mostrar os dados dos livros lançados após o livro, cujo nome será informado externamente
--
-----------------------------------------------------------
-- 02.30.	Mostrar os dados dos livros lançados após o livro, cujo trecho de nome será informado
--
-----------------------------------------------------------
