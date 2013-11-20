<%-- 
    Document   : index
    Created on : 27-oct-2013, 20:24:40
    Author     : amerikillo
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Clases.*" %>

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
    String clave = "", origen = "", desc = "";
    String submit = "";
    try {
        submit = request.getParameter("submit");
    } catch (Exception e) {
        submit = "";
    }
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
            <h1>Agregar Clave al Inventario</h1>
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
                            <li><a href="#about">Agregar una Clave al Inventario</a></li>
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
            <h4>INGRESE LOS DATOS</h4>
            <form method="post" name="form_agre1">
                <table>
                    <tr>
                        <td>Clave</td>
                        <td><input type="text" class="form-control" placeholder="Origen" autofocus name="clave"></td>
                        <td><button class="btn btn-info" value="500" name = "submit">Buscar</button></td>
                    </tr>
                </table>
            </form>
            <br>
            <%
                if (submit != null) {
                    if (submit.equals("500")) {
                        con.conectar();
                        ResultSet rset = con.consulta(consulta.qry_clave_descr(request.getParameter("clave")));
                        while (rset.next()) {
                            origen = rset.getString("ori");
                            clave = rset.getString("cla_ins");
                            desc = rset.getString("des_ins");
                        }
                        con.cierraConexion();
                    }
                }

            %>
            <form action="Principal" name="form_agre2" onsubmit="return validar();" method = "post">
                <table class="table table-bordered table-hover table-striped">
                    <tr>
                        <td width="13%" colspan="1">
                            Origen<input type="text" class="form-control" placeholder="Origen" value = "<%=origen%>" name = "origen" id = "origen">
                        </td>
                        <td width="12%" colspan="1">
                            Clave<input type="text" class="form-control" placeholder="Clave" value = "<%=clave%>" name = "clave" id = "clave">
                        </td>
                        <td colspan="6">
                            Descripción<input type="text" class="form-control" placeholder="Descripción" value = "<%=desc%>" name = "descripcion" id = "descripcion">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            Sector
                            <select class="form-control" name = "sector">
                                <%
                                    try {
                                        con.conectar();
                                        ResultSet rset = con.consulta(consulta.qry_sectores());
                                        while (rset.next()) {
                                            out.println("<option value ='" + rset.getString("id_sector") + "'>" + rset.getString("sector_des") + "</option>");
                                        }
                                        con.cierraConexion();
                                    } catch (Exception e) {
                                        con.cierraConexion();
                                    }
                                %>  
                            </select>
                        </td>
                        <td colspan="2">
                            Lote
                            <select class="form-control" name = "lote">
                                <option value ="-">-</option>
                                <%
                                    try {
                                        con.conectar();
                                        ResultSet rset = con.consulta(consulta.qry_lote_clave(request.getParameter("clave")));
                                        while (rset.next()) {
                                            out.println("<option value ='" + rset.getString("lote") + "'>" + rset.getString("lote") + "</option>");
                                        }
                                        con.cierraConexion();
                                    } catch (Exception e) {
                                        con.cierraConexion();
                                    }
                                %>  
                            </select>
                        </td>
                        <td colspan="2">
                            Caducidad<input type="text" class="form-control" id ="caducidad" name="caducidad">
                        </td>
                        <td width="23%" colspan="2">
                            Ubicación
                            <select class="form-control" name = "ubicacion">
                                <%
                                    try {
                                        con.conectar();
                                        ResultSet rset = con.consulta(consulta.qry_ubicaciones());
                                        while (rset.next()) {
                                            out.println("<option value ='" + rset.getString("id_ubi") + "'>" + rset.getString("des_ubi") + "</option>");
                                        }
                                        con.cierraConexion();
                                    } catch (Exception e) {
                                        con.cierraConexion();
                                    }
                                %>  
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            Cajas<input type="text" class="form-control" value = "0" name ="cajas" id ="cajas" onkeyup="sumar();">
                        </td>
                        <td colspan="2">
                            Piezas<input type="text" class="form-control" value = "0" name = "piezas" id ="piezas"  onkeyup="sumar();">
                        </td>
                        <td colspan="2">
                            Resto<input type="text" class="form-control" value = "0" name = "resto" id ="resto"  onkeyup="sumar();">
                        </td>
                        <td colspan="2">
                            Cantidad<input type="text" class="form-control" value = "0" name = "cantidad" readonly="" id ="cantidad" onkeyup="sumar();">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="8">
                            <button type="submit" value = "501" name = "submit" class="btn btn-primary btn-block">Guardar</button>
                        </td>
                    </tr>
                </table>
            </form>
            <table class="table table-bordered table-bordered">
                <tr>
                    <td>ID</td>
                    <td>Modificar</td>
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
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
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

<script>
                                $(function() {
                                    $("#caducidad").datepicker();
                                    $("#caducidad").datepicker('option', {dateFormat: 'dd/mm/yy'});
                                });
</script>
<script>
    function sumar() {
        cajas = parseInt(document.form_agre2.cajas.value);
        piezas = parseInt(document.form_agre2.piezas.value);
        resto = parseInt(document.form_agre2.resto.value);
        cantidad = (cajas * piezas) + resto;
        document.form_agre2.cantidad.value = cantidad;
    }

    function validar() {
        clave = document.form_agre2.clave.value;
        if (clave.length == 0) {
            alert("Datos Incompletos");
            return false;
        }
        return true;
    }
</script>
