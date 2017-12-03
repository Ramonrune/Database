-- Refor�ando sobre JOINS:
____________________________________________________________________________
. Basicamente, e de forma mais convencional, os relacionamentos ocorrem entre as tabelas adjuntas, ou seja, aquelas que t�m FK (chave estrangeira) com aquelas que t�m a PK (chave prim�ria) com conte�do igual a desta FK (n�o necessariamente o nome do atributo, mas, sim, seu conte�do).
. Se a Tabela A se relaciona com a Tabela B (FK de A e/ou FK de C), e esta com a Tabela C (FK de B, se FK de C n�o estiver em B), o JOIN deve ocorrer entre A e B e, depois, entre B e C.
. Se alguma tabela contiver tuplas com FK que podem estar NULL (vazias), no INNER JOIN n�o aparecer�o, mas em OUTER JOIN (LEFT/RIGHT/FULL), podem.
____________________________________________________________________________
01. Primeiramente, observe os conte�dos das tabelas Livro e da Editora:
---------------------------------
select * from livro		-- H� um livro sem editora. Observe os codedit...
select * from editora	-- H� v�rias editoras sem livros (codedit / 2, 3, 4...)
____________________________________________________________________________
02. Agora, mostre os dados da tabela Livro e os da editora correspondente.
---------------------------------
select  *
from    Livro INNER JOIN Editora
on       Livro.codedit = Editora.codedit	
---------------------------------
-- Como codedit est� em ambas, deve-se dizer de onde cada um vem! Por isto, "Livro." e "Editora.".
-- Observe, tamb�m, que o livro sem editora (null), n�o aparece, pois n�o h� editora correspondente!
____________________________________________________________________________
03. Mostre apenas o t�tulo do livro (que s� h� em Livro) e o nome da editora (que s� h� em Editora):
---------------------------------
select  titulo , nome
from    Livro INNER JOIN Editora
on       Livro.codedit = Editora.codedit
____________________________________________________________________________
04. Ao inv�s de indicar o nome completo da tabela (Livro.codedit), use vari�vel tupla (L.codedit):
---------------------------------
select  L.titulo , E.nome
from    Livro L INNER JOIN Editora E
on       L.codedit = E.codedit
____________________________________________________________________________
05. Volte a observar os conte�dos das tabelas Livro e Editora, pois experimentaremos OUTER JOINs:
---------------------------------
select * from livro
select * from editora
____________________________________________________________________________
06. Lembra-se do livro que est� com codedit = NULL? Pois �, agora vamos mostrar os t�tulos de TODOS os livros (eu disse TODOS) e, havendo Editora correspondente, seu nome: 
---------------------------------
select  L.titulo , E.nome
from    Livro L LEFT OUTER JOIN Editora E	-- LEFT priorizar� a tabela � esquerda = Livro!
on       L.codedit = E.codedit
---------------------------------
-- Viu, que agora h� livro com codedit = NULL? Com INNER JOIN n�o mostraria.
____________________________________________________________________________
06b. "NULL" � muito esquisito de se mostrar, ent�o, ao inv�s, mostre "-- sem editora"
---------------------------------
select  L.titulo , COALESCE (E.nome , '-- sem editora')
from    Livro L LEFT OUTER JOIN Editora E
on       L.codedit = E.codedit
---------------------------------
-- "Da hora", n�?
____________________________________________________________________________
07. Experimente trocar LEFT por RIGHT:
---------------------------------
select  L.titulo , E.nome
from    Livro L RIGHT OUTER JOIN Editora E
on       L.codedit = E.codedit
---------------------------------
�ia! "Despriorizou" o Livro e priorizou a Editora! L�gico, pois Editora est� � direita no FROM...
____________________________________________________________________________
08. Agora, sendo necess�rio mostrar TODOS os t�tulos dos Livros e TODOS os nomes de Editoras e sua correspond�ncia. Neste caso, se n�o houver correspond�ncia, aparecer�o como NULL em uma ou em outra (se um Livro n�o for de alguma Editora, ou se alguma Editora n�o editou livros).
---------------------------------
select  L.titulo , E.nome
from    Livro L FULL OUTER JOIN Editora E
on       L.codedit = E.codedit
---------------------------------
Viu s�?
____________________________________________________________________________
09. Mostrar todos os dados dos Livros e de seus Autores. 
-- Neste caso, observe que nem Livro, nem Autor, possui FK da outra, as quais est�o na tabela Escreve, pois o relacionamento entre Livro e Autor � M:N (muitos para muitos, o que obriga a exist�ncia da tabela intermedi�ria de relacionamento, Escreve, com ambas as FKs, tamb�m fazendo parte da PK composta PK = {codlivro , matricula}). 
-- Portanto, o JOIN dever� ocorrer entre Livro e Escreve, e entre Escreve e Autor. Veja:
---------------------------------
select  *
from    Livro L INNER JOIN Escreve Es ON L.codlivro = Es.codlivro	-- Livro:Escreve
                     INNER JOIN Autor Au ON Au.matricula = Es.matricula	-- Escreve:Autor
____________________________________________________________________________
10. Ao inv�s de mostrar todos os dados, mostre apenas o t�tulo do Livro e o nome do Autor:
---------------------------------
select  L.titulo , Au.nome
from    Livro L INNER JOIN Escreve Es ON L.codlivro = Es.codlivro
                     INNER JOIN Autor Au ON Au.matricula = Es.matricula
---------------------------------
-- Est� ficando cada vez melhor, n�?
____________________________________________________________________________
11. Mostre todos os dados dos Livros, de seus Autores, dos Assuntos e das Editoras correspondentes.
---------------------------------
select  *
from    Livro L INNER JOIN Escreve Es ON L.codlivro / Es.codlivro
                     INNER JOIN Autor Au ON Au.matricula / Es.matricula
                     INNER JOIN Assunto A ON A.sigla / L.sigla
                     INNER JOIN Editora Ed ON Ed.codedit / L.codedit
____________________________________________________________________________
12. Agora, mostre apenas o t�tulo de cada Livro, o nome de sua Editora, o nome de cada um de seus Autores e a descri��o do Assunto correspondente
---------------------------------
select  L.titulo, Ed.nome, Au.nome, A.descricao
from    Livro L INNER JOIN Escreve Es ON L.codlivro / Es.codlivro
                     INNER JOIN Autor Au ON Au.matricula / Es.matricula
                     INNER JOIN Assunto A ON A.sigla / L.sigla
                     INNER JOIN Editora Ed ON Ed.codedit / L.codedit
---------------------------------
