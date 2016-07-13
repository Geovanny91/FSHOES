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
              
                <div id="pintarTablita" style="margin: 5px;    
                     /*height: 50px;*/
                     width: 70%;

                     text-align: center;">
                    <table id="tabla" border="1"><!--agregar un atrr con jquery al a tabla para un rowspan y juntar todo-->
                        
                        <!---->
                        <tr>
				<td colspan='2' rowspan='2'>IMAGEN</td>
				<td colspan='2' style="color: #1b69b7; text-align: center;"><b>ORDEN DE PRODUCCIÓN N°</b></td>
							
				<td rowspan='2' colspan='2' style="color: #1b69b7; text-align: center; width: 50px;"><b>026 - V</b></td>				
				<td style="text-align: center;">FECHA EMISIÓN</td>
				<td style="text-align: center;">27/01/2016</td>
				
						</tr>

				<tr>
				
				<td style="text-align: center;"><b>ORD. PED. N°</b></td>
				<td style="text-align: center;">1604</td>				
				<td style="text-align: center;">FECHA ENTREGA</td>
				<td style="text-align: center;">29/01/2016</td>
				
						</tr>
                                                <tr>
                                                    <td colspan="6"></td>
                                                </tr>
				<tr>
				<td style="text-align: center;"><b>MODELO</b></td>
				<td style="text-align: center;">2G04</td>				
				<td style="text-align: center;"><b>COLOR</b></td>
				<td style="text-align: center;">CHAROL NUDE</td>
				<td style="text-align: center;"><b>CLIENTE</b></td>
				<td style="text-align: center;">VILMA</td>
						</tr>
                                                <tr>
                                                    <td colspan="6"></td>
                                                </tr>
				<tr>
				<td style="text-align: center;"><b>HORMA</b></td>
				<td style="text-align: center;">50763</td>				
				<td ></td>
				<td style="text-align: center;">SERIE
                                    <!--<div id="contenido_zapatos" style="width: 100%;">
                                        <div id="serie" style="display: inline-flex;">
                                            <div style="width: 40px; border: 1px solid black;">35</div>
                                            <div style="width: 40px; border: 1px solid black;">36</div>
                                            <div style="width: 40px; border: 1px solid black;">37</div>
                                            <div style="width: 40px; border: 1px solid black;">38</div>
                                            <div style="width: 40px; border: 1px solid black;">39</div>
                                            <div style="width: 40px; border: 1px solid black;">40</div>
                                        </div>
                                        <div id="pares" style="display: inline-flex;">
                                            <div style="width: 40px; border: 1px solid black;">0</div>
                                            <div style="width: 40px; border: 1px solid black;">0</div>
                                            <div style="width: 40px; border: 1px solid black;">5</div>
                                            <div style="width: 40px; border: 1px solid black;">5</div>
                                            <div style="width: 40px; border: 1px solid black;">5</div>
                                            <div style="width: 40px; border: 1px solid black;">5</div>
                                        </div>
                                    </div>-->
				<!--<table border='1' >
					<tr style="text-align: center;">
					<th width='50px'>35</th>
                                        <th width='50px'>36</th>
                                        <th width='50px'>37</th>
                                        <th width='50px'>38</th>
                                        <th width='50px'>39</th>
                                        <th width='50px'>40</th>
					<th >Total</th>
					</tr>
					<tr style="text-align: center;">
					<td rowspan='2'>0</td>
					<td rowspan='2'>5</td>
					<td rowspan='2'>5</td>
					<td rowspan='2'>5</td>
					<td rowspan='2'>5</td>
					<td rowspan='2'>0</td>
 					<td rowspan='2'>20</td>
					</tr>
					<tr>
					
					</tr>
				</table>-->
				</td>
                                
                                <td rowspan='3' colspan='2'>
                                    
				<table border='1' >
					<tr style="text-align: center;">
					<th width='50px'>35</th>
                                        <th width='50px'>36</th>
                                        <th width='50px'>37</th>
                                        <th width='50px'>38</th>
                                        <th width='50px'>39</th>
                                        <th width='50px'>40</th>
					<th >Total</th>
					</tr>
					<tr style="text-align: center;">
					<td rowspan='2'>0</td>
					<td rowspan='2'>5</td>
					<td rowspan='2'>5</td>
					<td rowspan='2'>5</td>
					<td rowspan='2'>5</td>
					<td rowspan='2'>0</td>
 					<td rowspan='2'>20</td>
					</tr>
					<tr>
					
					</tr>
				</table>
				</td>
                                
				
						</tr>

				<tr>
				<td style="text-align: center;"><b>TACO</b></td>
				<td style="text-align: center;">9T252PL30</td>				
				<td></td>
				<td rowspan='2' style="text-align: center;">PARES</td>				
						</tr>

				<tr>
                                    <td style="text-align: center;"><b>PLATAF.</b></td>
				<td style="text-align: center;">30PL19</td>				
							
						</tr>
                                                <tr>
                                                    <td colspan="6"></td>
                                                </tr>
                        <!--FIN CABECERA-->
                        
                        <tr>
                            <th colspan="4" class="text-center" style="background-color: #a3cce2;">MATERIALES E INSUMOS</th>
                            <th colspan="4" class="text-center" style="background-color: #a3cce2;">ESPECIFICACIONES TÉCNICAS</th>
                        </tr>                        
                        <tr>
                            <th colspan="4" class="text-center" style="background-color: #ddd7d0;">Horario de despacho: 8:30 am y 6:00 pm</th>                        
                        </tr>                        
                        <tr>
                            <th>Nombre</th>
                            <th>Descripción</th>
                            <th>U.M.</th>
                            <th>CANT. por doc</th>                            
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
                            <!--<td>< i%></td>
                            <td>< i%></td>
                            <td>< i%></td>
                            <td>< i%></td>-->
                            <td><%= lstMaterial.get(i).getNombre()%></td>
                            <td><%= lstMaterial.get(i).getDescripcion()%></td>
                            <td style="text-align: center;"><%= lstMaterial.get(i).getUnidadmedida()%></td>
                            <td style="text-align: center;"><%= lstMaterial.get(i).getCantidaddocena()%></td>

                        </tr>
                        <%}
                            }
                            }%>

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

        <script src="../js/jquery.min.js"></script>
        <script src="../js/jquery.base64.min.js"></script>
        <script>

            $(document).on("ready", function () {
                
                //pintarCabecera();
                pintarTabla();
                exportarOrden();
            });
            
            var pintarTabla = function () {


                
                var hola = $("#pintarTablita tbody");
                console.log(hola);
                var fila_empieza_especificacion = 10;
                var numero_fila = fila_empieza_especificacion + 22 ;//si se suma "algo" a 32
                var firstRow = document.getElementById("tabla").rows[ fila_empieza_especificacion ];
                var x = firstRow.insertCell(1);
                x.innerHTML = "CORTAOD: blaa ....  APARADO: blaa ...  ARMADO: blaa ...";//contenido de las ESPECIFICACIONES TÉCNICAS


                //var hola = $("#pintarTablita tbody");
                console.log(hola);
                //console.log(hola[0].children[2].cells[4].setAttribute("rowspan", "37"));
                console.log(hola[0].children[ fila_empieza_especificacion ].cells[1].setAttribute("rowspan", numero_fila));
                console.log(hola[0].children[ fila_empieza_especificacion ].cells[1].setAttribute("colspan", "4"));


                /*TABLA DE PROCESO*/

                firstRow = document.getElementById("tabla").rows[numero_fila +=10 ];//se resta ese "algo" a 
                x = firstRow.insertCell(4);
                x.innerHTML = "PROCESO";//APLICAR COLSPAN
                console.log(hola[0].children[numero_fila].cells[4].setAttribute("colspan", "4"));
                console.log(hola[0].children[ numero_fila ].cells[4].style.backgroundColor = "#a3cce2");

                firstRow = document.getElementById("tabla").rows[numero_fila += 1];
                x = firstRow.insertCell(4);
                x.innerHTML = "CIERRE DE PLANILLA Sábado 1 p.m (Trabajdo Terminado y Entregado)";//APLICAR COLSPAN
                console.log(hola[0].children[numero_fila].cells[4].setAttribute("colspan", "4")); 
                console.log(hola[0].children[ numero_fila ].cells[4].style.backgroundColor = "#ddd7d0");
                
                firstRow = document.getElementById("tabla").rows[numero_fila += 1];
                x = firstRow.insertCell(4);
                x.innerHTML = "COLABORADOR";
                x = firstRow.insertCell(5);
                x.innerHTML = "INICIO";
                x = firstRow.insertCell(6);
                x.innerHTML = "TERMINO";
                x = firstRow.insertCell(7);
                x.innerHTML = "VB";
                console.log(hola[0].children[ numero_fila ].cells[4].style.backgroundColor = "#f4c688");
                console.log(hola[0].children[ numero_fila ].cells[5].style.backgroundColor = "#f4c688");
                console.log(hola[0].children[ numero_fila ].cells[6].style.backgroundColor = "#f4c688");
                console.log(hola[0].children[ numero_fila ].cells[7].style.backgroundColor = "#f4c688");
                
                //OBJETO PROCESOS
                var proceso = {
                    "nombre": "", "tiempo": "", "limpiar": function () {
                        this.nombre = "";
                        this.tiempo = "";
                    }
                };

                //CORTE
                firstRow = document.getElementById("tabla").rows[numero_fila += 1];
                proceso.nombre = "CORTE";
                proceso.tiempo = "Tiempo max.";
                insertarFilas(firstRow, proceso);
                proceso.limpiar();

                firstRow = document.getElementById("tabla").rows[numero_fila += 1];
                insertarFilas(firstRow, proceso)
                unirFilas(hola, numero_fila);

                //APARADO
                firstRow = document.getElementById("tabla").rows[numero_fila += 3];
                proceso.nombre = "APARADO";
                proceso.tiempo = "Tiempo max.";
                insertarFilas(firstRow, proceso);
                proceso.limpiar();

                firstRow = document.getElementById("tabla").rows[numero_fila += 1];
                insertarFilas(firstRow, proceso);
                unirFilas(hola, numero_fila);

                //ARMADO
                firstRow = document.getElementById("tabla").rows[numero_fila += 3];
                proceso.nombre = "ARMADO";
                proceso.tiempo = "Tiempo max.";
                insertarFilas(firstRow, proceso);
                proceso.limpiar();

                firstRow = document.getElementById("tabla").rows[numero_fila += 1];
                insertarFilas(firstRow, proceso);
                unirFilas(hola, numero_fila);

                //ALISTADO
                firstRow = document.getElementById("tabla").rows[numero_fila += 3];
                proceso.nombre = "ALISTADO";
                proceso.tiempo = "Tiempo max.";
                insertarFilas(firstRow, proceso);
                proceso.limpiar();

                firstRow = document.getElementById("tabla").rows[numero_fila += 1];
                insertarFilas(firstRow, proceso);
                unirFilas(hola, numero_fila);

            }

            var insertarFilas = function (firstRow, proceso) {
                var x = firstRow.insertCell(4);
                x.innerHTML = proceso.nombre;//APLICAR COLSPAN		    
                x = firstRow.insertCell(5);
                x.innerHTML = proceso.tiempo;
                x = firstRow.insertCell(6);
                x.innerHTML = "";
                x = firstRow.insertCell(7);
                x.innerHTML = "";
            }

            var unirFilas = function (hola, numero_fila) {
                console.log(hola[0].children[numero_fila].cells[4].setAttribute("rowspan", 3));
                console.log(hola[0].children[numero_fila].cells[5].setAttribute("rowspan", 3));
                console.log(hola[0].children[numero_fila].cells[6].setAttribute("rowspan", 3));
                console.log(hola[0].children[numero_fila].cells[7].setAttribute("rowspan", 3));
            }

            function exportarOrden() {
                $("#btnExport").click(function (e) {
                    e.preventDefault();
                    //getting data from our table
                    var data_type = 'data:application/vnd.ms-excel;base64';//"base64", para los caracteres raros
                    var table_div = document.getElementById('dvData');
                    console.log(table_div.outerHTML);
                    //var table_html = table_div.outerHTML.replace(/ /g, '%20');
                    var table_html = table_div.outerHTML;
                    var a = document.createElement('a');
                    //a.href = data_type + ',' + $.base64.encode(table_html);
                    a.href = data_type + ',' + $.base64.encode(table_html);//se debe agregar un js base 64 de jquery
                    a.download = 'exported_table_' + Math.floor((Math.random() * 9999999) + 1000000) + '.xls';
                    a.click();
                });
            }
        </script>
    </body>
</html>