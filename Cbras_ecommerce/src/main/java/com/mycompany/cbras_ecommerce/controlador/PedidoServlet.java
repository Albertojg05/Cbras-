/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.cbras_ecommerce.controlador;

import com.mycompany.cbras_ecommerce.persistencia.PedidoDAO;
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
@WebServlet(name = "PedidoServlet", urlPatterns = {"/Pedido"})
public class PedidoServlet extends HttpServlet {

    private PedidoDAO pedidoDAO = new PedidoDAO();

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
            out.println("<title>Servlet PedidoServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PedidoServlet at " + request.getContextPath() + "</h1>");
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
        String origen = request.getParameter("origen");

        if ("cambiar_estado".equals(accion)) {
            int id = Integer.parseInt(request.getParameter("idPedido"));
            String actual = request.getParameter("estadoActual");
            String nuevo = "Pendiente";

            if ("Pendiente".equals(actual)) {
                nuevo = "Enviado";
            } else if ("Enviado".equals(actual)) {
                nuevo = "Entregado";
            } else if ("Entregado".equals(actual)) {
                nuevo = "Pendiente";
            }

            pedidoDAO.actualizarEstado(id, nuevo);

            if ("detalles".equals(origen)) {
                response.sendRedirect("detalles_pedido.jsp?id=" + id);
            } else {
                response.sendRedirect("pedidos.jsp");
            }
        } else if ("finalizar_compra".equals(accion)) {
            int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
            int idDireccion = Integer.parseInt(request.getParameter("idDireccion"));

            boolean exito = pedidoDAO.insertarPedidoDesdeCarrito(idUsuario, idDireccion);

            if (exito) {
                response.sendRedirect("confirmacion.jsp?mensaje=exito");
            } else {
                response.sendRedirect("carrito.jsp?error=compra");
            }
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
