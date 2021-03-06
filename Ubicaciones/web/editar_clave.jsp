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
            <h1>Modificacion de Insumo</h1>
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
            <h4>MODIFIQUE LOS DATOS</h4>
            <br>
            <%
                String ori = "", clave = "", descr = "", sector = "", lote = "", caducidad = "2013-01-01", ubi = "", id_ubi = "", cajas = "", cant_cajas = "";
                try {
                    con.conectar();
                    ResultSet rset = con.consulta(consulta.qry_modi_claves(request.getParameter("id_detins")));
                    while (rset.next()) {
                        ori = rset.getString("i.ori");
                        clave = rset.getString("di.cla_ins");
                        descr = rset.getString("i.des_ins");
                        sector = rset.getString("s.sector_des");
                        lote = rset.getString("di.lote");
                        caducidad = rset.getString("di.caducidad");
                        ubi = rset.getString("u.des_ubi");
                        id_ubi = rset.getString("di.id_ubi");
                        cajas = rset.getString("di.cant");
                        cant_cajas = rset.getString("di.cant_caja");
                    }
                    con.cierraConexion();
                } catch (Exception e) {
                    out.println(e.getMessage());
                    con.cierraConexion();
                }
            %>
            <form action="Principal" name="form_agre2" onsubmit="return validar();" method = "GET">
                <table class="table table-bordered table-hover table-striped">
                    <tr>
                        <td colspan="8">
                            <input type="text" class="form-control" placeholder="Origen" readonly name="id_detins" value="<%=request.getParameter("id_detins")%>">
                        </td>
                    </tr>
                    <tr>
                        <td width="13%" colspan="1">
                            Origen<input type="text" class="form-control" placeholder="Origen" value = "<%=ori%>" name = "origen" id = "origen" readonly="">
                        </td>
                        <td width="12%" colspan="1">
                            Clave<input type="text" class="form-control" placeholder="Clave" value = "<%=clave%>" name = "clave" id = "clave">
                        </td>
                        <td colspan="6">
                            Descripción<input type="text" class="form-control" placeholder="Descripción" value = "<%=descr%>" name = "descripcion" id = "descripcion" readonly="">
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
                            <div class="row">
                                <div class="col-sm-6">
                                    <input type="text" class="form-control" name="lote" id ="lote" value="<%=lote%>">
                                </div>
                                <div class="col-sm-6">
                                    <select class="form-control" id ="lote2" name="lote2" onChange="cambia_lote();">
                                        <option value = "-">-</option>
                                        <%
                                            try {
                                                con.conectar();
                                                ResultSet rset = con.consulta(consulta.qry_lote_clave(clave));
                                                while (rset.next()) {
                                                    out.println("<option value ='" + rset.getString("lote") + "'>" + rset.getString("lote") + "</option>");
                                                }
                                                con.cierraConexion();
                                            } catch (Exception e) {
                                                con.cierraConexion();
                                            }
                                        %>  
                                    </select>
                                </div>
                            </div>
                        </td>
                        <td colspan="2">
                            Caducidad<input id ="cadu" type="text" class="form-control" name="caducidad" value = "<%=(df3.format(df2.parse(caducidad)))%>">
                        </td>
                        <td width="23%" colspan="2">
                            Ubicación
                            <select class="form-control" name = "ubicacion" >
                                <option value = "<%=id_ubi%>"><%=ubi%></option>
                                <%
                                    try {
                                        con.conectar();
                                        ResultSet rset = con.consulta(consulta.qry_ubicaciones(ubi));
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
                    <%
                        int caj = Integer.parseInt(cajas);
                        int can_caj = Integer.parseInt(cant_cajas);
                        int icajas = 0;
                        int resto = 0;
                        try {
                            icajas = caj / can_caj;
                            resto = caj % can_caj;
                        } catch (Exception e) {
                            icajas=0;
                            resto=Integer.parseInt(cajas);
                        }
                    %>
                    <tr>
                        <td colspan="2">
                            Cajas<input type="text" class="form-control" value = "<%=icajas%>" name ="cajas" id ="cajas" onkeyup="sumar();">
                        </td>
                        <td colspan="2">
                            Piezas<input type="text" class="form-control" value = "<%=can_caj%>" name = "piezas" id ="piezas"  onkeyup="sumar();">
                        </td>
                        <td colspan="2">
                            Resto<input type="text" class="form-control" value = "<%=resto%>" name = "resto" id ="resto"  onkeyup="sumar();">
                        </td>
                        <td colspan="2">
                            Cantidad<input type="text" class="form-control" value = "<%=caj%>" name = "cantidad" readonly="" id ="cantidad" onkeyup="sumar();">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="8">
                            <button type="submit" value = "502" name = "submit" class="btn btn-primary btn-block">Guardar</button>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="8">
                            <button type="submit" value = "503" name = "submit" class="btn btn-danger btn-block" onclick="return confirm('Esta seguro de eliminarla?')">Eliminar</button>
                        </td>
                    </tr>
                </table>
            </form>
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