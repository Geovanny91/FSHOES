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
                    <form id="frmMaterial" method="POST" class="form-horizontal form-label-left">
                        <input type="hidden" id="parametro" name="parametro" value="registrarMaterial" />
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
                        <div class="modal fade bs-example-modal-lg" id="modalModelo" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
                            <div class="modal-dialog modal-lg">
                                <div class="modal-content">

                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span>
                                        </button>
                                        <h2 class="modal-title" id="myModalLabel">Buscar Modelo</h2>
                                    </div>
                                    <div class="modal-body">
                                        <div class="row">
                                            <div class="form-group">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12"></label>
                                                <div class="col-md-6 col-sm-6 col-xs-12">
                                                    <input type="text" class="form-control has-feedback-left" name="buscar-modelo" id="buscar-modelo" onkeyup="listarModelos(this.value);" value="" placeholder="Buscar por còdigo o razón social de cliente">
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
                                                                    <th>Código</th>
                                                                    <th>Horma</th>
                                                                    <th>Taco</th>
                                                                    <th>Plataforma</th>
                                                                    <th>Colección</th> 
                                                                    <th>Cliente</th> 
                                                                    <th></th>
                                                                </tr>
                                                            </thead>
                                                            <tbody id="tabla-modelo">                                                                    
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
                        
                        <input type="hidden" class="form-control" name="id_proveedor" id="id_proveedor" value="">
                        <input type="hidden" class="form-control" name="id_proceso" id="id_proceso" value="">
                        <input type="hidden" class="form-control" name="id_ficha" id="id_ficha" value="">
                         <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Nombre</label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <input type="text" class="form-control" name="nombre" id="nombre" placeholder="Nombre del manterial">
                            </div>
                        </div>  
                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Descripccion</label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <input type="text" class="form-control" name="descripcion" id="descripcion" placeholder="Descripcion">
                            </div>
                        </div>                    
                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Unidad de medida</label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <input type="text" class="form-control" name="unidad_medida" id="unidad_medida" value="" placeholder="Unidad de medida">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Cantidad por docena</label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <input type="text" name="cantidad_docena" id="cantidad_docena" class="form-control" placeholder="Cantidad por Docena">                        
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Precio Unitario</label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <input type="text" class="form-control" name="precio_unitario" id="precio_unitario" value="" placeholder="Precio Unitario">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Tipo</label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <input type="text" class="form-control" name="tipo" id="tipo" value="" placeholder="Tipo">
                            </div>
                        </div>                        
                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Proveedor</label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <input type="text" class="form-control" name="proveedor" id="proveedor" value="" placeholder="Proveedor" readonly="">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Proceso</label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <input type="text" class="form-control" name="proceso" id="proceso" value="" placeholder="Proceso" readonly="">
                            </div>
                        </div>
                        <div class="form-group"><!--Ver Ficha Técnica, en modelo Aquì-->
                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Modelo</label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <input type="text" class="form-control" name="modelo" id="modelo" value="" placeholder="Modelo" readonly="">
                            </div>
                        </div>
                        <div class="ln_solid"></div>
                        <div class="form-group">
                            <div class="col-md-9 col-sm-9 col-xs-12 col-md-offset-3">
                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modalProveedor" ><i class="fa fa-search"></i> Proveedor</button>
                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modalProceso" ><i class="fa fa-search"></i> Proceso</button>
                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modalModelo" ><i class="fa fa-search"></i> Modelo</button>
                                <!--AQUI MODAL DE LISTA DE FICHA TECNICA POR MODELO-->
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