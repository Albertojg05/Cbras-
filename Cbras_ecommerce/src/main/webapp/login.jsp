<%-- 
    Document   : login
    Created on : 28 mar 2026, 8:56:26 p.m.
    Author     : Alberto Jimenez
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Cbras+ | Iniciar Sesión</title>
        <link rel="stylesheet" href="./styles/login.css">
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
                <h1>Iniciar Sesión</h1>

                <div class="login-form-container">
                    <% if (request.getAttribute("error") != null) {%>
                    <p style="color: red; text-align: center;"><%= request.getAttribute("error")%></p>
                    <% }%>

                    <form action="Login" method="POST">
                        <div class="form-group">
                            <label for="email">Correo Electrónico</label>
                            <input type="email" id="email" name="correo" class="form-input" placeholder="example@gmail.com" required>
                        </div>

                        <div class="form-group">
                            <label for="password">Contraseña</label>
                            <input type="password" id="password" name="password" class="form-input" placeholder="password" required>
                        </div>

                        <button type="submit" class="btn-login">Iniciar Sesión</button>

                        <div class="login-links">
                            <a href="registro.html">Registrarse</a>
                            <a href="index.html" style="margin-top: 10px; color: var(--gray-text);">Regresar al inicio</a>
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
