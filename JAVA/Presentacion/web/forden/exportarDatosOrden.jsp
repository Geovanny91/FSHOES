<%@page import="com.fshoes.entidades.Material"%>
<%@page import="java.util.ArrayList"%>
<jsp:include page="../includes/cabecera_interna.jsp"></jsp:include>
<%@page import="com.fshoes.entidades.Trabajador" %>
<%@page import="com.fshoes.logicanegocio.MaterialLN" %>
<!-- page content -->

<%
    String usuario = "";
    HttpSession ses = request.getSession();
    if (ses.getAttribute("trabajador") != null) {
        Trabajador u = (Trabajador) ses.getAttribute("trabajador");
        usuario = u.getNombreCompleto();
    } else {
        response.sendRedirect("../index.html");
    }
%>
<!-- page content -->
<div class="right_col" role="main">

    <input type="button" id="btnExport" value=" Export Table data into Excel " />
    <br/>
    <br/>
    <div id="dvData">
        <label for="">ORDEN DE PRODUCCIÓN </label>
        <label for=""><img src="https://image.freepik.com/iconos-gratis/logo-freepik-en-version-negro_318-36111.png" alt="imagen" height="100" width="100"></label>

        <div class="row">
            <div class="col-md-6 col-sm-6 col-xs-12">
                <table class="table table-bordered">
                    <tr>
                        <th colspan="4" class="text-center">MATERIALES E INSUMOS</th>                        
                    </tr>
                    <tr>
                        <th colspan="4" class="text-center">Horario de despacho: 8:30 am y 6:00 pm</th>
                    </tr>
                    <tr>
                        <th>Nombre</th>
                        <th>Descripción</th>
                        <th>U. Medida</th>
                        <th>Cant. Docena</th>
                    </tr>

                    <%
                        String[] procesos = {"Corte", "Aparado", "Armado", "Alistado"};
                        ArrayList<Material> lstMaterial = new ArrayList<Material>();
                        lstMaterial = MaterialLN.Instancia().listarMaterial("F01", "listarMaterial");

                    %>

                    <% for (int p = 0; p < procesos.length; p++) {%>
                    <tr>
                        <th colspan="4" class="text-center"><%=procesos[p]%></th>
                    </tr>

                    <%    for (int i = 0; i < lstMaterial.size(); i++) {
                            if (lstMaterial.get(i).getObjProceso().getDescripcion().equals(procesos[p])) {
                    %>

                    <tr>
                        <td><%= lstMaterial.get(i).getNombre()%></td>
                        <td><%= lstMaterial.get(i).getDescripcion()%></td>
                        <td><%= lstMaterial.get(i).getUnidadmedida()%></td>
                        <td><%= lstMaterial.get(i).getCantidaddocena()%></td>
                    </tr>
                    <%}
                            }
                        }%>
                </table>
            </div>
                <div class="col-md-6 col-sm-6 col-xs-12">
                <table class="table table-bordered">
                    <tr>
                        <th colspan="4" class="text-center">ESPECIFICACIONES TÉCNICAS</th>                        
                    </tr>
                    <tr>
                        <td colspan="4">
                            <div class="center-block">
                                CORTADO
                                - Area de Material en uso de charol nude: 1,40 x 1,35
                                
                                APARADO
                                - COSTURAS: Utiizar ...
                                - BOTON: tomar en cuenta donde va el botón

                                ARMADO
                                - ENCHAPADO DE TACO: que quede bien sellado
                                - PLACA: poner ...
                                - Neolit: Filos Pintados
                            </div>
                        </td>                        

                    </tr>
                </table>
                    <table class="table table-bordered">
                    <tr>
                        <th class="text-center" colspan="4">PROCESO</th>                        
                    </tr>
                    <tr>
                        <th class="text-center" colspan="4">cierre de planilla Sábado 1 pm. (Trabajo TERMINADO Y ENTREGADO)</th>                        
                    </tr>
                    <tr>
                        <th>COLABORADOR</th>
                        <th>INICIO</th>
                        <th>TÉRMINO</th>
                        <th>V° B°</th>
                    </tr>
                    
                    <tr>
                        <td>CORTE</td>
                        <td>Tiempo máx</td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>APARADO</td>
                        <td>Tiempo máx</td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>ARMADO</td>
                        <td>Tiempo máx</td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>ALISTADO</td>
                        <td>Tiempo máx</td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                </table>
            </div>
        </div>

    </div>

    <!-- /page content -->
    <jsp:include page="../includes/pie_interno.jsp"></jsp:include>

    <script src="../js/jquery.base64.min.js"></script>