package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class index_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");

    HttpSession sesion = request.getSession();

      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html lang=\"en\">\n");
      out.write("  <head>\n");
      out.write("    <meta charset=\"utf-8\">\n");
      out.write("    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\n");
      out.write("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n");
      out.write("    <meta name=\"description\" content=\"\">\n");
      out.write("    <meta name=\"author\" content=\"\">\n");
      out.write("    <link rel=\"shortcut icon\" href=\"imagen/favicon.ico\">\n");
      out.write("\n");
      out.write("    <title>Generacion de Etiquetas</title>\n");
      out.write("\n");
      out.write("    <!-- Bootstrap core CSS -->\n");
      out.write("    <link href=\"css/bootstrap.css\" rel=\"stylesheet\">\n");
      out.write("\n");
      out.write("    <!-- Custom styles for this template -->\n");
      out.write("    <link href=\"css/singnin.css\" rel=\"stylesheet\">\n");
      out.write("\n");
      out.write("    <!-- Just for debugging purposes. Don't actually copy this line! -->\n");
      out.write("    <!--[if lt IE 9]><script src=\"../../docs-assets/js/ie8-responsive-file-warning.js\"></script><![endif]-->\n");
      out.write("\n");
      out.write("    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->\n");
      out.write("    <!--[if lt IE 9]>\n");
      out.write("      <script src=\"https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js\"></script>\n");
      out.write("      <script src=\"https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js\"></script>\n");
      out.write("    <![endif]-->\n");
      out.write("  </head>\n");
      out.write("\n");
      out.write("  <body>\n");
      out.write("\n");
      out.write("    <div class=\"container\">\n");
      out.write("\n");
      out.write("      <form class=\"form-signin\" action=\"Principal\" method=\"POST\">\n");
      out.write("        <h2 class=\"form-signin-heading\">Ingrese sus Datos</h2>\n");
      out.write("        <input type=\"text\" class=\"form-control\" placeholder=\"Usuario\" name=\"user\" required autofocus>\n");
      out.write("        <input type=\"password\" class=\"form-control\" placeholder=\"Contraseña\" name=\"pass\" required>\n");
      out.write("        <button class=\"btn btn-lg btn-primary btn-block\" type=\"submit\" name=\"submit\" value=\"200\">Entrar</button>\n");
      out.write("      </form>\n");
      out.write("\n");
      out.write("    </div> <!-- /container -->\n");
      out.write("\n");
      out.write("\n");
      out.write("    <!-- Bootstrap core JavaScript\n");
      out.write("    ================================================== -->\n");
      out.write("    <!-- Placed at the end of the document so the pages load faster -->\n");
      out.write("  </body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
