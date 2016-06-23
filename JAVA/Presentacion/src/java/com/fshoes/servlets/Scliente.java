/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fshoes.servlets;

import com.fshoes.entidades.Cliente;
import com.fshoes.logicanegocio.ClienteLN;
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
@WebServlet(name = "Scliente", urlPatterns = {"/Scliente"})
public class Scliente extends HttpServlet {

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
            out.println("<title>Servlet Scliente</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Scliente at " + request.getContextPath() + "</h1>");
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
        ArrayList<Cliente> lista = null;
        boolean rptCliente;
        Cliente objCliente;

        String parametro = request.getParameter("parametro");
        String valor = request.getParameter("valor");

        switch (parametro) {
            case "listarClientePaginacion": {
                try {                    
                    int inicio = Integer.parseInt(request.getParameter("start")),
                            fin = Integer.parseInt(request.getParameter("length"));
                    lista = new ArrayList<>();
                    lista = ClienteLN.Instancia().listarClientes("", parametro, inicio,(inicio + fin));
                    JSONArray array = new JSONArray();
                    array.addAll(lista);
                    StringWriter outjson = new StringWriter();

                    int total = ClienteLN.Instancia().obtenerTotalFilas(valor, "obtenerTotal");
                    int draw = Integer.parseInt(request.getParameter("draw"));

                    JSONObject json = new JSONObject();
                    json.put("draw", draw);
                    json.put("recordsTotal", total);
                    json.put("recordsFiltered", total);//es cuando hay busquedas
                    json.put("data", array);
                    json.writeJSONString(outjson);
                    out.println(outjson);
                    System.out.println(outjson);
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }break;
            case "listarCliente": {
                try {
                    lista = new ArrayList<>();
                    lista = ClienteLN.Instancia().listarClientes(valor, parametro);
                    for (int i = 0; i < lista.size(); i++) {
                        out.println(
                                "<tr  onclick='seleccionarCliente(this);' ><th scope='row'>" + (i + 1) + "</th>"
                                + "<td><input class='idcliente' type='hidden' value='" + lista.get(i).getIdcliente() + "' /></td>"
                                + "<td>" + lista.get(i).getRazonsocial() + "</td>"
                                + "<td>" + lista.get(i).getRuc() + "</td>"
                                + "<td>" + lista.get(i).getDireccion() + "</td>"
                                + "<td><a href='#' class=\"close\" data-dismiss=\"modal\" ><i class=\"fa fa-hand-o-left\"></i></a></td></tr>"
                        );
                    }
                } catch (Exception ex) {
                    ex.getMessage();
                }
            }
            break;
            case "registrarCliente": {
                try {
                    String razon_social = request.getParameter("razon"),
                            ruc = request.getParameter("ruc"),
                            direccion = request.getParameter("direccion");
                    boolean estado = Boolean.valueOf(request.getParameter("estado"));

                    objCliente = new Cliente(0, razon_social, ruc, direccion, estado);
                    rptCliente = ClienteLN.Instancia().registrarCliente(objCliente, parametro);
                    
                    if(rptCliente)  response.getWriter().write("true");
                    else response.getWriter().write("false");
                    
                } catch (Exception ex) {
                    ex.getMessage();
                }
            }
            break;
        }

        /*try {
            lista = ClienteLN.Instancia().listarClientes();
            for (int i = 0; i < lista.size(); i++) {
                out.println("<option value='"+lista.get(i).getCodigoproceso()+"'>"+lista.get(i).getDescripcion()+"</option>");                
            }            
        } catch (Exception ex) {
            ex.getMessage();
        } */
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
