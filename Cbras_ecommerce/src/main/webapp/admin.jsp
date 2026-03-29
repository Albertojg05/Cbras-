<%-- 
    Document   : admin
    Created on : 28 mar 2026, 10:01:24 p.m.
    Author     : Alberto Jimenez
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Cbras+ | Administración</title>
        <link rel="stylesheet" href="styles/admin.css">
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
                <h1>Administración</h1>

                <div class="admin-actions">
                    <a class="admin-btn" href="admin_usuarios.jsp">Usuarios</a>
                    <a class="admin-btn" href="admin_catalogo.jsp">Catálogo</a>
                    <a class="admin-btn" href="admin_resenas.jsp">Reseñas</a>
                    <a class="admin-btn" href="pedidos.jsp">Pedidos</a>
                </div>
            </main>

            <footer class="footer">
                <%@include file="./jspf/footer.jspf"%>
            </footer>
        </div>
    </body>
</html>
