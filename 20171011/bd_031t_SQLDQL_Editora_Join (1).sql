/* -------------------------------------------------------
Dados advindos de duas ou mais tabelas relacionadas:
------------------------------------------------------- */
-- 03.1.	Produto cartesiano (cruzamento direto) entre Editoras e Livros:

/* -------------------------------------------------------
03.2.	Do produto cartesiano, mostrar apenas o que interessa, ou seja, os dados de ambas as tabelas, contanto que o c�digo da editora em Editora (chave prim�ria) seja exatamente igual ao c�digo da Editora em Livro (chave estrangeira):
------------------------------------------------------- */

/* -------------------------------------------------------
03.3.	Pode-se efetuar esta opera��o utilizando vari�veis tupla (que representam cada tabela, neste caso, a vari�vel "E", por exemplo, representar� a tabela Editora, e "L", a tabela Livro):
------------------------------------------------------- */

/* -------------------------------------------------------
03.4.	Ao inv�s de mostrar todos os atributos, apresente apenas o c�digo e nome da editora e o t�tulo do livro:
------------------------------------------------------- */

-- 03.5.	Mostrar os t�tulos dos livros e os nomes das respectivas editoras.

/* -------------------------------------------------------
INNER JOIN
------------------------------------------------------- */

-- 03.6.	Repetindo o exemplo 03.5, por�m utilizando o INNER JOIN:

-- 03.7.	Ao inv�s de livro e editora, mostre os nomes das editoras e os livros que elas editam.

-- 03.8.	Mostre os t�tulos dos livros e os assuntos a que se referem por extenso

/* -------------------------------------------------------
03.9.	Mostre todos os t�tulos dos livros e nomes dos respectivos autores em ordem alfab�tica dos nomes dos autores. Como a tabela Livro n�o se relaciona diretamente com Autor, isto � feito atrav�s da Autor_Livro�
------------------------------------------------------- */

/* -------------------------------------------------------
03.10.	Mostre os nomes das editoras, os t�tulos dos livros e de seus autores, ordenados por esta prioridade.
------------------------------------------------------- */

/* -------------------------------------------------------
LEFT OUTER JOIN versus RIGHT OUTER JOIN
------------------------------------------------------- */

/* -------------------------------------------------------
03.11.	Mostrar os nomes das Editoras e, se houver livros por elas publicados, seus t�tulos, ordenados por editora e t�tulo.
------------------------------------------------------- */

/* -------------------------------------------------------
03.12.	Mostrar os nomes das Editoras e, se houver livros por elas publicados, seus t�tulos, ordenados por editora e t�tulo.
------------------------------------------------------- */

/* -------------------------------------------------------
03.13.	Mostrar os t�tulos dos livros e, se tiverem sido publicados, os nomes das respectivas Editoras, ordenados por t�tulo e editora.
------------------------------------------------------- */

/* -------------------------------------------------------
03.14.	Mostrar os t�tulos dos livros e, se tiverem sido publicados, os nomes das respectivas Editoras, ordenados por t�tulo e editora.
------------------------------------------------------- */

/* -------------------------------------------------------
03.15.	Mostrar os nomes das Editoras e, se houver livros por elas publicados, seus t�tulos, se n�o houver, mostre �-- N�o publicou livros ��, ordenados por editora e t�tulo.
------------------------------------------------------- */

/* -------------------------------------------------------
FULL OUTER JOIN
------------------------------------------------------- */

/* -------------------------------------------------------
03.16.	Mostrar os nomes de todas as Editoras, tendo elas publicado livros ou n�o, e de todos os livros, tendo ou n�o sido por elas publicado, ordenados por editora e t�tulo.
------------------------------------------------------- */

/* -------------------------------------------------------
03.17.	Mostrar os nomes de todas as Editoras (se n�o publicou livros, avisar "�Sem livros publicados �"), e de todos os livros (se n�o foram publicados, avisar "-- Ainda sem editora �", ordenados por editora e t�tulo.
------------------------------------------------------- */

