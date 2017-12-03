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
select  nomcli "Nome do cliente"
from    Cliente
where   UPPER (nomcli) LIKE UPPER ('%SILVA%')
order    by nomcli DESC

-- 2. Mostre os nomes dos clientes, que contenham "brazeel" em qualquer caixa
--------------------------------
select  nomcli "Nome do cliente"
from    Cliente
where   UPPER (nomcli) LIKE UPPER ('%brazeel%')
order    by nomcli DESC

-- 3. Mostre do 10º ao 20º caractere dos nomes dos clientes
--------------------------------
select  SUBSTRING (nomcli FROM 10 FOR 20)
from    Cliente

-- 4. Mostre quantos caracteres há no nome de cada cliente
--------------------------------
select  CHAR_LENGTH (TRIM(nomcli))
from    Cliente

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
select  TRIM (descri), moeda, preuni
from    Produto
where   UPPER (descri) LIKE UPPER ('%mouse%')
OR        UPPER (descri) LIKE UPPER ('%som%')

-- 8. Mostre a descrição, moeda e preço unitário de cada produto em "R$"
--------------------------------
select  * from Produto;

select  TRIM (descri), moeda, preuni
from    Produto
where   moeda = 'R$'
AND     preuni > 0

-- 9. Mostre o preço médio dos produtos em cada moeda
--------------------------------
select  moeda, AVG (preuni)
from    Produto
GROUP BY moeda

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
select  *
from    ItemVend It INNER JOIN Produto P ON It.codprod = P.codprod
--------------------------------
/* 12. Mostre o número de venda, código do produto, os 20 primeiros caracteres da descrição, a quantidade, a moeda, o preço unitário e o preço total de cada produto vendido
--------------------------------
select  nrovenda, TRIM (P.codprod), 
           SUBSTRING (descri FROM 1 for 20), quantid, moeda, preuni, 
           quantid * preuni
from    ItemVend It INNER JOIN Produto P ON It.codprod = P.codprod
--------------------------------
-- 03.4.4. Entre todas as tabelas
--------------------------------
select  * from Venda; 
select  * from Filial;
--------------------------------
/* 13. Mostre o número e data da venda, a filial em que ocorreu, o nome do vendedor e o do cliente, o código do produto, os 20 primeiros caracteres da descrição, a quantidade, moeda, preço unitário e total de cada produto vendido.
--------------------------------
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
where   UPPER (nomfilial) LIKE UPPER ('%centro%')
--------------------------------
/* 15. Crie o Stored, "SP_03_5", com as mesmas instruções do exercício 14, porém, cujo trecho de nome de filial seja informado externamente.
--------------------------------
--
set term^;
CREATE or ALTER PROCEDURE SP_03_5
    (i_TrechoFilial   varchar (30))
RETURNS
    (o_nrovenda smallint,
     o_datvenda date,
     o_nomfilial  varchar (30),
     o_nomvendr varchar (36),
     o_nomcli    varchar (36),
     o_codprod  varchar (17),
     o_descri     varchar (20),
     o_quantid   smallint,
     o_moeda    char (04),
     o_preunit   numeric (8,2),
     o_precototal numeric (10,2)
    )
AS
BEGIN
    FOR
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
        where   UPPER (nomfilial) LIKE UPPER ('%' || :i_trechofilial ||'%')
        INTO    :o_nrovenda,    :o_datvenda,
                    :o_nomfilial,  :o_nomvendr, :o_nomcli,
                    :o_codprod, :o_descri, :o_quantid,
                    :o_moeda, :o_preunit, :o_precototal
        DO
        SUSPEND;
END^
set term;^
COMMIT;
--
Select * from SP_03_5 ('o');
==========================
03.6. Monte Triggers em função de INSERT, UPDATE e DELETE em tabelas distintas, salvando valores e atributos fundamentais, tanto para o salvamento em si, quanto para trilha de auditoria (quem, quando, por onde se fez algo...).
==========================
/* 16. Toda vez que houver uma nova venda, antes que isto ocorra, deve-se armazenar seu código em uma tabela de segurança, Venda_Segura, além da informação do tipo de transação, o nome do usuário que a realizou e o endereço do compjutador, bem como a data, hora
*/
-- Criando a tabela Venda_Segura:
Create table Venda_Segura
    (nrovenda   smallint,
     datvenda   date,
     prazentr    smallint,
     codvendr   smallint,
     codcli        smallint,
     nrfilial       smallint,
     tiptrans     char (01),
     nomeusu   varchar (20),
     endcomp   varchar (20),
     datatrans  date,
     horatrans  time
    );
commit;
-------------------------------------------------------------------
set term^;
Create or Alter Trigger SP_03_6_16
FOR Venda
ACTIVE
BEFORE Insert
AS
BEGIN
    Insert into Venda_Segura (nrovenda, tiptrans, nomeusu, endcomp, datatrans, horatrans)
    Values (new.nrovenda, 'I', current_user, 
                (select rdb$get_context('SYSTEM', 'CLIENT_ADDRESS') from rdb$database), 
                current_date, current_time);
END^
set term;^
COMMIT;
-- Experimente uma execução por vez...
select * from Venda;
select * from Venda_Segura;

Insert into Venda (nrovenda, datvenda, prazentr, codvendr, codcli, nrfilial)
Values ((select MAX (nrovenda)+1 from Venda), current_date, 10, 222, 123, 5);

select * from Venda;
select * from Venda_Segura;
/* 17. Toda vez que houver alteração ou exclusão de uma venda, antes que isto ocorra, deve-se armazenar todos os seus dados em uma tabela de segurança, Venda_UpdDel, além da informação do tipo de transação, o nome do usuário que a realizou e o endereço do computador, bem como a data, hora
*/
set term^;
Create or Alter Trigger TG_03_6_17
FOR Venda
ACTIVE
BEFORE Update or Delete
AS
BEGIN
    Insert into Venda_Segura
    Values (old.nrovenda, old.datvenda, old.prazentr, old.codvendr, old.codcli, old.nrfilial,
                CASE
                    WHEN UPDATING THEN 'U'
                    ELSE 'D'
                END,
                current_user, 
                (select rdb$get_context('SYSTEM', 'CLIENT_ADDRESS') from rdb$database), 
                current_date, current_time);
END^
set term;^
COMMIT;
-- Experimente uma execução por vez...
select * from Venda;
select * from Venda_Segura;

UPDATE Venda SET nrfilial = 4 WHERE nrovenda = (select MAX(nrovenda) from Venda);

select * from Venda;
select * from Venda_Segura;

DELETE from Venda WHERE nrovenda = (select MAX(nrovenda) from Venda);

select * from Venda;
select * from Venda_Segura;

