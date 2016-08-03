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

    <div class="row" id="oculatFrmEditarTrabajador" style="display: none;">
        <div class="col-md-12 col-sm-12 col-xs-12">

            <div class="x_panel">
                <div class="x_title">
                    <h2>Trabajador <small>Editar datos del trabajador.</small></h2>
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

                        <form id="frmModificarTrabajador" action="" method="POST" class="form-horizontal form-label-left">
                            <input type="hidden" id="parametro" name="parametro" value="modificarTrabajador" />

                            <input type="hidden" id="id_empleado" name="id_empleado">
                            <input type="hidden" id="id_proceso" name="id_proceso">
                            
                            <div class="row">
                                <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                                    <label>Nombres</label>
                                    <input type="text" class="form-control has-feedback-left" id="nombres" name="nombres" placeholder="Ingresar nombres" required="">
                                    <span class="fa fa-edit form-control-feedback left" aria-hidden="true"></span>
                                </div>
                                <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                                    <label>Apellido Paterno</label>
                                    <input type="text" class="form-control has-feedback-left" id="ape_paterno" name="ape_paterno" required="" placeholder="Ingresar apellido">
                                    <span class="fa fa-edit form-control-feedback left" aria-hidden="true"></span>
                                </div><div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                                    <label>Apellido Materno</label>
                                    <input type="text" class="form-control has-feedback-left" id="ape_materno" name="ape_materno" required="" placeholder="Ingresar apellido">
                                    <span class="fa fa-edit form-control-feedback left" aria-hidden="true"></span>
                                </div><div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                                    <label>Dirección</label>
                                    <input type="text" class="form-control has-feedback-left" id="direccion" name="direccion" placeholder="Ingresar dirección">
                                    <span class="fa fa-edit form-control-feedback left" aria-hidden="true"></span>
                                </div>
                                <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                                    <label>Teléfono</label>
                                    <input type="text" class="form-control has-feedback-left" id="telefono" name="telefono" placeholder="Ingresar teléfono">
                                    <span class="fa fa-edit form-control-feedback left" aria-hidden="true"></span>
                                </div>
                                <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                                    <label>Dni</label>
                                    <input type="text" maxlength="8" class="form-control has-feedback-left" id="dni" required="" name="dni" placeholder="Ingresar dni">
                                    <span class="fa fa-edit form-control-feedback left" aria-hidden="true"></span>
                                </div>
                                <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                                    <label>Célular</label>
                                    <input type="text" class="form-control has-feedback-left" id="celular" name="celular" placeholder="Ingresar célular">
                                    <span class="fa fa-edit form-control-feedback left" aria-hidden="true"></span>
                                </div>
                                <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                                    <label>Fecha de Nacimiento</label>
                                    <input type="text" class="form-control has-feedback-left" id="fecha_nacimiento" name="fecha_nacimiento" required="" placeholder="Ingresar fecha de nacimiento">
                                    <span class="fa fa-edit form-control-feedback left" aria-hidden="true"></span>
                                </div>
                                <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                                    <label>Usuario</label>
                                    <input type="text" class="form-control has-feedback-left" id="usuario" name="usuario" placeholder="Ingresar usuario">
                                    <span class="fa fa-edit form-control-feedback left" aria-hidden="true"></span>
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

    <div class="row" id="oculatFrmListadoTrabajador">
        <div class="col-md-12 col-sm-12 col-xs-12">

            <div class="x_panel">
                <div class="x_title">
                    <h2>Trabajadores <small>lista de trabajadores.</small></h2>
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

                        <table class="table table-striped table-bordered dt-responsive nowrap" id="listaTrabajador" cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                    <th>ID</th>                                    
                                    <th>Nombres</th>
                                    <th>A. Paterno</th>
                                    <th>A. Materno</th>
                                    <th>Dni</th>
                                    <th>Dirección</th>
                                    <th>Teléfono</th>
                                    <th>Celular</th>
                                    <th>F. Nacimiento</th>
                                    <th>Usuario</th>
                                    <th>Contrasena</th>
                                    <th>Estado</th>
                                    <th>Proceso</th>
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

    <!-- /page content -->
    <jsp:include page="../includes/pie_interno.jsp"></jsp:include>