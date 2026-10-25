-- Banco loja (SQL Server)

-- 1. Banco, login e usuário
IF DB_ID('loja') IS NULL
    CREATE DATABASE loja;
GO

IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'loja')
    CREATE LOGIN loja WITH PASSWORD = 'loja', CHECK_POLICY = OFF, DEFAULT_DATABASE = loja;
GO

USE loja;
GO

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'loja')
BEGIN
    CREATE USER loja FOR LOGIN loja;
    ALTER ROLE db_owner ADD MEMBER loja;
END
GO

-- 2. Sequence para Pessoa
IF OBJECT_ID('dbo.orderPessoa', 'SO') IS NULL
    CREATE SEQUENCE dbo.orderPessoa AS INT START WITH 1 INCREMENT BY 1;
GO

-- 3. Tabelas
IF OBJECT_ID('dbo.Usuario', 'U') IS NULL
CREATE TABLE dbo.Usuario (
    idUsuario   INT IDENTITY(1,1) NOT NULL,
    login       VARCHAR(20)  NOT NULL,
    senha       VARCHAR(20)  NOT NULL,
    CONSTRAINT PK_Usuario PRIMARY KEY (idUsuario)
);
GO

IF OBJECT_ID('dbo.Pessoa', 'U') IS NULL
CREATE TABLE dbo.Pessoa (
    idPessoa    INT          NOT NULL,
    nome        VARCHAR(255) NOT NULL,
    logradouro  VARCHAR(255),
    cidade      VARCHAR(255),
    estado      CHAR(2),
    telefone    VARCHAR(11),
    email       VARCHAR(255),
    CONSTRAINT PK_Pessoa PRIMARY KEY (idPessoa)
);
GO

IF OBJECT_ID('dbo.PessoaFisica', 'U') IS NULL
CREATE TABLE dbo.PessoaFisica (
    idPessoa    INT      NOT NULL,
    cpf         CHAR(11) NOT NULL,
    CONSTRAINT PK_PessoaFisica PRIMARY KEY (idPessoa),
    CONSTRAINT FK_PessoaFisica_Pessoa FOREIGN KEY (idPessoa) REFERENCES dbo.Pessoa (idPessoa)
);
GO

IF OBJECT_ID('dbo.PessoaJuridica', 'U') IS NULL
CREATE TABLE dbo.PessoaJuridica (
    idPessoa    INT      NOT NULL,
    cnpj        CHAR(14) NOT NULL,
    CONSTRAINT PK_PessoaJuridica PRIMARY KEY (idPessoa),
    CONSTRAINT FK_PessoaJuridica_Pessoa FOREIGN KEY (idPessoa) REFERENCES dbo.Pessoa (idPessoa)
);
GO

IF OBJECT_ID('dbo.Produto', 'U') IS NULL
CREATE TABLE dbo.Produto (
    idProduto   INT IDENTITY(1,1) NOT NULL,
    nome        VARCHAR(255)  NOT NULL,
    quantidade  INT           NOT NULL,
    precoVenda  NUMERIC(10,2) NOT NULL,
    CONSTRAINT PK_Produto PRIMARY KEY (idProduto)
);
GO

IF OBJECT_ID('dbo.Movimento', 'U') IS NULL
CREATE TABLE dbo.Movimento (
    idMovimento   INT IDENTITY(1,1) NOT NULL,
    idUsuario     INT           NOT NULL,
    idPessoa      INT           NOT NULL,
    idProduto     INT           NOT NULL,
    quantidade    INT           NOT NULL,
    tipo          CHAR(1)       NOT NULL,
    valorUnitario NUMERIC(10,2) NOT NULL,
    CONSTRAINT PK_Movimento PRIMARY KEY (idMovimento),
    CONSTRAINT FK_Movimento_Usuario FOREIGN KEY (idUsuario) REFERENCES dbo.Usuario (idUsuario),
    CONSTRAINT FK_Movimento_Pessoa  FOREIGN KEY (idPessoa)  REFERENCES dbo.Pessoa (idPessoa),
    CONSTRAINT FK_Movimento_Produto FOREIGN KEY (idProduto) REFERENCES dbo.Produto (idProduto),
    CONSTRAINT CK_Movimento_Tipo CHECK (tipo IN ('E', 'S'))
);
GO

-- 4. Produtos iniciais
IF NOT EXISTS (SELECT 1 FROM dbo.Produto)
BEGIN
    INSERT INTO dbo.Produto (nome, quantidade, precoVenda) VALUES
        ('Banana', 100, 5.00),
        ('Laranja', 500, 2.00),
        ('Manga',   800, 4.00);
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.Usuario)
    INSERT INTO dbo.Usuario (login, senha) VALUES ('op1', 'op1'), ('op2', 'op2');
GO

SELECT * FROM dbo.Produto;
GO
