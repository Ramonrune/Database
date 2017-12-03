/* ===================================
LBDm - Aula de 06 de setembro de 2017
Structured Query Language – SQL/DML
Prof. MS Wagner Siqueira Cavalcante
===================================
Inserção de dados em tabela:
    INSERT INTO <TABELA> [(<atrib_1>, <atrib_2>, ..., <atrib_n>)]
        VALUES ( <conteudo_atrib_1>, <conteudo_atrib_2>, ..., <conteudo_atrib_n> ) ;
===================================
Algumas dicas:
01. Usar os nomes de atributos quando:
    01.1. Não estiverem na mesma ordem da estrutura
    01.2. Alguns estiverem com valor nulo (NULL)
02. Os conteúdos TEM que ser compatíveis com a definição!
------------------------------------------------------------------ */
-- 22.1. Inserir a informação de que o autor 502 escreveu o livro 1000, na tabela Escreve:
    INSERT INTO Escreve (matricula , codlivro)
        VALUES (502 , 1000);
-- ERRO! Deveria haver o Autor e o Livro ANTES de Escreve!
------------------------------------------------------------------
/* 22.2. Inserir o Livro "Análise Estruturada de Dados", de código 1000, 
            com preço de R$ 74,00, lançado em 10/10/1994, de assunto "A", 
            pela Editora "13"
*/
    INSERT INTO Livro
        VALUES (1000, 'Análise Estruturada de Dados', 74.00, '1994/10/10', 'A', 13);
    COMMIT;
-- ERRO! Deveria haver a Editora 13 antes! Ou, então, é nula.
-- Inserir o mesmo livro, mas sem o código de Editora (codedit=NULL).

-- ERRO! Deveria haver o assunto "A" antes!
===================================
-- 22.2b. Inserir o Assunto "A", que é "Análise de Sistemas":

-- ERRO! Deveria estar entre apóstrofes ('A' , 'Análise de Sistemas')!

-- Aspas delimitam apelido (para atributo, por exemplo)
    SELECT sigla, descricao from Assunto;   -- Observe o título DESCRICAO
    SELECT sigla, descricao AS "Descrição" from Assunto;    -- Agora, Descrição
    SELECT sigla, descricao AS "Nhonho" from Assunto;   -- Agora, Nhonho...
===================================
-- Agora, sim, insira o livro sugerido...

    SELECT * from Livro;    -- Agora, sim!
-- Insira o mesmo livro, porém com código 1001 e assunto "a"

-- ERRO! A sigla cadastrada é "A", e não "a".
-- Observe que pode haver livros com o mesmo título, mas não com o mesmo código!
===================================
-- 22.2c. Inserir o mesmo livro, mas com código 1001 e sem NULL em editora

-- ERRO! Está tentando inserir 5 colunas, mas há 6 em Livro...

===================================
-- 22.2d. Idem ao anterior, mas com código 1002 e título como primeiro atributo

===================================
-- 22.3. Inserir as tuplas em Autor:

-- ? Execute! -- Oops! Não poderia haver 2 CPFs iguais! 
-- Corrija a estrutura de Autor!
    ROLLBACK;   -- Como estava na RAM, apenas evita de ir para o HD
    SELECT * from Autor;
-- Alterando a tabela Autor, para evitar CPFs iguais...

-- Tente executar ambas as inserções em Autor

-- Beleza! Evitou 2 CPFs iguais!
-- Corrigir, para CPF = "22222222222" (11 "doises")

===================================
-- 22.4. Inserir as tuplas em Editora:
    SELECT * from Livro;
    SELECT * from Editora;
-- Inserir a editora 11, ' Pearson', e 22, 'Makron'

===================================
/* --------------------------------------------------------------------------
Alteração de dados em tabela:
    UPDATE <TABELA>
    SET <atrib_1> = <conteudo_atrib_1>,
    <atrib_2> = <conteudo_atrib_2>,
    ...,
    <atrib_n> = <conteudo_atrib_n>
    WHERE <condição>
--------------------------------------------------------------------------
Exclusão de dados de uma tabela:
    DELETE FROM <TABELA>
    WHERE <condição> 
-- Atenção! A condição (“WHERE”) é fundamental! 
-- Sem ela, TODOS os dados serão apagados da tabela!
-------------------------------------------------------------------------- */
    SELECT * from assunto;
    SELECT * from Livro;
--------------------------------------------------------------------------
-- 22.5. Modifique o assunto de "A" para "S"

-- ERRO! Não consegue, pois já há vários livros com sigla de assunto "A"
/* --------------------------------------------------------------------------
Provisoriamente:
    1. Remover todos os dados de Livros
    2. Atualizar a estrutura de Livro, com "ON UPDATE CASCADE" na FK sigla
    3. Reinserir os dados de Livros, com assunto "A" e mostrá-los
    4. Atualizar as siglas, de "A" para "S" em Assunto
    5. Mostrar os dados de Livros novamente
--------------------------------------------------------------------------*/
-- 1. Remover todos os dados de Livros

--------------------------------------------------------------------------
-- 2. Atualizar a estrutura de Livro, com "ON UPDATE CASCADE" na FK sigla

--------------------------------------------------------------------------
-- 3. Reinserir os dados de Livros, com assunto "A" e mostrá-los

--------------------------------------------------------------------------
-- 4. Atualizar as siglas, de "A" para "S" em Assunto

    SELECT * from Assunto;  -- Observe que a sigla agora é "S"
--------------------------------------------------------------------------
-- 5. Mostrar os dados de Livro novamente
    SELECT * from Livro;    -- Observe que a sigla também mudou-se em Livro
===================================
