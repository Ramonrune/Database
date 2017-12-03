/* ---------------------------------------------------------------------
LBDm - Aula de 22 de novembro de 2017
==========================
01. Expanda o BD, do arquivo "Vendas171122.zip", como "LBDm171122_RA_RA.fdb".
02. Registre-o e conecte-o
==========================
03. Inicie o Editor SQL, salve o texto como "LBDm171122_RA_RA.sql", e:
03.1. Explore o conteúdo de cada tabela (observe se, na FK, há NULL e quantos iguais há)
03.2. Explore a estrutura de cada tabela e, baseado nelas, desenhe um DER básico (sem atributos), com os conjuntos de entidades, seus relacionamentos e cardinalidades. Enfim, descubra quem está ligado a quem e com qual cardinalidade o faz...
==========================
03.3. Explore algumas funções (CAST, UPPER, LIKE, SUBSTRING, EXTRACT (DAY...), ...) inclusive as agrupadoras (COUNT, MAX, GROUP BY...)
==========================
03.4. Mostre dados específicos, contidos em tabelas distintas (INNER e OUTER JOINs)
03.4.1. Entre apenas duas tabelas ligadas
03.4.2. Entre três tabelas ligadas
03.4.3. Entre mais tabelas ligadas
03.4.4. Entre todas as tabelas
==========================
03.5. A partir de algumas das instruções criadas, crie Stored Procedures, cujos parâmetros sejam variados (como valores, datas, strings, parte de conteúdos, etc.).
==========================
03.6. Monte Triggers em função de INSERT, UPDATE e DELETE em tabelas distintas, salvando valores e atributos fundamentais, tanto para o salvamento em si, quanto para trilha de auditoria (quem, quando, por onde se fez algo...).
==========================
Resolvendo...
03.1. Explore o conteúdo de cada tabela (observe se, na FK, há NULL e quantos iguais há)
========================== */
select * from Cliente;
select * from Filial;
select * from ItemVend;
select * from Produto;
select * from Venda;
select * from Vendedor;
/* ==========================
03.3. Explore algumas funções (CAST, UPPER, LIKE, SUBSTRING, EXTRACT (DAY...), ...) inclusive as agrupadoras (COUNT, MAX, GROUP BY...)
========================== */
-- 1. Mostre os nomes dos clientes, definidos como CHAR, que contenham "SILVA" em qualquer caixa
--------------------------------

-- 2. Mostre os nomes dos clientes, que contenham "brazeel" em qualquer caixa
--------------------------------

-- 3. Mostre do 10º ao 20º caractere dos nomes dos clientes
--------------------------------

-- 4. Mostre quantos caracteres há no nome de cada cliente
--------------------------------

-- 5. Mostre o dia, mês, ano, dia de semana e dia do ano (separados) de cada data de venda
--------------------------------
select  * from Venda;

-- 6. Mostre a data de cada venda e o dia de semana em que foram realizadas
--------------------------------
            
-- 7. Mostre a descrição, moeda e preço unitário de cada produto que contenha "mouse" ou "som"
--------------------------------

-- 8. Mostre a descrição, moeda e preço unitário de cada produto em "R$"
--------------------------------
select  * from Produto;

-- 9. Mostre o preço médio dos produtos em cada moeda
--------------------------------

-- 10. Repita, porém, ambas as médias devem ser expressas, tanto em R$, quanto em US$
--------------------------------

/* ==========================
03.4. Mostre dados específicos, contidos em tabelas distintas (INNER e OUTER JOINs)
03.4.1. Entre apenas duas tabelas ligadas
03.4.2. Entre três tabelas ligadas
03.4.3. Entre mais tabelas ligadas
03.4.4. Entre todas as tabelas
========================== */
-- 03.4.1. Entre apenas duas tabelas ligadas
--------------------------------
select * from ItemVend;
select * from Produto;
--------------------------------
-- 11. Mostre todos os dados dos itens de venda e dos produtos correspondentes
--------------------------------

--------------------------------
/* 12. Mostre o número de venda, código do produto, os 20 primeiros caracteres da descrição, a quantidade, a moeda, o preço unitário e o preço total de cada produto vendido
--------------------------------

--------------------------------
-- 03.4.4. Entre todas as tabelas
--------------------------------
select  * from Venda; 
select  * from Filial;
--------------------------------
/* 13. Mostre o número e data da venda, a filial em que ocorreu, o nome do vendedor e o do cliente, o código do produto, os 20 primeiros caracteres da descrição, a quantidade, moeda, preço unitário e total de cada produto vendido.
--------------------------------

/* ==========================
03.5. A partir de algumas das instruções criadas, crie Stored Procedures, cujos parâmetros sejam variados (como valores, datas, strings, parte de conteúdos, etc.).
========================== */
/* 14. Mostre o número e data da venda, a filial em que ocorreu, o nome do vendedor e o do cliente, o código do produto, os 20 primeiros caracteres da descrição, a quantidade, moeda, preço unitário e total de cada produto vendido, porém somente das filiais, cujos nomes contenham a palavra "centro" em qualquer caixa.
--------------------------------

--------------------------------
/* 15. Crie o Stored, "SP_03_5", com as mesmas instruções do exercício 14, porém, cujo trecho de nome de filial seja informado externamente.
--------------------------------
--

--
Select * from SP_03_5 ('o');
==========================
03.6. Monte Triggers em função de INSERT, UPDATE e DELETE em tabelas distintas, salvando valores e atributos fundamentais, tanto para o salvamento em si, quanto para trilha de auditoria (quem, quando, por onde se fez algo...).
==========================
