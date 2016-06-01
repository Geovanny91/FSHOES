<jsp:include page="../includes/cabecera_interna.jsp"></jsp:include>
<%@page import="com.fshoes.entidades.Trabajador" %>
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

    <div class="row">        
        <div class="col-md-6 col-sm-6 col-xs-12">
            <div class="x_panel">
                <div class="x_title">
                    <h2>Formulario Asignar Orden a Trabajador <small></small></h2>
                    <ul class="nav navbar-right panel_toolbox">
                        <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                        </li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                        </li>                        
                    </ul>
                    <div class="clearfix"></div>
                </div>
                <div class="x_content">
                    <form id="frmAsignarOrden" action="" method="POST" class="form-horizontal form-label-left">
                        <br>
                        <div class="form-group">                            
                            <div class="col-md-10 col-sm-12 col-xs-12 col-md-push-1 has-feedback">                                
                                <input type="text" name="orden" id="orden" required="" class="form-control has-feedback-left" placeholder="Ingresar Còdigo Orden" onkeypress="listarDetalleOrdenPorCodigo(this);">
                                <span class="fa fa-file-text-o form-control-feedback left" aria-hidden="true"></span>                              
                            </div>                            
                        </div>
                        <br>
                        <div class="form-group">
                            <div class="col-md-10 col-sm-12 col-xs-12 col-md-push-1">                                
                                <table class="table table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th class="text-center">Orden</th>
                                            <th class="text-center">Trabajador</th>
                                            <th class="text-center">Proceso</th>
                                            <th class="text-center">Estado</th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody id="tabla-detalleorden">                                        
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <input type="hidden" name="parametro" id="parametro" value="asignarOrden">
                        <div class="form-group">
                            <div class="col-md-10 col-sm-12 col-xs-12 col-md-push-1">
                                <select id="cboproceso" name="cboproceso" onchange="cambiarTrabajadoPorProceso();" class="form-control">                                    
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-10 col-sm-12 col-xs-12 col-md-push-1">
                                <select id="cbotrabajador" name="cbotrabajador"  class="form-control">                                    
                                </select>
                            </div>
                        </div>
                        <div class="ln_solid"></div>
                        <div class="form-group">                            
                            <div class="col-md-9 col-sm-9 col-xs-12 col-md-offset-5">                                
                                <button type="submit" class="btn btn-success">Asignar</button>
                            </div>
                        </div>                        
                    </form>
                </div>
            </div>
        </div>
        <div class="col-md-6 col-sm-6 col-xs-12">            
        </div>
        <!--</form>-->
    </div>
    <!-- /page content -->
    <jsp:include page="../includes/pie_interno.jsp"></jsp:include>