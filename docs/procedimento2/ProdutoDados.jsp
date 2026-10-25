<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="cadastroee.model.Produto"%>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Dados do Produto</title>
    </head>
    <body>
        <%
            Produto produto = (Produto) request.getAttribute("produto");
            String acao = (produto == null) ? "incluir" : "alterar";
        %>
        <h1>Dados do Produto</h1>

        <form action="ServletProdutoFC" method="post">
            <input type="hidden" name="acao" value="<%= acao %>">
            <% if ("alterar".equals(acao)) { %>
            <input type="hidden" name="id" value="<%= produto.getIdProduto() %>">
            <% } %>

            <div>
                <label for="nome">Nome</label>
                <input type="text" id="nome" name="nome" required maxlength="255"
                       value="<%= (produto != null) ? produto.getNome().replace("\"", "&quot;") : "" %>">
            </div>

            <div>
                <label for="quantidade">Quantidade</label>
                <input type="number" id="quantidade" name="quantidade" required min="0" step="1"
                       value="<%= (produto != null) ? produto.getQuantidade() : "" %>">
            </div>

            <div>
                <label for="precoVenda">Preço de Venda</label>
                <input type="number" id="precoVenda" name="precoVenda" required min="0" step="0.01"
                       value="<%= (produto != null) ? produto.getPrecoVenda() : "" %>">
            </div>

            <button type="submit"><%= "incluir".equals(acao) ? "Incluir" : "Alterar" %></button>
            <a href="ServletProdutoFC?acao=listar">Voltar</a>
        </form>
    </body>
</html>
