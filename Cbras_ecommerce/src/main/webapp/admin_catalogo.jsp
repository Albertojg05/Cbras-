<%-- 
    Document   : admin_catalogo
    Created on : 28 mar 2026, 10:41:09 p.m.
    Author     : Alberto Jimenez
--%>
<%@page import="java.util.List"%>
<%@page import="com.mycompany.cbras_ecommerce.modelo.Producto"%>
<%@page import="com.mycompany.cbras_ecommerce.persistencia.ProductoDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Cbras+ | Administrar Catálogo</title>
        <link rel="stylesheet" href="styles/admin_catalogo.css?v=2">
    </head>

    <body>
        <div class="container">
            <header class="top-header">
                <%@include file="./jspf/header.jspf"%>
            </header>

            <aside class="sidebar">
                <%@include file="./jspf/sidebar.jspf" %>
            </aside>

            <main class="main-content">
                <div class="title-row">
                    <h1>Administrar Catálogo</h1>
                    <a href="registrar_producto.jsp" class="btn-primary">Registrar producto</a>
                </div>

                <div class="search-container">
                    <form action="admin_catalogo.jsp" method="GET" class="search-form">

                        <div class="search-group">
                            <label for="nombre" class="search-label">Nombre del producto:</label>
                            <input type="text" id="nombre" name="nombre" class="search-input" 
                                   value="<%= request.getParameter("nombre") != null ? request.getParameter("nombre") : ""%>">
                        </div>

                        <div class="search-group small">
                            <label for="precio" class="search-label">Precio máximo:</label>
                            <input type="number" step="0.01" min="0" id="precio" name="precio" class="search-input" 
                                   placeholder="Ej. 500" style="width: 120px;"
                                   value="<%= request.getParameter("precio") != null ? request.getParameter("precio") : ""%>">
                        </div>

                        <button type="submit" class="search-btn">Buscar</button>

                        <% if ((request.getParameter("nombre") != null && !request.getParameter("nombre").isEmpty())
                                    || (request.getParameter("precio") != null && !request.getParameter("precio").isEmpty())) { %>
                        <a href="admin_catalogo.jsp" class="clear-btn">Limpiar</a>
                        <% } %>
                    </form>
                </div>

                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Nombre</th>
                            <th>Precio</th>
                            <th>Stock disponible</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            ProductoDAO dao = new ProductoDAO();
                            List<Producto> listaProductos;

                            String paramNombre = request.getParameter("nombre");
                            String paramPrecio = request.getParameter("precio");

                            if ((paramNombre != null && !paramNombre.trim().isEmpty())
                                    || (paramPrecio != null && !paramPrecio.trim().isEmpty())) {

                                listaProductos = dao.buscarPorFiltros(paramNombre, paramPrecio);
                            } else {
                                listaProductos = dao.listarTodos();
                            }

                            if (listaProductos != null && !listaProductos.isEmpty()) {
                                for (Producto p : listaProductos) {
                        %>
                        <tr>
                            <td><%= p.getNombre()%></td>
                            <td>$ <%= p.getPrecio()%></td>
                            <td><%= p.getStock()%> piezas</td>
                            <td>
                                <div class="action-buttons">
                                    <a href="actualizar_producto.jsp?id=<%= p.getIdProducto()%>" class="btn-green">Editar</a>

                                    <form action="Producto" method="POST" style="display:inline;">
                                        <input type="hidden" name="accion" value="eliminar">
                                        <input type="hidden" name="idProducto" value="<%= p.getIdProducto()%>">
                                        <button type="submit" class="btn-delete" style="border: none; cursor: pointer;" onclick="return confirm('¿Seguro que deseas eliminar <%= p.getNombre()%>?');">Eliminar</button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                        <%
                            }
                        } else {
                        %>
                        <tr>
                            <td colspan="4" style="text-align: center;">No se encontraron productos con esos filtros.</td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </main>

            <footer class="footer">
                <%@include file="./jspf/footer.jspf"%>
            </footer>
        </div>
    </body>
</html>