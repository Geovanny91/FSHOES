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
            <form action="" method="POST" class="form-horizontal form-label-left">
                <div class="col-md-6 col-sm-6 col-xs-12">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>Formulario Orden <small>registrar datos.</small></h2>
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

                            <input type="hidden" class="form-control" name="id-proveedor" id="id-proveedor" value="">
                            <div class="form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12">Código de Orden</label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input type="text" class="form-control" name="codigo-orden" id="codigo-orden" placeholder="Código de Orden">
                                </div>
                            </div>                    
                            <div class="form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12">Orden de pedido</label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input type="text" class="form-control" name="orden-pedido" id="orden-pedido" value="" placeholder="Orden de pedido">
                                </div>
                            </div>
                            

                            <!--INICIO-->
                            <div class="form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12">Fecha emision</label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input type="text" class="form-control has-feedback-left" id="fecha-emision" name="fecha-emision" placeholder="Fecha emisión">
                                    <span class="fa fa-calendar-o form-control-feedback left" aria-hidden="true"></span>
                                </div>
                            </div>                            
                            <div class="daterangepicker picker_2 single opensright show-calendar"></div>
                            
                            <!--FIN-->

                            <div class="form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12">Fecha entrega</label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input type="text" class="form-control has-feedback-left" name="fecha-entrega" id="fecha-entrega" value="" placeholder="Fecha entrega">
                                    <span class="fa fa-calendar-o form-control-feedback left" aria-hidden="true"></span>
                                </div>
                            </div>
                            <div class="daterangepicker picker_2 single opensright show-calendar"></div>

                            <div class="form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12">Total</label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input type="text" class="form-control" name="total" id="total" value="" placeholder="Total">
                                </div>
                            </div>                        
                            <div class="ln_solid"></div>
                            <div class="form-group">
                                <div class="col-md-9 col-sm-9 col-xs-12 col-md-offset-3">
                                    <button type="reset" class="btn btn-primary">Cancelar</button>
                                    <button type="submit" class="btn btn-success">Guardar</button>
                                </div>
                            </div>
                            <!--</form>-->
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-sm-6 col-xs-12">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>Formulario Serie <small>agregar datos.</small></h2>
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

                            <div class="form-group">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12">Talla</label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input type="text" class="form-control" name="talla" id="talla" value="" placeholder="Ingresar n° talla">                                
                                </div>
                            </div>
                            <div class="form-group ">
                                <label class="control-label col-md-3 col-sm-3 col-xs-12">Pares</label>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input type="text" class="form-control" name="par" id="par" value="" placeholder="Ingresar n° pares ">                                
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-9 col-sm-9 col-xs-12 col-md-offset-3">
                                    <button type="button" onclick="agregarSerie();" class="btn btn-default"><i class="fa fa-plus-square"></i> Agregar</button>
                                    <button type="button" name="terminar-serie" id="terminar-serie" class="btn btn-default"><i class="fa fa-check-square"></i> Terminar</button>
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
                            </div>


                        </div>
                    </div>
                    <!-- Cliente -->
                </div>
            </form>
        </div>
        <!-- /page content -->
    <jsp:include page="../includes/pie_interno.jsp"></jsp:include>