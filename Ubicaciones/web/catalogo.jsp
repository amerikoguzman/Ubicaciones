<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.text.*"
         import="java.lang.*" import="java.util.*" import="javax.swing.*" import="java.io.*"
         import="java.text.DateFormat"
         import="java.text.ParseException" import="java.text.DecimalFormat" import="java.text.SimpleDateFormat"
         import="java.util.Calendar" import="java.util.Date" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("yyyyMMdd"); %>
<%java.text.DateFormat df3 = new java.text.SimpleDateFormat("hhmmss"); %>
<%

    HttpSession sesion = request.getSession();
    String usua = "";
    if (sesion.getAttribute("usuario") != null) {
        usua = (String) sesion.getAttribute("usuario");
    } else {
        response.sendRedirect("index.jsp");
    }
%>
<% java.util.Calendar currDate = new java.util.GregorianCalendar();
    Class.forName("org.gjt.mm.mysql.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/ubicaciones", "root", "");
    // add 1 to month because Calendar's months start at 0, not 1
%>
<%
    //declaracion de variables-------------------------------------------------------------------------------------------------------------------
    String but = "";
    String fecha1 = "", fecha2 = "", mensaje = "";
//-------------------------------------------------------------------------------------------------------------------------------------------

    Statement stmt = null;
    ResultSet rset = null;
    stmt = conn.createStatement();

    Statement stmt2 = null;
    ResultSet rset2 = null;
    stmt2 = conn.createStatement();

    Calendar calendar = Calendar.getInstance();
//out.println("Fecha Actual: " + calendar.getTime());
    calendar.add(Calendar.MONTH, -1);
//out.println("Fecha antigua: " + df.format(calendar.getTime()));
    String fecha_act = "" + df.format(calendar.getTime());
    String d = "0";
    int dias = 0;

//out.print(folio);
//.................................................................
//---------------Llena la tabla de reabasteciminento---------------------
//-----------------------------------------------------------------------

