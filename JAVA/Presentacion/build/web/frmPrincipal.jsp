<jsp:include page="cabecera.jsp"></jsp:include>
<%@page import="com.fshoes.entidades.Trabajador" %>
      <!-- page content -->

<%
    String usuario = "";
    HttpSession ses = request.getSession();    
    if(ses.getAttribute("trabajador")!=null){
        Trabajador u = (Trabajador)ses.getAttribute("trabajador");
        usuario = u.getNombreCompleto();
    }else{
        response.sendRedirect("index.html");
    }
%>
      
      <div class="right_col" role="main">        
          
          <div class="row">
              <div class="col-md-12">
              <div class="x_panel">
                
                <div class="x_content">

                  <div class="col-md-12 col-lg-12 col-sm-12">
                    <!-- blockquote -->
                    <blockquote>
                      <p>Bienvenido al Sistema Web FSHOES.</p>
                      <footer>Atte. Flores Rogriguez, Josè.</footer>
                    </blockquote>
                  </div>                  
                </div>
              </div>
            </div>
          </div>        
      </div>
      <!-- /page content -->
<jsp:include page="pie.jsp"></jsp:include>