/* ---------------------------------------------------------------------
LBDm - Aula de 22 de novembro de 2017
==========================
01. Expanda o BD, do arquivo "Vendas171122.zip", como "LBDm171122_RA_RA.fdb".
02. Registre-o e conecte-o
==========================
03. Inicie o Editor SQL, salve o texto como "LBDm171122_RA_RA.sql", e:
03.1. Explore o conte�do de cada tabela (observe se, na FK, h� NULL e quantos iguais h�)
03.2. Explore a estrutura de cada tabela e, baseado nelas, desenhe um DER b�sico (sem atributos), com os conjuntos de entidades, seus relacionamentos e cardinalidades. Enfim, descubra quem est� ligado a quem e com qual cardinalidade o faz...
==========================
03.3. Explore algumas fun��es (CAST, UPPER, LIKE, SUBSTRING, EXTRACT (DAY...), ...) inclusive as agrupadoras (COUNT, MAX, GROUP BY...)
==========================
03.4. Mostre dados espec�ficos, contidos em tabelas distintas (INNER e OUTER JOINs)
03.4.1. Entre apenas duas tabelas ligadas
03.4.2. Entre tr�s tabelas ligadas
03.4.3. Entre mais tabelas ligadas
03.4.4. Entre todas as tabelas
==========================
03.5. A partir de algumas das instru��es criadas, crie Stored Procedures, cujos par�metros sejam variados (como valores, datas, strings, parte de conte�dos, etc.).
==========================
03.6. Monte Triggers em fun��o de INSERT, UPDATE e DELETE em tabelas distintas, salvando valores e atributos fundamentais, tanto para o salvamento em si, quanto para trilha de auditoria (quem, quando, por onde se fez algo...).
==========================
Resolvendo...
03.1. Explore o conte�do de cada tabela (observe se, na FK, h� NULL e quantos iguais h�)
========================== */
select * from Cliente;
select * from Filial;
select * from ItemVend;
select * from Produto;
select * from Venda;
select * from Vendedor;
/* ==========================
03.3. Explore algumas fun��es (CAST, UPPER, LIKE, SUBSTRING, EXTRACT (DAY...), ...) inclusive as agrupadoras (COUNT, MAX, GROUP BY...)
========================== */
-- 1. Mostre os nomes dos clientes, definidos como CHAR, que contenham "SILVA" em qualquer caixa
--------------------------------

-- 2. Mostre os nomes dos clientes, que contenham "brazeel" em qualquer caixa
--------------------------------

-- 3. Mostre do 10� ao 20� caractere dos nomes dos clientes
--------------------------------

-- 4. Mostre quantos caracteres h� no nome de cada cliente
--------------------------------

-- 5. Mostre o dia, m�s, ano, dia de semana e dia do ano (separados) de cada data de venda
--------------------------------
select  * from Venda;

-- 6. Mostre a data de cada venda e o dia de semana em que foram realizadas
--------------------------------
            
-- 7. Mostre a descri��o, moeda e pre�o unit�rio de cada produto que contenha "mouse" ou "som"
--------------------------------

-- 8. Mostre a descri��o, moeda e pre�o unit�rio de cada produto em "R$"
--------------------------------
select  * from Produto;

-- 9. Mostre o pre�o m�dio dos produtos em cada moeda
--------------------------------

-- 10. Repita, por�m, ambas as m�dias devem ser expressas, tanto em R$, quanto em US$
--------------------------------

/* ==========================
03.4. Mostre dados espec�ficos, contidos em tabelas distintas (INNER e OUTER JOINs)
03.4.1. Entre apenas duas tabelas ligadas
03.4.2. Entre tr�s tabelas ligadas
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
/* 12. Mostre o n�mero de venda, c�digo do produto, os 20 primeiros caracteres da descri��o, a quantidade, a moeda, o pre�o unit�rio e o pre�o total de cada produto vendido
--------------------------------

--------------------------------
-- 03.4.4. Entre todas as tabelas
--------------------------------
select  * from Venda; 
select  * from Filial;
--------------------------------
/* 13. Mostre o n�mero e data da venda, a filial em que ocorreu, o nome do vendedor e o do cliente, o c�digo do produto, os 20 primeiros caracteres da descri��o, a quantidade, moeda, pre�o unit�rio e total de cada produto vendido.
--------------------------------

/* ==========================
03.5. A partir de algumas das instru��es criadas, crie Stored Procedures, cujos par�metros sejam variados (como valores, datas, strings, parte de conte�dos, etc.).
========================== */
/* 14. Mostre o n�mero e data da venda, a filial em que ocorreu, o nome do vendedor e o do cliente, o c�digo do produto, os 20 primeiros caracteres da descri��o, a quantidade, moeda, pre�o unit�rio e total de cada produto vendido, por�m somente das filiais, cujos nomes contenham a palavra "centro" em qualquer caixa.
--------------------------------

--------------------------------
/* 15. Crie o Stored, "SP_03_5", com as mesmas instru��es do exerc�cio 14, por�m, cujo trecho de nome de filial seja informado externamente.
--------------------------------
--

--
Select * from SP_03_5 ('o');
==========================
03.6. Monte Triggers em fun��o de INSERT, UPDATE e DELETE em tabelas distintas, salvando valores e atributos fundamentais, tanto para o salvamento em si, quanto para trilha de auditoria (quem, quando, por onde se fez algo...).
==========================
