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
    
  </script>
  <script>
    NProgress.done();
  </script>
</body>

</html>
