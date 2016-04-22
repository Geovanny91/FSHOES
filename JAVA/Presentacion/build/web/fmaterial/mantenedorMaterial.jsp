<jsp:include page="../includes/cabecera_interna.jsp"></jsp:include>
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
                    <form action="" method="POST" class="form-horizontal form-label-left">

                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Descripccion</label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <input type="text" class="form-control" name="descripccion" id="descripccion" placeholder="Descripccion">
                            </div>
                        </div>                    
                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Unidad de medida</label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <input type="text" class="form-control" name="unidad-medida" id="unidad-medida" value="" placeholder="Unidad de medida">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Cantidad por docena</label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <input type="text" name="cantidad-docena" id="cantidad-docena" class="form-control" placeholder="Cantidad por Docena">                        
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Precio Unitario</label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <input type="text" class="form-control" name="precio-unitario" id="precio-unitario" value="" placeholder="Precio Unitario">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Tipo</label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <input type="text" class="form-control" name="tipo" id="tipo" value="" placeholder="Tipo">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Color</label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <input type="text" class="form-control" name="color" id="color" value="" placeholder="Color">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Cliente</label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <input type="text" class="form-control" name="ruc" id="ruc" value="" placeholder="Cliente">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12">idproveedor</label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <input type="text" class="form-control" name="provedor" id="provedor" value="" placeholder="idproveedor">
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