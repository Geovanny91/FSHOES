<%-- 
    Document   : ordenesTerminadas
    Created on : 16/07/2016, 12:02:56 PM
    Author     : masong
--%>

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
        <div class="col-md-12 col-sm-12 col-xs-12">

            <div class="x_panel">
                <div class="x_title">
                    <h2>Órdenes Terminadas   <small>lista de órdenes terminadas.</small></h2>
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
                    <input type="text" value="2016-05-31" name="f_emision" id="f_emision" />
                    <input type="text" value="2016-07-30" name="f_entrega" id="f_entrega" />
                    <input type="button" value="Click" id="btnMostrarOrdenes"/>
                    <table class="table table-striped table-bordered dt-responsive nowrap" id="listaOrdenesTerminadas" cellspacing="0" width="100%">
                        <thead>
                            <tr>
                                <th>Orden</th>
                                <th>Pedido</th>
                                <th>Fecha Entrega</th>                                 
                                <th>Ficha Técnica</th>
                                <th>Total</th>
                                
                            </tr>
                        </thead>            
                    </table>
                </div>
            </div>
        </div>
    </div>
    
    <!-- /page content -->
    <jsp:include page="../includes/pie_interno.jsp"></jsp:include>