%>
<html>
    <head>
        <link rel="stylesheet" href="mm_restaurant1.css" type="text/css"/>
        <link href="css/demo_table_jui.css" rel="stylesheet" type ="text/css"/>
        <link href="css/bootstrap.css" rel="stylesheet" type ="text/css"/>
        <script language="javascript" src="scw.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
        <script src ="js/jquery-1.6.1.min.js" type = "text/javascript" ></script>
        <script src ="js/jquery.dataTables.min.js" type =  "text/javascript" ></script>
        <script src="js/jquery.dataTables.columnFilter.js" type ="text/javascript"></script>
        <script src="js/jquery.dataTables.pagination.js" type="text/javascript"></script>
        <style type="text/css">
            /* BeginOAWidget_Instance_2586523: #dataTable */

            @import url("css/cupertino/jquery-ui-1.10.3.custom.css");
            #dataTable {
                padding: 0;
                margin: 0;
                width: 100%;
            }

            #dataTable_wrapper {
                width: 100%;
            }

            #dataTable_wrapper th {
                cursor: pointer
            }

            #dataTable_wrapper tr.odd {
                color: #333;
                background-color: #FFF
            }

            #dataTable_wrapper tr.odd:hover {
                color: #333;
                background-color: #FFF
            }

            #dataTable_wrapper tr.odd td.sorting_1 {
                color: #000;
                background-color: #FFF
            }

            #dataTable_wrapper tr.odd:hover td.sorting_1 {
                color: #000;
                background-color: #FFF
            }

            #dataTable_wrapper tr.even {
                color: #FFF;
                background-color: #666
            }

            #dataTable_wrapper tr.even:hover, tr.even td.highlighted {
                color: #EEE;
                background-color: #CCC
            }

            #dataTable_wrapper tr.even td.sorting_1 {
                color: #CCC;
                background-color: #333
            }

            #dataTable_wrapper tr.even:hover td.sorting_1 {
                color: #FFF;
                background-color: #000
            }

            /* EndOAWidget_Instance_2586523 */
            tam14 {
                font-size: 14px;
            }

            .negritas {
                font-weight: bold;
                text-align: center;
                font-size: 9px;
            }

            .rojo {
                color: #900;
            }

            .FECHA {
                font-size: 10px;
            }

            .gray {
                color: #CCC;
            }

            .gray strong {
                color: #FFF;
            }

            .neg2 {
                font-weight: bold;
            }

            .MAR {
                color: #2A0000;
            }

            .rr {
                color: #A00;
                font-size: 18px;
                font-weight: bold;
            }

        </style>
        <script type="text/xml">
            <!--
            <oa:widgets>
                <oa:widget wid="2586523" binding="#dataTable" />
            </oa:widgets>
            -->
        </script>
        <script>
            function CloseWin() {
                window.opener = top;
                window.close();
            }
        </script>
        <title>Reporte de Reabastecimiento</title>
    </head>
    <body>
        <div class="container">

            <h1>Catalogo de Insumos</h1>
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

            <div style="width:1000px; background-color:#FFF; padding:20px; margin:auto; font-family:Verdana, Geneva, sans-serif; font-size:10px">

                <table width="97%" border="0" cellpadding="2" cellspacing="0" id="dataTable">
                    <thead>
                        <tr>
                            <th colspan="10" class="FECHA">
                                <hr/>
                            </th>
                        </tr>
                        <tr>
                            <td class="FECHA"><Strong>Clave Cruzada</Strong></td>
                            <td style="text-align:left" class="FECHA"><Strong>Clave Dynamics</Strong></td>
                            <td class="FECHA"><Strong>Descripcion</Strong></td>
                            <td class="FECHA"><Strong>Presentacion</Strong></td>
                            <!--td><Strong>Cant. <br/>Autorizada</Strong></td>
                            <td><Strong>Observaciones</Strong></td-->
                        </tr>
                        <tr>
                            <th colspan="10" class="FECHA">
                                <hr/>
                            </th>
                        </tr>
                    </thead>
                    <%            String qry_clave = "select * from catalogo";
                        //out.print(qry_clave);

                        rset = stmt.executeQuery(qry_clave);
                        while (rset.next()) {
                            out.print("<tr>");
                            out.print("<td>" + rset.getString(1) + "</td>");
                            out.print("<td>" + rset.getString(2) + "</td>");
                            out.print("<td>" + rset.getString(3) + "</td>");
                            out.print("<td>" + rset.getString(4) + "</td>");
                            out.print("</tr>");
                        }
                    %>
                </table>
            </div>
        </div>
        <div class="navbar navbar-fixed-bottom navbar-inverse">
            <div class="text-center text-muted">
                GNK Logística<span class="glyphicon glyphicon-registration-mark"></span>
            </div>
        </div>
    </body>
</html>
<script type="text/javascript">
    // BeginOAWidget_Instance_2586523: #dataTable

    $(document).ready(function() {
        oTable = $('#dataTable').dataTable({
            "bJQueryUI": true,
            "bScrollCollapse": false,
            "sScrollY": "400px",
            "bAutoWidth": true,
            "bPaginate": true,
            "sPaginationType": "two_button", //full_numbers,two_button
            "bStateSave": true,
            "bInfo": true,
            "bFilter": true,
            "iDisplayLength": 25,
            "bLengthChange": true,
            "aLengthMenu": [
                [10, 25, 50, 100, -1],
                [10, 25, 50, 100, "Todos"]
            ]
        });
    });

    // EndOAWidget_Instance_2586523
</script>
<%
    // ----- try que cierra la conexión a la base de datos
    try {
        // Se cierra la conexión dentro del try
        conn.close();
    } catch (Exception e) {
        mensaje = e.toString();
    } finally {
        if (conn != null) {
            conn.close();
            if (conn.isClosed()) {
                mensaje = "desconectado2";
            }
        }
    }
                     //out.print(mensaje);
    // ---- fin de la conexión	 	  

%>
