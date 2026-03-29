<%-- 
    Document   : pedidos
    Created on : 29 mar 2026, 12:58:34 a.m.
    Author     : Alberto Jimenez
--%>
<%@page import="java.util.List"%>
<%@page import="com.mycompany.cbras_ecommerce.modelo.Pedido"%>
<%@page import="com.mycompany.cbras_ecommerce.persistencia.PedidoDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Cbras+ | Gestión de Pedidos</title>
        <link rel="stylesheet" href="styles/pedidos.css">
    </head>

    <body>

        <div class="container">
            <header class="top-header">
                <%@include  file="./jspf/header.jspf"%>
            </header>

            <aside class="sidebar">
                <%@include file="./jspf/sidebar.jspf" %>
            </aside>

            <main class="main-content">
                <h1>Gestión pedidos</h1>

                <table class="orders-table">
                    <thead>
                        <tr>
                            <th>N. Pedido</th>
                            <th>Fecha compra</th>
                            <th>Total</th>
                            <th>Estado</th>
                            <th></th> </tr>
                    </thead>
                    <tbody>
                        <%
                            PedidoDAO dao = new PedidoDAO();
                            List<Pedido> lista = dao.listarTodos();

                            if (lista != null && !lista.isEmpty()) {
                                for (Pedido p : lista) {
                                    String fechaFormateada = new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm").format(p.getFechaPedido());
                                    String totalFormateado = String.format("%.2f", p.getTotal());
                        %>
                        <tr>
                            <td class="order-number">#ORD-<%= p.getIdPedido()%></td>
                            <td><%= p.getNombreUsuario()%></td>
                            <td><%= fechaFormateada%></td>
                            <td style="font-weight: bold;">$ <%= totalFormateado%></td>
                            <td>
                                <div class="status-wrapper">
                                    <span class="order-status-text status-<%= p.getEstado().toLowerCase()%>">
                                        <%= p.getEstado()%>
                                    </span>

                                    <form action="Pedido" method="POST" style="display:inline;">
                                        <input type="hidden" name="accion" value="cambiar_estado">
                                        <input type="hidden" name="idPedido" value="<%= p.getIdPedido()%>">
                                        <input type="hidden" name="estadoActual" value="<%= p.getEstado()%>">
                                        <button type="submit" class="btn-status-order">Siguiente estado</button>
                                    </form>
                                </div>
                            </td>
                            <td style="text-align: center;">
                                <a href="detalles_pedido.jsp?id=<%= p.getIdPedido()%>" class="btn-details">Ver detalles</a>
                            </td>
                        </tr>
                        <%
                            }
                        } else {
                        %>
                        <tr><td colspan="6" style="text-align:center; padding: 30px;">No hay pedidos en el sistema.</td></tr>
                        <% }%>
                    </tbody>
                </table>
            </main>

            <footer class="footer">
                <%@include file="./jspf/footer.jspf"%>
            </footer>
        </div>
    </body>
</html>
