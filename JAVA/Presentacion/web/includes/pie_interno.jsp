</div>

</div>

<div id="custom_notifications" class="custom-notifications dsp_none">
    <ul class="list-unstyled notifications clearfix" data-tabbed_notifications="notif-group">
    </ul>
    <div class="clearfix"></div>
    <div id="notif-group" class="tabbed_notifications"></div>
</div>

<script src="../js/jquery.min.js"></script>
<script src="../js/nprogress.js"></script>
<script src="../js/bootstrap.min.js"></script>  
<!-- bootstrap progress js -->
<script src="../js/progressbar/bootstrap-progressbar.min.js"></script>
<!-- icheck -->
<script src="../js/icheck/icheck.min.js"></script>
<script src="../js/custom.js"></script>
<!-- daterangepicker -->
<script type="text/javascript" src="../js/moment/moment.min.js"></script>
<script type="text/javascript" src="../js/datepicker/daterangepicker.js"></script>

<!-- range slider -->
<script src="../js/ion_range/ion.rangeSlider.min.js"></script>
<!-- color picker -->
<script src="../js/colorpicker/bootstrap-colorpicker.min.js"></script>
<script src="../js/colorpicker/docs.js"></script>
<!-- PNotify -->
<script type="text/javascript" src="../js/notify/pnotify.core.js"></script>
<script type="text/javascript" src="../js/notify/pnotify.buttons.js"></script>
<script type="text/javascript" src="../js/notify/pnotify.nonblock.js"></script>

<!-- Datatables-->
<script src="../js/datatables/jquery.dataTables.min.js"></script>
<script src="../js/datatables/dataTables.bootstrap.js"></script>
<script src="../js/datatables/dataTables.buttons.min.js"></script>
<script src="../js/datatables/buttons.bootstrap.min.js"></script>
<script src="../js/datatables/jszip.min.js"></script>
<script src="../js/datatables/pdfmake.min.js"></script>
<script src="../js/datatables/vfs_fonts.js"></script>
<script src="../js/datatables/buttons.html5.min.js"></script>
<script src="../js/datatables/buttons.print.min.js"></script>
<script src="../js/datatables/dataTables.fixedHeader.min.js"></script>
<script src="../js/datatables/dataTables.keyTable.min.js"></script>
<script src="../js/datatables/dataTables.responsive.min.js"></script>
<script src="../js/datatables/responsive.bootstrap.min.js"></script>
<script src="../js/datatables/dataTables.scroller.min.js"></script>

<!-- Validator-->
<script src="../js/validator/validator.js"></script>


<script>
<!-- skycons -->
    < script src = "../js/skycons/skycons.min.js" ></script>
<script>
            var icons = new Skycons({
                "color": "#73879C"
            }),
            list = [
                "clear-day", "clear-night", "partly-cloudy-day",
                "partly-cloudy-night", "cloudy", "rain", "sleet", "snow", "wind",
                "fog"
            ],
            i;
    for (i = list.length; i--; )
        icons.set(list[i], list[i]);
    icons.play();</script>

