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

    icons.play();
</script>

<script type="text/javascript">
    $(document).ready(function () {
        logout();
        listarClientes();
        fechas("#f_emision");
        fechas("#f_entrega");
        registrarcliente();
        registrarProveedor();
        orden();
    });

    /*VARIABLES GLOBALES*/
    var total;
    var resultVal = 0.0;
    /*FIN VARIABLES GLOBALES*/


    function orden() {
        $("#frmOrden").on("submit", function (e) {
            e.preventDefault();
            var orden = $("#orden").val(),
                    pedido = $("#pedido").val(),
                    f_emision = $("#f_emision").val(),
                    f_entrega = $("#f_entrega").val(),
                    total = $("#total").val();

            var cabecera = "#tabla-general-serie thead th",
                    cuerpo = "#tabla-general-serie tbody tr";
            var data = {"series": obtenerDataTabla(cabecera, cuerpo)};
            var objJson = JSON.stringify(data);
            console.log("data Json: " + objJson);
            console.log(data);
            console.log(objJson);
            $.ajax({
                method: "POST",
                url: "../SOrden",
                data: {"detalle": objJson, "orden": orden, "pedido": pedido, "f_emision": f_emision, "f_entrega": f_entrega, "total": total, "parametro": "registrarOrden"}
            }).done(function (info) {
                //console.log(info);
                console.log(typeof info);
                if (info == "null") {
                    new PNotify({//ver lo de la notificación
                        title: 'Mensaje de Advertencia',
                        text: 'Ingrese todos los datos solicitados',
                        hide: false
                    });
                } else if (info) {
                    new PNotify({//ver lo de la notificación
                        title: 'Mensaje de éxito',
                        text: 'Se guardaron los datos satisfactoriamente.',
                        type: 'success'
                    });
                    limpiarCamposOrden();
                    //location.reload();
                }
            });
        });
    }

    function limpiarCamposOrden() {
        $("#orden").val("");
        $("#pedido").val("");
        $("#f_emision").val("");
        $("#f_entrega").val("");
        $("#total").val("");
        $("#tabla-serie").html("");
    }

    function obtenerDataTabla(cabecera, cuerpo) {//de la table series
        var columna = $(cabecera).map(function () {
            return $(this).text();
        });
        var tablaObjecto = $(cuerpo).map(function (i) {
            var fila = {};
            $(this).find('td').each(function (i) {
                var nombre_fila = columna[i];
                fila[nombre_fila] = $(this).text();
            });
            return fila;
            // Don't forget .get() to convert the jQuery set to a regular array. || Igual ponerlo o no, es lo mismo
        }).get();
        return tablaObjecto;
        //console.log(tablaObjecto); 
    }

    function logout() {
        $("#salir").on("click", function () {
            document.getElementById("formlogout").submit();
        });
    }

    function listarClientes(valor) {
        // $("#buscar-cliente").on("click", function(){
        $.ajax({
            method: "POST",
            url: "../Scliente",
            data: {"valor": valor, "parametro": "listarCliente"}
        }).done(function (data) {
            $("#tabla-cliente").html(data);
        });
        //});        
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

    function seleccionar(x) {
        var id = x.childNodes[1].lastChild.value,
                razon_social = x.childNodes[2].innerHTML;
        var rz_cliente = $("#cliente").val(razon_social),
                id_cliente = $("#id-cliente").val(id);
        console.log(x.childNodes);
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

    function seleccionarProveedor(x) {
        var id = x.childNodes[1].lastChild.value,
                razon_social = x.childNodes[2].innerHTML;
        var rz_cliente = $("#proveedor").val(razon_social),
                id_cliente = $("#id-proveedor").val(id);
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

    function agregarSerie() {
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
    }

    function cacularMonto() {
        resultVal += parseInt($("#par").val());
        console.log(resultVal);
        total = $("#total").val(resultVal.toString());
        //total.innerHTML = resultVal;
    }

    function eliminar(valor) {
        var i = valor.parentNode.parentNode.rowIndex;
        console.log("indice de la fila: " + (i - 1));
        var valor_menos = document.getElementById("tabla-serie").rows[i - 1].cells.item(1).innerHTML;
        console.log("valor a restar: " + valor_menos);
        resultVal -= parseInt(valor_menos);
        total = $("#total").val(resultVal.toString());
        document.getElementById("tabla-serie").deleteRow(i - 1);
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
