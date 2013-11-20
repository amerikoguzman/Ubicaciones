/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Clases;

/**
 *
 * @author amerikillo
 */
public class Consultas {

    String query;
    
    public String cons_todos(String juris){
        query = "select sum(can_sur) from juris where juris = '"+juris+"'";
        return query;
    }
    
    public String qry_clave_descr(String clave){
        query = "select ori, cla_ins, des_ins from insumo where cla_ins = '" + clave + "'";
        return query;
    }
    
    public String qry_sectores(){
        query = "select id_sector, sector_des from sectores";
        return query;
    }
    
    public String qry_lote_clave(String clave){
        query = "select lote from det_insumo where cla_ins = '"+clave+"' ";
        return query;
    }
    
    public String qry_ubicaciones(){
        query = "select id_ubi, des_ubi from ubicaciones";
        return query;
    }
}