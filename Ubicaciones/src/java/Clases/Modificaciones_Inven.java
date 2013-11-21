/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Clases;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author CEDIS NAY 1
 */
public class Modificaciones_Inven {

    ConectionDB con = new ConectionDB();

    public void insertar_registro(
            String det_ins,
            String cla_ins,
            String lote,
            String caducidad,
            String fec_fab,
            String id_fab,
            String id_sec,
            String id_ubi,
            String cant,
            String cant_caja,
            String usuario
    ) throws SQLException {
        try {
            con.conectar();
            con.ejecuta("insert into det_insumo values ('" + det_ins + "','" + cla_ins + "','" + lote + "','" + caducidad + "','" + fec_fab + "','" + id_fab + "','" + id_sec + "','" + id_ubi + "','" + cant + "','" + cant_caja + "','1')");
            con.ejecuta("insert into registro values( '0','" + this.id_usu(usuario) + "', '"+det_ins+"','" + lote + "','" + caducidad + "','" + fec_fab + "','" + id_fab + "','" + id_sec + "','" + id_ubi + "','" + cant + "','" + cant_caja + "','INSERCION',NOW() )");
            con.cierraConexion();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            con.cierraConexion();
        }
    }

    public void modificar_registro(
            String det_ins,
            String cla_ins,
            String lote,
            String caducidad,
            String fec_fab,
            String id_fab,
            String id_sec,
            String id_ubi,
            String cant,
            String cant_caja,
            String usuario
    ) throws SQLException {
        try {
            con.conectar();
            con.ejecuta("update det_insumo set cla_ins = '" + cla_ins + "', lote = '" + lote + "', caducidad = '" + caducidad + "', fec_fab = '" + fec_fab + "', id_fab = '" + id_fab + "', id_sec = '" + id_sec + "', id_ubi = '" + id_ubi + "', cant = '" + cant + "', cant_caja='" + cant_caja + "' where id_detins = '" + det_ins + "','1'");
            con.ejecuta("insert into registro values( '0','" + this.id_usu(usuario) + "', '"+det_ins+"','" + lote + "','" + caducidad + "','" + fec_fab + "','" + id_fab + "','" + id_sec + "','" + id_ubi + "','" + cant + "','" + cant_caja + "','MODIFICACION',NOW() )");
            con.cierraConexion();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            con.cierraConexion();
        }
    }

    private String id_usu(String usuario) throws SQLException {
        String id_usu = "";
        try {
            con.conectar();
            ResultSet rset = con.consulta("select id_usu from usuarios where user = '" + usuario + "'");
            while (rset.next()) {
                id_usu = rset.getString(1);
            }
            con.cierraConexion();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            con.cierraConexion();
        }
        return id_usu;
    }

}
