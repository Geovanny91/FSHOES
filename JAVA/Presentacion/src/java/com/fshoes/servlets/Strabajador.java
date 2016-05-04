/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fshoes.servlets;

import com.fshoes.entidades.Proceso;
import com.fshoes.entidades.Trabajador;
import com.fshoes.logicanegocio.TrabajadorLN;
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
@WebServlet(name = "Strabajador", urlPatterns = {"/Strabajador"})
public class Strabajador extends HttpServlet {

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
            out.println("<title>Servlet Strabajador</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Strabajador at " + request.getContextPath() + "</h1>");
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
       // processRequest(request, response);
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        ArrayList<Trabajador> lista = new ArrayList<>();
        boolean rptTrabajador;
        Trabajador objTrabajador;
        
        String valor = request.getParameter("valor");
        String parametro = request.getParameter("parametro");

        switch (parametro) {
            case "listarTrabajador": {
                /*try {
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
                }*/
            }break;
            case "registrarTrabajador": {
                try {
                    String  dni = request.getParameter("dni"),
                            nombres = request.getParameter("nombres"),
                            ape_paterno = request.getParameter("ape_paterno"),
                            ape_materno = request.getParameter("ape_materno"),
                            direccion = request.getParameter("direccion"),
                            telefono = request.getParameter("telefono"),
                            celular = request.getParameter("celular"),
                            fecha_nacimiento = request.getParameter("fecha_nacimiento"),
                            usuario = request.getParameter("usuario"),
                            contrasena = request.getParameter("contrasena"),                            
                            codigoproceso = request.getParameter("proceso");
                    boolean estado = true;
                    
                    Proceso objproceso = new Proceso();
                            objproceso.setCodigoproceso(codigoproceso);
                    
                    objTrabajador = new Trabajador(0, dni, nombres, ape_paterno, ape_materno, direccion, telefono, celular, fecha_nacimiento, usuario, contrasena, estado, objproceso);
                    rptTrabajador = TrabajadorLN.Instancia().registrarTrabajador(objTrabajador, parametro);
                    if(rptTrabajador) out.println(rptTrabajador);
                    else    out.append(null);
                } catch (Exception ex) {
                    ex.getMessage();
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
