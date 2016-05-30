/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fshoes.servlets;

import com.fshoes.entidades.DetalleOrden;
import com.fshoes.entidades.Orden;
import com.fshoes.entidades.Trabajador;
import com.fshoes.logicanegocio.DetalleOrdenLN;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author flores
 */
@WebServlet(name = "Sdetalleorden", urlPatterns = {"/Sdetalleorden"})
public class Sdetalleorden extends HttpServlet {

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
            out.println("<title>Servlet Sdetalleorden</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Sdetalleorden at " + request.getContextPath() + "</h1>");
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
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();               

        String parametro = request.getParameter("parametro");
        String valor = request.getParameter("valor");
        
        /*Parámetros*/
        String codigoorden = request.getParameter("idorden"),
                idempleado = request.getParameter("idtrabajador"),
                estado = request.getParameter("estado");
        /*Fin Parámetros*/
        
        ArrayList<DetalleOrden> lista = null;
        DetalleOrden objDetalleOrden = null;
        boolean rptDetalleOrden; 
        
        switch (parametro) {
            case "listarDetalleOrden": {
                try {                    
                    lista = new ArrayList<DetalleOrden>();                    
                    lista = DetalleOrdenLN.Instancia().listarDetalleOrden(valor, parametro);
                    for (int i = 0; i < lista.size(); i++) {
                        out.println(
                                "<tr' ><th scope='row'>" + (i + 1) + "</th>"                                
                                + "<td>" + lista.get(i).getObjOrden().getCodigoorden() + "</td>"
                                + "<td>" + lista.get(i).getObjTrabajador().getNombreCompleto() + "</td>"
                                + "<td>" + lista.get(i).getObjTrabajador().getCodigoproceso().getDescripcion() + "</td>"
                                + "<td>" + lista.get(i).isEstado() + "</td>"
                                + "<td><a href='#' class=\"close\" data-dismiss=\"modal\" ><i class=\"fa fa-check\"></i></a></td></tr>"
                        );
                    }
                } catch (Exception ex) {
                    ex.getMessage();
                }
            }break;
            case "asignarOrden":{
                try {
                    Orden objOrden = new Orden();
                    objOrden.setCodigoorden(codigoorden);
                    Trabajador objTrabajador = new Trabajador();
                    objTrabajador.setIdempleado(Integer.parseInt(idempleado));
                    objDetalleOrden = new DetalleOrden(objOrden, objTrabajador, Boolean.parseBoolean(estado));                    
                    rptDetalleOrden =  DetalleOrdenLN.Instancia().asignarOrden(objDetalleOrden, parametro);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }break;
        }
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
