/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fshoes.servlets;

import com.fshoes.entidades.Proveedor;
import com.fshoes.logicanegocio.ProveedorLN;
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
@WebServlet(name = "Sproveedor", urlPatterns = {"/Sproveedor"})
public class Sproveedor extends HttpServlet {

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
            out.println("<title>Servlet Sproveedor</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Sproveedor at " + request.getContextPath() + "</h1>");
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
        ArrayList<Proveedor> lista = new ArrayList<>();
        boolean rptProveedor;
        Proveedor objProveedor;
        
        String valor = request.getParameter("valor");
        String parametro = request.getParameter("parametro");

        switch (parametro) {
            case "listarProveedor": {
                try {
                    lista = ProveedorLN.Instancia().listarProveedores(valor, parametro);
                    for (int i = 0; i < lista.size(); i++) {
                        out.println(
                                //"<tr id='cliente"+i+"' onclick='seleccionar(\"cliente"+i+"\");' ><th scope='row'>"+(i+1)+"</th>"+
                                "<tr  onclick='seleccionarProveedor(this);' ><th scope='row'>" + (i + 1) + "</th>"
                                + "<td><input class='id-proveedor' type='hidden' value='" + lista.get(i).getIdproveedor() + "' /></td>"
                                + "<td>" + lista.get(i).getRazonsocial() + "</td>"
                                + "<td>" + lista.get(i).getRuc() + "</td>"
                                + "<td>" + lista.get(i).getDireccion() + "</td>"
                                + "<td><a href='#' class=\"close\" data-dismiss=\"modal\" ><i class=\"fa fa-hand-o-left\"></i></a></td></tr>"
                        );
                    }
                } catch (Exception ex) {
                    ex.getMessage();
                }
            }break;
            case "registrarProveedor": {
                try {
                    String razon_social = request.getParameter("razon"),
                            ruc         = request.getParameter("ruc"),
                            direccion   = request.getParameter("direccion");
                    boolean estado      = Boolean.valueOf(request.getParameter("estado"));

                    objProveedor = new Proveedor(0, razon_social, ruc, direccion, estado);
                    rptProveedor = ProveedorLN.Instancia().registrarCliente(objProveedor, parametro);
                    out.println("Se registraron los datos?" + rptProveedor);
                } catch (Exception ex) {
                    ex.getMessage();
                }
            }
            break;
        }
    }

        /**
         * Returns a short description of the servlet.
         *
         * @return a String containing servlet description
         */
        @Override
        public String getServletInfo
        
            () {
        return "Short description";
        }// </editor-fold>

    }
