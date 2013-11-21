/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Clases.*;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Americo
 */
public class Principal extends HttpServlet {

    java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd");
    java.text.DateFormat df2 = new java.text.SimpleDateFormat("dd/MM/yyyy");

    AltaUsuarios alta = new AltaUsuarios();
    Login logueo = new Login();
    Modificaciones_Inven inven = new Modificaciones_Inven();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession sesion = request.getSession(true);
        String submit = request.getParameter("submit");
        int accion = Integer.parseInt(submit);
        switch (accion) {
            case 100://alta de usuarios
                alta.alta(request.getParameter("user"), request.getParameter("pass"), request.getParameter("pass2"), request.getParameter("rol"));
                response.sendRedirect("alta_usuarios.jsp");
                break;
            case 200://login
                String rol = logueo.login(request.getParameter("user"), request.getParameter("pass"));
                if (rol != null) {
                    sesion.setAttribute("usuario", request.getParameter("user"));
                    sesion.setAttribute("rol", rol);
                    response.sendRedirect("main_menu.jsp");
                } else {
                    sesion.setAttribute("mensaje", "Datos incorrectos");
                    response.sendRedirect("index.jsp");
                }
                break;
            case 501:
                try {
                    inven.insertar_registro(
                            request.getParameter("id_detins"),
                            request.getParameter("clave"),
                            request.getParameter("lote"),
                            df.format(df2.parse(request.getParameter("caducidad"))),
                            "2013-01-01",
                            "1",
                            request.getParameter("sector"),
                            request.getParameter("ubicacion"),
                            request.getParameter("cantidad"),
                            request.getParameter("piezas"),
                            (String) sesion.getAttribute("usuario"));
                } catch (Exception ex) {
                    System.out.println(ex.getMessage());
                }
                response.sendRedirect("agregar_clave.jsp");
                break;
            case 502:
                try {
                    inven.modificar_registro(
                            request.getParameter("id_detins"),
                            request.getParameter("clave"),
                            request.getParameter("lote"),
                            df.format(df2.parse(request.getParameter("caducidad"))),
                            "2013-01-01",
                            "1",
                            request.getParameter("sector"),
                            request.getParameter("ubicacion"),
                            request.getParameter("cantidad"),
                            request.getParameter("piezas"),
                            (String) sesion.getAttribute("usuario"));
                } catch (Exception ex) {
                    System.out.println(ex.getMessage());
                }
                response.sendRedirect("editar_clave.jsp?id_detins="+request.getParameter("id_detins"));
                break;
        }
        PrintWriter out = response.getWriter();
        try {
        } finally {
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
