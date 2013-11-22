/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Clases;

import java.sql.SQLException;

/**
 *
 * @author CEDIS NAY 1
 */
public class CodigoBarras {
    
    ConectionDB con = new ConectionDB();
    
    public void actualza_CB(String id, String cb) throws SQLException{
        try{
            con.ejecuta("update insumos set cb_ins='"+cb+"' where id = '"+id+"'");
        }catch(Exception e){
            con.cierraConexion();
        }
    }
}
