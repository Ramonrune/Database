/* -------------------------------------------------------
Algumas fun��es:
-----------------------------------
CONVERS�O DE TIPOS:	http://www.firebirdsql.org/refdocs/langrefupd20-cast.html
-----------------------------------
CAST (<atributo> AS <tipo>)
------------------------------------------------------- */
-- 02.01.	Mostrar as datas de lan�amento como configuradas (dd/mm/aaaa):
select lancamento from Livro
-----------------------------------------------------------
-- 02.02.	Mostrar as datas de lan�amento como strings:
select CAST (lancamento AS char (08)) from Livro
-- ERRO! Faltam as barras ("?")
select CAST (lancamento AS char (10)) from Livro
-----------------------------------------------------------
/* -------------------------------------------------------
Quantidade de caracteres em string:	
CHAR_LENGTH (<atributo_String>)
------------------------------------------------------- */
-- 02.03.	Mostrar os t�tulos dos livros e a quantidade de caracteres em cada
select  titulo, CHAR_LENGTH (titulo)
from    Livro
-----------------------------------------------------------
/* -------------------------------------------------------
Trecho de uma string:	
SUBSTRING (<atributo_string> FROM <1�_posi��o> FOR <qtd_caracteres>) 
------------------------------------------------------- */
-- 02.04.	Mostrar apenas os primeiros 10 caracteres dos t�tulos dos livros
select  titulo, SUBSTRING (titulo FROM 1 FOR 10)
from    Livro
-- 02.04b.	Mostrar apenas os primeiros 10 caracteres dos t�tulos dos livros, a partir do 3�
select  titulo, SUBSTRING (titulo FROM 3 FOR 10)
from    Livro
-----------------------------------------------------------
-- 02.05.	Mostrar os �ltimos 10 caracteres dos t�tulos dos livros
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
-- Oops! Faltou mostrar o �ltimo caractere!
select  titulo, 
    SUBSTRING (titulo FROM CHAR_LENGTH (titulo) - 9 FOR 10)
from    Livro
/* -------------------------------------------------------
Fun��es de data:	
DATE, CURRENT_DATE, 'TODAY'
------------------------------------------------------- */
-- 02.06.	Mostrar a data de hoje:
select  CURRENT_DATE from RDB$DATABASE
-----------------------------------------------------------
-- 02.07.	Mostrar a diferen�a (em dias) entre duas datas -> (mm/dd/aaaa):
select  '28/09/2017' - '01/09/2017'
from    RDB$DATABASE
-- ERRO! Est� tentando subtrair duas strings!
select  CAST ('28/09/2017' AS DATE) - CAST ('01/09/2017' AS DATE)
from    RDB$DATABASE
-- ERRO! As datas deveriam ser expressas em 'mm/dd/aaaa' ou 'aaaa/mm/dd'!
select  CAST ('09/28/2017' AS DATE) - CAST ('09/01/2017' AS DATE)
from    RDB$DATABASE
-- OU
select  CAST ('2017/09/28' AS DATE) - CAST ('2017/09/01' AS DATE)
from    RDB$DATABASE
-----------------------------------------------------------
-- 02.08.	Mostrar a quantidade de dias decorridos de uma data at� hoje
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
-- 02.11.	Mostrar, separadamente, o dia, m�s, ano, dia da semana e do ano das datas de lan�amento dos livros
select  lancamento,
           EXTRACT (DAY FROM lancamento) "dia",
           EXTRACT (MONTH FROM lancamento) "m�s",
           EXTRACT (YEAR FROM lancamento) "ano",
           EXTRACT (WEEKDAY FROM lancamento) "dia sem",
           EXTRACT (YEARDAY FROM lancamento) "dia ano"
from    Livro
where   lancamento IS NOT NULL
-----------------------------------------------------------
-- 02.12.	Idem ao anterior, por�m usando tua data de nascimento, ao inv�s de data de lan�amento do livro
select  CAST ('1885/10/31' AS DATE) "Nascim",
           EXTRACT (DAY FROM CAST ('1885/10/31' AS DATE)) "dia",
           EXTRACT (MONTH FROM CAST ('1885/10/31' AS DATE)) "m�s",
           EXTRACT (YEAR FROM CAST ('1885/10/31' AS DATE)) "ano",
           EXTRACT (WEEKDAY FROM CAST ('1885/10/31' AS DATE)) "dia sem",
           EXTRACT (YEARDAY FROM CAST ('1885/10/31' AS DATE)) "dia ano"
from    RDB$DATABASE
-----------------------------------------------------------
-- 02.13.	Idem ao anterior, todavia com t�tulos apropriados
    
/* -------------------------------------------------------
Cl�usula CASE:	
	SELECT	<atributo_1>, �, <atributo_n>,
		CASE
			when <condi��o1> then <informa��o1>
			�
			when <condi��oN> then <informa��oN>
			else <informa��o3>
		END [[AS] "<nome para este campo>"]
	From	<Rela��o>
------------------------------------------------------- */
-- 02.14.	Projete os nomes e pre�os dos livros e, em uma nova coluna, quando tiverem o seu pre�o superior a R$110, informe "Caro"; quando inferiores a R$80, informe "Barato"; sen�o, informe "Normal".
select  titulo, preco
from    Livro

select  titulo, preco,
        CASE
            WHEN preco > 110 THEN 'Caro'
            WHEN preco < 80 THEN 'Barato'
            ELSE 'Normal'
        END "Opini�o"
from    Livro
-----------------------------------------------------------
-- 02.15.	Projete as datas v�lidas de lan�amento e seus nomes de dias de semana
select  lancamento
from    Livro
where   lancamento IS NOT NULL

