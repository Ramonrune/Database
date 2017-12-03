/* -------------------------------------------------------
Dados advindos de duas ou mais tabelas relacionadas:
------------------------------------------------------- */
-- 03.1.	Produto cartesiano (cruzamento direto) entre Editoras e Livros:

/* -------------------------------------------------------
03.2.	Do produto cartesiano, mostrar apenas o que interessa, ou seja, os dados de ambas as tabelas, contanto que o código da editora em Editora (chave primária) seja exatamente igual ao código da Editora em Livro (chave estrangeira):
------------------------------------------------------- */

/* -------------------------------------------------------
03.3.	Pode-se efetuar esta operação utilizando variáveis tupla (que representam cada tabela, neste caso, a variável "E", por exemplo, representará a tabela Editora, e "L", a tabela Livro):
------------------------------------------------------- */

/* -------------------------------------------------------
03.4.	Ao invés de mostrar todos os atributos, apresente apenas o código e nome da editora e o título do livro:
------------------------------------------------------- */

-- 03.5.	Mostrar os títulos dos livros e os nomes das respectivas editoras.

/* -------------------------------------------------------
INNER JOIN
------------------------------------------------------- */

-- 03.6.	Repetindo o exemplo 03.5, porém utilizando o INNER JOIN:

-- 03.7.	Ao invés de livro e editora, mostre os nomes das editoras e os livros que elas editam.

-- 03.8.	Mostre os títulos dos livros e os assuntos a que se referem por extenso

/* -------------------------------------------------------
03.9.	Mostre todos os títulos dos livros e nomes dos respectivos autores em ordem alfabética dos nomes dos autores. Como a tabela Livro não se relaciona diretamente com Autor, isto é feito através da Autor_Livro…
------------------------------------------------------- */

/* -------------------------------------------------------
03.10.	Mostre os nomes das editoras, os títulos dos livros e de seus autores, ordenados por esta prioridade.
------------------------------------------------------- */

/* -------------------------------------------------------
LEFT OUTER JOIN versus RIGHT OUTER JOIN
------------------------------------------------------- */

/* -------------------------------------------------------
03.11.	Mostrar os nomes das Editoras e, se houver livros por elas publicados, seus títulos, ordenados por editora e título.
------------------------------------------------------- */

/* -------------------------------------------------------
03.12.	Mostrar os nomes das Editoras e, se houver livros por elas publicados, seus títulos, ordenados por editora e título.
------------------------------------------------------- */

/* -------------------------------------------------------
03.13.	Mostrar os títulos dos livros e, se tiverem sido publicados, os nomes das respectivas Editoras, ordenados por título e editora.
------------------------------------------------------- */

/* -------------------------------------------------------
03.14.	Mostrar os títulos dos livros e, se tiverem sido publicados, os nomes das respectivas Editoras, ordenados por título e editora.
------------------------------------------------------- */

/* -------------------------------------------------------
03.15.	Mostrar os nomes das Editoras e, se houver livros por elas publicados, seus títulos, se não houver, mostre “-- Não publicou livros –”, ordenados por editora e título.
------------------------------------------------------- */

/* -------------------------------------------------------
FULL OUTER JOIN
------------------------------------------------------- */

/* -------------------------------------------------------
03.16.	Mostrar os nomes de todas as Editoras, tendo elas publicado livros ou não, e de todos os livros, tendo ou não sido por elas publicado, ordenados por editora e título.
------------------------------------------------------- */

/* -------------------------------------------------------
03.17.	Mostrar os nomes de todas as Editoras (se não publicou livros, avisar "—Sem livros publicados –"), e de todos os livros (se não foram publicados, avisar "-- Ainda sem editora –", ordenados por editora e título.
------------------------------------------------------- */

