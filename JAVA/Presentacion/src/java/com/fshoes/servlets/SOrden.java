/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fshoes.servlets;

import com.fshoes.entidades.FichaTecnica;
import com.fshoes.entidades.Material;
import com.fshoes.entidades.Modelo;
import com.fshoes.entidades.Orden;
import com.fshoes.entidades.Serie;
import com.fshoes.logicanegocio.MaterialLN;
import com.fshoes.logicanegocio.OrdenLN;
import com.fshoes.logicanegocio.SerieLN;
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
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

/**
 *
 * @author flores
 */
@WebServlet(name = "SOrden", urlPatterns = {"/SOrden"})
public class SOrden extends HttpServlet {

    int talla, pares;

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
            out.println("<title>Servlet SOrden</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SOrden at " + request.getContextPath() + "</h1>");
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

        String parametro = request.getParameter("parametro");
        String valor = request.getParameter("valor");
        //boolean rptorden = false, rptSerie = false;
        //AQUI VAMOS A PROBAR EL DETALLE DE SERIES
        String json_detalle_serie = request.getParameter("detalle");//Aqui ver esto posiblemente ya no salen las notificaciones por la cache
        //System.out.println("Detalle json: " + json_detalle_serie);

        FichaTecnica objFicha = null;

        switch (parametro) {
            case "listarSerie": {
                /*try {
                    lista = ClienteLN.Instancia().listarClientes(valor, parametro);
                    for (int i = 0; i < lista.size(); i++) {
                        out.println(
                                "<tr  onclick='seleccionar(this);' ><th scope='row'>" + (i + 1) + "</th>"
                                + "<td><input class='id-cliente' type='hidden' value='" + lista.get(i).getIdcliente() + "' /></td>"
                                + "<td>" + lista.get(i).getRazonsocial() + "</td>"
                                + "<td>" + lista.get(i).getRuc() + "</td>"
                                + "<td>" + lista.get(i).getDireccion() + "</td>"
                                + "<td><a href='#' class=\"close\" data-dismiss=\"modal\" ><i class=\"fa fa-hand-o-left\"></i></a></td></tr>"
                        );
                    }
                } catch (Exception ex) {
                    ex.getMessage();
                }*/
            }
            break;
            case "registrarOrden": {
                boolean rptorden = false, rptSerie = false;
                try {
                    String orden = request.getParameter("orden").trim(),
                            pedido = request.getParameter("pedido").trim(),
                            f_emision = request.getParameter("f_emision").trim(),
                            f_entrega = request.getParameter("f_entrega").trim(),
                            codigoficha = request.getParameter("id_fichatecnica").trim();
                    int total = Integer.parseInt(request.getParameter("total").trim());

                    System.out.println("Detalle json: " + json_detalle_serie);
                    if (!json_detalle_serie.equals("{\"series\":[]}")) {
                        objFicha = new FichaTecnica();
                        objFicha.setCodigoficha(codigoficha);
                        Orden objOrden = new Orden(orden, pedido, f_emision, f_entrega, total, objFicha);
                        rptorden = OrdenLN.Instancia().registrarOrden(objOrden, parametro);
                        System.out.println("Registro Orden correcto? " + rptorden);
                        parametro = "registrarSerie";//modificar el parámentro

                        rptSerie = decodicarJson(json_detalle_serie, objOrden, parametro);
                        parametro = "";//reset parametro
                    }

                    if (rptorden == true && rptSerie == true) {
                        out.println(true);
                    } else if (rptSerie == false || rptorden == false) {
                        response.getWriter().write("false");
                    }
                    //out.println(rptorden);

                } catch (Exception ex) {
                    ex.getMessage();
                }
            }
            break;
            case "cabeceraOrden": {

                String cod_orden = request.getParameter("cod_orden");
                try {
                    ArrayList<Orden> lstOrden = new ArrayList<Orden>();

                    System.out.println("ORDEN OBTNIDA: " + cod_orden.trim());
                    lstOrden = OrdenLN.Instancia().listarCaberaOrden(cod_orden, parametro);

                    out.println(
                            "<div id='pintarTablita' style='margin: 5px; width: 70%; text-align: center;'>"
                            + "<table id='tabla' border='1'>"
                            + "<tr>"
                            + "<td colspan='2' rowspan='2'>IMAGEN</td>"
                            + "<td colspan='2' style='color: #1b69b7; text-align: center;'><b>ORDEN DE PRODUCCIÓN N°</b></td>"
                            + "<td rowspan='2' colspan='2' style='color: #1b69b7; text-align: center; width: 50px;'><b>" + lstOrden.get(0).getCodigoorden() + "</b></td>"
                            + "<td style='text-align: center;'>FECHA EMISIÓN</td>"
                            + "<td style='text-align: center;'>" + lstOrden.get(0).getFecha_emision() + "</td>"
                            + "</tr>"
                            + "<tr>"
                            + "<td style='text-align: center;'><b>ORD. PED. N°</b></td>"
                            + "<td style='text-align: center;'>1604</td>"
                            + "<td style='text-align: center;'>FECHA ENTREGA</td>"
                            + "<td style='text-align: center;'>" + lstOrden.get(0).getFecha_entrega() + "</td>"
                            + "</tr>"
                            + "<tr>"
                            + "<td colspan='6'></td>"
                            + "</tr>"
                            + "<tr>"
                            + "<td style='text-align: center;'><b>MODELO</b></td>"
                            + "<td style='text-align: center;'>" + lstOrden.get(0).getObjFicha().getObjModelo().getCodigomodelo() + "</td>"
                            + "<td style='text-align: center;'><b>COLOR</b></td>"
                            + "<td style='text-align: center;'>" + lstOrden.get(0).getObjFicha().getColor() + "</td>"
                            + "<td style='text-align: center;'><b>CLIENTE</b></td>"
                            + "<td style='text-align: center;'>" + lstOrden.get(0).getObjFicha().getObjModelo().getObjcliente().getRazonsocial() + "</td>"
                            + "</tr>"
                            + "<tr>"
                            + "<td colspan='6'></td>"
                            + "</tr>"
                            + "<tr>"
                            + "<td style='text-align: center;'><b>HORMA</b></td>"
                            + "<td style='text-align: center;'>" + lstOrden.get(0).getObjFicha().getObjModelo().getHorma() + "</td>"
                            + "<td ></td>"
                            + "<td style='text-align: center;'>SERIE</td>"
                            + "<td rowspan='3' colspan='2'>"
                            + "<table border='1' >"
                            + "<tr style='text-align: center;'>"
                            + "<th width='50px'>35</th>"
                            + "<th width='50px'>36</th>"
                            + "<th width='50px'>37</th>"
                            + "<th width='50px'>38</th>"
                            + "<th width='50px'>39</th>"
                            + "<th width='50px'>40</th>"
                            + "<th >Total</th>"
                            + "</tr>"
                            + "<tr style='text-align: center;'>");
                    String orden = lstOrden.get(0).getCodigoorden();
                    ArrayList<Serie> lstSerie = new ArrayList<>();
                    lstSerie = SerieLN.Instancia().listarSeriePorOrden(orden, "listarSerie");
                    
                        out.println(
                            "<td rowspan='2'>"+ lstSerie.get(0).getPares()+"</td>"
                            + "<td rowspan='2'>"+ lstSerie.get(1).getPares()+"</td>"
                            + "<td rowspan='2'>"+ lstSerie.get(2).getPares()+"</td>"
                            + "<td rowspan='2'>"+ lstSerie.get(3).getPares()+"</td>"
                            + "<td rowspan='2'>"+ lstSerie.get(4).getPares()+"</td>"
                            + "<td rowspan='2'>"+ lstSerie.get(5).getPares()+"</td>"
                        ); 
                        out.println(
                             "<td rowspan='2'>"+ lstOrden.get(0).getTotal()+"</td>"
                            + "</tr>"
                            + "<tr></tr>"
                            + "</table>"
                            + "</td>"
                            + "</tr>"
                            + "<tr>"
                            + "<td style='text-align: center;'><b>TACO</b></td>"
                            + "<td style='text-align: center;'>9T252PL30</td>"
                            + "<td></td>"
                            + "<td rowspan='2' style='text-align: center;'>PARES</td>"
                            + "</tr>"
                            + "<tr>"
                            + "<td style='text-align: center;'><b>PLATAF.</b></td>"
                            + "<td style='text-align: center;'>" + lstOrden.get(0).getObjFicha().getPlataforma() + "</td>"
                            + "</tr>"
                            + "<tr>"
                            + "<td colspan='6'></td>"
                            + "</tr>"
                            + "<!--FIN CABECERA-->"
                            + "<tr>"
                            + "<th colspan='4' class='text-center' style='background-color: #a3cce2;'>MATERIALES E INSUMOS</th>"
                            + "<th colspan='4' class='text-center' style='background-color: #a3cce2;'>ESPECIFICACIONES TÉCNICAS</th>"
                            + "</tr>"
                            + "<tr>"
                            + "<th colspan='4' class='text-center' style='background-color: #ddd7d0;'>Horario de despacho: 8:30 am y 6:00 pm</th>"
                            + "<th colspan='4' rowspan='32' style='text-align: center;'>"+ lstOrden.get(0).getObjFicha().getObjModelo().getEspecificacion()+"</th>"
                            + "</tr>"
                            + "<tr>"
                            + "<th>Nombre</th>"
                            + "<th>Descripción</th>"
                            + "<th>U.M.</th>"
                            + "<th>CANT. por doc</th>"
                            + "</tr>"
                    );
                    String[] procesos = {"Corte", "Aparado", "Armado", "Alistado"};
                    ArrayList<Material> lstMaterial = new ArrayList<>();

                    String ficha_tecnica = lstOrden.get(0).getObjFicha().getCodigoficha();

                    lstMaterial = MaterialLN.Instancia().listarMaterial(ficha_tecnica, "listarMaterial");

                    for (int p = 0; p < procesos.length; p++) {
                        out.println("<tr>"
                                + "<th colspan='4' class='text-center' style='background-color: #f4c688;'>"+procesos[p]+"</th>"
                                + "</tr>");

                        for (int i = 0; i < lstMaterial.size(); i++) {
                            if (lstMaterial.get(i).getObjProceso().getDescripcion().equals(procesos[p])) {
                                out.println("<tr>"
                                        + "<td>" + lstMaterial.get(i).getNombre() + "</td>"
                                        + "<td>" + lstMaterial.get(i).getDescripcion() + "</td>"
                                        + "<td style='text-align: center;'>" + lstMaterial.get(i).getUnidadmedida() + "</td>"
                                        + "<td style='text-align: center;'>" + lstMaterial.get(i).getCantidaddocena() + "</td>"
                                        + "</tr>");
                            }
                        }
                    }
                    out.println(
                            "</table>"
                            + "</div>" //pintar tablita)
                    );

                } catch (Exception ex) {
                    Logger.getLogger(SOrden.class.getName()).log(Level.SEVERE, null, ex);
                }

            }
            break;
        }
    }

    public boolean decodicarJson(String cadena_json, Orden objOrden, String parametro) {
        JSONParser serie_parser = new JSONParser();
        boolean rptSerie = false;
        Serie objSerie;
        try {
            System.out.println("DECODE\n");
            JSONObject objSeries = (JSONObject) serie_parser.parse(cadena_json.toString());
            //System.out.println("Data Obtenida: "+ objSeries);
            JSONArray arrSerie = (JSONArray) objSeries.get("series");
            System.out.println("Arreglo: " + arrSerie);
            int cantidadTallas = 7;
            for (int i = 0; i < cantidadTallas; i++) {
                JSONObject serie = (JSONObject) arrSerie.get(0);
                talla = Integer.parseInt(serie.get("talla" + i).toString());
                pares = Integer.parseInt(serie.get("par" + i).toString());

                //if (pares != 0) {
                    objSerie = new Serie(0, talla, pares, objOrden);
                    try {
                        rptSerie = SerieLN.Instancia().registrarSerie(objSerie, parametro);
                        //System.out.println("Registro Serie correcto? " + i + " : "+rptSerie);
                    } catch (Exception ex) {
                        Logger.getLogger(SOrden.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    System.out.println("Talla: " + talla + " Pares: " + pares);
                //}

                /*objSerie = new Serie(0, talla, pares, objOrden);
                try {
                    rptSerie = SerieLN.Instancia().registrarSerie(objSerie, parametro);
                    //System.out.println("Registro Serie correcto? " + i + " : "+rptSerie);
                } catch (Exception ex) {
                    Logger.getLogger(SOrden.class.getName()).log(Level.SEVERE, null, ex);
                }*/
            }
            System.out.println("Respuesta final serie: " + rptSerie);
            return rptSerie;

        } catch (ParseException ex) {
            Logger.getLogger(SOrden.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return rptSerie;
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
