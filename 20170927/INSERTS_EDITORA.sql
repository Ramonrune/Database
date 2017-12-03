/* -------------------------------------------------
22.3. Inserir as tuplas em Autor:
------------------------------------------------- */
INSERT INTO AUTOR VALUES (501, 'Rogério Luís de C. Costa', '11111111111', 'Rua Dom Pedro I, 111', '1971-01-01', 'BR');
INSERT INTO AUTOR VALUES (502, 'Chris Gane', '22222222222', 'Av La Rue, XV', '1952-02-02', 'US');
INSERT INTO AUTOR VALUES (503, 'Trish Sarson', '33333333333', '5th Av, 333', '1963-03-03', 'US');
INSERT INTO AUTOR VALUES (505, 'Rogério Matoso Capim', '44444444444', 'Praça do Centro, banco 4', '1974-04-04', 'BR');
INSERT INTO AUTOR VALUES (507, 'Roger Martin Duvalle', '55555555555', 'AV. C’est la vie, 555', '1985-05-05', 'FR');
INSERT INTO AUTOR VALUES (510, 'José Antônio da Silva', '66666666666', 'Rua 6 de Outubro, 606', '1976-06-06', 'BR');
INSERT INTO AUTOR VALUES (511, 'Elmasri', '77777777777', '5th Ave, 777', '1967-07-07', 'US');
INSERT INTO AUTOR VALUES (521, 'Navathe', '88888888888', '5th Ave, 888', '1958-08-08', 'IN');
INSERT INTO AUTOR VALUES (533, 'Silberschatz', '99999999999', '2nd Ave, 999', '1969-09-09', 'NO');
COMMIT;
/* -------------------------------------------------
22.4. Inserir as tuplas em Editora:
------------------------------------------------- */
INSERT INTO EDITORA VALUES (1, 'Mirandela Editora');
INSERT INTO EDITORA VALUES (2, 'Editora Via-Norte');
INSERT INTO EDITORA VALUES (3, 'Editora Ilhas Tijucas');
INSERT INTO EDITORA VALUES (4, 'Maria José Editora');
INSERT INTO EDITORA VALUES (5, 'Brasport Editora');
INSERT INTO EDITORA VALUES (6, 'Pearson Education');
INSERT INTO EDITORA VALUES (7, 'Editora Campus');
INSERT INTO EDITORA VALUES (8, 'Editora Érica');
INSERT INTO EDITORA VALUES (10, 'Editora Ática');
INSERT INTO EDITORA VALUES (11, 'Marketing Books');
INSERT INTO EDITORA VALUES (12, 'Editora Berkeley');
INSERT INTO EDITORA VALUES (13, 'LTC - Livros Técnicos e
Científicos Editora S/A');
COMMIT;
/* -------------------------------------------------
22.5. Inserir as tuplas em Assunto:
------------------------------------------------- */
INSERT INTO ASSUNTO VALUES ('D', 'Banco de Dados');
INSERT INTO ASSUNTO VALUES ('P', 'Programação');
INSERT INTO ASSUNTO VALUES ('R', 'Redes');
INSERT INTO ASSUNTO VALUES ('S', 'Sistemas Operacionais');
INSERT INTO ASSUNTO VALUES ('C', 'Certificações');
INSERT INTO ASSUNTO VALUES ('A', 'Análise de Sistemas');
INSERT INTO ASSUNTO VALUES ('E', 'Engenharia de Software');
INSERT INTO ASSUNTO VALUES ('I', 'Internet');
COMMIT;
/* -------------------------------------------------
22.2. Inserir as tuplas em Livro
------------------------------------------------- */
INSERT INTO LIVRO VALUES (1000, 'Análise Estruturada de Dados', 74, '1994-10-10', 'A', 13);
INSERT INTO LIVRO VALUES (1001, 'SQL - Guia Prático', 56, '2014-03-01', 'D', 5);
INSERT INTO LIVRO VALUES (1002, 'Sistemas de Banco de Dados', 175, '2014-05-10', 'D', 6);
INSERT INTO LIVRO VALUES (1005, 'Aplicações e Banco de Dados para Internet', 59, NULL, 'I', 8);
INSERT INTO LIVRO VALUES (1010, 'Sistema de Banco de Dados', 184, '2013-08-04', 'D', 6);
INSERT INTO LIVRO VALUES (1050, 'Servidores de Rede com Linux', 198, NULL, 'R', 11);
INSERT INTO LIVRO VALUES (1012, 'Dominando C++', 95, '2015-10-01', 'P', 1);
INSERT INTO LIVRO VALUES (1200, 'Dominando a Linguagem C', 158.00, NULL, 'P', 11);
COMMIT;
INSERT INTO LIVRO (codlivro, titulo, preco, sigla) VALUES (1111, 'Criação de lojas virtuais', 76.98, 'I');
INSERT INTO LIVRO (titulo, codlivro, preco, lancamento, sigla, codedit) VALUES ('Linguagem C++ Total', 1236, 195.73, '2015/05/18', 'P', 12);
COMMIT;
/* -------------------------------------------------
22.1. Inserir as tuplas em Escreve
------------------------------------------------- */
INSERT INTO Escreve (matricula, codlivro) values (502, 1000);
INSERT INTO Escreve (matricula, codlivro) values (503, 1000);
INSERT INTO Escreve (matricula, codlivro) values (501, 1001);
INSERT INTO Escreve (matricula, codlivro) values (511, 1001);
INSERT INTO Escreve (matricula, codlivro) values (521, 1002);
INSERT INTO Escreve (matricula, codlivro) values (510, 1005);
INSERT INTO Escreve (matricula, codlivro) values (533, 1010);
INSERT INTO Escreve (matricula, codlivro) values (510, 1012);
INSERT INTO Escreve (matricula, codlivro) values (507, 1050);
INSERT INTO Escreve (matricula, codlivro) values (507, 1236);
COMMIT;
/* -------------------------------------------------
22.6. Inserir as tuplas em Pais:
------------------------------------------------- */
INSERT INTO PAIS VALUES ('AR', 'Argentina', 'ARG', '.ar', '32', '54');
INSERT INTO PAIS VALUES ('BR', 'Brasil', 'BRA', '.br', '76', '55');
INSERT INTO PAIS VALUES ('FR', 'França', 'FRA', '.fr', '250', '33');
INSERT INTO PAIS VALUES ('DE', 'Alemanha', 'DEU', '.de', '276', '49');
INSERT INTO PAIS VALUES ('IN', 'Índia', 'IND', '.in', '356', '91');
INSERT INTO PAIS VALUES ('NO', 'Noruega', 'NOR', '.no', '578', '47');
INSERT INTO PAIS VALUES ('RU', 'Federação Russa', 'RUS', '.ru', '643', '7');
INSERT INTO PAIS VALUES ('US', 'Estados Unidos da América', 'USA', '.us', '840', '1');
COMMIT;
------------------------------------------------- */
select * from Autor;
select * from Assunto;
select * from Livro;
select * from Editora;
select * from escreve;
select * from pais;

















