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
}
