<%-- 
    Document   : detalles_pedidos
    Created on : 29 mar 2026, 1:09:40 a.m.
    Author     : Alberto Jimenez
--%>
<%@page import="java.util.List"%>
<%@page import="com.mycompany.cbras_ecommerce.modelo.*"%>
<%@page import="com.mycompany.cbras_ecommerce.persistencia.PedidoDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String idParam = request.getParameter("id");
    Pedido ped = null;
    List<DetallePedido> detalles = null;

    if (idParam != null) {
        try {
            int id = Integer.parseInt(idParam);
            PedidoDAO dao = new PedidoDAO();
            ped = dao.obtenerPorId(id);
            detalles = dao.listarDetalles(id);
        } catch (NumberFormatException e) {
            response.sendRedirect("pedidos.jsp");
            return;
        }
    }

    if (ped == null) {
        response.sendRedirect("pedidos.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Cbras+ | Detalles del Pedido</title>
        <link rel="stylesheet" href="styles/detalles_pedido.css">
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
                <h1>Detalles del pedido</h1>

                <div class="order-header-info">
                    <span class="order-id">Pedido: #ORD-<%= ped.getIdPedido()%></span>
                    <span class="order-status">Estado: <%= ped.getEstado()%></span>
                </div>

                <section class="order-items-card">
                    <%
                        double granTotal = 0;
                        if (detalles != null && !detalles.isEmpty()) {
                            for (DetallePedido d : detalles) {
                                double subtotalProducto = d.getCantidad() * d.getPrecioUnitario();
                                granTotal += subtotalProducto;
                    %>
                    <div class="item-row" style="border-bottom: 1px solid #eee; padding: 10px 0;">
                        <div class="item-info">
                            <span class="item-name" style="font-weight: bold; display: block;"><%= d.getNombreProducto()%></span>
                            <span class="item-qty" style="color: #666;">Cantidad: <%= d.getCantidad()%></span>
                        </div>
                        <div style="text-align: right;">
                            <span class="item-price" style="display: block;">$ <%= String.format("%.2f", d.getPrecioUnitario())%> c/u</span>
                            <span style="font-weight: bold;">Subtotal: $ <%= String.format("%.2f", subtotalProducto)%></span>
                        </div>
                    </div>
                    <%
                        }
                    } else {
                    %>
                    <p style="text-align:center; padding: 20px;">Este pedido no tiene productos registrados (revisa la tabla detalles_pedidos).</p>
                    <% }%>
                </section>

                <div class="order-summary-grid">
                    <div class="summary-box">
                        <h3>Información de envío</h3>
                        <p class="summary-text">
                            <strong>Fecha:</strong> <%= ped.getFechaPedido()%><br>
                            <strong>Cliente:</strong> <%= ped.getNombreUsuario()%><br>
                            <strong>Dirección:</strong> Calle Ejemplo #123, Sonora.
                        </p>
                    </div>
                            
                    <div class="summary-box">
                        <h3>Resumen de pago</h3>
                        <p class="summary-text">
                            <strong>Subtotal:</strong> $ <%= String.format("%.2f", granTotal)%><br>
                            <strong>Envío:</strong> $ 0.00
                        </p>
                        <div class="total-highlight">
                            Total pagado: $ <%= String.format("%.2f", granTotal)%>
                        </div>
                    </div>
                </div>

                <div class="footer-actions">
                    <a href="pedidos.jsp" class="btn-back">Volver a la lista de pedidos</a>
                </div>
            </main>

            <footer class="footer">
                <%@include file="./jspf/footer.jspf"%>
            </footer>
        </div>

    </body>
</html>
