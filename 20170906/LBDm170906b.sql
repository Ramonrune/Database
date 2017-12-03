/* ===================================
LBDm - Aula de 06 de setembro de 2017
Structured Query Language � SQL/DML
Prof. MS Wagner Siqueira Cavalcante
===================================
Inser��o de dados em tabela:
    INSERT INTO <TABELA> [(<atrib_1>, <atrib_2>, ..., <atrib_n>)]
        VALUES ( <conteudo_atrib_1>, <conteudo_atrib_2>, ..., <conteudo_atrib_n> ) ;
===================================
Algumas dicas:
01. Usar os nomes de atributos quando:
    01.1. N�o estiverem na mesma ordem da estrutura
    01.2. Alguns estiverem com valor nulo (NULL)
02. Os conte�dos TEM que ser compat�veis com a defini��o!
------------------------------------------------------------------ */
-- 22.1. Inserir a informa��o de que o autor 502 escreveu o livro 1000, na tabela Escreve:
    INSERT INTO Escreve (matricula , codlivro)
        VALUES (502 , 1000);
-- ERRO! Deveria haver o Autor e o Livro ANTES de Escreve!
------------------------------------------------------------------
/* 22.2. Inserir o Livro "An�lise Estruturada de Dados", de c�digo 1000, 
            com pre�o de R$ 74,00, lan�ado em 10/10/1994, de assunto "A", 
            pela Editora "13"
*/
    INSERT INTO Livro
        VALUES (1000, 'An�lise Estruturada de Dados', 74.00, '1994/10/10', 'A', 13);
    COMMIT;
-- ERRO! Deveria haver a Editora 13 antes! Ou, ent�o, � nula.
-- Inserir o mesmo livro, mas sem o c�digo de Editora (codedit=NULL).

-- ERRO! Deveria haver o assunto "A" antes!
===================================
-- 22.2b. Inserir o Assunto "A", que � "An�lise de Sistemas":

-- ERRO! Deveria estar entre ap�strofes ('A' , 'An�lise de Sistemas')!

-- Aspas delimitam apelido (para atributo, por exemplo)
    SELECT sigla, descricao from Assunto;   -- Observe o t�tulo DESCRICAO
    SELECT sigla, descricao AS "Descri��o" from Assunto;    -- Agora, Descri��o
    SELECT sigla, descricao AS "Nhonho" from Assunto;   -- Agora, Nhonho...
===================================
-- Agora, sim, insira o livro sugerido...

    SELECT * from Livro;    -- Agora, sim!
-- Insira o mesmo livro, por�m com c�digo 1001 e assunto "a"

-- ERRO! A sigla cadastrada � "A", e n�o "a".
-- Observe que pode haver livros com o mesmo t�tulo, mas n�o com o mesmo c�digo!
===================================
-- 22.2c. Inserir o mesmo livro, mas com c�digo 1001 e sem NULL em editora

-- ERRO! Est� tentando inserir 5 colunas, mas h� 6 em Livro...

===================================
-- 22.2d. Idem ao anterior, mas com c�digo 1002 e t�tulo como primeiro atributo

===================================
-- 22.3. Inserir as tuplas em Autor:

-- ? Execute! -- Oops! N�o poderia haver 2 CPFs iguais! 
-- Corrija a estrutura de Autor!
    ROLLBACK;   -- Como estava na RAM, apenas evita de ir para o HD
    SELECT * from Autor;
-- Alterando a tabela Autor, para evitar CPFs iguais...

-- Tente executar ambas as inser��es em Autor

-- Beleza! Evitou 2 CPFs iguais!
-- Corrigir, para CPF = "22222222222" (11 "doises")

===================================
-- 22.4. Inserir as tuplas em Editora:
    SELECT * from Livro;
    SELECT * from Editora;
-- Inserir a editora 11, ' Pearson', e 22, 'Makron'

===================================
/* --------------------------------------------------------------------------
Altera��o de dados em tabela:
    UPDATE <TABELA>
    SET <atrib_1> = <conteudo_atrib_1>,
    <atrib_2> = <conteudo_atrib_2>,
    ...,
    <atrib_n> = <conteudo_atrib_n>
    WHERE <condi��o>
--------------------------------------------------------------------------
Exclus�o de dados de uma tabela:
    DELETE FROM <TABELA>
    WHERE <condi��o> 
-- Aten��o! A condi��o (�WHERE�) � fundamental! 
-- Sem ela, TODOS os dados ser�o apagados da tabela!
-------------------------------------------------------------------------- */
    SELECT * from assunto;
    SELECT * from Livro;
--------------------------------------------------------------------------
-- 22.5. Modifique o assunto de "A" para "S"

-- ERRO! N�o consegue, pois j� h� v�rios livros com sigla de assunto "A"
/* --------------------------------------------------------------------------
Provisoriamente:
    1. Remover todos os dados de Livros
    2. Atualizar a estrutura de Livro, com "ON UPDATE CASCADE" na FK sigla
    3. Reinserir os dados de Livros, com assunto "A" e mostr�-los
    4. Atualizar as siglas, de "A" para "S" em Assunto
    5. Mostrar os dados de Livros novamente
--------------------------------------------------------------------------*/
-- 1. Remover todos os dados de Livros

--------------------------------------------------------------------------
-- 2. Atualizar a estrutura de Livro, com "ON UPDATE CASCADE" na FK sigla

--------------------------------------------------------------------------
-- 3. Reinserir os dados de Livros, com assunto "A" e mostr�-los

--------------------------------------------------------------------------
-- 4. Atualizar as siglas, de "A" para "S" em Assunto

    SELECT * from Assunto;  -- Observe que a sigla agora � "S"
--------------------------------------------------------------------------
-- 5. Mostrar os dados de Livro novamente
    SELECT * from Livro;    -- Observe que a sigla tamb�m mudou-se em Livro
===================================
