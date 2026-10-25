package cadastroee.servlets;

import cadastroee.controller.ProdutoFacadeLocal;
import cadastroee.model.Produto;
import java.io.IOException;
import jakarta.ejb.EJB;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ServletProdutoFC extends HttpServlet {

    @EJB
    ProdutoFacadeLocal facade;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String acao = request.getParameter("acao");
        if (acao == null || acao.isBlank()) {
            acao = "listar";
        }

        String destino = ("formAlterar".equals(acao) || "formIncluir".equals(acao))
                ? "ProdutoDados.jsp"
                : "ProdutoLista.jsp";

        try {
            switch (acao) {
                case "listar":
                    break;

                case "formIncluir":
                    break;

                case "formAlterar": {
                    Integer id = Integer.valueOf(request.getParameter("id"));
                    request.setAttribute("produto", facade.find(id));
                    break;
                }

                case "excluir": {
                    Integer id = Integer.valueOf(request.getParameter("id"));
                    Produto produto = facade.find(id);
                    if (produto != null) {
                        facade.remove(produto);
                        request.setAttribute("mensagem", "Produto excluído com sucesso.");
                    }
                    break;
                }

                case "alterar": {
                    Integer id = Integer.valueOf(request.getParameter("id"));
                    Produto produto = facade.find(id);
                    if (produto != null) {
                        preencher(produto, request);
                        facade.edit(produto);
                        request.setAttribute("mensagem", "Produto alterado com sucesso.");
                    }
                    break;
                }

                case "incluir": {
                    Produto produto = new Produto();
                    preencher(produto, request);
                    facade.create(produto);
                    request.setAttribute("mensagem", "Produto incluído com sucesso.");
                    break;
                }

                default:
                    request.setAttribute("erro", "Ação inválida: " + acao);
                    destino = "ProdutoLista.jsp";
            }
        } catch (NumberFormatException e) {
            request.setAttribute("erro", "Dados inválidos: verifique quantidade, preço e id.");
            destino = "ProdutoLista.jsp";
        } catch (Exception e) {
            request.setAttribute("erro", "Não foi possível concluir a operação \"" + acao
                    + "\". O produto pode estar vinculado a movimentações.");
            destino = "ProdutoLista.jsp";
            log("Erro em ServletProdutoFC, acao=" + acao, e);
        }

        if ("ProdutoLista.jsp".equals(destino)) {
            request.setAttribute("produtos", facade.findAll());
        }

        RequestDispatcher rd = request.getRequestDispatcher(destino);
        rd.forward(request, response);
    }

    private void preencher(Produto produto, HttpServletRequest request) {
        produto.setNome(request.getParameter("nome").trim());
        produto.setQuantidade(Integer.parseInt(request.getParameter("quantidade").trim()));
        produto.setPrecoVenda(Float.valueOf(request.getParameter("precoVenda").trim().replace(",", ".")));
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
