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
SELECT nomcli "Nome do cliente" FROM Cliente WHERE UPPER(TRIM(nomcli)) LIKE UPPER('%Silva%');

--------------------------------

-- 2. Mostre os nomes dos clientes, que contenham "brazeel" em qualquer caixa
--------------------------------
SELECT nomcli FROM Cliente WHERE UPPER(nomcli) LIKE UPPER('%BRAZEEL%');
-- 3. Mostre do 10º ao 20º caractere dos nomes dos clientes
--------------------------------
SELECT SUBSTRING(nomcli FROM 10 FOR 20 ) FROM Cliente;
-- 4. Mostre quantos caracteres há no nome de cada cliente
--------------------------------
SELECT CHAR_LENGTH(TRIM(nomcli)) FROM Cliente;
-- 5. Mostre o dia, mês, ano, dia de semana e dia do ano (separados) de cada data de venda
--------------------------------
select  * from Venda;

select  EXTRACT (DAY FROM datvenda),
           EXTRACT (MONTH FROM datvenda),
           EXTRACT (YEAR FROM datvenda), 
           EXTRACT (WEEKDAY FROM datvenda),
           EXTRACT (YEARDAY FROM datvenda)
from    Venda
-- 6. Mostre a data de cada venda e o dia de semana em que foram realizadas
--------------------------------
select  datvenda,
        CASE 
            WHEN EXTRACT (WEEKDAY FROM datvenda) = 0 THEN 'Domingo'
            WHEN EXTRACT (WEEKDAY FROM datvenda) = 1 THEN 'Segunda'
            WHEN EXTRACT (WEEKDAY FROM datvenda) = 2 THEN 'Terça'
            WHEN EXTRACT (WEEKDAY FROM datvenda) = 3 THEN 'Quarta'
            WHEN EXTRACT (WEEKDAY FROM datvenda) = 4 THEN 'Quinta'
            WHEN EXTRACT (WEEKDAY FROM datvenda) = 5 THEN 'Sexta'
            ELSE 'Sábado'
        END "Dia de semana"
from Venda          
-- 7. Mostre a descrição, moeda e preço unitário de cada produto que contenha "mouse" ou "som"
--------------------------------
SELECT descri, moeda, preuni FROM Produto WHERE UPPER(descri) LIKE UPPER('mouse') OR UPPER(descri) LIKE UPPER('%som%');
-- 8. Mostre a descrição, moeda e preço unitário de cada produto em "R$"
--------------------------------
select  * from Produto;

SELECT descri, moeda, preuni, 
CASE
    WHEN moeda = 'US$' THEN preuni / 3.14
    ELSE preuni
END "Preço convertido em R$"
FROM Produto;

-- 9. Mostre o preço médio dos produtos em cada moeda
--------------------------------
SELECT moeda, AVG(preuni) FROM Produto GROUP BY Moeda;
-- 10. Repita, porém, ambas as médias devem ser expressas, tanto em R$, quanto em US$
--------------------------------
SELECT moeda, AVG(preuni), 
    CASE
        WHEN moeda = 'US$' then AVG(preuni) * 3.14
        ELSE AVG(preuni)
    END
FROM Produto GROUP BY moeda;
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
SELECT P.codprod, P.descri, P.moeda, P.preuni FROM Produto P INNER JOIN ItemVend I ON P.codprod = I.codprod;
--------------------------------
/* 12. Mostre o número de venda, código do produto, os 20 primeiros caracteres da descrição, a quantidade, a moeda, o preço unitário e o preço total de cada produto vendido
--------------------------------*/
SELECT I.nrovenda, P.codprod, SUBSTRING(P.descri FROM 1 FOR 20), I.quantid, P.moeda, P.preuni, I.quantid * P.preuni "Preço total" FROM Produto P INNER JOIN ItemVend I ON P.codprod = I.codprod;

--------------------------------
-- 03.4.4. Entre todas as tabelas
--------------------------------
select  * from Venda; 
select  * from Filial;
--------------------------------
/* 13. Mostre o número e data da venda, a filial em que ocorreu, o nome do vendedor e o do cliente, o código do produto, os 20 primeiros caracteres da descrição, a quantidade, moeda, preço unitário e total de cada produto vendido.
--------------------------------*/

SELECT Venda.NROVENDA, VENDA.DATVENDA, FILIAL.NOMFILIAL, 
VENDEDOR.NOMVENDR, CLIENTE.NOMCLI, 
Produto.CODPROD, SUBSTRING(Produto.DESCRI FROM 1 FOR 20), ITEMVEND.QUANTID, 
PRODUTO.MOEDA, PRODUTO.PREUNI, ITEMVEND.QUANTID * PRODUTO.PREUNI
FROM Venda INNER JOIN Filial ON Venda.NRFILIAL = Filial.NRFILIAL
           INNER JOIN Vendedor ON Venda.CODVENDR = VENDEDOR.CODVENDR
           INNER JOIN Cliente ON Venda.CODCLI = CLIENTE.CODCLI
           INNER JOIN ItemVend ON Venda.NROVENDA = ITEMVEND.NROVENDA
           INNER JOIN Produto ON ITEMVEND.CODPROD = PRODUTO.CODPROD


select  V.nrovenda, datvenda,
           nomfilial,
           nomvendr,
           nomcli,
           TRIM (P.codprod), 
           SUBSTRING (descri FROM 1 for 20), quantid, moeda, preuni, 
           quantid * preuni
from    Venda V  INNER JOIN Filial F ON V.nrfilial = F.nrfilial
                        INNER JOIN Vendedor Vr ON V.codvendr = Vr.codvendr
                        INNER JOIN Cliente C ON V.codcli = C.codcli
                        INNER JOIN ItemVend It ON V.nrovenda = It.nrovenda
                        INNER JOIN Produto P ON It.codprod = P.codprod
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
