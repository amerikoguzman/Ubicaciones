<%-- 
    Document   : index
    Created on : 11/11/2013, 11:27:20 AM
    Author     : CEDIS NAY 1
--%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Clases.*" %>

<%
    HttpSession sesion = request.getSession();
    String mensaje = "";
    if (sesion.getAttribute("mensaje") != null) {
        mensaje = (String) sesion.getAttribute("mensaje");
    }
    ConectionDB con = new ConectionDB();
    Consultas consulta = new Consultas();
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">
        <link rel="shortcut icon" href="imagen/favicon.ico">

        <title>Generacion de Etiquetas</title>

        <!-- Bootstrap core CSS -->
        <link href="css/bootstrap.css" rel="stylesheet">

        <!-- Custom styles for this template -->
        <link href="css/singnin.css" rel="stylesheet">

        <!-- Just for debugging purposes. Don't actually copy this line! -->
        <!--[if lt IE 9]><script src="../../docs-assets/js/ie8-responsive-file-warning.js"></script><![endif]-->

        <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
          <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
        <![endif]-->
    </head>

    <body>

        <div class="container">

            <form class="form-signin" action="Principal" method="POST">
                <h2 class="form-signin-heading">Ingrese sus Datos</h2>
                <select name="user" class="form-control">
                    <%
                        try {
con.conectar();
ResultSet rset = con.consulta(consulta.qry_eliminar_usuarios());
while(rset.next()){
    out.println("<option value = "+rset.getString("user")+">"+rset.getString("user")+"</option>");
}
con.cierraConexion();
                        } catch (Exception e) {
con.cierraConexion();
                        }
                    %>
                </select>
                <input type="password" class="form-control" placeholder="Contraseña" name="pass" required>
                <%
                    if (!mensaje.equals("")) {
                        out.println("<div class='alert alert-warning'>Datos Incorretos</div>");
                    }
                %>
                <button class="btn btn-lg btn-primary btn-block" type="submit" name="submit" value="200">Entrar</button>
            </form>

        </div> <!-- /container -->


        <!-- Bootstrap core JavaScript
        ================================================== -->
        <!-- Placed at the end of the document so the pages load faster -->
    </body>
</html>
<%
    sesion.invalidate();
%>