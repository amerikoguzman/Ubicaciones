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
        if (sesion.getAttribute("usuario").equals("1")){
            response.sendRedirect("main_menu.jsp");
        }
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
    
    try{
        if(request.getParameter("alta").equals("1")){
            %>
            <script>alert("Alta Correcta")</script>
            <%
        }
    }catch(Exception e){
    }
    
    try{
        if(request.getParameter("alta").equals("0")){
            %>
            <script>alert("Alta Incorrecta")</script>
            <%
        }
    }catch(Exception e){
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
            <h4>INGRESE LOS DATOS</h4>
            <form method="post" name="form_agre1" action="agregar_clave.jsp">
                <table>
                    <tr>
                        <td>Clave</td>
                        <td><input type="text" class="form-control" placeholder="Clave" autofocus name="clave"></td>
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
                <table class="table table-bordered table-striped">
                    <tr>
                        <td colspan="8">
                            <input type="text" class="hidden" placeholder="Origen" readonly name="id_detins" value="<%=df.format(new java.util.Date())%>">
                        </td>
                    </tr>
                    <tr>
                        <td width="13%" colspan="1">
                            Origen<input type="text" class="form-control" placeholder="Origen" value = "<%=origen%>" name = "origen" id = "origen" readonly>
                        </td>
                        <td width="20%" colspan="1">
                            Clave<input type="text" class="form-control" placeholder="Clave" value = "<%=clave%>" name = "clave" id = "clave" readonly>
                        </td>
                        <td colspan="6">
                            Descripción
                            <textarea  class="form-control" placeholder="Descripción" name = "descripcion" id = "descripcion" readonly><%=desc%></textarea>
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
                                <div class="col-sm-7">
                                    <input type="text" class="form-control" name="lote" id ="lote" value="-">
                                </div>
                                <div class="col-sm-5">
                                    <select class="form-control" id ="lote2" name="lote2" onChange="cambia_lote();">
                                        <option value = "-">-</option>
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
                                </div>
                            </div>

                        </td>
                        <td colspan="2">
                            Caducidad<input type="text" class="form-control" id ="caducidad" name="caducidad">
                        </td>
                        <td width="18%" colspan="2">
                            Ubicación
                            <select class="form-control" name = "ubicacion">
                                <%
                                    try {
                                        con.conectar();
                                        ResultSet rset = con.consulta(consulta.qry_ubicaciones("-"));
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
                            Cantidad<input type="text" class="form-control" value = "0" name = "cantidad" readonly id ="cantidad" onkeyup="sumar();">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="8">
                            <button type="submit" value = "501" name = "submit" class="btn btn-primary btn-block">Guardar</button>
                        </td>
                    </tr>
                </table>
            </form>
            <table class="table table-bordered table-striped">
                <tr>
                    <td width="4%"></td>
                    <td width="5%">Clave</td>
                    <td width="5%">Lote</td>
                    <td width="26%">Descripción</td>
                    <td width="8%">Caducidad</td>
                    <td width="7%">Ubicación</td>
                    <td width="7%">Sector</td>
                    <td width="10%">Cajas Completas</td>
                    <td width="7%">Pzs x Cajas</td>
                    <td width="5%">Resto</td>
                    <td width="7%">Existencia</td>
                    <td width="9%">Total de Cajas</td>
                </tr>
                <%
                    try {
                        con.conectar();
                        ResultSet rset = con.consulta(consulta.qry_alta_claves((String) sesion.getAttribute("usuario")));
                        while (rset.next()) {
                %>
                <tr>
                    <td><a href="editar_clave.jsp?id_detins=<%=rset.getString("di.id_detins")%>" class="btn btn-danger"><span class="glyphicon glyphicon-pencil"></span></a></td>
                    <td><%=rset.getString("di.cla_ins")%></td>
                    <td><%=rset.getString("di.lote")%></td>
                    <td><%=rset.getString("i.des_ins")%></td>
                    <td><%=df3.format(df2.parse(rset.getString("di.caducidad")))%></td>
                    <td><%=rset.getString("u.des_ubi")%></td>
                    <td><%=rset.getString("s.sector_des")%></td>
                    <%
                        int cant = Integer.parseInt(rset.getString("di.cant"));
                        int cant_caja = Integer.parseInt(rset.getString("di.cant_caja"));
                        
                        int cajas=0;
                        int resto=0;
                        
                        try{
                        cajas = cant / cant_caja;
                        }catch(Exception e){cajas=0;};
                        try{
                        resto = cant % cant_caja;
                        }catch(Exception e){resto=0;};
                        int cajas_tot = 0;
                        if (resto > 0) {
                            cajas_tot = cajas + 1;
                        } else {
                            cajas_tot = cajas;
                        }
                    %>
                    <td><%=cajas%></td>
                    <td><%=cant_caja%></td>
                    <td><%=resto%></td>
                    <td><%=cant%></td>
                    <td><%=cajas_tot%></td>
                </tr>
                <%
                        }
                        con.cierraConexion();
                    } catch (Exception e) {
                        con.cierraConexion();
                    }
                %>

            </table>
        </div>
        <br><br><br>
        
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
<script type="text/javascript">
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
