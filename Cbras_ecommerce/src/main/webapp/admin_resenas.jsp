<%-- 
    Document   : admin_resenas
    Created on : 29 mar 2026, 12:28:45 a.m.
    Author     : Alberto Jimenez
--%>
<%@page import="java.util.List"%>
<%@page import="com.mycompany.cbras_ecommerce.modelo.Resena"%>
<%@page import="com.mycompany.cbras_ecommerce.persistencia.ResenaDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Cbras+ | Administrar Reseñas</title>
        <link rel="stylesheet" href="styles/admin_resenas.css?v=2">
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
                <h1>Administrar Reseñas</h1>

                <% if ("eliminado".equals(request.getParameter("mensaje"))) { %>
                <p style="color: #f44336; font-weight: bold; text-align: center; margin-bottom: 10px;">Reseña eliminada.</p>
                <% } %>

                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Producto reseñado</th>
                            <th>Usuario reseñador</th>
                            <th>Puntuación</th>
                            <th>Opinión</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            ResenaDAO dao = new ResenaDAO();
                            List<Resena> listaResenas = dao.listarTodas();

                            if (listaResenas != null && !listaResenas.isEmpty()) {
                                for (Resena r : listaResenas) {
                        %>
                        <tr>
                            <td><%= r.getNombreProducto()%></td>
                            <td><%= r.getNombreUsuario()%></td>
                            <td><%= r.getCalificacion()%> / 5</td>
                            <td><%= r.getComentario()%></td>
                            <td>
                                <form action="Resena" method="POST" style="display:inline;">
                                    <input type="hidden" name="accion" value="eliminar">
                                    <input type="hidden" name="idResena" value="<%= r.getIdResena()%>">
                                    <button type="submit" class="btn-delete" 
                                            style="border: none; cursor: pointer;"
                                            onclick="return confirm('¿Seguro que deseas eliminar esta reseña?');">
                                        Eliminar
                                    </button>
                                </form>
                            </td>
                        </tr>
                        <%
                            }
                        } else {
                        %>
                        <tr>
                            <td colspan="5" style="text-align: center;">No hay reseñas registradas aún.</td>
                        </tr>
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
