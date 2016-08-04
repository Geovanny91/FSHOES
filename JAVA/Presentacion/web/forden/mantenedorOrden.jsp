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
        <!--<form id="frmOrden" method="POST" class="form-horizontal form-label-left">-->
        <div class="col-md-6 col-sm-6 col-xs-12">
            <div class="x_panel">
                <div class="x_title">
                    <h2>Formulario Orden <small id="mensajeOrden" ></small></h2>
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
                    <form id="frmOrden" action="../SOrden" method="POST" class="form-horizontal form-label-left">
                        <br>
                        <input type="hidden" name="id_fichatecnica" id="id_fichatecnica" value="">

                        <!--INICIO MODAL MODELO-->
                        <div class="modal fade bs-example-modal-lg" id="modalModeloPorFicha" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
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
                                                                    <!--th>Id Cliente</th>-->
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

                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Orden de Producciòn</label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <input type="text" class="form-control" name="orden" id="orden" placeholder="Ingresar código de orden" required="">
                            </div>
                        </div>                    
                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Orden de pedido</label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <input type="text" class="form-control" name="pedido" id="pedido" value="" placeholder="Ingresar orden de pedido" required="">
                            </div>
                        </div>


                        <!--INICIO-->
                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Fecha emision</label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <input type="text" class="form-control has-feedback-left" id="f_emision" name="f_emision" placeholder="Ingresar fecha de emisión" required="">
                                <span class="fa fa-calendar-o form-control-feedback left" aria-hidden="true"></span>
                            </div>
                        </div>                            
                        <div class="daterangepicker picker_2 single opensright show-calendar"></div>

                        <!--FIN-->

                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Fecha entrega</label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <input type="text" class="form-control has-feedback-left" name="f_entrega" id="f_entrega" value="" placeholder="Ingresar fecha de entrega" required="">
                                <span class="fa fa-calendar-o form-control-feedback left" aria-hidden="true"></span>
                            </div>
                        </div>
                        <div class="daterangepicker picker_2 single opensright show-calendar"></div>

                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Total</label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <input type="text" class="form-control" name="total" id="total" value="0" placeholder="Ingresar total" readonly="">
                            </div>
                        </div>                        
                        <div class="form-group">                            
                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Ficha Técnica</label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <input type="text" class="form-control" name="ficha_tecnica" id="ficha_tecnica" value="" placeholder="Ingresar código de ficha técnica" readonly="">                                
                            </div>
                        </div>
                        <div class="ln_solid"></div>
                        <div class="form-group">                            
                            <div class="col-md-9 col-sm-9 col-xs-12 col-md-offset-3">
                                <button type="button" id="guardarOrden" class="btn btn-success">Guardar</button>
                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modalModeloPorFicha" ><i class="fa fa-search"></i> Ficha</button>
                                
                            </div>
                        </div>                        
                    </form>
                </div>
            </div>
        </div>
        <div class="col-md-6 col-sm-6 col-xs-12">
            <div class="x_panel">
                <div class="x_title">
                    <h2>Formulario Serie <small>agregar nùmero de pares de acuerdo a cada talla.</small></h2>
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
                    <form class="form-horizontal form-label-left">

                        <table id="tabla-general-serie" class="table table-striped table-bordered dt-responsive nowrap" cellspacing="0" width="100%">
                            <thead>
                                <tr>                                                    
                                    <!--<th class="text-center">34</th>-->
                                    <th class="text-center">35</th>                                                    
                                    <th class="text-center">36</th>
                                    <th class="text-center">37</th>
                                    <th class="text-center">38</th>
                                    <th class="text-center">39</th>
                                    <th class="text-center">40</th>
                                </tr>
                            </thead>
                            <tbody id="tabla-serie">
                                <tr>
                                    <!--<td><input id="par1" type="number" min="0" class="cantidad form-control text-center" value="0"/></td>-->
                                    <td><input id="par1" type="number" min="0" class="cantidad form-control text-center" value="0"/></td>
                                    <td><input id="par2" type="number" min="0" class="cantidad form-control text-center" value="0"/></td>
                                    <td><input id="par3" type="number" min="0" class="cantidad form-control text-center" value="0"/></td>
                                    <td><input id="par4" type="number" min="0" class="cantidad form-control text-center" value="0"/></td>
                                    <td><input id="par5" type="number" min="0" class="cantidad form-control text-center" value="0"/></td>
                                    <td><input id="par6" type="number" min="0" class="cantidad form-control text-center" value="0"/></td>
                                </tr>
                            </tbody>
                        </table>
                        <div class="ln_solid"></div>
                        <div class="form-group">
                            <div class="col-md-9 col-sm-9 col-xs-12">                                
                                <button type="button" id="generarTotal" class="btn btn-primary">Generar Total</button>
                            </div>
                        </div>
                        <!--
                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Talla</label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <input type="number" class="form-control" name="talla" id="talla" value="0" placeholder="Ingresar n° talla" min="34" max="40" required="">                                
                            </div>
                        </div>
                        <div class="form-group ">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Pares</label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <input type="text" class="form-control" name="par" id="par" value="0" placeholder="Ingresar n° pares " required="">                                
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-9 col-sm-9 col-xs-12 col-md-offset-3">
                                <button type="button" onclick="agregarSerie();" class="btn btn-default"><i class="fa fa-plus-square"></i> Agregar</button>                                    
                            </div>
                        </div>

                        <div class="ln_solid"></div>
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <div class="x_panel">
                                <div class="x_title">
                                    <h2>Detalle serie <small>agregar datos.</small></h2>
                                    <ul class="nav navbar-right panel_toolbox">
                                        <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                        </li>                                                                
                                        <li><a class="close-link"><i class="fa fa-close"></i></a>
                                        </li>
                                    </ul>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                    <table id="tabla-general-serie" class="table table-hover">
                                        <thead>
                                            <tr>                                                    
                                                <th>Talla</th>
                                                <th>Pares</th>                                                    
                                                <th></th>
                                            </tr>
                                        </thead>
                                        <tbody id="tabla-serie">                                                                    
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>-->
                    </form>
                </div>
            </div>
            <!-- Cliente -->
        </div>
        <!--</form>-->
    </div>
    <!-- /page content -->
    <jsp:include page="../includes/pie_interno.jsp"></jsp:include>