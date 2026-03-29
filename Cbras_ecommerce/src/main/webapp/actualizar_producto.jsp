<%-- 
    Document   : actualizar_producto
    Created on : 28 mar 2026, 11:02:13 p.m.
    Author     : Alberto Jimenez
--%>
<%@page import="com.mycompany.cbras_ecommerce.modelo.Producto"%>
<%@page import="com.mycompany.cbras_ecommerce.persistencia.ProductoDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String idParam = request.getParameter("id");
    Producto p = null;

    if (idParam != null && !idParam.isEmpty()) {
        int id = Integer.parseInt(idParam);
        ProductoDAO dao = new ProductoDAO();
        p = dao.obtenerPorId(id);
    }

    if (p == null) {
        response.sendRedirect("admin_catalogo.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Cbras+ | Actualizar Producto</title>
        <link rel="stylesheet" href="styles/actualizar_producto.css">
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
                <h1>Actualizar Producto</h1>

                <div class="form-card">
                    <form action="Producto" method="POST">
                        
                        <input type="hidden" name="accion" value="actualizar">
                        <input type="hidden" name="idProducto" value="<%= p.getIdProducto() %>">
                        
                        <div class="form-group">
                            <label for="nombre">Nombre del producto</label>
                            <input type="text" id="nombre" name="nombre" class="form-input" value="<%= p.getNombre() %>" required>
                        </div>

                        <div class="form-group-row">
                            <div class="form-group">
                                <label for="precio">Precio</label>
                                <input type="number" step="0.01" id="precio" name="precio" class="form-input" value="<%= p.getPrecio() %>" required>
                            </div>

                            <div class="form-group">
                                <label for="stock">Stock disponible</label>
                                <input type="number" id="stock" name="stock" class="form-input" value="<%= p.getStock() %>" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="descripcion">Descripción</label>
                            <textarea id="descripcion" name="descripcion" class="form-textarea" required><%= p.getDescripcion() %></textarea>
                        </div>

                        <div class="form-group">
                            <label for="imagen">Imagen del producto</label>
                            <input type="text" id="imagen" name="urlImagen" class="form-input" value="<%= p.getUrlImagen() != null ? p.getUrlImagen() : "" %>">
                        </div>

                        <div class="action-buttons">
                            <button type="submit" class="btn-save">Guardar cambios</button>
                            <a href="admin_catalogo.jsp" class="btn-back">Cancelar</a>
                        </div>
                    </form>
                </div>
            </main>

            <footer class="footer">
                <%@include file="./jspf/footer.jspf"%>
            </footer>
        </div>
    </body>
</html>
