package org.apache.jsp.cliente;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class mantenedorClientes_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "cabecera.jsp", out, false);
      out.write("\n");
      out.write("      <!-- page content -->\n");
      out.write("      <div class=\"right_col\" role=\"main\">        \n");
      out.write("          \n");
      out.write("          <div class=\"row\">\n");
      out.write("            <!-- Cliente -->\n");
      out.write("            <div class=\"col-md-12 col-sm-12 col-xs-12\">\n");
      out.write("              <div class=\"x_panel\">\n");
      out.write("                <div class=\"x_title\">\n");
      out.write("                  <h2>Form Design <small>different form elements</small></h2>\n");
      out.write("                  <ul class=\"nav navbar-right panel_toolbox\">\n");
      out.write("                    <li><a class=\"collapse-link\"><i class=\"fa fa-chevron-up\"></i></a>\n");
      out.write("                    </li>\n");
      out.write("                    <li class=\"dropdown\">\n");
      out.write("                      <a href=\"#\" class=\"dropdown-toggle\" data-toggle=\"dropdown\" role=\"button\" aria-expanded=\"false\"><i class=\"fa fa-wrench\"></i></a>\n");
      out.write("                      <ul class=\"dropdown-menu\" role=\"menu\">\n");
      out.write("                        <li><a href=\"#\">Settings 1</a>\n");
      out.write("                        </li>\n");
      out.write("                        <li><a href=\"#\">Settings 2</a>\n");
      out.write("                        </li>\n");
      out.write("                      </ul>\n");
      out.write("                    </li>\n");
      out.write("                    <li><a class=\"close-link\"><i class=\"fa fa-close\"></i></a>\n");
      out.write("                    </li>\n");
      out.write("                  </ul>\n");
      out.write("                  <div class=\"clearfix\"></div>\n");
      out.write("                </div>\n");
      out.write("                <div class=\"x_content\">\n");
      out.write("                  <br>\n");
      out.write("                  <form id=\"demo-form2\" data-parsley-validate=\"\" class=\"form-horizontal form-label-left\" novalidate=\"\">\n");
      out.write("\n");
      out.write("                    <div class=\"form-group\">\n");
      out.write("                      <label class=\"control-label col-md-3 col-sm-3 col-xs-12\" for=\"first-name\">First Name <span class=\"required\">*</span>\n");
      out.write("                      </label>\n");
      out.write("                      <div class=\"col-md-6 col-sm-6 col-xs-12\">\n");
      out.write("                        <input type=\"text\" id=\"first-name\" required=\"required\" class=\"form-control col-md-7 col-xs-12\" data-parsley-id=\"4785\"><ul class=\"parsley-errors-list\" id=\"parsley-id-4785\"></ul>\n");
      out.write("                      </div>\n");
      out.write("                    </div>\n");
      out.write("                    <div class=\"form-group\">\n");
      out.write("                      <label class=\"control-label col-md-3 col-sm-3 col-xs-12\" for=\"last-name\">Last Name <span class=\"required\">*</span>\n");
      out.write("                      </label>\n");
      out.write("                      <div class=\"col-md-6 col-sm-6 col-xs-12\">\n");
      out.write("                        <input type=\"text\" id=\"last-name\" name=\"last-name\" required=\"required\" class=\"form-control col-md-7 col-xs-12\" data-parsley-id=\"9450\"><ul class=\"parsley-errors-list\" id=\"parsley-id-9450\"></ul>\n");
      out.write("                      </div>\n");
      out.write("                    </div>\n");
      out.write("                    <div class=\"form-group\">\n");
      out.write("                      <label for=\"middle-name\" class=\"control-label col-md-3 col-sm-3 col-xs-12\">Middle Name / Initial</label>\n");
      out.write("                      <div class=\"col-md-6 col-sm-6 col-xs-12\">\n");
      out.write("                        <input id=\"middle-name\" class=\"form-control col-md-7 col-xs-12\" type=\"text\" name=\"middle-name\" data-parsley-id=\"0562\"><ul class=\"parsley-errors-list\" id=\"parsley-id-0562\"></ul>\n");
      out.write("                      </div>\n");
      out.write("                    </div>\n");
      out.write("                    <div class=\"form-group\">\n");
      out.write("                      <label class=\"control-label col-md-3 col-sm-3 col-xs-12\">Gender</label>\n");
      out.write("                      <div class=\"col-md-6 col-sm-6 col-xs-12\">\n");
      out.write("                        <div id=\"gender\" class=\"btn-group\" data-toggle=\"buttons\">\n");
      out.write("                          <label class=\"btn btn-default\" data-toggle-class=\"btn-primary\" data-toggle-passive-class=\"btn-default\">\n");
      out.write("                            <input type=\"radio\" name=\"gender\" value=\"male\" data-parsley-multiple=\"gender\" data-parsley-id=\"5538\"> &nbsp; Male &nbsp;\n");
      out.write("                          </label><ul class=\"parsley-errors-list\" id=\"parsley-id-multiple-gender\"></ul>\n");
      out.write("                          <label class=\"btn btn-primary active\" data-toggle-class=\"btn-primary\" data-toggle-passive-class=\"btn-default\">\n");
      out.write("                            <input type=\"radio\" name=\"gender\" value=\"female\" checked=\"\" data-parsley-multiple=\"gender\" data-parsley-id=\"5538\"> Female\n");
      out.write("                          </label>\n");
      out.write("                        </div>\n");
      out.write("                      </div>\n");
      out.write("                    </div>\n");
      out.write("                    <div class=\"form-group\">\n");
      out.write("                      <label class=\"control-label col-md-3 col-sm-3 col-xs-12\">Date Of Birth <span class=\"required\">*</span>\n");
      out.write("                      </label>\n");
      out.write("                      <div class=\"col-md-6 col-sm-6 col-xs-12\">\n");
      out.write("                        <input id=\"birthday\" class=\"date-picker form-control col-md-7 col-xs-12\" required=\"required\" type=\"text\" data-parsley-id=\"6097\"><ul class=\"parsley-errors-list\" id=\"parsley-id-6097\"></ul>\n");
      out.write("                      </div>\n");
      out.write("                    </div>\n");
      out.write("                    <div class=\"ln_solid\"></div>\n");
      out.write("                    <div class=\"form-group\">\n");
      out.write("                      <div class=\"col-md-6 col-sm-6 col-xs-12 col-md-offset-3\">\n");
      out.write("                        <button type=\"submit\" class=\"btn btn-primary\">Cancel</button>\n");
      out.write("                        <button type=\"submit\" class=\"btn btn-success\">Submit</button>\n");
      out.write("                      </div>\n");
      out.write("                    </div>\n");
      out.write("\n");
      out.write("                  </form>\n");
      out.write("                </div>\n");
      out.write("              </div>\n");
      out.write("            </div>\n");
      out.write("\n");
      out.write("            <!-- Cliente -->\n");
      out.write("          </div>        \n");
      out.write("      </div>\n");
      out.write("      <!-- /page content -->\n");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "pie.jsp", out, false);
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
