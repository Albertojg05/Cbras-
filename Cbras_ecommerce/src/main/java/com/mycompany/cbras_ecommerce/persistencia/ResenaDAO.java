/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.cbras_ecommerce.persistencia;

import com.mycompany.cbras_ecommerce.modelo.Resena;
import com.mycompany.cbras_ecommerce.util.ConexionBD;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Alberto Jimenez
 */
public class ResenaDAO {

    public List<Resena> listarTodas() {
        List<Resena> lista = new ArrayList<>();
        String sql = "SELECT r.id_resena, p.nombre AS nombre_producto, u.nombre AS nombre_usuario, "
                + "r.calificacion, r.comentario, r.fecha "
                + "FROM resenas r "
                + "JOIN productos p ON r.id_producto = p.id_producto "
                + "JOIN usuarios u ON r.id_usuario = u.id_usuario "
                + "ORDER BY r.fecha DESC";

        try (Connection con = ConexionBD.obtenerConexion(); PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Resena r = new Resena();
                r.setIdResena(rs.getInt("id_resena"));
                r.setNombreProducto(rs.getString("nombre_producto"));
                r.setNombreUsuario(rs.getString("nombre_usuario"));
                r.setCalificacion(rs.getInt("calificacion"));
                r.setComentario(rs.getString("comentario"));
                r.setFecha(rs.getTimestamp("fecha"));
                lista.add(r);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public boolean eliminar(int id) {
        String sql = "DELETE FROM resenas WHERE id_resena = ?";
        try (Connection con = ConexionBD.obtenerConexion(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            int filasAfectadas = ps.executeUpdate();
            return filasAfectadas > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
