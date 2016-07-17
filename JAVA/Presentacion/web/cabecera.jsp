<%-- 
    Document   : frmPrincipal
    Created on : 14-abr-2016, 8:29:14
    Author     : Rìos Abarca Geovanny
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.fshoes.entidades.Trabajador" %>
<!DOCTYPE html>
<html lang="es">

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Meta, title, CSS, favicons, etc. -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>FHOES System</title>

        <!-- Bootstrap core CSS -->

        <link href="css/bootstrap.min.css" rel="stylesheet">

        <link href="fonts/css/font-awesome.min.css" rel="stylesheet">  

        <!-- Custom styling plus plugins -->
        <link href="css/custom.css" rel="stylesheet">  

        <!--[if lt IE 9]>
              <script src="../assets/js/ie8-responsive-file-warning.js"></script>
              <![endif]-->

        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!--[if lt IE 9]>
                <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
                <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
              <![endif]-->

    </head>


    <body class="nav-md">

        <div class="container body">


            <div class="main_container">

                <div class="col-md-3 left_col">
                    <div class="left_col scroll-view">

                        <div class="navbar nav_title" style="border: 0;">
                            <a href="frmPrincipal.jsp" class="site_title"><i class="fa fa-paw"></i> <span>FSHOES System</span></a>
                        </div>
                        <div class="clearfix"></div>

                        <!-- menu prile quick info -->
                        <%
                            String usuario = "";
                            HttpSession ses = request.getSession();
                            if (ses.getAttribute("trabajador") != null) {
                                Trabajador u = (Trabajador) ses.getAttribute("trabajador");
                                usuario = u.getNombreCompleto();
                            } else {
                                response.sendRedirect("index.html");
                            }
                        %>

                        <div class="profile">
                            <div class="profile_pic">
                                <img src="images/img.jpg" alt="..." class="img-circle profile_img">
                            </div>
                            <div class="profile_info">
                                <span>Bienvenido,</span>
                                <h2><%=usuario%></h2>
                            </div>
                        </div>
                        <!-- /menu prile quick info -->

                        <br />

                        <!-- sidebar menu -->
                        <div id="sidebar-menu" class="main_menu_side hidden-print main_menu">

                            <div class="menu_section">
                                <h3>General</h3>
                                <ul class="nav side-menu">                
                                    <li><a><i class="fa fa-desktop"></i> Modelo <span class="fa fa-chevron-down"></span></a>
                                        <ul class="nav child_menu" style="display: none">
                                            <li><a href="fmodelo/mantenedorModelo.jsp">Nuevo</a>
                                            </li>
                                            <li><a href="fmodelo/listadoModelo.jsp">Lista</a>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><a><i class="fa fa-table"></i> Material <span class="fa fa-chevron-down"></span></a>
                                        <ul class="nav child_menu" style="display: none">
                                            <li><a href="fmaterial/mantenedorMaterial.jsp">Registrar</a>
                                            <li><a href="fmaterial/listadoMaterial.jsp">Listar</a>
                                            <li><a href="fmaterial/asignarMaterialNuevaFichaTecnica.jsp">Asignar</a></li>
                                    </li>                    
                                </ul>
                                </li>
                                <li><a><i class="fa fa-bar-chart-o"></i> Orden <span class="fa fa-chevron-down"></span></a>
                                    <ul class="nav child_menu" style="display: none">
                                        <li><a href="forden/mantenedorOrden.jsp">Registrar</a>
                                        <li><a href="forden/asignarOrdenTrabajador.jsp">Asignar</a>
                                        <li><a href="forden/ordenesTerminadas.jsp">Verificar</a></li>
                                        <li><a href="forden/exportarDatosOrden.jsp" target="_blank">Exportar</a></li>                                                         
                                    </ul>
                                </li>
                                </ul>
                            </div>
                            <div class="menu_section">
                                <h3>Live On</h3>
                                <ul class="nav side-menu">
                                    <li><a><i class="fa fa-bug"></i> Proveedor <span class="fa fa-chevron-down"></span></a>
                                        <ul class="nav child_menu" style="display: none">
                                            <li><a href="fproveedor/mantenedorProveedor.jsp">Registrar</a>
                                            </li>
                                            <li><a href="fproveedor/listarProveedor.jsp">Listar</a>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><a><i class="fa fa-edit"></i> Cliente <span class="fa fa-chevron-down"></span></a>
                                        <ul class="nav child_menu" style="display: none">
                                            <li><a href="fcliente/mantenedorClientes.jsp">Registrar</a>
                                            </li>
                                            <li><a href="fcliente/listarCliente.jsp">Listar</a>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><a><i class="fa fa-laptop"></i> Landing Page <span class="label label-success pull-right">Coming Soon</span></a>
                                    </li>
                                </ul>
                            </div>

                        </div>
                        <!-- /sidebar menu -->
                    </div>
                </div>

                <!-- top navigation -->
                <div class="top_nav">

                    <div class="nav_menu">
                        <nav class="" role="navigation">
                            <div class="nav toggle">
                                <a id="menu_toggle"><i class="fa fa-bars"></i></a>
                            </div>

                            <ul class="nav navbar-nav navbar-right">
                                <li class="">
                                    <a href="javascript:;" class="user-profile dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                        <img src="images/img.jpg" alt=""><%=usuario%>
                                        <span class=" fa fa-angle-down"></span>
                                    </a>
                                    <ul class="dropdown-menu dropdown-usermenu animated fadeInDown pull-right">
                                        <li><a href="javascript:;">  Perfil</a>
                                        </li>
                                        <li>
                                            <a href="javascript:;">                      
                                                <span>Configuraciòn</span>
                                            </a>
                                        </li>                  
                                        <li><a href="#" id="salir"><span>
                                                    <span>
                                                        <form id="formlogout" method="POST" action="CerrarSesion" > 
                                                            <!--<button class="btn btn-sm btn-default" ><i class="fa fa-sign-out pull-right"></i>Salir</button>-->
                                                        </form>
                                                        <i class="fa fa-sign-out pull-right"></i> Salir
                                                    </span>
                                                </span></a>
                                        </li>
                                    </ul>
                                </li>

                                <li role="presentation" class="dropdown">
                                    <a href="javascript:;" class="dropdown-toggle info-number" data-toggle="dropdown" aria-expanded="false">
                                        <i class="fa fa-envelope-o"></i>
                                        <span class="badge bg-green">6</span>
                                    </a>
                                    <ul id="menu1" class="dropdown-menu list-unstyled msg_list animated fadeInDown" role="menu">
                                        <li>
                                            <a>
                                                <span class="image">
                                                    <img src="images/img.jpg" alt="Profile Image" />
                                                </span>
                                                <span>
                                                    <span>John Smith</span>
                                                    <span class="time">3 mins ago</span>
                                                </span>
                                                <span class="message">
                                                    Film festivals used to be do-or-die moments for movie makers. They were where...
                                                </span>
                                            </a>
                                        </li>
                                        <li>
                                            <a>
                                                <span class="image">
                                                    <img src="images/img.jpg" alt="Profile Image" />
                                                </span>
                                                <span>
                                                    <span>John Smith</span>
                                                    <span class="time">3 mins ago</span>
                                                </span>
                                                <span class="message">
                                                    Film festivals used to be do-or-die moments for movie makers. They were where...
                                                </span>
                                            </a>
                                        </li>
                                        <li>
                                            <a>
                                                <span class="image">
                                                    <img src="images/img.jpg" alt="Profile Image" />
                                                </span>
                                                <span>
                                                    <span>John Smith</span>
                                                    <span class="time">3 mins ago</span>
                                                </span>
                                                <span class="message">
                                                    Film festivals used to be do-or-die moments for movie makers. They were where...
                                                </span>
                                            </a>
                                        </li>
                                        <li>
                                            <a>
                                                <span class="image">
                                                    <img src="images/img.jpg" alt="Profile Image" />
                                                </span>
                                                <span>
                                                    <span>John Smith</span>
                                                    <span class="time">3 mins ago</span>
                                                </span>
                                                <span class="message">
                                                    Film festivals used to be do-or-die moments for movie makers. They were where...
                                                </span>
                                            </a>
                                        </li>
                                        <li>
                                            <div class="text-center">
                                                <a href="inbox.html">
                                                    <strong>See All Alerts</strong>
                                                    <i class="fa fa-angle-right"></i>
                                                </a>
                                            </div>
                                        </li>
                                    </ul>
                                </li>

                            </ul>
                        </nav>
                    </div>

                </div>
                <!-- /top navigation -->