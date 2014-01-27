<%-- 
    Document   : exportar_existencias
    Created on : 24-ene-2014, 16:26:04
    Author     : Amerikillo
--%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Clases.*" %>

<%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyyMMddhhmmss"); %>
<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%java.text.DateFormat df3 = new java.text.SimpleDateFormat("dd/MM/yyyy"); %>
<%
    ConectionDB con = new ConectionDB();
    response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition","attachment; filename=Ubicaciones y cantidades del CEDIS NAYARIT.xls");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h2>Ubicaciones y cantidades del CEDIS NAYARIT</h2>
        <table border="1">
            <tr>
                <td>Clave</td>
                <td>Descripcion</td>
                <td>Lote</td>
                <td>Caducidad</td>
                <td>Ubicacion</td>
                <td>Cantidad</td>
            </tr>
            <%
    try{
    con.conectar();
    ResultSet rset = con.consulta("SELECT i.cla_ins, i.des_ins, di.lote, di.caducidad, u.des_ubi, di.cant From insumo i, det_insumo di, ubicaciones u where i.cla_ins = di.cla_ins and di.id_ubi = u.id_ubi and di.cant!=0 ORDER BY i.cla_ins+0 ;");
    while(rset.next()){
            %>
            <tr>
                <td><%=rset.getString(1)%></td>
                <td><%=rset.getString(2)%></td>
                <td><%=rset.getString(3)%></td>
                <td><%=df3.format(df2.parse(rset.getString(4)))%></td>
                <td><%=rset.getString(5)%></td>
                <td><%=rset.getString(6)%></td>
            </tr>
            <%
    }
    }catch(Exception e){
        
    }
            %>
        </table>
    </body>
</html>
