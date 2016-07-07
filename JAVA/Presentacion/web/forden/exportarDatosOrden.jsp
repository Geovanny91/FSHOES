<%@page import="com.fshoes.logicanegocio.MaterialLN"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.fshoes.entidades.Material" %>
<!DOCTYPE html>
<html lang="es">

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Meta, title, CSS, favicons, etc. -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1">

        <title>FHOES System</title>
        
    </head>


    <body>

        <!-- page content -->
        <div class="contenedor">

            <!--<div class="elemento elemento1">1</div>
            <div class="elemento elemento2">2</div>
            <div class="elemento elemento3">3</div>-->



            <input type="button" id="btnExport" value=" Export Table data into Excel " />
            <br/>
            <br/>
            <div id="dvData" style="width: 100%;
                 height: 100%;
                 background: #fff;

                 border:  10px solid #2C3E50 ;


                 display: -webkit-flex;
                 display: flex;/**inline-flex*/
                 display: -ms-flexbox;
                 flex-wrap: wrap;/*adapta a los elementos hijos, al ancho del padre*/
                 flex-direction: row;

                 justify-content: flex-start;
                 align-items: flex-start;">


                <div style="margin: 5px;    
                     /*height: 50px;*/
                     width: 48%;

                     text-align: center;">
                    <table id="tablaexportar" border="1|0"><!--agregar un atrr con jquery al a tabla para un rowspan y juntar todo-->
                        <tr>
                            <th colspan="4" class="text-center" style="background-color: #a3cce2;">MATERIALES E INSUMOS</th>
                            <th colspan="4" class="text-center" style="background-color: #a3cce2;">ESPECIFICACIONES TÉCNICAS</th>
                        </tr>
                        
                        <tr>
                            <th colspan="4" class="text-center" style="background-color: #ddd7d0;">Horario de despacho: 8:30 am y 6:00 pm</th>
                        <!--ESPECIFICACIONES-->
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
                            <!-- FIN ESPECIFICACIONES-->
                        </tr>
                        
                        
                        <tr>
                            <th>Nombre</th>
                            <th>Descripción</th>
                            <th>U. Medida</th>
                            <th>Cant. Docena</th>
                            <!--PROCESOS-->
                            <th class="text-center" colspan="4" style="background-color: #a3cce2;">PROCESO</th>                            
                            <!--FIN PROCESOS-->
                        </tr>

                        <%
                            String[] procesos = {"Corte", "Aparado", "Armado", "Alistado"};
                            ArrayList<Material> lstMaterial = new ArrayList<Material>();
                            lstMaterial = MaterialLN.Instancia().listarMaterial("F01", "listarMaterial");

                        %>

                        <% for (int p = 0; p < procesos.length; p++) {%>
                        <tr>
                            <th colspan="4" class="text-center" style="background-color: #f4c688;"><%=procesos[p]%></th>
                        </tr>

                        <%    for (int i = 0; i < lstMaterial.size(); i++) {
                                if (lstMaterial.get(i).getObjProceso().getDescripcion().equals(procesos[p])) {
                        %>

                        <tr>
                            <td><%= lstMaterial.get(i).getNombre()%></td>
                            <td><%= lstMaterial.get(i).getDescripcion()%></td>
                            <td><%= lstMaterial.get(i).getUnidadmedida()%></td>
                            <td><%= lstMaterial.get(i).getCantidaddocena()%></td>
                            <td></td>
                        </tr>
                        <%}
                                }
                            }%>
                                                
                    </table>
                </div>
                    <div style="margin: 5px;    
                     /*height: 50px;*/
                     width: 48%;

                     text-align: center;">
                    
                    <table border="1|0">
                        <tr>
                            <th class="text-center" colspan="4" style="background-color: #a3cce2;">PROCESO</th>                        
                        </tr>
                        <tr>
                            <th class="text-center" colspan="4" style="background-color: #ddd7d0;">cierre de planilla Sábado 1 pm. (Trabajo TERMINADO Y ENTREGADO)</th>                        
                        </tr>
                        <tr style="background-color: #f4c688;">
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
                <div style="margin: 5px;    
                     /*height: 50px;*/
                     width: 100%;

                     text-align: center;">
                    ELEMENTO 3 O TABLA 3
                </div>

            </div>
        </div>
        <!-- /page content -->
        <jsp:include page="../includes/pie_interno.jsp"></jsp:include>

        <script src="../js/jquery.base64.min.js"></script>