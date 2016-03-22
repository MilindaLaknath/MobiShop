package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import conn.FactoryManager;
import org.hibernate.Session;
import hiben.Invoice;
import hiben.User;

public final class client_005finvoice_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.ArrayList<String>(2);
    _jspx_dependants.add("/partials/header.jsp");
    _jspx_dependants.add("/partials/commonjs.jsp");
  }

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
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        ");
      out.write("\n");
      out.write("\n");
      out.write("    <meta charset=\"utf-8\">\n");
      out.write("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n");
      out.write("\n");
      out.write("    <title>MobiShop</title>\n");
      out.write("\n");
      out.write("    <link href=\"http://localhost:8080/MobiShop/partials/assets/css/bootstrap.min.css\" rel=\"stylesheet\">\n");
      out.write("    <link href=\"http://localhost:8080/MobiShop/partials/assets/font-awesome/css/font-awesome.css\" rel=\"stylesheet\">\n");
      out.write("\n");
      out.write("    <link href=\"http://localhost:8080/MobiShop/partials/assets/css/animate.css\" rel=\"stylesheet\">\n");
      out.write("    <link href=\"http://localhost:8080/MobiShop/partials/assets/css/style.css\" rel=\"stylesheet\">\n");
      out.write("\n");
      out.write("    <!-- Toastr -->\n");
      out.write("    <link href=\"http://localhost:8080/MobiShop/partials/assets/css/plugins/toastr/toastr.min.css\" rel=\"stylesheet\">\n");
      out.write("\n");
      out.write("\n");
      out.write("    <!-- FAVICONS -->\n");
      out.write("<!--    <link rel=\"shortcut icon\" href=\"http://localhost:8080/MobiShop/partials/assets/img/favicon/favicon.ico\" type=\"image/x-icon\">\n");
      out.write("    <link rel=\"icon\" href=\"http://localhost:8080/MobiShop/partials/assets/img/favicon/favicon.ico\" type=\"image/x-icon\">-->\n");
      out.write("\n");
      out.write("    <!-- GOOGLE FONT -->\n");
      out.write("    <link rel=\"stylesheet\" href=\"http://fonts.googleapis.com/css?family=Open+Sans:400italic,700italic,300,400,700\">\n");
      out.write("\n");
      out.write("\n");
      out.write("    </head>\n");
      out.write("    <body class=\"white-bg\">\n");
      out.write("\n");
      out.write("        <div class=\"wrapper wrapper-content p-xl\">\n");
      out.write("\n");
      out.write("            ");
                     try {
                    User user = null;
                    user = (User) session.getAttribute("user");
                    if (user == null) {
                        response.sendRedirect("login.jsp");
                        return;
                    }

                    String invoiceid = request.getParameter("invoiceid");
                    if (invoiceid == null && invoiceid.equals("")) {
                        response.sendRedirect("client_user_orders.jsp");
                        return;
                    }
                    
                    Session con = FactoryManager.getSessionFactory().openSession();
                    
                    Invoice inv = (Invoice)con.load(Invoice.class, Integer.parseInt(invoiceid));
                    
                    if (inv == null) {
                        response.sendRedirect("client_user_orders.jsp");
                        return;
                    }

            
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("            <div class=\"ibox-content p-xl\">\n");
      out.write("                <div class=\"row\">\n");
      out.write("                    <div class=\"col-sm-6\">\n");
      out.write("                        <h5>From:</h5>\n");
      out.write("                        <address>\n");
      out.write("                            <strong>Inspinia, Inc.</strong><br>\n");
      out.write("                            106 Jorg Avenu, 600/10<br>\n");
      out.write("                            Chicago, VT 32456<br>\n");
      out.write("                            <abbr title=\"Phone\">P:</abbr> (123) 601-4590\n");
      out.write("                        </address>\n");
      out.write("                    </div>\n");
      out.write("\n");
      out.write("                    <div class=\"col-sm-6 text-right\">\n");
      out.write("                        <h4>Invoice No.</h4>\n");
      out.write("                        <h4 class=\"text-navy\">INV-000567F7-00</h4>\n");
      out.write("                        <span>To:</span>\n");
      out.write("                        <address>\n");
      out.write("                            <strong>Corporate, Inc.</strong><br>\n");
      out.write("                            112 Street Avenu, 1080<br>\n");
      out.write("                            Miami, CT 445611<br>\n");
      out.write("                            <abbr title=\"Phone\">P:</abbr> (120) 9000-4321\n");
      out.write("                        </address>\n");
      out.write("                        <p>\n");
      out.write("                            <span><strong>Invoice Date:</strong> Marh 18, 2014</span><br/>\n");
      out.write("                            <span><strong>Due Date:</strong> March 24, 2014</span>\n");
      out.write("                        </p>\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("\n");
      out.write("                <div class=\"table-responsive m-t\">\n");
      out.write("                    <table class=\"table invoice-table\">\n");
      out.write("                        <thead>\n");
      out.write("                            <tr>\n");
      out.write("                                <th>Item List</th>\n");
      out.write("                                <th>Quantity</th>\n");
      out.write("                                <th>Unit Price</th>\n");
      out.write("                                <th>Tax</th>\n");
      out.write("                                <th>Total Price</th>\n");
      out.write("                            </tr>\n");
      out.write("                        </thead>\n");
      out.write("                        <tbody>\n");
      out.write("                            <tr>\n");
      out.write("                                <td><div><strong>Admin Theme with psd project layouts</strong></div>\n");
      out.write("                                    <small>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</small></td>\n");
      out.write("                                <td>1</td>\n");
      out.write("                                <td>$26.00</td>\n");
      out.write("                                <td>$5.98</td>\n");
      out.write("                                <td>$31,98</td>\n");
      out.write("                            </tr>\n");
      out.write("                            <tr>\n");
      out.write("                                <td><div><strong>Wodpress Them customization</strong></div>\n");
      out.write("                                    <small>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\n");
      out.write("                                        Eiusmod tempor incididunt ut labore et dolore magna aliqua.\n");
      out.write("                                    </small></td>\n");
      out.write("                                <td>2</td>\n");
      out.write("                                <td>$80.00</td>\n");
      out.write("                                <td>$36.80</td>\n");
      out.write("                                <td>$196.80</td>\n");
      out.write("                            </tr>\n");
      out.write("                            <tr>\n");
      out.write("                                <td><div><strong>Angular JS & Node JS Application</strong></div>\n");
      out.write("                                    <small>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</small></td>\n");
      out.write("                                <td>3</td>\n");
      out.write("                                <td>$420.00</td>\n");
      out.write("                                <td>$193.20</td>\n");
      out.write("                                <td>$1033.20</td>\n");
      out.write("                            </tr>\n");
      out.write("\n");
      out.write("                        </tbody>\n");
      out.write("                    </table>\n");
      out.write("                </div><!-- /table-responsive -->\n");
      out.write("\n");
      out.write("                <table class=\"table invoice-total\">\n");
      out.write("                    <tbody>\n");
      out.write("                        <tr>\n");
      out.write("                            <td><strong>Sub Total :</strong></td>\n");
      out.write("                            <td>$1026.00</td>\n");
      out.write("                        </tr>\n");
      out.write("                        <tr>\n");
      out.write("                            <td><strong>TAX :</strong></td>\n");
      out.write("                            <td>$235.98</td>\n");
      out.write("                        </tr>\n");
      out.write("                        <tr>\n");
      out.write("                            <td><strong>TOTAL :</strong></td>\n");
      out.write("                            <td>$1261.98</td>\n");
      out.write("                        </tr>\n");
      out.write("                    </tbody>\n");
      out.write("                </table>\n");
      out.write("                <div class=\"well m-t\"><strong>Comments</strong>\n");
      out.write("                    It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("            ");
                    } catch (Exception e) {
                    e.printStackTrace();
                }
            
      out.write("\n");
      out.write("        </div>\n");
      out.write("        ");
      out.write("\n");
      out.write("\n");
      out.write("<script src=\"http://localhost:8080/MobiShop/partials/assets/js/jquery-2.1.1.js\"></script>\n");
      out.write("<script src=\"http://localhost:8080/MobiShop/partials/assets/js/bootstrap.min.js\"></script>\n");
      out.write("<script src=\"http://localhost:8080/MobiShop/partials/assets/js/plugins/metisMenu/jquery.metisMenu.js\"></script>\n");
      out.write("<script src=\"http://localhost:8080/MobiShop/partials/assets/js/plugins/slimscroll/jquery.slimscroll.min.js\"></script>\n");
      out.write("<script src=\"http://localhost:8080/MobiShop/partials/assets/js/plugins/toastr/toastr.min.js\"></script>\n");
      out.write("<script src=\"http://localhost:8080/MobiShop/partials/assets/js/inspinia.js\"></script>\n");
      out.write("<script src=\"http://localhost:8080/MobiShop/partials/assets/js/plugins/pace/pace.min.js\"></script>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!-- jQuery UI \n");
      out.write("<script src=\"http://localhost:8080/MobiShop/partials/assets/js/plugins/jquery-ui/jquery-ui.min.js\"></script>\n");
      out.write("\n");
      out.write(" Flot \n");
      out.write("<script src=\"http://localhost:8080/MobiShop/partials/assets/js/js/plugins/flot/jquery.flot.js\"></script>\n");
      out.write("<script src=\"http://localhost:8080/MobiShop/partials/assets/js/js/plugins/flot/jquery.flot.tooltip.min.js\"></script>\n");
      out.write("<script src=\"http://localhost:8080/MobiShop/partials/assets/js/js/plugins/flot/jquery.flot.spline.js\"></script>\n");
      out.write("<script src=\"http://localhost:8080/MobiShop/partials/assets/js/js/plugins/flot/jquery.flot.resize.js\"></script>\n");
      out.write("<script src=\"http://localhost:8080/MobiShop/partials/assets/js/js/plugins/flot/jquery.flot.pie.js\"></script>-->");
      out.write("\n");
      out.write("        <script type=\"text/javascript\">\n");
      out.write("            window.print();\n");
      out.write("        </script>\n");
      out.write("\n");
      out.write("    </body>\n");
      out.write("\n");
      out.write("\n");
      out.write("</html>\n");
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