<script type="text/javascript">
    $(document).ready(function () {
        logout();
        listarClientes();
        fechas("#f_emision");
        fechas("#f_entrega");
        registrarcliente();
        registrarProveedor();
        orden();
        comboProceso();
        asignarOrdenTrabajadorProceso();

        listarModelosPaginacion();
        editarModelo();
        registrarModelo();
        validarCampos();

        listarMaterialesPaginacion();
        registrarMaterial();

        obtenerFichaTecnica();
    });
    /*VARIABLES GLOBALES*/
    var total;
    var resultVal = 0.0;
    var tabla_paginacion_material, tabla_paginacion_modelo;
    /*FIN VARIABLES GLOBALES*/


    function orden() {
        $("#guardarOrden").on("click", function () {
            //e.preventDefault();
            var orden = $("#orden").val(),
                    pedido = $("#pedido").val(),
                    f_emision = $("#f_emision").val(),
                    f_entrega = $("#f_entrega").val(),
                    total = $("#total").val(),
                    idmodelo = $("#id_modelo").val();
            var url = $("#frmOrden").attr("action");
            var cabecera = "#tabla-general-serie thead th",
                    cuerpo = "#tabla-general-serie tbody tr";

            /*OBETNER DATA DE LA TABLA SERIE*/
            var data = {"series": obtenerDataTabla(cabecera, cuerpo)};
            var objJson = JSON.stringify(data);

            console.log("data mi detalle: " + objJson);
            console.log(data.series[0].par0);
            var objJson = JSON.stringify(data);
            console.log("data Json: " + objJson);
            console.log(data);
            console.log(objJson);
            $.ajax({
                method: "POST",
                url: url,
                data: {"detalle": objJson, "orden": orden, "pedido": pedido, "f_emision": f_emision, "f_entrega": f_entrega, "id_modelo": idmodelo, "total": total, "parametro": "registrarOrden"},
                success: function (info) {
                    //console.log(info);
                    console.log(typeof info);
                    if (info == "false") {
                        new PNotify({//ver lo de la notificaci�n
                            title: 'Mensaje de Advertencia',
                            text: 'Ingrese todos los datos solicitados',
                            hide: false
                        });
                    } else if (info) {
                        limpiarCamposOrden();
                        //location.reload();
                        new PNotify({//ver lo de la notificaci�n
                            title: 'Mensaje de �xito',
                            text: 'Se guardaron los datos satisfactoriamente.',
                            type: 'success'
                        });
                        url = ""; //posible solouci�n hacer el reload cuando se haga click en la "x" de la notificaci�n
                        resultVal = 0; //set resultVal
                        //location.reload();
                    }
                }
            });
        });
    }

    function listarDetalleOrdenPorCodigo(valor) {
        var char = event.which || event.keyCode;
        var cod = valor.value;
        console.log(char + " cod: " + cod);
        if (char == "13") {//enter
            event.preventDefault();
            if (cod == "")
                new PNotify({
                    title: 'Mensaje de Informaci�n',
                    text: 'Ingresar campo C�digo de Orden',
                    type: 'info',
                    hide: false
                });
            else {
                //alert("bien enter");
                $.ajax({
                    method: "POST",
                    url: "../Sdetalleorden",
                    data: {"valor": cod, "parametro": "listarDetalleOrden"}
                }).done(function (data) {
                    console.log(data);
                    if (data == "vacio") {
                        new PNotify({
                            title: 'Mensaje de Informaci�n',
                            text: 'A�n la orden no se asignado a un proceso.',
                            type: 'info',
                            hide: false
                        });
                    } else {
                        $("#tabla-detalleorden").html(data);
                    }
                });
            }
        }
    }

    function asignarOrdenTrabajadorProceso() {
        $("#frmAsignarOrden").on("submit", function (e) {
            e.preventDefault();

            var codigoorden = $("#orden").val().trim();

            frm = $(this).serialize();
            console.log(frm);
            $.ajax({
                url: "../Sdetalleorden",
                method: "POST",
                data: frm
            }).done(function (data) {
                if (data == "true") {
                    new PNotify({
                        title: 'Mensaje de Informaci�n',
                        text: 'Se asign� la orden al trabajador correctamente.',
                        type: 'success'
                    });
                    actualizarTablaDetalleOrden(codigoorden);
                } else {
                    new PNotify({
                        title: 'Mensaje de Informaci�n',
                        text: 'No se asign� la orden al trabajador correctamente.',
                        type: 'error',
                        hide: false
                    });
                }
            });

        });
    }

    function terminarProcesoOrden(x) {
        var ho = $(x).parent().css({"color": "red", "border": "2px solid red"});
        var tr = $(x).parent().parent();
        console.log(tr);
        //var id = x.childNodes[1].lastChild.value;        
        var codigoorden = tr[0].childNodes[1].innerHTML;
        console.log("codigo proceso:" + codigoorden);
        $.ajax({
            method: "POST",
            url: "../Sdetalleorden",
            data: {"orden": codigoorden, "parametro": "terminarProcesoOrden"}
        }).done(function (data) {
            actualizarTablaDetalleOrden(codigoorden);
        });
    }

    function actualizarTablaDetalleOrden(cod) {
        //coger codigo de la orden pero la tabla
        //alert("bien enter");
        $.ajax({
            method: "POST",
            url: "../Sdetalleorden",
            data: {"valor": cod, "parametro": "listarDetalleOrden"}
        }).done(function (data) {
            $("#tabla-detalleorden").html(data);
        });
    }

    function cambiarTrabajadoPorProceso() {
        var idproceso = document.getElementById("cboproceso").value;
        console.log("Id proceso: " + idproceso);
        comoboTrabajadoresPorProceso(idproceso);
    }


    function comoboTrabajadoresPorProceso(idproceso) {
        //idproceso = $("#cboproceso option:selected").attr("value");//ID del combo proceso
        var parametro = "listarcomboTrabajador";
        $.ajax({
            method: "POST",
            url: "../Strabajador",
            data: {"parametro": parametro, "valor": idproceso}
        }).done(function (data) {
            if (data != "")
                $("#cbotrabajador").html(data);
        });
    }

    function comboProceso() {
        var parametro = "listarcomboProceso";
        $.ajax({
            method: "POST",
            url: "../Sproceso",
            data: {"parametro": parametro}
        }).done(function (data) {
            if (data != "")
                $("#cboproceso").html(data);
            else {
                alert("no hay datos");
            }
        });
    }

    function limpiarCamposOrden() {
        $("#orden").val("");
        $("#pedido").val("");
        $("#f_emision").val("");
        $("#f_entrega").val("");
        $("#total").val("0");
        $("#modelo").val("");
        $("#tabla-serie tr td").children().val("0");
    }

    function validarCampos() {
        $("#generarTotal").on("click", function () {
            var par1 = $("#par1").val(),
                    par2 = $("#par2").val(),
                    par3 = $("#par3").val(),
                    par4 = $("#par4").val(),
                    par5 = $("#par5").val(),
                    par6 = $("#par6").val(),
                    par7 = $("#par7").val();
            console.log("par: " + par2);
            if ((par1 != "") && (par2 != "") && (par3 != "") && (par4 != "") && (par5 != "") && (par6 != "") && (par7 != "")) {//validar que ningun campo este vacio
                generarTotal();
            } else
                alert("Llenar todos los campos");
        });
    }

    function generarTotal() {
        var sum = 0;
        var quantity = 0;
        $('.cantidad').each(function () {
            var cantidad = $(this);
            sum += parseInt(cantidad.val());
        });
        $("#total").val(sum);
        console.log($("#total").val(sum));
    }

    function obtenerDataTabla(cabecera, cuerpo) {//de la table series
        var columna = $(cabecera).map(function () {
            return $(this).text();
        });
        var tablaObjecto = $(cuerpo).map(function (i) {
            var fila = {};
            $(this).find('input').each(function (i) {
                var nombre_fila = columna[i];
                var cantidad = ("par" + i);
                var talla = ("talla" + i)
                fila[cantidad] = $(this).val();
                fila[talla] = columna[i];
            });
            return fila;
            // Don't forget .get() to convert the jQuery set to a regular array. || Igual ponerlo o no, es lo mismo
        }).get();
        return tablaObjecto;
        //console.log(tablaObjecto); 
    }

    /*function agregarSerie() {
     var table = document.getElementById("tabla-serie");
     var row = table.insertRow(0);
     cell1 = row.insertCell(0),
     cell2 = row.insertCell(1),
     cell3 = row.insertCell(2);
     var talla = $("#talla").val(),
     par = $("#par").val();
     if (talla > 33 && talla < 41) {
     cell1.innerHTML = talla;
     cell2.innerHTML = par;
     cell3.innerHTML = "<a href='#' onclick='eliminar(this);' ><i class='fa fa-remove'></i></a>"
     cacularMonto();
     } else {
     alert("Ingresar tallas entre 34 y 40");
     }
     
     $("#talla").val("").focus();
     $("#par").val("");
     }*/

    /*function cacularMonto() {
     resultVal += parseInt($("#par").val());
     console.log(resultVal);
     total = $("#total").val(resultVal.toString());
     //total.innerHTML = resultVal;
     }*/

    /*function eliminar(valor) {
     var i = valor.parentNode.parentNode.rowIndex;
     console.log("indice de la fila: " + (i - 1));
     var valor_menos = document.getElementById("tabla-serie").rows[i - 1].cells.item(1).innerHTML;
     console.log("valor a restar: " + valor_menos);
     resultVal -= parseInt(valor_menos);
     total = $("#total").val(resultVal.toString());
     document.getElementById("tabla-serie").deleteRow(i - 1);
     }*/

    function logout() {
        $("#salir").on("click", function () {
            document.getElementById("formlogout").submit();
        });
    }

    function listarClientes(valor) {
        //$("#listaModelos").on("click", function(){
        $.ajax({
            method: "POST",
            url: "../Scliente",
            data: {"valor": valor, "parametro": "listarCliente"}
        }).done(function (data) {
            $("#tabla-cliente").html(data);
        });
        // });        
    }

    function registrarcliente() {
        $("#frmCliente").on("submit", function (e) {
            e.preventDefault();
            var estado = document.getElementById("estado").checked;
            var razon = $("#razon").val(),
                    ruc = $("#ruc").val(),
                    direccion = $("#direccion").val();
            $.ajax({
                method: "POST",
                url: "../Scliente",
                data: {"parametro": "registrarCliente", "estado": estado, "razon": razon, "ruc": ruc, "direccion": direccion}
            }).done(function (data) {
                console.log("Se registro" + data);
                var arreglo = ["#razon", "#ruc", "#direccion"];
                limpiar(arreglo);
            })
        });
    }

    function seleccionarCliente(x) {
        var id = x.childNodes[1].lastChild.value,
                razon_social = x.childNodes[2].innerHTML;
        var rz_cliente = $("#cliente").val(razon_social),
                id_cliente = $("#idcliente").val(id);
        console.log(x.childNodes);
    }

    function listarModelosPaginacion() {//listar modelos con sus fichas tecnicas

        tabla_paginacion_modelo = $('#listaModelos').DataTable({
            //"scrollX": true
            "processing": true,
            "serverSide": true,
            "ajax": {
                "url": "../Smodelo",
                "type": "POST",
                "data": {"parametro": "listarFichaTecnicaPaginacion"}
                //"dataSrc": "animes"
            },
            //ft.codigomodelo, horma, , , , , , c.idcliente, c.razonsocial
            "columnDefs": [
                {"name": "codigoficha", "targets": 0},
                {"name": "color", "targets": 1},
                {"name": "horma", "targets": 2},
                {"name": "taco", "targets": 3},
                {"name": "plataforma", "targets": 4},
                {"name": "coleccion", "targets": 5},
                {"name": "idcliente", "targets": 6},
                {"name": "razonsocial", "targets": 7},
                {"name": "codigomodelo", "targets": 8}
            ],
            "columns": [
                {"data": "codigoficha"},
                {"data": "color"},
                {"data": "objModelo.horma"},
                {"data": "taco"},
                {"data": "plataforma"},
                {"data": "coleccion"},
                {"data": "objModelo.objCliente.idcliente"},
                {"data": "objModelo.objCliente.razonsocial"},
                {"data": "objModelo.codigomodelo"},
                {"defaultContent": "<button tipo='modificarModelo' class='btn btn-info btn-xs'><i class='fa fa-edit'></i></button> <button tipo='eliminarModelo' class='btn btn-danger btn-xs'><i class='fa fa-remove'></i></button>", "width": "5%"}
                //{"defaultContent": "<button class='btn btn-primary btn-xs'><i class='fa fa-remove'></i></button>"}
            ]
        });
        tabla_paginacion_modelo.column(6).visible(false);
        mantenedoresModelo('#listaModelos tbody', tabla_paginacion_modelo);
    }

    function mantenedoresModelo(lista, tabla) {
        $(lista).on('click', 'button', function () {
            var data = tabla.row($(this).parents('tr')).data();
            console.log(data);
            var parametro = $(this).attr("tipo").toString();
            var divEditar = document.getElementById("editarModelo");

            console.log("parametro: " + parametro + " codigo: " + data.codigomodelo);
            if (parametro === "modificarModelo") {
                var idcliente = $("#idcliente").val(data.objCliente.idcliente),
                        modelo = $("#modelo").val(data.codigomodelo),
                        cliente = $("#cliente").val(data.objCliente.razonsocial),
                        horma = $("#horma").val(data.horma),
                        taco = $("#taco").val(data.taco),
                        plataforma = $("#plataforma").val(data.plataforma),
                        coleccion = $("#coleccion").val(data.coleccion),
                        especificacion = $("#especificacion").val(data.especificacion);
                //estado = $("#").val();
                if (data.estado)
                    $("#estadomodelo").prop("checked", true);
                else
                    $("#estadomodelo").prop('checked', false);
                divEditar.style.display = 'block';
            } else if (parametro == "eliminarModelo") {
                divEditar.style.display = 'none';
            }
        });
    }

    function editarModelo() {
        $("#frmModeloEditar").on("submit", function (e) {
            e.preventDefault();
            modificar_checkbox($(this));//modificar para poder enviar su valor, cuando se utilice la funci�n serialize(), se pasa como par�metro el id del form            
            var frm = $(this).serialize();
            console.log("data frm: " + frm);
            $.ajax({
                method: "POST",
                url: "../Smodelo",
                data: frm
            }).done(function (info) {
                console.log(typeof info);
                if (info == "false") {
                    new PNotify({//ver lo de la notificaci�n
                        title: 'Mensaje de Advertencia',
                        text: 'Ingrese todos los datos solicitados',
                        hide: false
                    });
                } else if (info) {
                    new PNotify({//ver lo de la notificaci�n
                        title: 'Mensaje de �xito',
                        text: 'Se modificaron los datos satisfactoriamente.',
                        type: 'success'
                    });
                    //$("#listaModelos").html("");
                    tabla_paginacion_modelo.destroy();
                    listarModelosPaginacion();
                }
            });
        });
    }

    function registrarModelo() {
        $("#frmModeloRegistrar").on("submit", function (e) {
            e.preventDefault();
            /*var idcliente = $("#idcliente").val(),
             modelo = $("#modelo").val(),
             horma = $("#horma").val(),
             ficha_tecnica = $("#ficha_tecnica").val(),
             taco = $("#taco").val(),
             plataforma = $("#plataforma").val(),
             coleccion = $("#coleccion").val(),
             especificacion = $("#especificacion").val(),
             estadomodelo = $("#estadomodelo").prop("checked");
             console.log(idcliente, " ", modelo, " estado: " + estadomodelo);*/
            modificar_checkbox($(this));
            var frm = $(this).serialize();
            console.log(frm);

            $.ajax({
                method: "POST",
                url: "../Smodelo",
                data: frm
                        //data: {"parametro": "registrarModelo", "idcliente": idcliente, "ficha_tecnica": ficha_tecnica , "modelo": modelo, "horma": horma, "taco": taco, "plataforma": plataforma, "coleccion": coleccion, "especificacion": especificacion, "estadomodelo": estadomodelo}
            }).done(function (info) {
                console.log(typeof info);
                if (info == "existe") {
                    new PNotify({
                        title: 'Mensaje de Advertencia',
                        text: 'C�digo Modelo, ya existe.',
                        type: 'info'
                    });
                } else if (info == "false") {
                    new PNotify({
                        title: 'Mensaje de Advertencia',
                        text: 'Ingrese todos los datos solicitados',
                        hide: false
                    });
                } else if (info == "true") {
                    new PNotify({
                        title: 'Mensaje de �xito',
                        text: 'Se modificaron los datos satisfactoriamente.',
                        type: 'success'
                    });
                    $("#frmModeloRegistrar").find("input[type='text']").val("");
                    $("#tabla-cliente").html("");//agregue esto aqui pero ver por errores.
                }
            });
        });
    }


    function listarMaterialesPaginacion() {
        tabla_paginacion_material = $('#listaMateriales').DataTable({
            //"scrollX": true
            "processing": true,
            "serverSide": true,
            "ajax": {
                "url": "../Smaterial",
                "type": "POST",
                "data": {"parametro": "listarMaterial"}
                //"dataSrc": "animes"
            },
            "columns": [
                {"data": "idmaterial"},
                {"data": "nombre"},
                {"data": "descripcion"},
                {"data": "unidadmedida"},
                {"data": "cantidaddocena"},
                {"data": "preciounitario"},
                {"data": "tipo"},
                {"data": "objProveedor.idproveedor"},
                {"data": "objProveedor.razonsocial"},
                {"data": "objProceso.codigoproceso"},
                {"data": "objProceso.descripcion"},
                {"data": "objFichaTecnica.codigoficha"},
                {"defaultContent": "<button tipo='modificarMaterial' class='btn btn-info btn-xs'><i class='fa fa-edit'></i></button> <button tipo='eliminarMaterial' class='btn btn-danger btn-xs'><i class='fa fa-remove'></i></button>", "width": "5%"}
                //{"defaultContent": "<button class='btn btn-primary btn-xs'><i class='fa fa-remove'></i></button>"}
            ]
        });
        tabla_paginacion_material.column(0).visible(false);
        tabla_paginacion_material.column(7).visible(false);
        tabla_paginacion_material.column(9).visible(false);

        //mantenedoresModelo('#listaModelos tbody', tabla_paginacion_material);
    }

    function registrarMaterial() {
        $("#frmMaterial").on("submit", function (e) {
            e.preventDefault();
            modificar_checkbox($(this));
            var frm = $(this).serialize();
            console.log("frm: " + frm);
            $.ajax({
                method: "POST",
                url: "../Smaterial",
                data: frm
            }).done(function (info) {
                console.log(typeof info);
                if (info == "false") {
                    new PNotify({
                        title: 'Mensaje de Advertencia',
                        text: 'Ingrese todos los datos solicitados',
                        hide: false
                    });
                } else if (info) {
                    new PNotify({
                        title: 'Mensaje de �xito',
                        text: 'Se guardaron los datos satisfactoriamente.',
                        type: 'success'
                    });
                    //$("#frmMaterial").find("input").val("");//esto borra todo incluso el valor del par�metro por eso no registra
                    var arreglo = ["#nombre", "#descripcion", "#unidad_medida", "#cantidad_docena", "#precio_unitario", "#tipo", "#color", "#proveedor", "#proceso", "#modelo", "#fichatecnica"];
                    limpiar(arreglo);
                    //$("#tabla-material").html("");//agregue esto aqui pero ver por errores.
                    $("#tabla-proveedor").html("");
                    $("#tabla-proceso").html("");
                    $("#tabla-modelo").html("");
                }
            });
        });
    }

    function obtenerFichaTecnica() {
        $("#btnFichaTecnica").on("click", function () {
            var valor = $("#codigoFicha").val();
            $.ajax({
                method: "POST",
                url: "../Sfichatecnica",
                data: {"parametro": "obtenerFichaTecnica", "valor": valor}
            }).done(function (json) {                
                var objFicha = JSON.parse(json);                
                var plataforma = objFicha.data[0].plataforma,
                    taco = objFicha.data[0].taco,
                    color = objFicha.data[0].color,
                    coleccion = objFicha.data[0].coleccion,
                    cod_modelo = objFicha.data[0].objModelo.codigomodelo;
            
                $("#plataforma").val(plataforma);
                $("#taco").val(taco);
                $("#color").val(color);
                $("#coleccion").val(coleccion);
                $("#cod_modelo").val(cod_modelo);
                
                //prueba
                /*var cad = "hola";
                    cad+="geovanny";
                    cad+="adios";
                    console.log(cad);*/
                //llamar a funcion de materiales por ficha t�cnica
                var codigo_ficha = objFicha.data[0].codigoficha;
                obtenerMaterialesPorFichaTecnica(codigo_ficha);
                
            });
        });
    }
    
    function obtenerMaterialesPorFichaTecnica(codigoFicha){
        $.ajax({
           method:"POST",
           url: "../Smaterial",
           data: {"parametro": "obtenerMaterialesPorFichaTecnica", "valor": codigoFicha}
        }).done(function(json){
            console.log(json);
            var objMaterial = JSON.parse(json);
            console.log(objMaterial);
            var cad = pintarTablasMaterialesPorProceso(objMaterial);
            /*for(var i=0; i< objMaterial.data.length; i++){
                cad += "";
                if( i%2 == 0 ){
                    cad += "<div class='row'>";
                    cad+="<div class='col-md-6 col-sm-6 col-xs-12'>"+objMaterial.data[i].objProceso.descripcion+"</div>";
                }else{
                    cad+="<div class='col-md-6 col-sm-6 col-xs-12'>"+objMaterial.data[i].objProceso.descripcion+"</div></div>";
                }
            }*/
            $(".contenedor-materiales-procesos").append(cad);
        });
    }
    
    function pintarTablasMaterialesPorProceso(objMaterial){
        var cad = "";
        for(var i=0; i< objMaterial.data.length; i++){
                cad += "";
                if( i%2 == 0 ){
                    cad += "<div class='row'>";
                    cad+="<div class='col-md-6 col-sm-6 col-xs-12'>"+objMaterial.data[i].objProceso.descripcion+"</div>";
                }else{
                    cad+="<div class='col-md-6 col-sm-6 col-xs-12'>"+objMaterial.data[i].objProceso.descripcion+"</div></div>";
                }
            }
        return cad;
    }

    function modificar_checkbox(formulario) {
        var checkboxes = $(formulario).find('input[type="checkbox"]');
        $.each(checkboxes, function (key, value) {
            if (value.checked === false) {
                value.value = false;
            } else {
                value.value = true;
            }
            //$(value).attr('type', 'hidden');
        });
    }

    function listarProveedores(valor) {
        $.ajax({
            method: "POST",
            url: "../Sproveedor",
            data: {"valor": valor, "parametro": "listarProveedor"}
        }).done(function (data) {
            $("#tabla-proveedor").html(data);
        });
    }

    function listarProcesos(valor) {
        $.ajax({
            method: "POST",
            url: "../Sproceso",
            data: {"valor": valor, "parametro": "listarProceso"}
        }).done(function (data) {
            $("#tabla-proceso").html(data);
        });
    }

    function listarModelos(valor) {
        $.ajax({
            method: "POST",
            url: "../Smodelo",
            data: {"valor": valor, "parametro": "listarModelo"}
        }).done(function (data) {
            $("#tabla-modelo").html(data);
        });
    }

    function listarFichaTecnica(valor) {
        console.log(valor);
        $.ajax({
            method: "POST",
            url: "../Sfichatecnica",
            data: {"valor": valor, "parametro": "listarFichaTecnica"}
        }).done(function (data) {
            $("#tabla-fichatecnica").html(data);
        });
    }

    function seleccionarProveedor(x) {
        var id = x.childNodes[1].lastChild.value,
                razon_social = x.childNodes[2].innerHTML;
        var rz_cliente = $("#proveedor").val(razon_social),
                id_proveedor = $("#id_proveedor").val(id);
        console.log(x.childNodes);
    }

    function seleccionarProceso(x) {
        var id = x.childNodes[2].innerHTML,
                razon_social = x.childNodes[3].innerHTML;
        var rz_cliente = $("#proceso").val(razon_social),
                id_proceso = $("#id_proceso").val(id);
        console.log("id proceoso: " + id)
        console.log(x.childNodes);
    }

    function seleccionarModelo(x) {
        var id = x.childNodes[1].lastChild.value,
                razon_social = x.childNodes[1].lastChild.value;
        var rz_cliente = $("#modelo").val(razon_social),
                id_proceso = $("#id_modelo").val(id);
        console.log("id modelo " + id)
        console.log(x.childNodes);
    }

    function seleccionarFichaTecnica(x) {
        var id = x.childNodes[1].lastChild.value,
                razon_social = x.childNodes[1].lastChild.value;
        var rz_cliente = $("#fichatecnica").val(razon_social),
                id_proceso = $("#id_fichatecnica").val(id);
        console.log("id f. t�cnica " + id)
        console.log(x.childNodes);
    }

    function registrarProveedor() {
        $("#frmProveedor").on("submit", function (e) {
            e.preventDefault();
            var estado = document.getElementById("estado").checked;
            var razon = $("#razon").val(),
                    ruc = $("#ruc").val(),
                    direccion = $("#direccion").val();
            $.ajax({
                method: "POST",
                url: "../Sproveedor",
                data: {"parametro": "registrarProveedor", "estado": estado, "razon": razon, "ruc": ruc, "direccion": direccion}
            }).done(function (data) {
                console.log("Se registro" + data);
                var arreglo = ["#razon", "#ruc", "#direccion"];
                limpiar(arreglo);
            })
        });
    }

    function fechas(valor) {
        $(valor).daterangepicker({
            singleDatePicker: true,
            calender_style: "picker_2",
            locale: {
                format: 'YYYY-MM-DD',
                daysOfWeek: ['Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sa'],
                monthNames: ['Enero', 'Febreri', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre']
            }
        });
        $(valor).on('apply.daterangepicker', function (ev, picker) {
            $(this).val(picker.startDate.format('DD/MM/YYYY'));
        });
    }

    function limpiar(arr) {
        for (var i = 0; i < arr.length; i++) {
            $(arr[i]).val("");
        }
    }

</script>
<script>
    NProgress.done();
</script>
</body>

</html>
