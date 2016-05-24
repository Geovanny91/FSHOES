/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fshoes.servlets;

import com.fshoes.accesodatos.ModeloAD;
import com.fshoes.entidades.Material;
import com.fshoes.entidades.Proveedor;
import com.fshoes.logicanegocio.MaterialLN;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author Geovanny
 */
@WebServlet(name = "Smaterial", urlPatterns = {"/Smaterial"})
public class Smaterial extends HttpServlet {

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
        Material objMaterial = null;
        Proveedor objProveedor = null;

        switch (parametro) {
            case "listarMaterial": {
                try {
                    ArrayList<Material> lista = new ArrayList<>();
                    int inicio = Integer.parseInt(request.getParameter("start")),
                            fin = Integer.parseInt(request.getParameter("length"));
                    lista = MaterialLN.Instancia().listarMaterial("", parametro, inicio, (fin + inicio));//getListPersonajes(n_col, dir, inicio, fin);//base de datos
                    JSONArray array = new JSONArray();
                    array.addAll(lista);
                    StringWriter outjson = new StringWriter();

                    int total = MaterialLN.Instancia().obtenerTotalFilas(valor, "obtenerTotal");
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
                    ex.printStackTrace();
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
