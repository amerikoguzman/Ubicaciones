<%-- 
    Document   : carga_inventario
    Created on : 08-feb-2014, 11:52:23
    Author     : Amerikillo
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Clases.*" %>
<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%java.text.DateFormat df3 = new java.text.SimpleDateFormat("dd/MM/yyyy"); %>
<%
    ConectionDB con = new ConectionDB();
    try {
        con.ejecuta("truncate table registro");
    } catch (Exception e) {

    }
    try {
        con.ejecuta("truncate table det_insumo");
    } catch (Exception e) {

    }
    int cont = 1;
    con.conectar();
    ResultSet rset = con.consulta("select * from carga_inv");

    while (rset.next()) {
        String id_ubi = "";
        String det_ins = "";
        ResultSet rset2 = con.consulta("select id_ubi from ubicaciones where des_ubi = '" + rset.getString("ubi_pro") + "' ");
        while (rset2.next()) {
            id_ubi = rset2.getString("id_ubi");
        }
        
        String qry_inv = "insert into det_insumo values ('" + cont + "','" + rset.getString("cla_pro") + "','" + rset.getString("lot_pro") + "','" + df2.format(df3.parse(rset.getString("cad_pro"))) + "', '2012-01-01', '1', '1', '" + id_ubi + "', '" + rset.getString("cant_pro") + "', '0', '1')";
        try {
            con.ejecuta(qry_inv);
        } catch (Exception e) {
            out.println(qry_inv);
        }
        //out.println(qry_inv);
        out.println("<br>");

        String qry_reg = "insert into registro values ('0','1','" + cont + "','" + rset.getString("lot_pro") + "','" + df2.format(df3.parse(rset.getString("cad_pro"))) + "', '2012-01-01', '1', '1', '" + id_ubi + "', '" + rset.getString("cant_pro") + "', '0', 'INVENTARIO INICIAL', CURDATE())";
        try {
            con.ejecuta(qry_reg);
        } catch (Exception e) {
            out.println(qry_reg);
        }
        //out.println(qry_reg);
        out.println("<br>");

        cont++;
    }

    con.cierraConexion();
%>
