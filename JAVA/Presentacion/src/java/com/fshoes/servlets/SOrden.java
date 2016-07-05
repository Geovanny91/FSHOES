/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fshoes.servlets;

import com.fshoes.entidades.FichaTecnica;
import com.fshoes.entidades.Modelo;
import com.fshoes.entidades.Orden;
import com.fshoes.entidades.Serie;
import com.fshoes.logicanegocio.OrdenLN;
import com.fshoes.logicanegocio.SerieLN;
import java.io.IOException;
import java.io.PrintWriter;
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
                    String orden       = request.getParameter("orden").trim(),
                           pedido      = request.getParameter("pedido").trim(),
                           f_emision   = request.getParameter("f_emision").trim(),
                           f_entrega   =request.getParameter("f_entrega").trim(),
                           codigoficha = request.getParameter("id_fichatecnica").trim();
                    int    total       = Integer.parseInt(request.getParameter("total").trim());
                    
                    System.out.println("Detalle json: " + json_detalle_serie);
                    if( !json_detalle_serie.equals("{\"series\":[]}") ){
                        objFicha = new FichaTecnica();
                        objFicha.setCodigoficha(codigoficha);
                        Orden objOrden = new Orden(orden, pedido, f_emision, f_entrega, total, objFicha);
                        rptorden = OrdenLN.Instancia().registrarOrden(objOrden, parametro);
                        System.out.println("Registro Orden correcto? " + rptorden);
                        parametro = "registrarSerie";//modificar el parámentro
                        
                        rptSerie = decodicarJson(json_detalle_serie, objOrden, parametro);
                        parametro = "";//reset parametro
                    }                    
                    
                    if(rptorden == true && rptSerie == true)
                        out.println(true);
                    else if(rptSerie == false || rptorden == false)
                        response.getWriter().write("false");
                    //out.println(rptorden);
                    
                } catch (Exception ex) {
                    ex.getMessage();
                }
            }
            break;
        }
    }

    public boolean decodicarJson(String cadena_json, Orden objOrden, String parametro){
        JSONParser serie_parser = new JSONParser();
        boolean rptSerie = false;
        Serie objSerie;
        try {
            System.out.println("DECODE\n");
            JSONObject objSeries = (JSONObject) serie_parser.parse(cadena_json.toString());
            //System.out.println("Data Obtenida: "+ objSeries);
            JSONArray arrSerie =  (JSONArray) objSeries.get("series");
            System.out.println("Arreglo: " +arrSerie); 
            int cantidadTallas = 7;
            for(int i=0; i< cantidadTallas; i++){
                JSONObject serie = (JSONObject) arrSerie.get(0);
                talla = Integer.parseInt(serie.get("talla"+i).toString());
                pares = Integer.parseInt(serie.get("par"+i).toString());
                
                if(pares!=0){
                    objSerie = new Serie(0, talla, pares, objOrden);
                    try {
                        rptSerie = SerieLN.Instancia().registrarSerie(objSerie, parametro);
                        //System.out.println("Registro Serie correcto? " + i + " : "+rptSerie);
                    } catch (Exception ex) {
                        Logger.getLogger(SOrden.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    System.out.println("Talla: " + talla + " Pares: " + pares);
                }
                
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
            Logger.getLogger(SOrden.class.getName()).log(Level.SEVERE, null, ex);
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
