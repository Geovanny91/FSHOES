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
import com.fshoes.logicanegocio.OrdenLN;
import com.fshoes.logicanegocio.ProcesoLN;
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
        String codigoorden = request.getParameter("orden"),
                idempleado = request.getParameter("cbotrabajador"),
                codigoproceso = request.getParameter("cboproceso");
        //estado = request.getParameter("estado");
        /*Fin Parámetros*/

        ArrayList<DetalleOrden> lista = null;
        DetalleOrden objDetalleOrden = null;
        boolean rptDetalleOrden;

        switch (parametro) {
            case "listarDetalleOrden": {
                try {
                    //lista = new ArrayList<DetalleOrden>();
                    String icon;
                    int existe_orden = 0;
                    existe_orden = OrdenLN.Instancia().existeOrden(valor, "verificarOrden");// valor contigo código de orden

                    if (existe_orden > 0) {

                        lista = DetalleOrdenLN.Instancia().listarDetalleOrden(valor, parametro);
                        if (lista.size() != 0) {
                            for (int i = 0; i < lista.size(); i++) {
                                if (lista.get(i).isEstado()) {
                                    icon = "<a href=\"#/smile-o\"><i class=\"fa fa-smile-o\" style=\"font-size:20px;\" ></i></a>";
                                } else {
                                    icon = "<a href=\"#/clock-o\"><i class=\"fa fa-clock-o\" style=\"font-size:20px;\"></i></a>";
                                }

                                out.println(
                                        "<tr class=\"text-center\" ><th scope='row'>" + (i + 1) + "</th>"
                                        + "<td>" + lista.get(i).getObjOrden().getCodigoorden() + "</td>"
                                        + "<td>" + lista.get(i).getObjTrabajador().getNombreCompleto() + "</td>"
                                        + "<td>" + lista.get(i).getObjTrabajador().getCodigoproceso().getDescripcion() + "</td>"
                                        + "<td>" + icon + "</td>"
                                        + "<td><a onclick='terminarProcesoOrden(this);' href=\"#/check\"><i class=\"fa fa-check\" style=\"font-size:20px;\" ></i></a></td></tr>"
                                );
                            }
                        } else {
                            response.getWriter().append("vacio");
                        }
                    } else {
                        response.getWriter().write("noexisteorden");
                    }

                } catch (Exception ex) {
                    ex.getMessage();
                }
            }
            break;
            case "asignarOrden": {
                try {
                    int existe_orden = 0, evaluar_rango_procesos = 0, existe_proceso_en_detalleorden = 0;
                    existe_orden = OrdenLN.Instancia().existeOrden(codigoorden, "verificarOrden");
                    // ya esta listo el codigo de proceso, solo mandar como parámetro.

                    if (existe_orden > 0) {
                        evaluar_rango_procesos = ProcesoLN.Instancia().evaluarRangoProcesos(codigoproceso, "evaluarRangoProcesos");
                        if (evaluar_rango_procesos > 0) {
                            existe_proceso_en_detalleorden = DetalleOrdenLN.Instancia().existeProcesosEnDetalleOrden(codigoproceso, codigoorden, "verificarProcesosOrden");
                            if (existe_proceso_en_detalleorden > 0) {
                                response.getWriter().write("existe_proceso_en_detalleorden");
                            } else {
                                Orden objOrden = new Orden();
                                objOrden.setCodigoorden(codigoorden);
                                Trabajador objTrabajador = new Trabajador();
                                objTrabajador.setIdempleado(Integer.parseInt(idempleado));
                                objDetalleOrden = new DetalleOrden(objOrden, objTrabajador, false);
                                rptDetalleOrden = DetalleOrdenLN.Instancia().asignarOrden(objDetalleOrden, parametro);
                                if (rptDetalleOrden) {
                                    response.getWriter().write("true");
                                } else {
                                    response.getWriter().write("false");
                                }
                            }
                        } else {
                            response.getWriter().write("proceso_no_adeacudo");
                        }

                    } else {
                        response.getWriter().write("noexisteorden");
                    }

                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            break;
            case "terminarProcesoOrden": {//aquí, solo se actulizada el estado del detalle orden, de acuerdo a un proceso cuncluído.
                try {
                    Orden objOrden = new Orden();
                    objOrden.setCodigoorden(codigoorden);
                    objDetalleOrden = new DetalleOrden();
                    objDetalleOrden.setObjOrden(objOrden);
                    objDetalleOrden.setEstado(true);//para indicar que ya se completo el proceso de la orden
                    rptDetalleOrden = DetalleOrdenLN.Instancia().terminarProcesoOrden(objDetalleOrden, parametro);
                    if (rptDetalleOrden) {
                        response.getWriter().append("true");
                    } else {
                        response.getWriter().append("false");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
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
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
