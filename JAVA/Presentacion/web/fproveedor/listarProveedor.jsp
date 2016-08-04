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

    <div class="row" id="oculatFrmEditarProveedor"style="display: none;">
        <!-- Cliente -->
        <div class="col-md-12 col-sm-12 col-xs-12">    
            <div class="x_panel">
                <div class="x_title">
                    <h2>Formulario Proveedor <small>modificar datos.</small></h2>
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
                    <form id="frmModificarProveedor" action="" method="POST" class="form-horizontal form-label-left">
                        <div class="form-group">
                            <input type="hidden" name="parametro" id="parametro" value="modificarProveedor" />                            
                            <input type="hidden" class="form-control" name="idproveedor" id="idproveedor">
                            <div class="form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12">Razón Social</label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input type="text" class="form-control" name="razonsocial" id="razonsocial" value="" required placeholder="Razón Social">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12">Ruc</label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input type="text" class="form-control" maxlength="11" name="ruc" id="ruc" value="" required placeholder="Ruc">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12">Dirección</label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input type="text" name="direccion" id="direccion" class="form-control" required placeholder="Dirección">                        
                                </div>
                            </div>                           
                            <div class="form-group">
                                <label class="col-md-3 col-sm-3 col-xs-12 control-label">Estado                        
                                </label>
                                <div class="col-md-9 col-sm-9 col-xs-12">
                                    <div class="checkbox">
                                        <label>
                                            <input id="estadoproveedor" name="estadoproveedor" type="checkbox" value=""> Opción para habilitar un modelo.
                                        </label>
                                    </div>                        
                                </div>
                            </div>
                            <div class="ln_solid"></div>
                            <div class="form-group">
                                <div class="col-md-9 col-sm-9 col-xs-12 col-md-offset-3">
                                    <button type="submit" id="btnModificarModelo" class="btn btn-success">Guardar</button>
                                    <input id="btnCancelar" value="Cancelar" type="button" class="btn btn-default">
                                </div>
                            </div>
                        </div>
                    </form>
                </div>                
            </div>
        </div>
    </div>
    
    <div class="row" id="oculatFrmListadoProveedor">
        <div class="col-md-12 col-sm-12 col-xs-12">

            <div class="x_panel">
                <div class="x_title">
                    <h2>Proveedores <small>lista de proveedores.</small></h2>
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
                    <table class="table table-striped table-bordered dt-responsive nowrap" id="listaProveedor" cellspacing="0" width="100%">
                        <thead>
                            <tr>
                                <th>Razón Social</th>
                                <th>Ruc</th>
                                <th>Dirección</th>                                 
                                <th></th>                                
                            </tr>
                        </thead>            
                    </table>
                </div>
            </div>
        </div>
    </div>
    <!-- /page content -->
    <jsp:include page="../includes/pie_interno.jsp"></jsp:include>