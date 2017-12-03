/* -------------------------------------------------------
Dados advindos de duas ou mais tabelas relacionadas:
------------------------------------------------------- */
-- 03.1.	Produto cartesiano (cruzamento direto) entre Editoras e Livros:
SELECT * FROM Livro, Editora;

/* -------------------------------------------------------
03.2.	Do produto cartesiano, mostrar apenas o que interessa, ou seja, os dados de ambas as tabelas, contanto que o c�digo da editora em Editora (chave prim�ria) seja exatamente igual ao c�digo da Editora em Livro (chave estrangeira):
------------------------------------------------------- */
SELECT * FROM Livro, Editora WHERE Livro.codedit = Editora.codedit;
/* -------------------------------------------------------
03.3.	Pode-se efetuar esta opera��o utilizando vari�veis tupla (que representam cada tabela, neste caso, a vari�vel "E", por exemplo, representar� a tabela Editora, e "L", a tabela Livro):
------------------------------------------------------- */
SELECT * FROM Livro L, Editora E WHERE L.codedit = E.codedit;
/* -------------------------------------------------------
03.4.	Ao inv�s de mostrar todos os atributos, apresente apenas o c�digo e nome da editora e o t�tulo do livro:
------------------------------------------------------- */
SELECT L.codedit, E.nome, L.titulo FROM Livro L, Editora E WHERE L.codedit = E.codedit;
-- 03.5.	Mostrar os t�tulos dos livros e os nomes das respectivas editoras.
SELECT L.titulo, E.nome FROM Livro as L, Editora E WHERE L.codedit = E.codedit;
/* -------------------------------------------------------
INNER JOIN
------------------------------------------------------- */

-- 03.6.	Repetindo o exemplo 03.5, por�m utilizando o INNER JOIN:
SELECT L.codedit, E.nome, L.titulo FROM Livro L INNER JOIN Editora E ON L.codedit = E.codedit;
-- 03.7.	Ao inv�s de livro e editora, mostre os nomes das editoras e os livros que elas editam.
SELECT E.nome, L.titulo FROM Editora E INNER JOIN Livro L ON E.codedit = L.codedit;
-- 03.8.	Mostre os t�tulos dos livros e os assuntos a que se referem por extenso
SELECT L.titulo, A.descricao FROM Livro L INNER JOIN Assunto A ON L.sigla = A.sigla;
/* -------------------------------------------------------
03.9.	Mostre todos os t�tulos dos livros e nomes dos respectivos autores em ordem alfab�tica dos nomes dos autores. Como a tabela Livro n�o se relaciona diretamente com Autor, isto � feito atrav�s da Autor_Livro?
------------------------------------------------------- */
SELECT L.titulo, A.nome FROM Livro L INNER JOIN Escreve E ON L.codlivro = E.codlivro
                                     INNER JOIN Autor A ON E.matricula = A.matricula
                                     ORDER BY A.nome ASC;
/* -------------------------------------------------------
03.10.	Mostre os nomes das editoras, os t�tulos dos livros e de seus autores, ordenados por esta prioridade.
------------------------------------------------------- */
SELECT Ed.nome, L.titulo, Au.nome FROM Livro L INNER JOIN Escreve E ON L.codlivro = E.codlivro
                                                INNER JOIN Autor Au ON Au.matricula = E.matricula
                                                INNER JOIN Editora Ed ON L.codedit = Ed.codedit
                                                ORDER BY Ed.nome ASC, L.titulo ASC, Au.nome ASC;
/* -------------------------------------------------------
LEFT OUTER JOIN versus RIGHT OUTER JOIN
------------------------------------------------------- */

/* -------------------------------------------------------
03.11.	Mostrar os nomes das Editoras e, se houver livros por elas publicados, seus t�tulos, ordenados por editora e t�tulo.
------------------------------------------------------- */
SELECT E.nome, COALESCE(L.titulo, 'N�o possui') FROM Editora E LEFT OUTER JOIN Livro L ON L.codedit = E.codedit 
                                                     ORDER BY E.nome ASC, L.titulo ASC;
/* -------------------------------------------------------
03.12.	Mostrar os nomes das Editoras e, se houver livros por elas publicados, seus t�tulos, ordenados por editora e t�tulo.
------------------------------------------------------- */
SELECT E.nome, L.titulo FROM Livro L RIGHT OUTER JOIN Editora E ON E.codedit = L.codedit
ORDER BY E.nome ASC, L.titulo ASC;
/* -------------------------------------------------------
03.13.	Mostrar os t�tulos dos livros e, se tiverem sido publicados, os nomes das respectivas Editoras, ordenados por t�tulo e editora.
------------------------------------------------------- */
SELECT L.titulo, E.nome FROM Livro L LEFT OUTER JOIN Editora E ON L.codedit = E.codedit ORDER BY L.titulo ASC, E.nome ASC;
/* -------------------------------------------------------
03.14.	Mostrar os t�tulos dos livros e, se tiverem sido publicados, os nomes das respectivas Editoras, ordenados por t�tulo e editora.
------------------------------------------------------- */
SELECT L.titulo, E.nome FROM Editora E RIGHT OUTER JOIN Livro L ON L.codedit = E.codedit ORDER BY L.titulo ASC, E.nome ASC;
/* -------------------------------------------------------
03.15.	Mostrar os nomes das Editoras e, se houver livros por elas publicados, seus t�tulos, se n�o houver, mostre ?-- N�o publicou livros ??, ordenados por editora e t�tulo.
------------------------------------------------------- */
SELECT E.nome, COALESCE(L.titulo, 'N�o publicou Livros') FROM Editora E LEFT OUTER JOIN Livro L ON E.codedit = L.codedit ORDER BY E.nome ASC, L.titulo ASC;
/* -------------------------------------------------------
FULL OUTER JOIN
------------------------------------------------------- */

/* -------------------------------------------------------
03.16.	Mostrar os nomes de todas as Editoras, tendo elas publicado livros ou n�o, e de todos os livros, tendo ou n�o sido por elas publicado, ordenados por editora e t�tulo.
------------------------------------------------------- */
SELECT E.nome, L.titulo FROM Editora E FULL OUTER JOIN Livro L ON L.codedit = E.codedit ORDER BY E.nome ASC, L.titulo ASC;
/* -------------------------------------------------------
03.17.	Mostrar os nomes de todas as Editoras (se n�o publicou livros, avisar "?Sem livros publicados ?"), e de todos os livros (se n�o foram publicados, avisar "-- Ainda sem editora ?", ordenados por editora e t�tulo.
------------------------------------------------------- */
SELECT COALESCE(E.nome, 'Ainda sem editora'), COALESCE(L.titulo, 'Sem livros publicados') FROM Editora E FULL OUTER JOIN Livro L
ON L.codedit = E.codedit ORDER BY E.nome ASC, L.titulo ASC;
