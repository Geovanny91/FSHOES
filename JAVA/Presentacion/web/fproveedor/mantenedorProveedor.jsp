<jsp:include page="../includes/cabecera_interna.jsp"></jsp:include>
<%@page import="com.fshoes.entidades.Trabajador" %>
      <!-- page content -->

<%
    String usuario = "";
    HttpSession ses = request.getSession();    
    if(ses.getAttribute("trabajador")!=null){
        Trabajador u = (Trabajador)ses.getAttribute("trabajador");
        usuario = u.getNombreCompleto();
    }else{
        response.sendRedirect("../index.html");
    }
%>
      <!-- page content -->
      <div class="right_col" role="main">        
          
          <div class="row">
            <!-- Cliente -->
            <div class="x_panel">
                <div class="x_title">
                  <h2>Formulario Proveedor <small>registrar datos.</small></h2>
                  <ul class="nav navbar-right panel_toolbox">
                    <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                    </li>
                    <li class="dropdown">
                      <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                      
                    </li>
                    <li><a class="close-link"><i class="fa fa-close"></i></a>
                    </li>
                  </ul>
                  <div class="clearfix"></div>
                </div>
                <div class="x_content">
                  <br>
                  <form id="frmProveedor" class="form-horizontal form-label-left">

                    <div class="form-group">
                      <label class="control-label col-md-3 col-sm-3 col-xs-12">Razon Social</label>
                      <div class="col-md-6 col-sm-6 col-xs-12">
                        <input type="text" class="form-control" name="razon" id="razon" placeholder="Razón Social">
                      </div>
                    </div>                    
                    <div class="form-group">
                      <label class="control-label col-md-3 col-sm-3 col-xs-12">Ruc</label>
                      <div class="col-md-6 col-sm-6 col-xs-12">
                          <input type="text" class="form-control" maxlength="11" name="ruc" id="ruc" value="" placeholder="Ruc">
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="control-label col-md-3 col-sm-3 col-xs-12">Dirección</label>
                      <div class="col-md-6 col-sm-6 col-xs-12">
                          <input type="text" name="direccion" id="direccion" class="form-control" placeholder="Dirección">                        
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-md-3 col-sm-3 col-xs-12 control-label">Estado                        
                      </label>
                      <div class="col-md-9 col-sm-9 col-xs-12">
                        <div class="checkbox">
                          <label>
                              <input type="checkbox" id="estado" name="estado" value=""> Opción para habilitar a un proveedor.
                          </label>
                        </div>                        
                      </div>
                    </div>
                    <div class="ln_solid"></div>
                    <div class="form-group">
                      <div class="col-md-9 col-sm-9 col-xs-12 col-md-offset-3">
                        <button type="reset" class="btn btn-primary">Cancelar</button>
                        <button type="submit" class="btn btn-success">Guardar</button>
                      </div>
                    </div>
                  </form>
                </div>
              </div>
            <!-- Cliente -->
          </div>        
      </div>
      <!-- /page content -->
<jsp:include page="../includes/pie_interno.jsp"></jsp:include>