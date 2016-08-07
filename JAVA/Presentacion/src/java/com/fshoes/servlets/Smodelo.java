/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fshoes.servlets;

import com.fshoes.entidades.Cliente;
import com.fshoes.entidades.FichaTecnica;
import com.fshoes.entidades.Modelo;
import com.fshoes.logicanegocio.FichaTecnicaLN;
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
                especificacion = request.getParameter("especificacion"),
                url_imagen = request.getParameter("url_imagen"),
                idcliente = request.getParameter("idcliente"),
                ficha_tecnica = request.getParameter("ficha_tecnica"),
                taco = request.getParameter("taco"),
                plataforma = request.getParameter("plataforma"),
                color = request.getParameter("color"),
                coleccion = request.getParameter("coleccion");

        boolean estado = Boolean.valueOf(request.getParameter("estadomodelo"));
        /*//varificar los id, con campos vacios.
        if(idcliente.equals("")) idcliente = "0";*/

        boolean rptModelo = false, rptFicha = false;
        Modelo objModelo = null;
        Cliente objCliente = null;
        ArrayList<FichaTecnica> listaFicha = null;
        ArrayList<Modelo> lista = null;

        switch (parametro) {
            case "listarModelo": {
                try {
                    lista = ModeloLN.Instancia().listarModelos(valor, parametro);
                    for (int i = 0; i < lista.size(); i++) {
                        out.println(
                                //"<tr id='cliente"+i+"' onclick='seleccionar(\"cliente"+i+"\");' ><th scope='row'>"+(i+1)+"</th>"+
                                "<tr  onclick='seleccionarModelo(this);' ><th scope='row'>" + (i + 1) + "</th>"
                                + "<td><input class='id_modelo' type='hidden' value='" + lista.get(i).getCodigomodelo() + "' /></td>"
                                + "<td>" + lista.get(i).getCodigomodelo() + "</td>"
                                + "<td>" + lista.get(i).getHorma() + "</td>"
                                + "<td>" + lista.get(i).getObjcliente().getRazonsocial() + "</td>"
                                + "<td><a href='#' class=\"close\" data-dismiss=\"modal\" ><i class=\"fa fa-hand-o-left\"></i></a></td></tr>"
                        );
                    }
                } catch (Exception ex) {
                    ex.getMessage();
                }
            }
            break;
            case "listarFichaTecnicaPaginacion": {//aqui por modelo
                try {
                    String codigo_modelo = request.getParameter("codigo_modelo");
                    int existe_modelo = 0;
                    existe_modelo = ModeloLN.Instancia().existeModelo(codigo_modelo, "verificarModelo");
                    
                    if( existe_modelo > 0 ){                    
                        int inicio = Integer.parseInt(request.getParameter("start")),
                            fin = Integer.parseInt(request.getParameter("length"));                    

                        //listar por código de modelo, que irá en el parámetro valor
                        //lista = ModeloLN.Instancia().listarModelos("", parametro, inicio, (fin + inicio));//getListPersonajes(n_col, dir, inicio, fin);//base de datos
                        listaFicha = FichaTecnicaLN.Instancia().listarFichaTecnica(codigo_modelo, parametro, inicio, (inicio + fin));
                        JSONArray array = new JSONArray();
                        array.addAll(listaFicha);
                        StringWriter outjson = new StringWriter();

                        int total = FichaTecnicaLN.Instancia().obtenerTotalFilas(codigo_modelo, "obtenerTotal");
                        int draw = Integer.parseInt(request.getParameter("draw"));

                        JSONObject json = new JSONObject();
                        json.put("draw", draw);
                        json.put("recordsTotal", total);//consulta BD
                        json.put("recordsFiltered", total);//es cuando hay busquedas
                        json.put("data", array);
                        json.writeJSONString(outjson);
                        out.println(outjson);
                        System.out.println(outjson);
                    }else{
                        response.getWriter().write("no_existe_modelo");
                    }
                } catch (Exception ex) {
                    Logger.getLogger(Smodelo.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            break;
            case "registrarModelo": {
                try {
                    int existe_modelo = 0, existe_ficha = 0;
                    if (idcliente.equals("")) {
                        idcliente = "0";
                    }

                    objCliente = new Cliente();
                    objCliente.setIdcliente(Integer.parseInt(idcliente));
                    objModelo = new Modelo(cod_modelo, horma, especificacion, objCliente, estado);
                    FichaTecnica objFicha = new FichaTecnica(ficha_tecnica, plataforma, taco, color, coleccion, url_imagen, objModelo);
                    
                    //Validando si existen modelos o fichas tecnicas, antes de registrar en la BD.
                    existe_modelo = ModeloLN.Instancia().existeModelo(cod_modelo, "verificarModelo");
                    existe_ficha = FichaTecnicaLN.Instancia().existeFichaTecnica(ficha_tecnica, "verificarFichaTecnicoa");                    
                    
                    if (existe_modelo == 1) {
                        response.getWriter().write("existe");
                    } else{                        
                        if(existe_ficha == 1)
                            response.getWriter().write("existe_ficha");
                        else{                        
                            if (!objFicha.getCodigoficha().equals("")) {
                                rptModelo = ModeloLN.Instancia().registrarModelo(objModelo, parametro);
                                parametro = "registrarFichaTecnica";
                                rptFicha = FichaTecnicaLN.Instancia().registrarFichaTecnica(objFicha, parametro);
                            } if (rptModelo == true && rptFicha == true) {
                                response.getWriter().write("true");
                                System.out.println("Respuesta modelo: " + rptModelo + ", Respuesta ficha: " + rptFicha);
                            } else {
                                response.getWriter().write("false");
                            }
                        }
                    }
                } catch (Exception ex) {
                    Logger.getLogger(Smodelo.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            break;
            case "modificarModelo": {
                try {
                    //varificar los id, con campos vacios.
                    if (idcliente.equals("")) {
                        idcliente = "0";
                    }

                    objCliente = new Cliente();
                    objCliente.setIdcliente(Integer.parseInt(idcliente));
                    objModelo = new Modelo(cod_modelo, horma, especificacion, objCliente, estado);
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
