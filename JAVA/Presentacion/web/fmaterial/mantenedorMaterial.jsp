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
        <!-- Cliente -->
        <div class="x_panel">
            <div class="x_title">
                <h2>Formulario Material <small>registrar datos.</small></h2>
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

                <!--INICIO MODAL PROVEEDOR-->
                <div class="modal fade bs-example-modal-lg" id="modalProveedor" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">

                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span>
                                </button>
                                <h2 class="modal-title" id="myModalLabel">Buscar Proveedor</h2>
                            </div>
                            <div class="modal-body">
                                <div class="row">
                                    <div class="form-group">
                                        <label class="control-label col-md-3 col-sm-3 col-xs-12"></label>
                                        <div class="col-md-6 col-sm-6 col-xs-12">
                                            <input type="text" class="form-control has-feedback-left" name="buscar-proveedor" id="buscar-proveedor" onkeyup="listarProveedores(this.value);" value="" placeholder="Buscar por ruc o razón social">
                                            <span class="fa fa-search form-control-feedback left" aria-hidden="true"></span>
                                        </div>
                                    </div>
                                    <div class="ln_solid"></div>
                                    <div class="col-md-12 col-sm-12 col-xs-12">
                                        <div class="x_panel">
                                            <div class="x_title">
                                                <h2>Proveedor <small>Lista en detalle.</small></h2>
                                                <ul class="nav navbar-right panel_toolbox">
                                                    <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                                    </li>                                                                
                                                    <li><a class="close-link"><i class="fa fa-close"></i></a>
                                                    </li>
                                                </ul>
                                                <div class="clearfix"></div>
                                            </div>
                                            <div class="x_content">
                                                <table class="table table-hover">
                                                    <thead>
                                                        <tr>
                                                            <th>#</th>
                                                            <th></th>  
                                                            <th>R. Social</th>
                                                            <th>Ruc</th>
                                                            <th>Dirección</th>
                                                            <th></th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="tabla-proveedor">                                                                    
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--FIN MODAL PROVEEDOR-->

                <!--INICIO MODAL PROCESO-->
                <div class="modal fade bs-example-modal-lg" id="modalProceso" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">

                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span>
                                </button>
                                <h2 class="modal-title" id="myModalLabel">Buscar Proceso</h2>
                            </div>
                            <div class="modal-body">
                                <div class="row">
                                    <div class="form-group">
                                        <label class="control-label col-md-3 col-sm-3 col-xs-12"></label>
                                        <div class="col-md-6 col-sm-6 col-xs-12">
                                            <input type="text" class="form-control has-feedback-left" name="buscar-proceso" id="buscar-proceso" onkeyup="listarProcesos(this.value);" value="" placeholder="Buscar por còdigo o proceso">
                                            <span class="fa fa-search form-control-feedback left" aria-hidden="true"></span>
                                        </div>
                                    </div>
                                    <div class="ln_solid"></div>
                                    <div class="col-md-12 col-sm-12 col-xs-12">
                                        <div class="x_panel">
                                            <div class="x_title">
                                                <h2>Proceso <small>Lista en detalle.</small></h2>
                                                <ul class="nav navbar-right panel_toolbox">
                                                    <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                                    </li>                                                                
                                                    <li><a class="close-link"><i class="fa fa-close"></i></a>
                                                    </li>
                                                </ul>
                                                <div class="clearfix"></div>
                                            </div>
                                            <div class="x_content">
                                                <table class="table table-hover">
                                                    <thead>
                                                        <tr>
                                                            <th>#</th>
                                                            <th></th>  
                                                            <th>ID</th>
                                                            <th>Proceso</th>                                                                    
                                                            <th></th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="tabla-proceso">                                                                    
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--FIN MODAL PROCESO-->

                <!--INICIO MODAL MODELO-->
                <div class="modal fade bs-example-modal-lg" id="modalFichaTecnica" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">

                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span>
                                </button>
                                <h2 class="modal-title" id="myModalLabel">Buscar Ficha Técnica</h2>
                            </div>
                            <div class="modal-body">
                                <div class="row">
                                    <div class="form-group">
                                        <label class="control-label col-md-3 col-sm-3 col-xs-12"></label>
                                        <div class="col-md-6 col-sm-6 col-xs-12">
                                            <input type="text" class="form-control has-feedback-left" name="buscar-fichatecnica" id="buscar-fichatecnica" onkeyup="listarFichaTecnica(this.value);" value="" placeholder="Buscar por F. Técnica o código de Modelo">
                                            <span class="fa fa-search form-control-feedback left" aria-hidden="true"></span>
                                        </div>
                                    </div>
                                    <div class="ln_solid"></div>
                                    <div class="col-md-12 col-sm-12 col-xs-12">
                                        <div class="x_panel">
                                            <div class="x_title">
                                                <h2>Ficha Técnica <small>Lista en detalle.</small></h2>
                                                <ul class="nav navbar-right panel_toolbox">
                                                    <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                                    </li>                                                                
                                                    <li><a class="close-link"><i class="fa fa-close"></i></a>
                                                    </li>
                                                </ul>
                                                <div class="clearfix"></div>
                                            </div>
                                            <div class="x_content">
                                                <table class="table table-hover">
                                                    <thead>
                                                        <tr>
                                                            <th>#</th>
                                                            <th></th>  
                                                            <th>F. Técnica</th>
                                                            <th>Color</th>
                                                            <th>Horma</th>                                
                                                            <th>Taco</th>
                                                            <th>Plataforma</th>                                                                
                                                            <!--<th>Id Cliente</th>-->
                                                            <th>Cliente</th>
                                                            <th>Modelo</th> 
                                                            <th></th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="tabla-fichatecnica">                                                                    
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--FIN MODAL MODELO-->

                <form id="frmMaterial" method="POST" class="form-horizontal form-label-left">
                    <input type="hidden" id="parametro" name="parametro" value="registrarMaterial" />

                    <input type="hidden" class="form-control" name="id_proveedor" id="id_proveedor" value="">
                    <input type="hidden" class="form-control" name="id_proceso" id="id_proceso" value="">
                    
                    <div class="row">
                                <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                                    <label>Nombre</label>
                                    <input type="text" class="form-control has-feedback-left" id="nombre" name="nombre" placeholder="Ingresar nombre">
                                    <span class="fa fa-edit form-control-feedback left" aria-hidden="true"></span>
                                </div>
                                <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                                    <label>Descripción</label>
                                    <input type="text" class="form-control has-feedback-left" id="descripcion" name="descripcion" placeholder="Ingresar descripción">
                                    <span class="fa fa-edit form-control-feedback left" aria-hidden="true"></span>
                                </div>
                                <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                                    <label>Unidad de medida</label>
                                    <input type="text" class="form-control has-feedback-left" id="unidad_medida" name="unidad_medida" placeholder="Ingresar unidad de medida">
                                    <span class="fa fa-edit form-control-feedback left" aria-hidden="true"></span>
                                </div>
                                <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                                    <label>Cantidad por docena</label>
                                    <input type="text" class="form-control has-feedback-left" id="cantidad_docena" name="cantidad_docena" placeholder="Ingresar cantidad por docena">
                                    <span class="fa fa-edit form-control-feedback left" aria-hidden="true"></span>
                                </div>
                                <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                                    <label>Precio unitario</label>
                                    <input type="text" class="form-control has-feedback-left" id="precio_unitario" name="precio_unitario" placeholder="Ingresar precio unitario">
                                    <span class="fa fa-edit form-control-feedback left" aria-hidden="true"></span>
                                </div>
                                <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                                    <label>Tipo</label>
                                    <input type="text" class="form-control has-feedback-left" id="tipo" name="tipo" placeholder="Ingresar tipo: sólido o líquido">
                                    <span class="fa fa-edit form-control-feedback left" aria-hidden="true"></span>
                                </div>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <label>Proveedor</label>                                  
                                    <div class="input-group">                                        
                                        <input type="text" class="form-control" id="proveedor" name="proveedor" readonly="" placeholder="Seleccionar proveedor">
                                        <span class="input-group-btn" aria-hidden="true">
                                            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modalProveedor"><i class="fa fa-search"></i></button>
                                        </span>
                                    </div>                                    
                                </div>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <label>Proceso</label>
                                    <div class="input-group">                                        
                                        <input type="text" class="form-control" id="proceso" name="proceso" readonly="" placeholder="Seleccionar proceso">
                                        <span class="input-group-btn" aria-hidden="true">
                                            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modalProceso"><i class="fa fa-search"></i></button>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <label>Ficha técnica</label>
                                    <div class="input-group">                                        
                                        <input type="text" class="form-control" id="id_fichatecnica" name="id_fichatecnica" readonly="" placeholder="Seleccionar ficha técnica">
                                        <span class="input-group-btn" aria-hidden="true">
                                            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modalFichaTecnica"><i class="fa fa-search"></i></button>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="ln_solid"></div>

                            <div class="form-group">                            
                                <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-5">
                                    
                                    <!--<button id="btnModificarFicha" type="submit" class="btn btn-success">Modificar</button>-->
                                    <button id="btnCrearFicha" type="submit" class="btn btn-success">Guardar</button>
                                    <button id="btnCrearFicha" type="reset" class="btn btn-primary">Cancelar</button>
                                    
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