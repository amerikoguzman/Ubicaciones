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
    
    public boolean login(String user, String pass){
        boolean valido=false;
        if (this.valida(user, pass)){
            valido=true;
        }
        return valido;
    }
    
    private boolean valida(String user, String pass){
        boolean valido=false;
        try{
            con.conectar();
            ResultSet rset = con.consulta("select id_usu from usuarios where user = '"+user+"' and pass = PASSWORD('"+pass+"') and rol='5'");
            while(rset.next()){
                valido=true;
            }
            con.cierraConexion();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return valido;
    }
}
