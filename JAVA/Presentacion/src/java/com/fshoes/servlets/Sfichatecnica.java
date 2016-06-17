/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fshoes.servlets;

import com.fshoes.entidades.FichaTecnica;
import com.fshoes.logicanegocio.FichaTecnicaLN;
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
 * @author Flores
 */
@WebServlet(name = "Sfichatecnica", urlPatterns = {"/Sfichatecnica"})
public class Sfichatecnica extends HttpServlet {

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
            out.println("<title>Servlet Sfichatecnica</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Sfichatecnica at " + request.getContextPath() + "</h1>");
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

        String valor = request.getParameter("valor");
        String parametro = request.getParameter("parametro");

        String horma = request.getParameter("horma"),
                cod_modelo = request.getParameter("modelo"),
                especificacion = request.getParameter("especificacion"),
                idcliente = request.getParameter("idcliente"),
                id_fichatecnica = request.getParameter("id_fichatecnica"),
                taco = request.getParameter("taco"),
                plataforma = request.getParameter("plataforma"),
                color = request.getParameter("color");

        boolean estado = Boolean.valueOf(request.getParameter("estadomodelo"));

        ArrayList<FichaTecnica> listaFicha = null;

        switch (parametro) {
            case "listarFichaTecnica": {
                try {
                    listaFicha = FichaTecnicaLN.Instancia().listarFichaTecnica(valor, parametro);
                    for (int i = 0; i < listaFicha.size(); i++) {
                        out.println(
                                //"<tr id='cliente"+i+"' onclick='seleccionar(\"cliente"+i+"\");' ><th scope='row'>"+(i+1)+"</th>"+
                                "<tr  onclick='seleccionarFichaTecnica(this);' ><th scope='row'>" + (i + 1) + "</th>"
                                + "<td><input class='id_fichatecnica' type='hidden' value='" + listaFicha.get(i).getCodigoficha() + "' /></td>"
                                + "<td>" + listaFicha.get(i).getCodigoficha() + "</td>"
                                + "<td>" + listaFicha.get(i).getColor() + "</td>"
                                + "<td>" + listaFicha.get(i).getObjModelo().getHorma() + "</td>"
                                + "<td>" + listaFicha.get(i).getTaco() + "</td>"
                                + "<td>" + listaFicha.get(i).getPlataforma() + "</td>"
                                + "<td>" + listaFicha.get(i).getObjModelo().getObjcliente().getIdcliente()+ "</td>"
                                + "<td>" + listaFicha.get(i).getObjModelo().getObjcliente().getRazonsocial() + "</td>"
                                + "<td>" + listaFicha.get(i).getObjModelo().getCodigomodelo() + "</td>"
                                + "<td><a href='#' class=\"close\" data-dismiss=\"modal\" ><i class=\"fa fa-hand-o-left\"></i></a></td></tr>"
                        );
                    }
                } catch (Exception ex) {
                    ex.getMessage();
                }
            }
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
