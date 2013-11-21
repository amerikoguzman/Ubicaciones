<%-- 
    Document   : index
    Created on : 27-oct-2013, 20:24:40
    Author     : amerikillo
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Clases.*" %>

<%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyyMMddhhmmss"); %>
<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%java.text.DateFormat df3 = new java.text.SimpleDateFormat("dd/MM/yyyy"); %>
<%

    HttpSession sesion = request.getSession();
    String usua = "";
    if (sesion.getAttribute("usuario") != null) {
        usua = (String) sesion.getAttribute("usuario");
    } else {
        response.sendRedirect("index.jsp");
    }
    ConectionDB con = new ConectionDB();
    Consultas consulta = new Consultas();
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">
        <!-- Estilos CSS -->
        <link href="css/bootstrap.css" rel="stylesheet">
        <link rel="stylesheet" href="css/cupertino/jquery-ui-1.10.3.custom.css" />
        <link href="css/navbar-fixed-top.css" rel="stylesheet">
        <!---->
        <title>:: SISTEMA DE UBICACIONES ::</title>
    </head>
    <body>
        <div class="container">
            <h1>Consultas</h1>
            <div class="navbar navbar-default">
                <div class="container">
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <a class="navbar-brand" href="#">Sistema de Ubicaciones</a>
                    </div>
                    <div class="navbar-collapse collapse">
                        <ul class="nav navbar-nav">
                            <li class="active"><a href="#">Consultas</a></li>
                            <li><a href="agregar_clave.jsp">Agregar una Clave al Inventario</a></li>
                            <li><a href="#about">Catálogo</a></li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Usuarios <b class="caret"></b></a>
                                <ul class="dropdown-menu">
                                    <li><a href="#">Altas</a></li>
                                    <li><a href="#">Bajas</a></li>
                                    <li><a href="#">Modificaciones</a></li>
                                </ul>
                            </li>
                        </ul>
                        <ul class="nav navbar-nav navbar-right">
                            <li><a href=""><span class="glyphicon glyphicon-user"></span> <%=usua%></a></li>
                            <li class="active"><a href="../navbar/"><span class="glyphicon glyphicon-log-out"></span></a></li>
                        </ul>
                    </div><!--/.nav-collapse -->
                </div>
            </div>
            <table class="table table-bordered table-bordered">
                <tr>
                    <td colspan="3"><h3>Introduzca Clave para localizarla dentro del Almacén</h3></td>
                </tr>
                <tr>
                    <td>
                        <input type="text" class="form-control" placeholder="Ubicacion" autofocus="">
                        <button class="btn btn-block btn-info">Ubicación</button>
                    </td>
                    <td>
                        <input type="text" class="form-control" placeholder="Clave">
                        <button class="btn btn-block btn-info">Clave</button>
                    </td>
                    <td>
                        <input type="text" class="form-control" placeholder="Lote">
                        <button class="btn btn-block btn-info">Lote</button>
                    </td>
                </tr>
                <tr>
                    <td><button class="btn btn-block btn-success">Por Ubicar</button></td>
                    <td>
                        <form method="post">
                            <button class="btn btn-block btn-success" name="submit" value = "401">Todos</button>
                        </form>
                    </td>
                </tr>
            </table>
            <table class="table table-bordered table-bordered">
                <tr>
                    <td></td>
                    <td></td>
                    <td>Clave</td>
                    <td>Lote</td>
                    <td>Descripción</td>
                    <td>Caducidad</td>
                    <td>Ubicación</td>
                    <td>Sector</td>
                    <td>Cajas Completas</td>
                    <td>Pzs Cajas</td>
                    <td>Resto</td>
                    <td>Existencia</td>
                    <td>Total de Cajas</td>
                </tr>
                <%
                    try {
                        con.conectar();
                        ResultSet rset = null;
                        if (request.getParameter("submit").equals("401")) {
                            rset = con.consulta(consulta.qry_main_todos());
                        }
                        while (rset.next()) {
                %>
                <tr>
                    <td><a href="det_cla.jsp?id_detins=<%=rset.getString("di.id_detins")%>" class="btn btn-success"><span class="glyphicon glyphicon-zoom-in"></span></a></td>
                    <td><a href="editar_clave.jsp?id_detins=<%=rset.getString("di.id_detins")%>" class="btn btn-danger"><span class="glyphicon glyphicon-pencil"></span></a></td>
                    <td><%=rset.getString("cla_ins")%></td>
                    <td><%=rset.getString("lote")%></td>
                    <td><%=rset.getString("des_ins")%></td>
                    <td><%=df3.format(df2.parse(rset.getString("caducidad")))%></td>
                    <td><%=rset.getString("des_ubi")%></td>
                    <td><%=rset.getString("sector_des")%></td>
                    <%
                    int cant = Integer.parseInt(rset.getString("cant"));
                    int cant_caj = Integer.parseInt(rset.getString("cant_caja"));
                    int caj=cant/cant_caj;
                    int resto=cant%cant_caj;
                    int caj_t=0;
                    if(resto>0){
                        caj_t=caj+1;
                    }else{
                        caj_t=caj;
                    }
                    %>
                    <td><%=caj%></td>
                    <td><%=cant_caj%></td>
                    <td><%=resto%></td>
                    <td><%=cant%></td>
                    <td><%=caj_t%></td>
                </tr>
                <%
                        }
                        con.cierraConexion();
                    } catch (Exception e) {
                    }
                %>
            </table>
        </div>
        <br><br><br>
        <div class="navbar navbar-fixed-bottom navbar-inverse">
            <div class="text-center text-muted">
                GNK Logística<span class="glyphicon glyphicon-registration-mark"></span>
            </div>
        </div>
    </body>
</html>

<!-- 
================================================== -->
<!-- Se coloca al final del documento para que cargue mas rapido -->
<!-- Se debe de seguir ese orden al momento de llamar los JS -->
<script src="js/jquery-1.9.1.js"></script>
<script src="js/bootstrap.js"></script>
<script src="js/jquery-ui-1.10.3.custom.js"></script>