/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fshoes.servlets;

import com.fshoes.entidades.FichaTecnica;
import com.fshoes.entidades.Material;
import com.fshoes.entidades.Modelo;
import com.fshoes.entidades.Proceso;
import com.fshoes.entidades.Proveedor;
import com.fshoes.logicanegocio.FichaTecnicaLN;
import com.fshoes.logicanegocio.MaterialLN;
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
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

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
                id_fichatecnica = request.getParameter("id_fichatecnica"),
                taco = request.getParameter("taco"),
                plataforma = request.getParameter("plataforma"),
                color = request.getParameter("color"),
                cod_modelo = request.getParameter("modelo"),
                coleccion = request.getParameter("coleccion"),
                idcliente = request.getParameter("idcliente"),
                especificacion = request.getParameter("especificacion");
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
                                //+ "<td>" + listaFicha.get(i).getObjModelo().getObjcliente().getIdcliente() + "</td>"
                                + "<td>" + listaFicha.get(i).getObjModelo().getObjcliente().getRazonsocial() + "</td>"
                                + "<td>" + listaFicha.get(i).getObjModelo().getCodigomodelo() + "</td>"
                                + "<td><a href='#' class=\"close\" data-dismiss=\"modal\" ><i class=\"fa fa-hand-o-left\"></i></a></td></tr>"
                        );
                    }
                } catch (Exception ex) {
                    ex.getMessage();
                }
            }
            break;
            case "obtenerFichaTecnica": {
                try {
                    ArrayList<FichaTecnica> lista = new ArrayList<>();
                    lista = FichaTecnicaLN.Instancia().listarFichaTecnica(valor, parametro);
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
            case "registrarMaterialesDeNuevaFichaTecnica": {
                int existeFicha  = 0, rptFichaTecnica = 0;
                ArrayList<Material> arrayMaterial = null;
                try {
                    String json_materiales = "";
                    json_materiales = request.getParameter("datos");
                    System.out.println("Materiales json: " + json_materiales);

                    if (!json_materiales.equals("{\"arreglo\":[]}")) {
                        Modelo objModelo = new Modelo();
                        objModelo.setCodigomodelo(cod_modelo);
                        //si se quiere registrar una ficha tecnica nueva, se tiene que cambiar el código, aqui validar id_fichaTecnica
                        existeFicha = FichaTecnicaLN.Instancia().existeFichaTecnica(id_fichatecnica, "verificarFichaTecnica" );                        
                        if(existeFicha > 0)  response.getWriter().append("existe_ficha");
                        else{
                            FichaTecnica objFicha = new FichaTecnica(id_fichatecnica, plataforma, taco, color, coleccion, "url", objModelo);                        
                            arrayMaterial = new ArrayList<Material>();
                            arrayMaterial = decodicarJson(json_materiales, objFicha);
                            rptFichaTecnica = FichaTecnicaLN.Instancia().transaccion(objFicha, arrayMaterial);//evaluar esto no deberia registrarse ver, lo de rollback
                        }
                    }

                    if ( rptFichaTecnica == 1 ) response.getWriter().write("true");
                    
                } catch (Exception ex) {
                    ex.getMessage();
                }
            }
            break;
            case "modificarMaterialesDeFichaTecnica": {

            }
            break;
        }
    }

    public ArrayList<Material> decodicarJson(String cadena_json, FichaTecnica objFicha) {
        JSONParser serie_parser = new JSONParser();
        ArrayList<Material> lstMaterial = null;        
        try {
            System.out.println("DECODE\n");
            JSONObject objMateriales = (JSONObject) serie_parser.parse(cadena_json.toString());
            //System.out.println("Data Obtenida: "+ objMateriales);
            JSONArray arrMateriales = (JSONArray) objMateriales.get("arreglo");
            System.out.println("Arreglo materiales: " + arrMateriales);
            System.out.println("TaMAÑO Arreglo materiales: " + arrMateriales.size());
            lstMaterial = new ArrayList<>();
            Material objMaterial = null;
            Proveedor objProveedor = null;
            Proceso objProceso = null;
            for (int i = 0; i < arrMateriales.size(); i++) {
                JSONObject serie = (JSONObject) arrMateriales.get(i);
                System.out.println(serie.get("descripcion") + " - " + serie.get("nombre"));
                String nombre = serie.get("nombre").toString(),
                        descripcion = serie.get("descripcion").toString(),
                        unidadmedida = serie.get("unidadmedida").toString(),
                        tipo = serie.get("tipo").toString(),
                        codigoficha = serie.get("codigoficha").toString(),
                        codigoproceso = serie.get("codigoproceso").toString();
                Long idproveedor = Long.parseLong(serie.get("idproveedor").toString());
                float preciounitario = Float.parseFloat(serie.get("preciounitario").toString()),
                        cantidaddocena = Float.parseFloat(serie.get("cantidaddocena").toString());

                objProveedor = new Proveedor();
                objProveedor.setIdproveedor(idproveedor);
                objProceso = new Proceso();
                objProceso.setCodigoproceso(codigoproceso);
                objMaterial = new Material(0, nombre, descripcion, unidadmedida, preciounitario, preciounitario, tipo, objProveedor, objProceso, objFicha);
                
                lstMaterial.add(objMaterial);
            }
             
        } catch (ParseException ex) {
            ex.printStackTrace();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return lstMaterial;
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
