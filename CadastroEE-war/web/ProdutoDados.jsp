<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="cadastroee.model.Produto"%>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Dados do Produto</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    </head>
    <body class="container">
        <%
            Produto produto = (Produto) request.getAttribute("produto");
            String acao = (produto == null) ? "incluir" : "alterar";
        %>
        <h1 class="mt-3">Dados do Produto</h1>

        <form class="form" action="ServletProdutoFC" method="post">
            <input type="hidden" name="acao" value="<%= acao %>">
            <% if ("alterar".equals(acao)) { %>
            <input type="hidden" name="id" value="<%= produto.getIdProduto() %>">
            <% } %>

            <div class="mb-3">
                <label for="nome" class="form-label">Nome</label>
                <input type="text" class="form-control" id="nome" name="nome" required maxlength="255"
                       value="<%= (produto != null) ? produto.getNome().replace("\"", "&quot;") : "" %>">
            </div>

            <div class="mb-3">
                <label for="quantidade" class="form-label">Quantidade</label>
                <input type="number" class="form-control" id="quantidade" name="quantidade" required min="0" step="1"
                       value="<%= (produto != null) ? produto.getQuantidade() : "" %>">
            </div>

            <div class="mb-3">
                <label for="precoVenda" class="form-label">Preço de Venda</label>
                <input type="number" class="form-control" id="precoVenda" name="precoVenda" required min="0" step="0.01"
                       value="<%= (produto != null) ? produto.getPrecoVenda() : "" %>">
            </div>

            <button type="submit" class="btn btn-primary"><%= "incluir".equals(acao) ? "Incluir" : "Alterar" %></button>
            <a class="btn btn-secondary" href="ServletProdutoFC?acao=listar">Voltar</a>
        </form>
    </body>
</html>
