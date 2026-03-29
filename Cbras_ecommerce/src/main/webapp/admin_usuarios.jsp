<%-- 
    Document   : admin_usuarios
    Created on : 28 mar 2026, 11:27:57 p.m.
    Author     : Alberto Jimenez
--%>
<%@page import="java.util.List"%>
<%@page import="com.mycompany.cbras_ecommerce.modelo.Usuario"%>
<%@page import="com.mycompany.cbras_ecommerce.persistencia.UsuarioDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Cbras+ | Administrar Usuarios</title>
        <link rel="stylesheet" href="styles/admin_usuarios.css">
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
                <div class="title-row">
                    <h1>Administrar Usuarios</h1>
                </div>

                <div class="search-container">
                    <form action="admin_usuarios.jsp" method="GET" class="search-form">
                        <input type="text" name="q" placeholder="Buscar usuario por nombre..." 
                               class="search-input"
                               value="<%= request.getParameter("q") != null ? request.getParameter("q") : ""%>">

                        <button type="submit" class="search-btn">Buscar</button>

                        <% if (request.getParameter("q") != null && !request.getParameter("q").isEmpty()) { %>
                        <a href="admin_usuarios.jsp" class="clear-btn">Limpiar</a>
                        <% } %>
                    </form>
                </div>

                <% if ("estado_actualizado".equals(request.getParameter("mensaje"))) { %>
                <p style="color: #4CAF50; font-weight: bold; text-align: center;">El estado del usuario se actualizó correctamente.</p>
                <% } else if ("eliminado".equals(request.getParameter("mensaje"))) { %>
                <p style="color: #f44336; font-weight: bold; text-align: center;">Usuario eliminado correctamente.</p>
                <% } %>

                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Nombre</th>
                            <th>Rol</th>
                            <th>Correo electrónico</th>
                            <th>Estado</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            UsuarioDAO dao = new UsuarioDAO();
                            List<Usuario> listaUsuarios;

                            String busqueda = request.getParameter("q");

                            if (busqueda != null && !busqueda.trim().isEmpty()) {
                                listaUsuarios = dao.buscarPorNombre(busqueda.trim());
                            } else {
                                listaUsuarios = dao.listarTodos();
                            }

                            if (listaUsuarios != null && !listaUsuarios.isEmpty()) {
                                for (Usuario u : listaUsuarios) {
                                    String claseBadge = "Activo".equalsIgnoreCase(u.getEstado()) ? "active" : "inactive";
                        %>
                        <tr>
                            <td><%= u.getNombre()%></td>
                            <td><%= u.getRol()%></td>
                            <td><%= u.getCorreo()%></td>
                            <td>
                                <div class="status-cell">
                                    <span class="badge <%= claseBadge%>"><%= u.getEstado()%></span>

                                    <form action="Usuario" method="POST" style="display:inline;">
                                        <input type="hidden" name="accion" value="cambiar_estado">
                                        <input type="hidden" name="idUsuario" value="<%= u.getId()%>">
                                        <input type="hidden" name="estadoActual" value="<%= u.getEstado()%>">
                                        <button type="submit" class="btn-status">Cambiar estado</button>
                                    </form>
                                </div>
                            </td>
                            <td>
                                <%
                                    Usuario adminActual = (Usuario) session.getAttribute("adminLogueado");
                                    if (adminActual != null && adminActual.getId() != u.getId()) {
                                %>
                                <form action="Usuario" method="POST" style="display:inline;">
                                    <input type="hidden" name="accion" value="eliminar">
                                    <input type="hidden" name="idUsuario" value="<%= u.getId()%>">
                                    <button type="submit" class="btn-delete" style="border: none; cursor: pointer;" onclick="return confirm('¿Seguro que deseas eliminar a <%= u.getNombre()%>?');">Eliminar</button>
                                </form>
                                <% } else { %>
                                <span style="color: gray; font-size: 0.9em;">(Tú)</span>
                                <% } %>
                            </td>
                        </tr>
                        <%
                            }
                        } else {
                        %>
                        <tr>
                            <td colspan="5" style="text-align:center;">No hay usuarios registrados.</td>
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
