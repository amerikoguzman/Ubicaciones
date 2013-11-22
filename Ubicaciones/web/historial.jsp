<%-- 
    Document   : index
    Created on : 27-oct-2013, 20:24:40
    Author     : amerikillo
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Clases.*" %>

<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("yyyy-MM-dd hh:mm:ss"); %>
<%java.text.DateFormat df3 = new java.text.SimpleDateFormat("dd/MM/yyyy hh:mm:ss"); %>
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
            <h1>Kardex</h1>
            <div class="navbar navbar-default">
                <div class="container">
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <a class="navbar-brand" href="#">Sistemas de Ubicaciones</a>
                    </div>
                    <div class="navbar-collapse collapse">
                        <ul class="nav navbar-nav">
                            <li class="active"><a href="main_menu.jsp">Consultas</a></li>
                            <li><a href="catalogo.jsp" target="_blank">Catálogo</a></li>
                            <li><a href="historial.jsp" target="_blank">Kardex</a></li>
                                <%
                                    if (!sesion.getAttribute("rol").equals("1")) {
                                %>
                            <li><a href="agregar_clave.jsp">Agregar una Clave al Inventario</a></li>
                                <%
                                    if (!sesion.getAttribute("rol").equals("2")) {
                                %>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Usuarios <b class="caret"></b></a>
                                <ul class="dropdown-menu">
                                    <li><a href="alta_usuarios.jsp">Altas</a></li>
                                    <li><a href="modi_usuario.jsp">Modificaciones</a></li>
                                </ul>
                            </li>
                            <%
                                }
                            %>
                            <%
                                }
                            %>

                        </ul>
                        <ul class="nav navbar-nav navbar-right">
                            <li><a href=""><span class="glyphicon glyphicon-user"></span> <%=usua%></a></li>
                            <li class="active"><a href="index.jsp"><span class="glyphicon glyphicon-log-out"></span></a></li>
                        </ul>
                    </div><!--/.nav-collapse -->
                </div>
            </div>
            <form method="get">
                <table class="table table-bordered table-bordered">
                    <tr>
                        <td colspan="7"><h3>Seleccione los parametros de filtrado</h3></td>
                    </tr>
                    <tr>
                        <td>
                            Clave:
                            <select name = "clave" class="form-control">
                                <option value = ''>Ninguna</option>
                                <%
                                    try {
                                        con.conectar();
                                        ResultSet rset = con.consulta(consulta.qry_kardex_claves());
                                        while (rset.next()) {
                                            out.println("<option value = '" + rset.getString("cla_ins") + "'>" + rset.getString("cla_ins") + "</option>");
                                        }
                                        con.cierraConexion();
                                    } catch (Exception e) {
                                        con.cierraConexion();
                                    }
                                %>
                            </select>
                        </td>
                        <td>
                            Lote:
                            <select name = "lote" class="form-control">
                                <option value = ''>Ninguna</option>
                                <%
                                    try {
                                        con.conectar();
                                        ResultSet rset = con.consulta(consulta.qry_kardex_lote());
                                        while (rset.next()) {
                                            out.println("<option value = '" + rset.getString("lote") + "'>" + rset.getString("lote") + "</option>");
                                        }
                                        con.cierraConexion();
                                    } catch (Exception e) {
                                        con.cierraConexion();
                                    }
                                %>
                            </select>
                        </td>
                        <td>
                            Caducidad:
                            <select name = "cad" class="form-control">
                                <option value = ''>Ninguna</option>
                                <%
                                    try {
                                        con.conectar();
                                        ResultSet rset = con.consulta(consulta.qry_kardex_caducidad());
                                        while (rset.next()) {
                                            out.println("<option value = '" + rset.getString("caducidad") + "'>" + rset.getString("caducidad") + "</option>");
                                        }
                                        con.cierraConexion();
                                    } catch (Exception e) {
                                        con.cierraConexion();
                                    }
                                %>
                            </select>
                        </td>
                        <td>
                            Ubicacion:
                            <select name = "ubi" class="form-control">
                                <option value = ''>Ninguna</option>
                                <%
                                    try {
                                        con.conectar();
                                        ResultSet rset = con.consulta(consulta.qry_kardex_ubicacion());
                                        while (rset.next()) {
                                            out.println("<option value = '" + rset.getString("r.id_ubi") + "'>" + rset.getString("u.des_ubi") + "</option>");
                                        }
                                        con.cierraConexion();
                                    } catch (Exception e) {
                                        con.cierraConexion();
                                    }
                                %>
                            </select>
                        </td>
                        <td>
                            Usuario:
                            <select name = "usu" class="form-control">
                                <option value = ''>Ninguna</option>
                                <%
                                    try {
                                        con.conectar();
                                        ResultSet rset = con.consulta(consulta.qry_kardex_usuario());
                                        while (rset.next()) {
                                            out.println("<option value = '" + rset.getString("r.idUsuario") + "'>" + rset.getString("u.user") + "</option>");
                                        }
                                        con.cierraConexion();
                                    } catch (Exception e) {
                                        con.cierraConexion();
                                    }
                                %>
                            </select>
                        </td>
                        <td>
                            Movmiento:
                            <select name = "mov" class="form-control">
                                <option value = ''>Ninguna</option>
                                <%
                                    try {
                                        con.conectar();
                                        ResultSet rset = con.consulta(consulta.qry_kardex_movimiento());
                                        while (rset.next()) {
                                            out.println("<option value = '" + rset.getString("tipo_mov") + "'>" + rset.getString("tipo_mov") + "</option>");
                                        }
                                        con.cierraConexion();
                                    } catch (Exception e) {
                                        con.cierraConexion();
                                    }
                                %>
                            </select>
                        </td>
                        <td>
                            <br>
                            <button class="btn btn-block btn-primary" type="submit" name="submit" value="300" >Buscar</button>
                        </td>
                    </tr>
                </table>
            </form>
            <table class="table table-bordered table-bordered">
                <tr>
                    <td>Clave</td>
                    <td>Lote</td>
                    <td>Caducidad</td>
                    <td>Cantidad</td>
                    <td>Cantidad x Caja</td>
                    <td>Resto</td>
                    <td>Cajas Completas</td>
                    <td>Ubicacion</td>
                    <td>Movimiento</td>
                    <td>Fecha y Hora</td>
                    <td>Usuario</td>
                </tr>
                <%
                    String submit = "";
                    try {
                        submit = request.getParameter("submit");

                        if (submit.equals("300")) {

                            try {
                                con.conectar();
                                ResultSet rset = con.consulta(consulta.qry_kardex_consulta(request.getParameter("clave"),
                                        request.getParameter("lote"),
                                        request.getParameter("cad"),
                                        request.getParameter("ubi"),
                                        request.getParameter("usu"),
                                        request.getParameter("mov")));

                                while (rset.next()) {
                %>
                <tr>
                    <td><%=rset.getString(1)%></td>
                    <td><%=rset.getString(2)%></td>
                    <td><%=rset.getString(3)%></td>
                    <td><%=rset.getString(4)%></td>
                    <td><%=rset.getString(5)%></td>
                    <%
                    int caj=Integer.parseInt(rset.getString(4));
                    int cant_c=Integer.parseInt(rset.getString(5));
                    int resto = caj%cant_c;
                    int caj_c=cant_c;
                    if (resto>0){
                        caj_c+=1;
                    }
                    %>
                    <td><%=resto%></td>
                    <td><%=caj_c%></td>
                    <td><%=rset.getString(6)%></td>
                    <td><%=rset.getString(7)%></td>
                    <td><%=df3.format(df2.parse(rset.getString(8)))%></td>
                    <td><%=rset.getString(9)%></td>
                </tr>
                <%
                                }
                                con.cierraConexion();
                            } catch (Exception e) {
                            }
                        }
                    } catch (Exception e) {
                        submit = "";
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