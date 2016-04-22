<jsp:include page="../includes/cabecera_interna.jsp"></jsp:include>
    <!-- page content -->
    <div class="right_col" role="main">        

        <div class="row">
            <!-- Cliente -->
            <div class="x_panel">
                <div class="x_title">
                    <h2>Formulario Modelo <small>registrar datos.</small></h2>
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
                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Mostrar Imagen</label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <input type="text" class="form-control" name="razon-social" id="razon-social" placeholder="Mostrar Imagen">
                            </div>
                        </div>                    
                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Horma</label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <input type="text" class="form-control" name="ruc" id="ruc" value="" placeholder="Horma">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Taco</label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <input type="text" name="direccion" id="direccion" class="form-control" placeholder="Taco">                        
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Plataforma</label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <input type="text" class="form-control" name="ruc" id="ruc" value="" placeholder="Plataforma">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Colección</label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <input type="text" class="form-control" name="ruc" id="ruc" value="" placeholder="Colección">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Especificación</label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <input type="text" class="form-control" name="ruc" id="ruc" value="" placeholder="Especificación">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Cliente</label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <input type="text" class="form-control" name="ruc" id="ruc" value="" placeholder="Cliente">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 col-sm-3 col-xs-12 control-label">Estado                        
                            </label>
                            <div class="col-md-9 col-sm-9 col-xs-12">
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" value=""> Opción para habilitar un modelo.
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