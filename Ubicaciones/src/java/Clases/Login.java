/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Clases;

import java.sql.ResultSet;
import java.sql.SQLException;
/**
 *
 * @author CEDIS NAY 1
 */
public class Login {
    ConectionDB con = new ConectionDB();
    
    public String login(String user, String pass){
        String rol = this.valida(user, pass);
        System.out.println(rol);
        if (!rol.equals("")){
            System.out.println("Entra");
            return (rol);
        }
        return null;
    }
    
    private String valida(String user, String pass){
        String rol="";
        try{
            con.conectar();
            ResultSet rset = con.consulta("select rol from usuarios where user = '"+user+"' and pass = PASSWORD('"+pass+"')");
            while(rset.next()){
                rol = rset.getString("rol");
            }
            con.cierraConexion();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return rol;
    }
}
