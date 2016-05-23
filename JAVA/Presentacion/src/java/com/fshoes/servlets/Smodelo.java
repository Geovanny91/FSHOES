/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fshoes.servlets;

import com.fshoes.entidades.Cliente;
import com.fshoes.entidades.Modelo;
import com.fshoes.logicanegocio.ModeloLN;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
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

/**
 *
 * @author flores
 */
@WebServlet(name = "Smodelo", urlPatterns = {"/Smodelo"})
public class Smodelo extends HttpServlet {

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
            out.println("<title>Servlet Smodelo</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Smodelo at " + request.getContextPath() + "</h1>");
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

        String valor = request.getParameter("valor");
        String parametro = request.getParameter("parametro");

        String horma = request.getParameter("horma"),
                cod_modelo = request.getParameter("modelo"),
                taco = request.getParameter("taco"),
                plataforma = request.getParameter("plataforma"),
                coleccion = request.getParameter("coleccion"),
                especificacion = request.getParameter("especificacion"),
                idcliente = request.getParameter("idcliente");
        boolean estado = Boolean.valueOf(request.getParameter("estadomodelo"));
        
        boolean rptModelo = false;
        Modelo objModelo = null;
        Cliente objCliente = null;

        switch (parametro) {
            case "listarModelo": {
                try {
                    ArrayList<Modelo> lista = new ArrayList<>();
                    int inicio = Integer.parseInt(request.getParameter("start")),
                            fin = Integer.parseInt(request.getParameter("length"));
                    lista = ModeloLN.Instancia().listarModelos("", parametro, inicio, (fin + inicio));//getListPersonajes(n_col, dir, inicio, fin);//base de datos
                    JSONArray array = new JSONArray();
                    array.addAll(lista);
                    StringWriter outjson = new StringWriter();

                    int total = ModeloLN.Instancia().obtenerTotalFilas(valor, "obtenerTotal");
                    int draw = Integer.parseInt(request.getParameter("draw"));

                    JSONObject json = new JSONObject();
                    json.put("draw", draw);
                    json.put("recordsTotal", total);//consulta BD
                    json.put("recordsFiltered", total);//es cuando hay busquedas
                    json.put("data", array);
                    json.writeJSONString(outjson);
                    out.println(outjson);
                    System.out.println(outjson);
                } catch (Exception ex) {
                    Logger.getLogger(Smodelo.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            break;

            case "registrarModelo": {
                try {
                    objCliente = new Cliente();
                    objCliente.setIdcliente(Integer.parseInt(idcliente));
                    objModelo = new Modelo(cod_modelo, "", horma, taco, plataforma, coleccion, especificacion, objCliente, estado);
                    rptModelo = ModeloLN.Instancia().registrarModelo(objModelo, parametro);
                    //out.println(rptModelo);
                    if (rptModelo) {
                        response.getWriter().write("true");
                        System.out.println("Respuesta modelo: " + rptModelo);
                    } else {
                        response.getWriter().write("false");
                    }
                    /*cod_modelo = null;
                    horma=null;
                    taco=null;
                    plataforma=null;
                    coleccion=null;
                    especificacion=null;
                    objCliente=null;
                    estado=false;*/
                } catch (Exception ex) {
                    Logger.getLogger(Smodelo.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            break;
            case "modificarModelo": {
                try {
                    /* objCliente = new Cliente();
                    objCliente.setIdcliente(Integer.parseInt(idcliente));
                    objModelo = new Modelo(cod_modelo, "", horma, taco, plataforma, coleccion, especificacion, objCliente, estado);
                    rptModelo = ModeloLN.Instancia().modificarModelo(objModelo, parametro);
                    //out.println(rptModelo);
                    if (rptModelo) {
                        response.getWriter().write("true");
                    } else {
                        response.getWriter().write("false");
                    }*/
                } catch (Exception ex) {
                    Logger.getLogger(Smodelo.class.getName()).log(Level.SEVERE, null, ex);
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
