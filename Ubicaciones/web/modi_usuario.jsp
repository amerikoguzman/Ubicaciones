<%-- 
    Document   : alta_usuarios
    Created on : 16/11/2013, 04:33:16 PM
    Author     : Americo
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
        <title>Modificaciones de Usuarios</title>
    </head>
    <body>
        <div class="container">
            <h1>Modificaciones de Usuarios</h1>
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
                                <%
                                    if (!sesion.getAttribute("rol").equals("1")) {
                                %>
                            <li><a href="agregar_clave.jsp">Agregar una Clave al Inventario</a></li>
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

                        </ul>
                        <ul class="nav navbar-nav navbar-right">
                            <li><a href=""><span class="glyphicon glyphicon-user"></span> <%=usua%></a></li>
                            <li class="active"><a href="index.jsp"><span class="glyphicon glyphicon-log-out"></span></a></li>
                        </ul>
                    </div><!--/.nav-collapse -->
                </div>
            </div>

            <form class="" name="form1" action="Principal" method="POST" onsubmit="return compara_pass();">
                <table class="table table-bordered">
                    <tr>
                        <td>
                            Usuario
                            <select class="form-control" name="usuario">
                                <%
                                    try {
                                        con.conectar();
                                        ResultSet rset = con.consulta(consulta.qry_eliminar_usuarios());
                                        while (rset.next()) {
                                            out.println("<option value = '"+rset.getString("id_usu")+"'>"+rset.getString("user")+"</option>");
                                        }
                                        con.cierraConexion();
                                    } catch (Exception e) {
                                    }
                                %>
                            </select>
                        </td>
                        <td>
                            Rol
                            <select class="form-control" name="rol">
                                <option value = '5'>Administrador</option>
                                <option value = '2'>Altas y Bajas</option>
                                <option value = '1'>Consultor</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Contraseña:
                            <input type="password" class="form-control" name="pass">
                        </td>
                        <td>
                            Confirmar Contraseña:
                            <input type="password" class="form-control" name="pass2">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <button class="btn btn-primary btn-block" value="102" name="submit">Actualizar</button>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <button class="btn btn-danger btn-block" value="101" name="submit">Eliminar</button>
                        </td>
                    </tr>
                </table>
            </form>

        </div>
    </body>
</html>

<script src="js/jquery-1.9.1.js"></script>
<script src="js/bootstrap.js"></script>
<script src="js/jquery-ui-1.10.3.custom.js"></script>
<script type="text/javascript">
    function compara_pass() {
        p1 = document.form1.pass.value;
        p2 = document.form1.pass2.value;
        if (p1!=p2) {
            window.alert("Contraseñas Distintas");
            return false;
        }
        return true;
    }
</script>