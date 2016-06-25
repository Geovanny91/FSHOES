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

    <div class="page-title">
        <div class="title_left">
            <h2>Materiales<small> asignar materiales a nueva ficha técnica de un modelo.</small></h2>
        </div>
        <div class="title_right">
            <div class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
                <div class="input-group">
                    <input type="text" name="id_fichatecnica" id="id_fichatecnica" class="form-control" placeholder="Ingresar codigo ficha técnica">
                    <span class="input-group-btn">
                        <button class="btn btn-default" id="btnFichaTecnica" type="button">Click</button>
                    </span>
                </div>
            </div>
        </div>
    </div>
    
    <!--INICIO FORMULARIO-->
    <form id="frmAsignarMateriales" action="" method="POST" class="form-horizontal form-label-left">
        
        <div class="row">        
            <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                <label>Plataforma</label>
                <input type="text" class="form-control has-feedback-left" id="plataforma" name="plataforma" placeholder="Plataforma">
                <span class="fa fa-edit form-control-feedback left" aria-hidden="true"></span>
            </div>
            <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                <label>Taco</label>
                <input type="text" class="form-control has-feedback-left" id="taco" name="taco" placeholder="Taco">
                <span class="fa fa-edit form-control-feedback left" aria-hidden="true"></span>
            </div>
            <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                <label>Color</label>
                <input type="text" class="form-control has-feedback-left" id="color" name="color" placeholder="Color">
                <span class="fa fa-edit form-control-feedback left" aria-hidden="true"></span>
            </div>
            <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                <label>Colección</label>
                <input type="text" class="form-control has-feedback-left" id="coleccion" name="coleccion" placeholder="Colección">
                <span class="fa fa-edit form-control-feedback left" aria-hidden="true"></span>
            </div>
            <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                <label>Código Modelo</label>
                <input type="text" class="form-control has-feedback-left" id="modelo" name="modelo" readonly="" placeholder="Código Modelo">
                <span class="fa fa-edit form-control-feedback left" aria-hidden="true"></span>
            </div>
        </div>
        <div class="ln_solid"></div>

        <div class="contenedor-materiales-procesos">            
        </div>

        <div class="ln_solid"></div>
        <div class="form-group">                            
            <div class="col-md-9 col-sm-9 col-xs-12 col-md-offset-5">                                
                <button id="btnModificarFicha" type="submit" class="btn btn-success">Modificar</button>
                <button id="btnCrearFicha" type="submit" class="btn btn-success">Crear</button>
            </div>
        </div> 

    </form>
    <!--FIN FORMULARIO-->
    <!-- /page content -->
    <jsp:include page="../includes/pie_interno.jsp"></jsp:include>