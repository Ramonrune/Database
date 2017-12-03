-- Primeiramente, criar as tabelas independentes
/* -------------------------------------------------
   Criação da tabela Editora
------------------------------------------------- */
CREATE TABLE Editora
  (codedit     SMALLINT      NOT NULL,
   nome        VARCHAR(80)   NOT NULL,
   CONSTRAINT PK_Editora PRIMARY KEY (codedit));
commit;
/* -------------------------------------------------
Criação da tabela Assunto
------------------------------------------------- */
CREATE TABLE Assunto
  (sigla       CHAR (01)     NOT NULL,
   descricao   VARCHAR (50)  NOT NULL,
               CONSTRAINT   PK_Assunto
               PRIMARY KEY (sigla));
commit;
/* -------------------------------------------------
Como a tabela Livro depende de Editora e Assunto,
com PK e FKs, só pode ser criada logo após ambas.
------------------------------------------------- */
/* -------------------------------------------------
   Criação da tabela Autor
------------------------------------------------- */
CREATE TABLE Autor
  (matricula   SMALLINT      NOT NULL,
   nome        VARCHAR  (80) NOT NULL,
   cpf         CHAR     (11),
   endereco    VARCHAR (120) NOT NULL,
   nascim      DATE          NOT NULL,
   pais        CHAR (02)     NOT NULL,
   CONSTRAINT PK_Autor PRIMARY KEY (matricula));
commit;
/* -------------------------------------------------
   Criação da tabela Livro
------------------------------------------------- */
CREATE TABLE Livro
  (codlivro    SMALLINT      NOT NULL, 
   titulo      VARCHAR(80)   NOT NULL,
   preco       NUMERIC(10,2),
   lancamento  DATE,
   sigla       CHAR (01)     NOT NULL,
   codedit     SMALLINT,
   CONSTRAINT PK_Livro   PRIMARY KEY (codlivro),
   CONSTRAINT FK_Assunto FOREIGN KEY (sigla)
               REFERENCES Assunto (sigla),
   CONSTRAINT FK_Editora FOREIGN KEY (codedit)
               REFERENCES Editora (codedit));
commit;
/* -------------------------------------------------
Como a tabela Escreve descreve um relacionamento M:N,
entre Autor e Livro, com PK e FKs, só pode ser criada 
após ambas.
------------------------------------------------- */
/* -------------------------------------------------
   Criação da tabela Escreve (Autor-Livro = M:N)
------------------------------------------------- */
CREATE TABLE Escreve (
   matricula   SMALLINT      NOT NULL,
   codlivro    SMALLINT      NOT NULL,
   CONSTRAINT PK_Escreve 
               PRIMARY KEY (matricula , codlivro),
   CONSTRAINT FK_Autor FOREIGN KEY (matricula)
               REFERENCES Autor (matricula),
   CONSTRAINT FK_Livro FOREIGN KEY (codlivro)
               REFERENCES Livro
);
commit;
/* -------------------------------------------------
   Criação da tabela País
------------------------------------------------- */
Create table Pais (
  id_pais2 char(02) not null,
  nome  varchar (60) not null,
  id_pais3 char(03) not null,
  paisnet char(03) not null,
  onuiso char(03) not null,
  ddi smallint,
  Constraint PK_Pais PRIMARY KEY (id_pais2));
commit;
