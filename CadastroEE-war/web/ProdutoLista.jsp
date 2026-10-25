<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Locale"%>
<%@page import="cadastroee.model.Produto"%>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Lista de Produtos</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    </head>
    <body class="container">
        <h1 class="mt-3">Listagem de Produtos</h1>

        <%
            String mensagem = (String) request.getAttribute("mensagem");
            String erro = (String) request.getAttribute("erro");
            if (mensagem != null) {
        %>
        <div class="alert alert-success" role="alert"><%= mensagem %></div>
        <%  }
            if (erro != null) { %>
        <div class="alert alert-danger" role="alert"><%= erro %></div>
        <%  } %>

        <a class="btn btn-primary m-2" href="ServletProdutoFC?acao=formIncluir">Novo Produto</a>

        <table class="table table-striped">
            <thead class="table-dark">
                <tr>
                    <th>#</th>
                    <th>Nome</th>
                    <th>Quantidade</th>
                    <th>Preço de Venda</th>
                    <th>Opções</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Produto> produtos = (List<Produto>) request.getAttribute("produtos");
                    if (produtos != null) {
                        for (Produto p : produtos) {
                %>
                <tr>
                    <td><%= p.getIdProduto() %></td>
                    <td><%= p.getNome() %></td>
                    <td><%= p.getQuantidade() %></td>
                    <td><%= String.format(new Locale("pt", "BR"), "R$ %.2f", p.getPrecoVenda()) %></td>
                    <td>
                        <a class="btn btn-primary btn-sm"
                           href="ServletProdutoFC?acao=formAlterar&id=<%= p.getIdProduto() %>">Alterar</a>
                        <a class="btn btn-danger btn-sm"
                           href="ServletProdutoFC?acao=excluir&id=<%= p.getIdProduto() %>"
                           onclick="return confirm('Excluir o produto <%= p.getNome().replace("'", "\\'") %>?');">Excluir</a>
                    </td>
                </tr>
                <%
                        }
                    }
                %>
            </tbody>
        </table>
    </body>
</html>
