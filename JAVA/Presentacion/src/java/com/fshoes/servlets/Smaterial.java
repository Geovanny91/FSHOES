/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fshoes.servlets;

import com.fshoes.accesodatos.ModeloAD;
import com.fshoes.entidades.FichaTecnica;
import com.fshoes.entidades.Material;
import com.fshoes.entidades.Modelo;
import com.fshoes.entidades.Proceso;
import com.fshoes.entidades.Proveedor;
import com.fshoes.logicanegocio.MaterialLN;
import com.fshoes.logicanegocio.ModeloLN;
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
        String nombre = null, descripccion = null, unidad_medida = null, cantidad_docena = null, precio_unitario = null, tipo = null, id_proveedor = null, id_proceso = null, id_ficha = null;
        if(parametro.equals("registrarMaterial")){        
            nombre = request.getParameter("nombre");
            descripccion = request.getParameter("descripcion");
            unidad_medida = request.getParameter("unidad_medida").trim();
            cantidad_docena = request.getParameter("cantidad_docena").replace(",", ".");
            precio_unitario = request.getParameter("precio_unitario").replace(",", ".");
            tipo = request.getParameter("tipo");            
            id_proveedor = request.getParameter("id_proveedor").trim();
            id_proceso = request.getParameter("id_proceso").trim();
            id_ficha = request.getParameter("id_fichatecnica").trim();
            //Comprobar id de campos enteros
            if(id_proveedor.equals("")) id_proveedor = "0";
            if(cantidad_docena.equals("")) cantidad_docena = "0";
            if(precio_unitario.equals("")) precio_unitario = "0";
        }
        boolean rptMaterial = false;
        Material objMaterial = null;
        Proveedor objProveedor = null;
        Proceso objProceso = null;
        FichaTecnica objFicha = null;        

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
            case "registrarMaterial":{
                try {
                    objProveedor = new Proveedor();
                    objProveedor.setIdproveedor(Integer.parseInt(id_proveedor));
                    objProceso = new Proceso();
                    objProceso.setCodigoproceso(id_proceso);
                    objFicha = new FichaTecnica();
                    objFicha.setCodigoficha(id_ficha);
                    
                    System.out.println(cantidad_docena + " " + precio_unitario);
                    
                    objMaterial = new Material(0, nombre, descripccion, unidad_medida, 
                            Float.parseFloat(cantidad_docena), 
                            Float.parseFloat(precio_unitario), 
                            tipo, objProveedor, objProceso, objFicha);
                    rptMaterial = MaterialLN.Instancia().registrarMaterial(objMaterial, parametro);
                    System.out.println("respuesta: " + rptMaterial);                    
                    if (rptMaterial) {
                        response.getWriter().write("true");
                        System.out.println("Respuesta modelo: " + rptMaterial);
                    } else {
                        response.getWriter().write("false");
                    }
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }break;
            case "obtenerMaterialesPorFichaTecnica": {
                try {
                    ArrayList<Material> lista = new ArrayList<>();
                    lista = MaterialLN.Instancia().obtenerMaterialesPorFichaTecnica(valor, parametro);
                    JSONArray array = new JSONArray();
                    array.addAll(lista);
                    StringWriter outjson = new StringWriter();
                    JSONObject json = new JSONObject();                    
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
