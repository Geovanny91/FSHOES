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
        //varificar los id, con campos vacios.
        if(idcliente.equals("")) idcliente = "0";
        
        boolean rptModelo = false;
        Modelo objModelo = null;
        Cliente objCliente = null;
        ArrayList<Modelo> lista = null;

        switch (parametro) {
            case "listarModelo":{
                try {
                    lista = ModeloLN.Instancia().listarModelos(valor, parametro);
                    for (int i = 0; i < lista.size(); i++) {
                        out.println(
                                //"<tr id='cliente"+i+"' onclick='seleccionar(\"cliente"+i+"\");' ><th scope='row'>"+(i+1)+"</th>"+
                                "<tr  onclick='seleccionarModelo(this);' ><th scope='row'>" + (i + 1) + "</th>"
                                + "<td><input class='id_modelo' type='hidden' value='" + lista.get(i).getCodigomodelo()+ "' /></td>"
                                + "<td>" + lista.get(i).getCodigomodelo()+ "</td>"
                                + "<td>" + lista.get(i).getHorma() + "</td>"
                                + "<td>" + lista.get(i).getTaco() + "</td>"
                                + "<td>" + lista.get(i).getPlataforma() + "</td>"
                                + "<td>" + lista.get(i).getColeccion()+ "</td>"
                                + "<td>" + lista.get(i).getObjcliente().getRazonsocial()+ "</td>"
                                + "<td><a href='#' class=\"close\" data-dismiss=\"modal\" ><i class=\"fa fa-hand-o-left\"></i></a></td></tr>"
                        );
                    }
                } catch (Exception ex) {
                    ex.getMessage();
                }
            }
            break;
            case "listarModeloPaginacion": {//aqui con paginacion arreglart parámetro
                try {
                    lista = new ArrayList<>();
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
                } catch (Exception ex) {
                    Logger.getLogger(Smodelo.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            break;
            case "modificarModelo": {
                try {
                    objCliente = new Cliente();
                    objCliente.setIdcliente(Integer.parseInt(idcliente));
                    objModelo = new Modelo(cod_modelo, "", horma, taco, plataforma, coleccion, especificacion, objCliente, estado);
                    rptModelo = ModeloLN.Instancia().modificarModelo(objModelo, parametro);
                    //out.println(rptModelo);
                    if (rptModelo) {
                        response.getWriter().write("true");
                    } else {
                        response.getWriter().write("false");
                    }
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
