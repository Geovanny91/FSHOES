<%@page import="com.fshoes.entidades.Orden"%>
<%@page import="com.fshoes.logicanegocio.OrdenLN"%>
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
            <div id="entradas" id="dvData" style="width: 80%;
                 margin: 0 auto;
                 text-align: center;
                 padding: 10px;
                 height: 100%;
                 background: #fff;
                 border:  5px solid #2C3E50 ;">
                <input type="text" value="" name="cod_orden" id="cod_orden" placeholder="Ingresar Orden"/>
                <input type="button" id="boton" value="Click" />
                <input type="button" id="btnExport" value=" Exportar a Excel" />
            </div>
            
            <br/>
            <br/>
            <div id="dvData" style="width: 80%;
                 margin: 0 auto;
                 height: 100%;
                 background: #fff;
                 border:  7px solid #2C3E50 ;">

                <div id="tabla_formato">

                </div>

                

            </div>
        </div>
        <!-- /page content -->

        <script src="../js/jquery.min.js"></script>
        <script src="../js/jquery.base64.min.js"></script>
        <script>

            $(document).on("ready", function () {

                //pintarCabecera();
                imprimirFormarto();
                //pintarTabla();
                exportarOrden();
            });

            var imprimirFormarto = function () {
                $("#boton").on("click", function () {
                    
                    var cod_orden = $("#cod_orden").val();
                    console.log(cod_orden);
                    $.ajax({
                        method: "POST",
                        url: "../SOrden",
                        data: {"parametro": "cabeceraOrden", "cod_orden": cod_orden}
                    }).done(function (data) {                        
                        if( data === "vacio"){
                            $("#tabla_formato").html("<p>Tabla vacia, código de orden incorrecto o no existe.</p>");
                            console.log("tabla vacio, el código de orden no existe");
                        }else{
                            $("#tabla_formato").html("");
                            $("#tabla_formato").append(data);
                            pintarTabla( cod_orden );//pasar como parametro en JSON para la espeecificacióneee
                            $("#tabla_formato").hide();
                            $("#tabla_formato").show("medium");
                        }
                    });
                });
            }

            var pintarTabla = function ( cod_orden ) {
                var hola = $("#pintarTablita tbody");
                console.log(hola);
                var fila_empieza_especificacion = 10;
                var numero_fila = fila_empieza_especificacion + 22;//si se suma "algo" a 32
                /*var firstRow = document.getElementById("tabla").rows[ fila_empieza_especificacion ];
                 var x = firstRow.insertCell(1);
                 x.innerHTML = "CORTAOD: blaa ....  APARADO: blaa ...  ARMADO: blaa ...";//contenido de las ESPECIFICACIONES TÉCNICAS
                 
                 
                 //var hola = $("#pintarTablita tbody");
                 console.log(hola);
                 //console.log(hola[0].children[2].cells[4].setAttribute("rowspan", "37"));
                 console.log(hola[0].children[ fila_empieza_especificacion ].cells[1].setAttribute("rowspan", numero_fila));
                 console.log(hola[0].children[ fila_empieza_especificacion ].cells[1].setAttribute("colspan", "4"));*/


                /*TABLA DE PROCESO*/

                var firstRow = document.getElementById("tabla").rows[numero_fila += 10 ];//se resta ese "algo" a 
                var x = firstRow.insertCell(4);
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

                console.log("ULTIMO N FILA D TABLA:" + numero_fila);

                var table = document.getElementById("tabla");                
                var row = table.insertRow(62);
                var cell = row.insertCell(0);                
                console.log(hola[0].children[ 62 ].cells[0].setAttribute("colspan", 8));//agregando linea vacia
                
                row = table.insertRow(63);
                cell = row.insertCell(0);
                cell.innerHTML = "CORTADO O.P N° "+cod_orden;//contenido de las ESPECIFICACIONES TÉCNICAS
                cell = row.insertCell(1);                
                cell.innerHTML = "APARADO O.P N° "+cod_orden;                
                cell = row.insertCell(2);
                cell.innerHTML = "ARMADO O.P N° "+cod_orden;
                cell = row.insertCell(3);                
                cell.innerHTML = "ALISTADO O.P N°"+cod_orden;

                console.log(hola[0].children[ 63 ].cells[0].setAttribute("colspan", 2));
                console.log(hola[0].children[ 63 ].cells[1].setAttribute("colspan", 2));
                console.log(hola[0].children[ 63 ].cells[2].setAttribute("colspan", 2));
                console.log(hola[0].children[ 63 ].cells[3].setAttribute("colspan", 2));                
                
                row = table.insertRow(64);                
                console.log(hola[0].children[ 63 ].cells[0].setAttribute("rowspan", 2));
                console.log(hola[0].children[ 63 ].cells[1].setAttribute("rowspan", 2));
                console.log(hola[0].children[ 63 ].cells[2].setAttribute("rowspan", 2));
                console.log(hola[0].children[ 63 ].cells[3].setAttribute("rowspan", 2));
                //aplicando tamaño
                console.log(hola[0].children[ 63 ].cells[0].setAttribute("style", "font-size: 30px; text-align: center;"));
                console.log(hola[0].children[ 63 ].cells[1].setAttribute("style", "font-size: 30px; text-align: center;"));
                console.log(hola[0].children[ 63 ].cells[2].setAttribute("style", "font-size: 30px; text-align: center;"));
                console.log(hola[0].children[ 63 ].cells[3].setAttribute("style", "font-size: 30px; text-align: center;"));
                

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