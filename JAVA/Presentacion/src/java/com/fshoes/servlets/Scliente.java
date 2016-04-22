/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fshoes.servlets;

import com.fshoes.entidades.Cliente;
import com.fshoes.logicanegocio.ClienteLN;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author flores
 */
@WebServlet(name = "Scliente", urlPatterns = {"/Scliente"})
public class Scliente extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Scliente</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Scliente at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        //processRequest(request, response);
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();        
        ArrayList<Cliente> lista = new ArrayList<>();
        String valor = request.getParameter("valor");
        try {
            lista = ClienteLN.Instancia().listarClientes(valor);
            
            for (int i = 0; i < lista.size(); i++) {
                out.println(
                        "<tr><th scope='row'>"+(i+1)+"</th>"+
                        "<td>"+lista.get(i).getRazonsocial()+"</td>"+
                        "<td>"+lista.get(i).getRuc()+"</td>"+
                        "<td>"+lista.get(i).getDireccion()+"</td>"+                        
                        "<td><a href='#'><i class=\"fa fa-hand-o-left\"></i></a></td></tr>"                
                );
            }            
        } catch (Exception ex) {
            Logger.getLogger(Scliente.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        
        /*try {
            lista = ClienteLN.Instancia().listarClientes();
            for (int i = 0; i < lista.size(); i++) {
                out.println("<option value='"+lista.get(i).getCodigoproceso()+"'>"+lista.get(i).getDescripcion()+"</option>");                
            }            
        } catch (Exception ex) {
            ex.getMessage();
        } */
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
