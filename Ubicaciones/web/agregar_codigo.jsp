<%-- 
    Document   : index
    Created on : 27-oct-2013, 20:24:40
    Author     : amerikillo
--%>

<%@page import="java.util.Date"%>
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
        if (sesion.getAttribute("usuario").equals("1")) {
            response.sendRedirect("main_menu.jsp");
        }
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
            <h1>Agregar CB</h1>
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
                            <li class="active"><a href="../navbar/"><span class="glyphicon glyphicon-log-out"></span></a></li>
                        </ul>
                    </div><!--/.nav-collapse -->
                </div>
            </div>
            <h4>CAPTURE EL CODIGO DE BARRAS</h4>
            <br>
            <%
                String submit = "";
                try {
                    submit = request.getParameter("id");
                } catch (Exception e) {
                }
                if (submit == null || submit.equals("")) {
                    submit = "1";
                }
                String query = "select * from insumos;";
                try {
                    con.conectar();
                    ResultSet rset = con.consulta(query);
                    while (rset.next()) {
                        if (rset.getString("id").equals(submit)) {
            %>
            <form action="Principal" name="form_agre2" onsubmit="return validar();" method = "GET">
                <table class="table table-bordered table-hover table-striped">
                    <tr>
                        <td width="13%" colspan="1">Caducidad                          
                            <input id ="cadu" type="text" class="form-control" name="caducidad" readonly value="<%=df3.format(df2.parse(rset.getString(4)))%>">
                        </td>
                        <td width="12%" colspan="1">
                            Clave
                            <input type="text" class="form-control" placeholder="Clave" name = "clave" id = "clave" readonly value="<%=rset.getString(1)%>">
                        </td>
                        <td colspan="6">Descripcion
                            <textarea name="descr" readonly="readonly" class="form-control" id="descr"><%=rset.getString(2)%></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <div class="row">
                                <div class="col-md-6">
                                    ID <input id ="id" type="text" class="form-control" name="id" readonly  value="<%=rset.getString(6)%>">
                                </div>                                
                                <div class="col-md-6">
                                    Lote <input id ="lote" type="text" class="form-control" name="lote" readonly  value="<%=rset.getString(3)%>">
                                </div>
                            </div>
                        </td>
                        <td colspan="2"> Codigo de Barras
                            <input type="text" class="form-control" placeholder="Origen" name = "cb" id = "cb" autofocus value="<%=rset.getString(5)%>">
                        </td>
                        <td colspan="2">
                            <%

                                String ant = "";
                                rset.previous();
                                try {
                                    ant = rset.getString("id");
                                } catch (Exception e) {
                                }
                            %>
                            <%
                               // if (!ant.equals("")) {
                            %>
                            <br><a href="agregar_codigo.jsp?id=<%=ant%>" class="btn btn-block btn-info">Anterior</a>
                            <%
                                //}
                            %>
                        </td>
                        <td width="23%" colspan="2">
                            <%
                                String sig = "";
                                rset.next();
                                rset.next();
                                try {
                                    sig = rset.getString("id");
                                } catch (Exception e) {
                                }
                            %>
                            <br><a href="agregar_codigo.jsp?id=<%=sig%>" class="btn btn-block btn-info">Siguiente</a>
                        </td>
                    </tr>

                    <tr>
                        <td colspan="8">
                            <button type="submit" value = "600" name = "submit" class="btn btn-primary btn-block">Guardar</button>
                        </td>
                    </tr>
                </table>
            </form>
            <%
                        }
                    }
                    con.cierraConexion();
                } catch (Exception e) {

                }
            %>
        </div>
        <br><br><br>
        <div class="navbar navbar-fixed-bottom navbar-inverse">
            <div class="text-center text-muted">
                GNK Logística <span class="glyphicon glyphicon-registration-mark"></span>
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
                function validar() {
                    clave = document.form_agre2.clave.value;
                    cad = document.form_agre2.caducidad.value;
                    if (clave.length == 0 || cad.length == 0) {
                        window.alert("Datos Incompletos");
                        return false;
                    }
                    return true;
                }
                function sumar() {
                    cajas = parseInt(document.form_agre2.cajas.value);
                    piezas = parseInt(document.form_agre2.piezas.value);
                    resto = parseInt(document.form_agre2.resto.value);
                    cantidad = (cajas * piezas) + resto;
                    document.form_agre2.cantidad.value = cantidad;
                }
                function cambia_lote() {
                    lote = document.form_agre2.lote2.value;
                    document.form_agre2.lote.value = lote;
                }
</script>
<script>
    $(function() {
        $("#cadu").datepicker({dateFormat: "dd/mm/yy"}).val()
    });
</script>