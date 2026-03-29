/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.cbras_ecommerce.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author Alberto Jimenez
 */

public class ConexionBD {
    private static final String URL = "jdbc:mysql://localhost:3306/cbras_db?zeroDateTimeBehavior=CONVERT_TO_NULL";
    private static final String USUARIO = "root";
    private static final String PASSWORD = "ITSON";
    
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.err.println("Error cargando driver: " + e.getMessage());
        }
    }
    
    public static Connection obtenerConexion() throws SQLException {
        return DriverManager.getConnection(URL, USUARIO, PASSWORD);
    }
}
