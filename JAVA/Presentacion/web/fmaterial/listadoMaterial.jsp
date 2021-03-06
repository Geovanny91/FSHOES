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


    <div class="row" id="oculatFrmEditarMaterial" style="display: none;">
        <div class="col-md-12 col-sm-12 col-xs-12">

            <div class="x_panel">
                <div class="x_title">
                    <h2>Material <small>Editar datos de un material en espec�fico.</small></h2>
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
                    <div class="row">

                        <!--INICIO MODAL PROVEEDOR-->
                        <div class="modal fade bs-example-modal-lg" id="modalProveedor" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
                            <div class="modal-dialog modal-lg">
                                <div class="modal-content">

                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">�</span>
                                        </button>
                                        <h2 class="modal-title" id="myModalLabel">Buscar Proveedor</h2>
                                    </div>
                                    <div class="modal-body">
                                        <div class="row">
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12"></label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <input type="text" class="form-control has-feedback-left" name="buscar-proveedor" id="buscar-proveedor" onkeyup="listarProveedores(this.value);" value="" placeholder="Buscar por ruc o raz�n social">
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
                                                                    <th>Direcci�n</th>
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
                                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">�</span>
                                        </button>
                                        <h2 class="modal-title" id="myModalLabel">Buscar Proceso</h2>
                                    </div>
                                    <div class="modal-body">
                                        <div class="row">
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12"></label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <input type="text" class="form-control has-feedback-left" name="buscar-proceso" id="buscar-proceso" onkeyup="listarProcesos(this.value);" value="" placeholder="Buscar por c�digo o proceso">
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
                                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">�</span>
                                        </button>
                                        <h2 class="modal-title" id="myModalLabel">Buscar Ficha T�cnica</h2>
                                    </div>
                                    <div class="modal-body">
                                        <div class="row">
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12"></label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <input type="text" class="form-control has-feedback-left" name="buscar-fichatecnica" id="buscar-fichatecnica" onkeyup="listarFichaTecnica(this.value);" value="" placeholder="Buscar por F. T�cnica o c�digo de Modelo">
                                                    <span class="fa fa-search form-control-feedback left" aria-hidden="true"></span>
                                                </div>
                                            </div>
                                            <div class="ln_solid"></div>
                                            <div class="col-md-12 col-sm-12 col-xs-12">
                                                <div class="x_panel">
                                                    <div class="x_title">
                                                        <h2>Ficha T�cnica <small>Lista en detalle.</small></h2>
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
                                                                    <th>F. T�cnica</th>
                                                                    <th>Color</th>
                                                                    <th>Horma</th>                                
                                                                    <th>Taco</th>
                                                                    <th>Plataforma</th>                                                                
                                                                    <th>Id Cliente</th>
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


                        <form id="frmModificarMaterial" action="" method="POST" class="form-horizontal form-label-left">
                            <input type="hidden" id="parametro" name="parametro" value="modificarMaterial" />
                            
                            <input type="hidden" id="id_material" name="id_material">
                            <input type="hidden" id="id_proveedor" name="id_proveedor">
                            <input type="hidden" id="id_proceso" name="id_proceso">
                            <input type="hidden" id="id_fichatecnica" name="id_fichatecnica">
                            <div class="row">
                                <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                                    <label>Nombre</label>
                                    <input type="text" class="form-control has-feedback-left" id="nombre" name="nombre" placeholder="Ingresar nombre" required="">
                                    <span class="fa fa-edit form-control-feedback left" aria-hidden="true"></span>
                                </div>
                                <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                                    <label>Descripci�n</label>
                                    <input type="text" class="form-control has-feedback-left" id="descripcion" name="descripcion" placeholder="Ingresar descripci�n">
                                    <span class="fa fa-edit form-control-feedback left" aria-hidden="true"></span>
                                </div>
                                <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                                    <label>Unidad de medida</label>
                                    <input type="text" class="form-control has-feedback-left" id="unidad_medida" name="unidad_medida" placeholder="Ingresar unidad de medida">
                                    <span class="fa fa-edit form-control-feedback left" aria-hidden="true"></span>
                                </div>
                                <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                                    <label>Cantidad por docena</label>
                                    <input type="text" class="form-control has-feedback-left" id="cantidad_docena" name="cantidad_docena" placeholder="Ingresar cantidad por docena" required="">
                                    <span class="fa fa-edit form-control-feedback left" aria-hidden="true"></span>
                                </div>
                                <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                                    <label>Precio unitario</label>
                                    <input type="text" class="form-control has-feedback-left" id="precio_unitario" name="precio_unitario" placeholder="Ingresar precio unitario" required="">
                                    <span class="fa fa-edit form-control-feedback left" aria-hidden="true"></span>
                                </div>
                                <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                                    <label>Tipo</label>
                                    <input type="text" class="form-control has-feedback-left" id="tipo" name="tipo" placeholder="Ingresar tipo: s�lido o l�quido">
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
                                    <label>Ficha t�cnica</label>
                                    <div class="input-group">                                        
                                        <input type="text" class="form-control" id="fichatecnica" name="fichatecnica" readonly="" placeholder="Seleccionar ficha t�cnica">
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
                                    <button type="submit" class="btn btn-primary">Guardar</button>
                                    <input id="btnCancelar" value="Cancelar" type="button" class="btn btn-default">
                                    
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row" id="oculatFrmListadoMaterial">
        <div class="col-md-12 col-sm-12 col-xs-12">

            <div class="x_panel">
                <div class="x_title">
                    <h2>Materiales <small>lista de materiales por ficha t�cnica.</small></h2>
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
                    <div class="row">                        
                        <form class="form-inline" method="POST">
                            <div class="form-group">
                                <div class="input-group">
                                    <div class="input-group-addon"><i class="fa fa-search"></i></div>
                                    <input type="text" maxlength="10" class="form-control" id="ficha_tecnica" name="ficha_tecnica" placeholder="Ingresar ficha t�cnica" required="">                                
                                </div>
                            </div>                            
                            <input type="button" value="Click" id="btnMostrarMaterialesPorFicha" class="btn btn-primary" />
                        </form>
                        <div class="ln_solid"></div>

                        <table class="table table-striped table-bordered dt-responsive nowrap" id="listaMateriales" cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Nombre</th>
                                    <th>Descripccion</th>
                                    <th>Unidad Medida</th>
                                    <th>Cantidad Docena</th>
                                    <th>Precio</th>
                                    <th>Tipo</th>                                
                                    <th>idproveedor</th>
                                    <th>Proveedor</th>
                                    <th>ID Proceso</th>
                                    <th>Proceso</th>
                                    <th>Ficha T�cnica</th>
                                    <th></th>
                                    <!--<th></th>-->
                                </tr>
                            </thead>            
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row" id="editarModelo" style="display: none;">
        <!-- Cliente -->
        <div class="col-md-12 col-sm-12 col-xs-12">    
            <div class="x_panel">
                <div class="x_title">
                    <h2>Formulario Modelo <small>modificar datos.</small></h2>
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
                    <form id="frmModeloEditar" action="" method="POST" class="form-horizontal form-label-left">
                        <!--<div class="form-group">                            
                            <div class="col-md-9 col-sm-9 col-xs-12 col-md-offset-3">                                
                                <label class="btn btn-primary btn-upload col-md-1 col-sm-1 col-xs-12" for="inputImage" title="Upload image file">                                    
                                    <input class="sr-only form-control" id="inputImage" name="file" type="file" accept="image/*">
                                    <span class="docs-tooltip" data-toggle="tooltip" title="" data-original-title="Importar imagen con Blob URLs">
                                        <span class="fa fa-upload"></span>
                                    </span>                                    
                                </label>
                            </div>                            
                        </div>                    -->
                        <div class="form-group">             
                            <div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog modal-lg">
                                    <div class="modal-content">

                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">�</span>
                                            </button>
                                            <h2 class="modal-title" id="myModalLabel">Buscar Cliente</h2>
                                        </div>
                                        <div class="modal-body">
                                            <div class="row">
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12"></label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        <input type="text" class="form-control has-feedback-left" id="buscar-cliente" onkeyup="listarClientes(this.value);" value="" placeholder="Buscar por ruc o raz�n social">
                                                        <span class="fa fa-search form-control-feedback left" aria-hidden="true"></span>
                                                    </div>
                                                </div>
                                                <div class="ln_solid"></div>
                                                <div class="col-md-12 col-sm-12 col-xs-12">
                                                    <div class="x_panel">
                                                        <div class="x_title">
                                                            <h2>Clientes <small>Lista en detalle.</small></h2>
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
                                                                        <th>Direcci�n</th>
                                                                        <th></th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody id="tabla-cliente">                                                                    
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!--<div class="modal-footer">
                                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                <button type="button" class="btn btn-primary">Save changes</button>
                                            </div>-->

                                        </div>
                                    </div>
                                </div>
                            </div>
                            <input type="hidden" name="parametro" id="parametro" value="modificarModelo" />
                            <div class="form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12">Modelo</label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input type="text" class="form-control" name="modelo" id="modelo" value="" required readonly>
                                </div>
                            </div>
                            <input type="hidden" class="form-control" name="idcliente" id="idcliente">
                            <div class="form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12">Cliente</label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input type="text" class="form-control" name="cliente" id="cliente" value="" required readonly>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12">Horma</label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input type="text" class="form-control" name="horma" id="horma" value="" required placeholder="Horma">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12">Taco</label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input type="text" name="taco" id="taco" class="form-control" required placeholder="Taco">                        
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12">Plataforma</label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input type="text" class="form-control" name="plataforma" id="plataforma" value="" required placeholder="Plataforma">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12">Colecci�n</label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input type="text" class="form-control" name="coleccion" id="coleccion" value="" required placeholder="Colecci�n">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12">Especificaci�n</label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input type="text" class="form-control" name="especificacion" id="especificacion" value="" required placeholder="Especificaci�n">
                                </div>
                            </div>                        
                            <div class="form-group">
                                <label class="col-md-3 col-sm-3 col-xs-12 control-label">Estado                        
                                </label>
                                <div class="col-md-9 col-sm-9 col-xs-12">
                                    <div class="checkbox">
                                        <label>
                                            <input id="estadomodelo" name="estadomodelo" type="checkbox" value=""> Opci�n para habilitar un modelo.
                                        </label>
                                    </div>                        
                                </div>
                            </div>
                            <div class="ln_solid"></div>
                            <div class="form-group">
                                <div class="col-md-9 col-sm-9 col-xs-12 col-md-offset-3">
                                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target=".bs-example-modal-lg" ><i class="fa fa-search"></i> Cliente</button>
                                    <button type="submit" id="btnModificarModelo" class="btn btn-success">Guardar</button>                                
                                </div>
                            </div>

                        </div>
                    </form>
                </div>
                <!-- Cliente -->
            </div>
        </div>
    </div>



    <!-- /page content -->
    <jsp:include page="../includes/pie_interno.jsp"></jsp:include>