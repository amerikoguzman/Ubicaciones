<%-- 
    Document   : alta_usuarios
    Created on : 16/11/2013, 04:33:16 PM
    Author     : Americo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <title>Alta de Usuarios</title>
    </head>
    <body>
        <div class="container">
            <h1>Alta de Usuarios</h1>
            <div class="navbar navbar-default">
                <div class="container">
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <a class="navbar-brand" href="#">Project name</a>
                    </div>
                    <div class="navbar-collapse collapse">
                        <ul class="nav navbar-nav">
                            <li class="active"><a href="#">Home</a></li>
                            <li><a href="#about">About</a></li>
                            <li><a href="#contact">Contact</a></li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Dropdown <b class="caret"></b></a>
                                <ul class="dropdown-menu">
                                    <li><a href="#">Action</a></li>
                                    <li><a href="#">Another action</a></li>
                                    <li><a href="#">Something else here</a></li>
                                    <li class="divider"></li>
                                    <li class="dropdown-header">Nav header</li>
                                    <li><a href="#">Separated link</a></li>
                                    <li><a href="#">One more separated link</a></li>
                                </ul>
                            </li>
                        </ul>
                        <ul class="nav navbar-nav navbar-right">
                            <li><a href="../navbar/">Default</a></li>
                            <li><a href="../navbar-static-top/">Static top</a></li>
                            <li class="active"><a href="./">Fixed top</a></li>
                        </ul>
                    </div><!--/.nav-collapse -->
                </div>
            </div>
            
            <form class="jumbotron" action="Principal" method="post">
                <table >
                    <tr>
                        <td>
                          Usuario  
                        </td>
                        <td>
                            <input type="text" class="form-control">
                        </td>
                    </tr>
                    <tr>
                        <td>
                          Contraseña  
                        </td>
                        <td>
                           <input type="password" class="form-control">
                        </td>
                    </tr>
                    <tr>
                        <td>
                          Confirme Contraseña  
                        </td>
                        <td>
                           <input type="password" class="form-control">
                        </td>
                    </tr>
                    <tr>
                        <td>
                          Seleccione Rol
                        </td>
                        <td>
                            <select class="form-control">
                                <option value = '5'>Administrador</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            
                        </td>
                        <td>
                            <button class="btn btn-primary btn-block" value="100" name="submit">Guardar</button>
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