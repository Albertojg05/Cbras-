/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.cbras_ecommerce.controlador;

import com.mycompany.cbras_ecommerce.modelo.Producto;
import com.mycompany.cbras_ecommerce.persistencia.ProductoDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Alberto Jimenez
 */
@WebServlet(name = "ProductoServlet", urlPatterns = {"/Producto"})
public class ProductoServlet extends HttpServlet {

    private ProductoDAO productoDAO = new ProductoDAO();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ProductoServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductoServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");

        if ("agregar".equals(accion)) {
            try {
                String nombre = request.getParameter("nombre");
                String descripcion = request.getParameter("descripcion");
                double precio = Double.parseDouble(request.getParameter("precio"));
                int stock = Integer.parseInt(request.getParameter("stock"));
                String urlImagen = request.getParameter("urlImagen");

                Producto p = new Producto();
                p.setNombre(nombre);
                p.setDescripcion(descripcion);
                p.setPrecio(precio);
                p.setStock(stock);
                p.setUrlImagen(urlImagen);

                boolean exito = productoDAO.agregar(p);

                if (exito) {
                    response.sendRedirect("admin_catalogo.jsp?mensaje=exito");
                } else {
                    response.sendRedirect("registrar_producto.jsp?error=bd");
                }

            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("registrar_producto.jsp?error=formato");
            }

        } else if ("eliminar".equals(accion)) {
            int idProducto = Integer.parseInt(request.getParameter("idProducto"));
            boolean exito = productoDAO.eliminar(idProducto);

            if (exito) {
                response.sendRedirect("admin_catalogo.jsp?mensaje=eliminado");
            } else {
                response.sendRedirect("admin_catalogo.jsp?error=bd");
            }

        } else if ("actualizar".equals(accion)) {
            try {
                int idProducto = Integer.parseInt(request.getParameter("idProducto"));
                String nombre = request.getParameter("nombre");
                String descripcion = request.getParameter("descripcion");
                double precio = Double.parseDouble(request.getParameter("precio"));
                int stock = Integer.parseInt(request.getParameter("stock"));
                String urlImagen = request.getParameter("urlImagen");

                Producto p = new Producto();
                p.setIdProducto(idProducto);
                p.setNombre(nombre);
                p.setDescripcion(descripcion);
                p.setPrecio(precio);
                p.setStock(stock);
                p.setUrlImagen(urlImagen);

                boolean exito = productoDAO.actualizar(p);

                if (exito) {
                    response.sendRedirect("admin_catalogo.jsp?mensaje=actualizado");
                } else {
                    response.sendRedirect("admin_catalogo.jsp?error=bd");
                }

            } catch (Exception e) {
                System.out.println("----- ERROR AL ACTUALIZAR -----");
                e.printStackTrace();
                response.sendRedirect("admin_catalogo.jsp?error=formato");
            }
        } else {
            System.out.println("----- ACCIÓN DESCONOCIDA O NULA -----");
            response.sendRedirect("admin_catalogo.jsp");
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
