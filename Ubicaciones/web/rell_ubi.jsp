<%-- 
    Document   : rell_ubi
    Created on : 4/12/2013, 10:55:11 AM
    Author     : CEDIS NAY 1
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Clases.*" %>
<%
    ConectionDB con = new ConectionDB();
    con.conectar();
        ResultSet rset = con.consulta("select clave, lote, cadu, fecha_fab, ubi, piezas, resto, cajas from datos_inv_cod");
        while(rset.next()){
            out.println(rset.getString(1));
            out.println(rset.getString(2));
            out.println(rset.getString(3));
            out.println(rset.getString(4));
            out.println(rset.getString(5));
            out.println(rset.getString(6));
            out.println(rset.getString(7));
            out.println(rset.getString(8));
            out.println("<br>");
            out.println("insert into det_insumo values ('0', '"+rset.getString(1)+"', '"+rset.getString(2)+"', '"+rset.getString(3)+"', '"+rset.getString(4)+"', '1', '1', '"+rset.getString(5)+"', '', '', '1')");
        }
    con.cierraConexion();
%>
