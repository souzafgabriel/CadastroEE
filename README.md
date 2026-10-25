# CadastroEE

Trabalho prático da disciplina DGT2811 - Desenvolvimento Back-End Corporativo com Java e Cloud (Estácio, 2026.2).

Cadastro de produtos com JPA, EJB, Servlets, JSP e Bootstrap, rodando no GlassFish 6.2.5 com banco SQL Server.

Aluno: Gabriel de Souza Ferreira

## Tecnologias

- NetBeans 25 (projeto Ant - Enterprise Application)
- Jakarta EE 9.1
- GlassFish 6.2.5 com JDK 17
- SQL Server 2022 Express + driver mssql-jdbc 12.2.0
- Bootstrap 5.3

## Estrutura

- `CadastroEE` - projeto principal (EAR)
- `CadastroEE-ejb` - entidades (`cadastroee.model`) e session beans (`cadastroee.controller`)
- `CadastroEE-war` - servlets (`cadastroee.servlets`) e páginas JSP
- `sql/loja.sql` - script do banco
- `docs` - relatório e prints

## Configuração

1. Executar `sql/loja.sql` no SQL Server Management Studio.
2. Copiar `mssql-jdbc-12.2.0.jre8.jar` para `glassfish/lib`.
3. Criar o pool e o recurso JNDI pelo asadmin:

```
create-jdbc-connection-pool --datasourceclassname com.microsoft.sqlserver.jdbc.SQLServerDataSource --restype javax.sql.DataSource --property serverName=localhost:portNumber=1433:databaseName=loja:user=loja:password=loja:trustServerCertificate=true SQLServerPool
set resources.jdbc-connection-pool.SQLServerPool.property.driverClass=com.microsoft.sqlserver.jdbc.SQLServerDriver
set "resources.jdbc-connection-pool.SQLServerPool.property.URL=jdbc:sqlserver://localhost:1433;databaseName=loja;encrypt=true;trustServerCertificate=true;"
ping-connection-pool SQLServerPool
create-jdbc-resource --connectionpoolid SQLServerPool jdbc/loja
```

4. Abrir o projeto no NetBeans e executar o CadastroEE (Run).

## Acesso

No meu ambiente o GlassFish está na porta 8081 (a 8080 já estava em uso).

- http://localhost:8081/CadastroEE-war/ServletProduto
- http://localhost:8081/CadastroEE-war/ServletProdutoFC?acao=listar