select  lancamento,
    CASE
        WHEN EXTRACT (WEEKDAY FROM lancamento) = 0 then 'Domingo'
        WHEN EXTRACT (WEEKDAY FROM lancamento) = 1 then 'Segunda-feira'
        WHEN EXTRACT (WEEKDAY FROM lancamento) = 2 then 'Ter�a-feira'
        WHEN EXTRACT (WEEKDAY FROM lancamento) = 3 then 'Quarta-feira'
        WHEN EXTRACT (WEEKDAY FROM lancamento) = 4 then 'Quinta-feira'
        WHEN EXTRACT (WEEKDAY FROM lancamento) = 5 then 'Sexta-feira'
        ELSE 'S�bado'
    END "Dia de semana"
from    Livro
where   lancamento IS NOT NULL
/* -------------------------------------------------------
Cl�usula COALESCE:	
COALESCE (<atributo_1> , �Informa��o, se <atributo_1> for nulo�)
------------------------------------------------------- */
-- 02.16.	Mostrar o t�tulo e data de lan�amento de cada livro, por�m se estiver vazia, o c�digo da editora e, se ambos vazios, vazio:
select  titulo, lancamento
from    Livro

select  titulo, COALESCE (lancamento , 'N�o lan�ado')
from    Livro
--
select  titulo, COALESCE (CAST(lancamento AS CHAR (10)) , codedit)
from    Livro
--
select  titulo, COALESCE (CAST(lancamento AS CHAR (10)) , 
                    COALESCE (codedit , 'Nem foi aceito'))
from    Livro
-----------------------------------------------------------
-- 02.17.	Mostrar o t�tulo do livro e o c�digo da editora, por�m se estiver vazio, a data de lan�amento e, se ambos vazios, "N�o foi aceito":
select  titulo, codedit
from    Livro
--
select  titulo, COALESCE (codedit , 
                   COALESCE (CAST (lancamento AS CHAR (10)) , 'N�o foi aceito'))
from    Livro
/* -------------------------------------------------------
Fun��es de agrega��o:	
COUNT (<atrib>)	-> quantidade, contagem de <atrib>
SUM (<atrib>)	-> soma de valores de <atrib>
AVG (<atrib>)	-> m�dia aritm�tica de <atrib>
MIN (<atrib>)	-> menor valor de <atrib>
MAX  (<atrib>)	-> maior valor de <atrib>
GROUP BY <atributo_n�o_agregado>
------------------------------------------------------- */
-- 02.18.	Mostrar quantos livros est�o cadastrados

-----------------------------------------------------------
-- 02.19.	Mostrar quantos livros foram aceitos por editoras

-----------------------------------------------------------
-- 02.20.	Mostrar a soma dos pre�os dos livros

-----------------------------------------------------------
-- 02.21.	Mostrar o pre�o m�dio dos livros

-----------------------------------------------------------
-- 02.22.	Mostrar quantos livros h�, qual a soma de seus pre�os e o pre�o m�dio
--
-----------------------------------------------------------
-- 02.23.	Mostrar o menor pre�o, bem como o maior, o m�dio e a quantidade de livros (embora n�o signifique nada aqui, acrescente a soma):
--
-----------------------------------------------------------
-- 02.24.	Mostrar cada assunto, em ordem inversa, e quantos livros h� de cada
--
-----------------------------------------------------------
-- 02.25.	Mostrar quantos livros foram aceitos por cada editora
--
-----------------------------------------------------------
-- 02.26.	Mostrar quantos livros foram lan�ados por ano
--
-----------------------------------------------------------
-- 02.27.	Inserir o livro "Sistemas Operacionais", cujo c�digo � o imediatamente posterior ao �ltimo, aceito, mas n�o lan�ado pela Editora de c�digo = 11, e com assunto Sistemas Operacionais
-----------------------------------------------------------
-- 1�) Mostrar o �ltimo c�digo de livro:
-- 2�) Mostrar o �ltimo c�digo de livro, +1:
-- 2�) Inserir o novo livro, com este c�digo encontrado:
-----------------------------------------------------------
-- 02.27b. Inserir o livro "Sistemas Operacionais Robustos", cujo c�digo � o imediatamente posterior ao �ltimo, com pre�o R$ 20,00 acima do pre�o m�dio dos livros, aceito, mas n�o lan�ado pela Editora Brasport Editora, e assunto de Sistemas Operacionais
-----------------------------------------------------------
-- 1�) Encontre o pre�o m�dio, adicionado a R$ 20,00
-- 2�) Encontre o c�digo da editora "Brasport Editora"
-- 3�) Encontre a sigla do assunto "Sistemas Operacionais"
-- 4�) Junte tudo e sirva com queijo parmes�o ralado na hora...
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
--
-- 2�) Mostrar, em fun��o deste pre�o m�dio encontrado
--
------------------------------------------------------- */
-- 02.28b. Mostrar os t�tulos e pre�os dos livros, cujos livros tenham sido aceitos pela editora "Pearson Education"
--
------------------------------------------------------- */
-- 02.28c.	 Mostrar os t�tulos e pre�os dos livros, aceitos por alguma editora, cujo nome cont�m a palavra "Editora" em alguma posi��o, em qualquer caso.
--
-----------------------------------------------------------
-- 02.29.	Mostrar os dados dos livros lan�ados ap�s o livro, cujo nome ser� informado externamente
--
-----------------------------------------------------------
-- 02.30.	Mostrar os dados dos livros lan�ados ap�s o livro, cujo trecho de nome ser� informado
--
-----------------------------------------------------------
