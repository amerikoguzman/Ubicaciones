/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Clases;

import java.sql.SQLException;

/**
 *
 * @author Americo
 */
public class AltaUsuarios {

    ConectionDB con = new ConectionDB();

    public void alta(String user, String pass, String pass2, String rol) {
        try {
            if (valida_pass(pass, pass2)) {
                try {
                    con.ejecuta("insert into usuarios values('0', '" + user + "', '" + user + "',PASSWORD('" + pass + "'),'" + rol + "','1','1')");
                } catch (SQLException ex) {
                    System.out.println(ex.getMessage());
                }
            } else {
                System.out.println("Algo mal");
            }
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }

    }

    public boolean valida_pass(String pass, String pass2) {
        return pass.equals(pass2);
    }
    
    public void elimina_usuario(String id_usu) throws SQLException{
        try{
            System.out.println("update usuarios set status = '0' where id_usu = '"+id_usu+"'");
            con.ejecuta("update usuarios set status = '0' where id_usu = '"+id_usu+"'");
        }catch (SQLException ex) {
            con.cierraConexion();
            System.out.println(ex.getMessage());
        }
    }
    
    public void modifica_usuario(String user, String pass, String pass2, String rol) throws SQLException{
        try{
            con.ejecuta("update usuarios set pass = PASSWORD('"+pass+"'), rol = '"+rol+"' where id_usu='"+user+"' ");
        }catch (SQLException ex) {
            con.cierraConexion();
            System.out.println(ex.getMessage());
        }
    }
}
