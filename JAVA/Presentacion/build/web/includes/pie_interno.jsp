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
  <!-- daterangepicker -->  
  <script type="text/javascript" src="../js/datepicker/daterangepicker.js"></script>
  <script src="../js/custom.js"></script>
  <script>
  <!-- skycons -->
  <script src="../js/skycons/skycons.min.js"></script>
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

    for (i = list.length; i--;)
      icons.set(list[i], list[i]);

    icons.play();
  </script>
  <script type="text/javascript">
    $(document).ready(function() {
        logout();
        listarClientes();
        
    });
    
    function logout() {
        $("#salir").on("click", function (){
           document.getElementById("formlogout").submit(); 
        });        
    }
    
    function listarClientes(valor){        
       // $("#buscar-cliente").on("click", function(){
            $.ajax({
                method: "POST",
                url: "../Scliente",
                data: {"valor": valor}
            }).done(function(data){                
                $("#tabla-cliente").html(data);                
            });
        //});        
    }
    
    function seleccionar(x){
        var id = x.childNodes[1].lastChild.value,
            razon_social= x.childNodes[2].innerHTML;        
        var rz_cliente = $("#cliente").val(razon_social),
            id_cliente = $("#id-cliente").val(id);        
        console.log(x.childNodes);
    }
    
    function listarProveedores(valor){
        $.ajax({
            method: "POST",
            url: "../Sproveedor",
            data: {"valor": valor}
        }).done(function(data){                
            $("#tabla-proveedor").html(data);                
        });
    }
    
    function seleccionarProveedor(x){
        var id = x.childNodes[1].lastChild.value,
            razon_social= x.childNodes[2].innerHTML;        
        var rz_cliente = $("#proveedor").val(razon_social),
            id_cliente = $("#id-proveedor").val(id);        
        console.log(x.childNodes);
    }
    
    function agregarSerie() {
        var table = document.getElementById("tabla-serie");
        var row = table.insertRow(0);        
        var cell1 = row.insertCell(0);
        var cell2 = row.insertCell(1);
        var cell3 = row.insertCell(2);
        cell1.innerHTML = $("#talla").val();
        cell2.innerHTML = $("#par").val();
        cell3.innerHTML = "<a href='#' onclick='eliminar(this);' ><i class='fa fa-remove'></i></a>"
    }
    
    function eliminar(valor){        
        var i = valor.parentNode.parentNode.rowIndex;
        console.log(i);
        document.getElementById("tabla-serie").deleteRow(i-1);
    }
    
  </script>
  <script>
    NProgress.done();
  </script>
</body>

</html>
