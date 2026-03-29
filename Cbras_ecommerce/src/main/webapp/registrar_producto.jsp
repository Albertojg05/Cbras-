<%-- 
    Document   : registrar_producto
    Created on : 28 mar 2026, 10:18:24 p.m.
    Author     : Alberto Jimenez
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Cbras+ | Registrar Producto</title>
        <link rel="stylesheet" href="styles/registrar_producto.css">
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
                <h1>Registro de Producto</h1>

                <div class="form-card">
                    <form action="Producto" method="POST">
                        
                        <input type="hidden" name="accion" value="agregar">
                        
                        <div class="form-group">
                            <label for="nombre">Nombre del producto</label>
                            <input type="text" id="nombre" name="nombre" class="form-input" placeholder="Ej. Chaqueta clasic" required>
                        </div>

                        <div class="form-group-row">
                            <div class="form-group">
                                <label for="precio">Precio</label>
                                <input type="number" step="0.01" id="precio" name="precio" class="form-input" placeholder="449.99" required>
                            </div>

                            <div class="form-group">
                                <label for="stock">Stock disponible</label>
                                <input type="number" id="stock" name="stock" class="form-input" placeholder="15" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="descripcion">Descripción</label>
                            <textarea id="descripcion" name="descripcion" class="form-textarea" placeholder="Describe el producto..." required></textarea>
                        </div>

                        <div class="form-group">
                            <label for="imagen">Imagen del producto</label>
                            <input type="text" id="imagen" name="urlImagen" class="form-input" placeholder="URL de la imagen o nombre del archivo">
                        </div>

                        <div class="action-buttons">
                            <button type="submit" class="btn-save">Guardar producto</button>
                            <a href="admin_catalogo.html" class="btn-cancel">Cancelar</a>
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
