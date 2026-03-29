<%-- 
    Document   : index
    Created on : 28 mar 2026, 9:44:08 p.m.
    Author     : Alberto Jimenez
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Cbras+ | Página Principal</title>
        <link rel="stylesheet" href="styles/index.css">
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
                <section class="hero">
                    <h1>Hora de descuento</h1>
                    <p>Hasta 40% de descuento en nueva temporada</p>
                    <a href="#" class="btn-oferta">Ver Ofertas</a>
                </section>

                <div class="dev-info">
                    Alberto Jiménez García - 252595
                    <br>Joel Rubén Borbón Reyes - 203829
                    <br>David Duarte Esquer - 228615
                </div>

                <section class="categories-section">
                    <h2>Explora nuestras categorías</h2>
                    <div class="categories-grid">
                        <div class="category-item">
                            <div class="circle"><img
                                    src="https://www.svgrepo.com/show/482611/t-shirt-7.svg">
                            </div>
                            <span>Camisetas</span>
                        </div>
                        <div class="category-item">
                            <div class="circle"><img
                                    src="https://th.bing.com/th/id/R.c8d204f6cd4346d9b17d03c0630aa154?rik=OIfALCOd1IniWg&pid=ImgRaw&r=0">
                            </div>
                            <span>Camisas</span>
                        </div>
                        <div class="category-item">
                            <div class="circle"><img
                                    src="https://cdn-icons-png.flaticon.com/512/2161/2161173.png">
                            </div>
                            <span>Calcetines</span>
                        </div>
                        <div class="category-item">
                            <div class="circle"><img
                                    src="https://cdn-icons-png.flaticon.com/512/81/81593.png">
                            </div>
                            <span>Calzado</span>
                        </div>
                    </div>
                </section>
            </main>

            <footer class="footer">
                <%@include file="./jspf/footer.jspf"%>
            </footer>
        </div>
    </body>
</html>
