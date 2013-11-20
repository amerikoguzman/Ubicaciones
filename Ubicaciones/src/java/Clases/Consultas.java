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
}