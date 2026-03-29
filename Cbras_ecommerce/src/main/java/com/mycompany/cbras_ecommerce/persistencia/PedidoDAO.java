/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.cbras_ecommerce.persistencia;

import com.mycompany.cbras_ecommerce.modelo.DetallePedido;
import com.mycompany.cbras_ecommerce.modelo.Pedido;
import com.mycompany.cbras_ecommerce.util.ConexionBD;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Alberto Jimenez
 */
public class PedidoDAO {

    public List<Pedido> listarTodos() {
        List<Pedido> lista = new ArrayList<>();
        String sql = "SELECT p.id_pedido, p.fecha_pedido, p.estado, u.nombre, "
                + "IFNULL(SUM(d.cantidad * d.precio_unitario), 0) AS total_calculado "
                + "FROM pedidos p "
                + "JOIN usuarios u ON p.id_usuario = u.id_usuario "
                + "LEFT JOIN detalles_pedidos d ON p.id_pedido = d.id_pedido "
                + "GROUP BY p.id_pedido "
                + "ORDER BY p.fecha_pedido DESC";

        try (Connection con = ConexionBD.obtenerConexion(); PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Pedido p = new Pedido();
                p.setIdPedido(rs.getInt("id_pedido"));
                p.setFechaPedido(rs.getTimestamp("fecha_pedido"));
                p.setEstado(rs.getString("estado"));
                p.setNombreUsuario(rs.getString("nombre"));
                p.setTotal(rs.getDouble("total_calculado"));
                lista.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public Pedido obtenerPorId(int id) {
        String sql = "SELECT p.id_pedido, p.fecha_pedido, p.estado, u.nombre, "
                + "IFNULL(SUM(d.cantidad * d.precio_unitario), 0) AS total_calculado "
                + "FROM pedidos p "
                + "JOIN usuarios u ON p.id_usuario = u.id_usuario "
                + "LEFT JOIN detalles_pedidos d ON p.id_pedido = d.id_pedido "
                + "WHERE p.id_pedido = ? "
                + "GROUP BY p.id_pedido";

        try (Connection con = ConexionBD.obtenerConexion(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Pedido p = new Pedido();
                p.setIdPedido(rs.getInt("id_pedido"));
                p.setFechaPedido(rs.getTimestamp("fecha_pedido"));
                p.setEstado(rs.getString("estado"));
                p.setNombreUsuario(rs.getString("nombre"));
                p.setTotal(rs.getDouble("total_calculado"));
                return p;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<DetallePedido> listarDetalles(int idPedido) {
        List<DetallePedido> detalles = new ArrayList<>();
        String sql = "SELECT d.*, p.nombre FROM detalles_pedidos d "
                + "JOIN productos p ON d.id_producto = p.id_producto "
                + "WHERE d.id_pedido = ?";
        try (Connection con = ConexionBD.obtenerConexion(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idPedido);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                DetallePedido d = new DetallePedido();
                d.setNombreProducto(rs.getString("nombre"));
                d.setCantidad(rs.getInt("cantidad"));
                d.setPrecioUnitario(rs.getDouble("precio_unitario"));
                detalles.add(d);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return detalles;
    }

    public boolean actualizarEstado(int id, String nuevoEstado) {
        String sql = "UPDATE pedidos SET estado = ? WHERE id_pedido = ?";
        try (Connection con = ConexionBD.obtenerConexion(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, nuevoEstado);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            return false;
        }
    }

    public boolean insertarPedidoDesdeCarrito(int idUsuario, int idDireccion) {
        String sqlPedido = "INSERT INTO pedidos (id_usuario, direccion_envio_id, total, estado) VALUES (?, ?, 0, 'Pendiente')";

        String sqlDetalles = "INSERT INTO detalles_pedidos (id_pedido, id_producto, cantidad, precio_unitario) "
                + "SELECT ?, c.id_producto, c.cantidad, p.precio "
                + "FROM carrito c "
                + "JOIN productos p ON c.id_producto = p.id_producto "
                + "WHERE c.id_usuario = ?";

        String sqlLimpiarCarrito = "DELETE FROM carrito WHERE id_usuario = ?";

        try (Connection con = ConexionBD.obtenerConexion()) {
            con.setAutoCommit(false);

            try (PreparedStatement psPed = con.prepareStatement(sqlPedido, Statement.RETURN_GENERATED_KEYS)) {
                psPed.setInt(1, idUsuario);
                psPed.setInt(2, idDireccion);
                psPed.executeUpdate();

                ResultSet rs = psPed.getGeneratedKeys();
                if (rs.next()) {
                    int idPedido = rs.getInt(1);

                    try (PreparedStatement psDet = con.prepareStatement(sqlDetalles)) {
                        psDet.setInt(1, idPedido);
                        psDet.setInt(2, idUsuario);
                        psDet.executeUpdate();
                    }

                    try (PreparedStatement psDel = con.prepareStatement(sqlLimpiarCarrito)) {
                        psDel.setInt(1, idUsuario);
                        psDel.executeUpdate();
                    }
                }
                con.commit();
                return true;
            } catch (SQLException e) {
                con.rollback();
                e.printStackTrace();
                return false;
            }
        } catch (Exception e) {
            return false;
        }
    }
}
