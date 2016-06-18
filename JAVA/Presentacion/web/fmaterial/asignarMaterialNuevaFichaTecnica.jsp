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
            <h3>Asignar Materiales a Ficha Técnica</h3>
        </div>
        <div class="title_right">
            <div class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
                <div class="input-group">
                    <input type="text" name="codigoFicha" id="codigoFicha" class="form-control" placeholder="Ingresar codigo ficha técnica">
                    <span class="input-group-btn">
                        <button class="btn btn-default" id="btnFichaTecnica" type="button">Click</button>
                    </span>
                </div>
            </div>
        </div>
    </div>
    <!--INICIO FORMULARIO-->
    <form id="frmAsignarOrden" action="" method="POST" class="form-horizontal form-label-left">
        <div class="row">        
            <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                <input type="text" class="form-control has-feedback-left" id="plataforma" name="plataforma" placeholder="Plataforma">
                <span class="fa fa-edit form-control-feedback left" aria-hidden="true"></span>
            </div>
            <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                <input type="text" class="form-control has-feedback-left" id="taco" name="taco" placeholder="Taco">
                <span class="fa fa-edit form-control-feedback left" aria-hidden="true"></span>
            </div>
            <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                <input type="text" class="form-control has-feedback-left" id="color" name="color" placeholder="Color">
                <span class="fa fa-edit form-control-feedback left" aria-hidden="true"></span>
            </div>
            <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                <input type="text" class="form-control has-feedback-left" id="coleccion" name="coleccion" placeholder="Colección">
                <span class="fa fa-edit form-control-feedback left" aria-hidden="true"></span>
            </div>
            <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                <input type="text" class="form-control has-feedback-left" id="cod_modelo" name="cod_modelo" readonly="" placeholder="Código Modelo">
                <span class="fa fa-edit form-control-feedback left" aria-hidden="true"></span>
            </div>
        </div>
        <div class="ln_solid"></div>

        <div class="contenedor-materiales-procesos">
            <!-- VER ESTA OARTE DE CODIGO EN LA FUNCION pintarTablasMaterialesPorProceso
            <div class="col-md-6 col-sm-6 col-xs-12">
                <div class="x_panel">
                    <div class="x_title">
                        <h2>Proceso Corte<small></small></h2>
                        <ul class="nav navbar-right panel_toolbox">
                            <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                            </li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                            </li>                        
                        </ul>
                        <div class="clearfix"></div>
                    </div>
                    <div class="x_content">


                        <table class="table table-striped responsive-utilities jambo_table bulk_action">
                            <thead>
                                <tr class="headings">

                                    <th class="column-title" style="display: table-cell;">Nombre </th>
                                    <th class="column-title" style="display: table-cell;">Descripción </th>
                                    <th class="column-title" style="display: table-cell;">U.m </th>
                                    <th class="column-title" style="display: table-cell;">Cant. por doc.</th>                                    
                                </tr>
                            </thead>

                            <tbody>
                                <tr class="even pointer">                        
                                    <td class=" ">121000040</td>
                                    <td class=" ">May 23, 2014 11:47:56 PM </td>
                                    <td class=" ">121000210 <i class="success fa fa-long-arrow-up"></i></td>
                                    <td class=" ">John Blank L</td>                                    
                                </tr>
                                <tr class="odd pointer">                        
                                    <td class=" ">121000039</td>
                                    <td class=" ">May 23, 2014 11:30:12 PM</td>
                                    <td class=" ">121000208 <i class="success fa fa-long-arrow-up"></i>
                                    </td>
                                    <td class=" ">John Blank L</td>                                    
                                </tr>
                                <tr class="even pointer">                        
                                    <td class=" ">121000038</td>
                                    <td class=" ">May 24, 2014 10:55:33 PM</td>
                                    <td class=" ">121000203 <i class="success fa fa-long-arrow-up"></i>
                                    </td>
                                    <td class=" ">Mike Smith</td>

                                </tr>
                                <tr class="odd pointer">                        
                                    <td class=" ">121000037</td>
                                    <td class=" ">May 24, 2014 10:52:44 PM</td>
                                    <td class=" ">121000204</td>
                                    <td class=" ">Mike Smith</td>

                                </tr>
                                <tr class="even pointer">                        
                                    <td class=" ">121000040</td>
                                    <td class=" ">May 24, 2014 11:47:56 PM </td>
                                    <td class=" ">121000210</td>
                                    <td class=" ">John Blank L</td>

                                </tr>
                                <tr class="odd pointer">                        
                                    <td class=" ">121000039</td>
                                    <td class=" ">May 26, 2014 11:30:12 PM</td>
                                    <td class=" ">121000208 <i class="error fa fa-long-arrow-down"></i>
                                    </td>
                                    <td class=" ">John Blank L</td>

                                </tr>
                                <tr class="even pointer">                        
                                    <td class=" ">121000038</td>
                                    <td class=" ">May 26, 2014 10:55:33 PM</td>
                                    <td class=" ">121000203</td>
                                    <td class=" ">Mike Smith</td>

                                </tr>
                                <tr class="odd pointer">                        
                                    <td class=" ">121000037</td>
                                    <td class=" ">May 26, 2014 10:52:44 PM</td>
                                    <td class=" ">121000204</td>
                                    <td class=" ">Mike Smith</td>

                                </tr>                      
                            </tbody>
                        </table>                    

                    </div>
                </div>
            </div>-->
        </div>

        <div class="ln_solid"></div>
        <div class="form-group">                            
            <div class="col-md-9 col-sm-9 col-xs-12 col-md-offset-5">                                
                <button type="submit" class="btn btn-success">Modificar</button>
                <button type="submit" class="btn btn-success">Crear</button>
            </div>
        </div> 

    </form>
    <!--FIN FORMULARIO-->
    <!-- /page content -->
    <jsp:include page="../includes/pie_interno.jsp"></jsp:include>