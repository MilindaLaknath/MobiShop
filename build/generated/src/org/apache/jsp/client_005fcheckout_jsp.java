package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.TreeSet;
import java.util.HashSet;
import java.util.Set;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import hiben.Interfaces;
import java.util.List;
import org.hibernate.Criteria;
import hiben.IntfGroup;
import conn.FactoryManager;
import org.hibernate.Session;
import hiben.User;

public final class client_005fcheckout_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.ArrayList<String>(5);
    _jspx_dependants.add("/partials/header.jsp");
    _jspx_dependants.add("/partials/sidebar_search.jsp");
    _jspx_dependants.add("/partials/top_bar.jsp");
    _jspx_dependants.add("/partials/footer.jsp");
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
      out.write("    <body>\n");
      out.write("        ");

            try {
                User user = null;

                user = (User) session.getAttribute("user");

                if (user == null) {
                    response.sendRedirect("login.jsp");
                    return;
                }
        
      out.write("\n");
      out.write("        <div id=\"wrapper\">\n");
      out.write("            ");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<nav class=\"navbar-default navbar-static-side\" role=\"navigation\">\n");
      out.write("    <div class=\"sidebar-collapse\">\n");
      out.write("        <ul class=\"nav\" id=\"side-menu\">\n");
      out.write("            <li class=\"nav-header\">\n");
      out.write("                <div class=\"dropdown profile-element\"> <span>\n");
      out.write("                        <!--                        <img alt=\"image\" class=\"img-circle\" src=\"img/profile_small.jpg\" />\n");
      out.write("                                            </span>\n");
      out.write("                                            <a data-toggle=\"dropdown\" class=\"dropdown-toggle\" href=\"#\">\n");
      out.write("                                                <span class=\"clear\"> <span class=\"block m-t-xs\"> <strong class=\"font-bold\">David Williams</strong>\n");
      out.write("                                                    </span> <span class=\"text-muted text-xs block\">Art Director <b class=\"caret\"></b></span> </span> </a>\n");
      out.write("                                            <ul class=\"dropdown-menu animated fadeInRight m-t-xs\">\n");
      out.write("                                                <li><a href=\"profile.html\">Profile</a></li>\n");
      out.write("                                                <li><a href=\"contacts.html\">Contacts</a></li>\n");
      out.write("                                                <li><a href=\"mailbox.html\">Mailbox</a></li>\n");
      out.write("                                                <li class=\"divider\"></li>\n");
      out.write("                                                <li><a href=\"login.html\">Logout</a></li>\n");
      out.write("                                            </ul>-->\n");
      out.write("                </div>\n");
      out.write("                <!--                <div class=\"logo-element\">\n");
      out.write("                                    IN+\n");
      out.write("                                </div>-->\n");
      out.write("            </li>\n");
      out.write("\n");
      out.write("            ");

                try {
                    Session con = FactoryManager.getSessionFactory().openSession();
//                IntfGroup intgrp = null;

                    Criteria cri = con.createCriteria(IntfGroup.class);
                    cri.addOrder(Order.asc("groupName"));

                    List<IntfGroup> intgrplist = cri.list();

                    for (IntfGroup intgrp : intgrplist) {

                        if (intgrp.getGroupName().equals("NoGroup")) {

                            for (Interfaces inf : intgrp.getInterfaceses()) {
            
      out.write("\n");
      out.write("            <li>\n");
      out.write("                <a href=\"http://localhost:8080/MobiShop/");
      out.print(inf.getUrl());
      out.write("\"><i class=\"fa fa-flask\"></i> <span class=\"nav-label\">");
      out.print(inf.getIfaseName());
      out.write("</span> </a>\n");
      out.write("            </li>\n");
      out.write("            ");

                }
            
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("            ");

            } else {
            
      out.write("\n");
      out.write("            <li>\n");
      out.write("                <a href=\"\"><i class=\"fa fa-th-large\"></i> <span class=\"nav-label\">");
      out.print(intgrp.getGroupName());
      out.write("</span> <span class=\"fa arrow\"></span></a>\n");
      out.write("                <ul class=\"nav nav-second-level\">\n");
      out.write("                    ");


                        for (Interfaces inf : intgrp.getInterfaceses()) {
                    
      out.write("\n");
      out.write("\n");
      out.write("                    <li ><a href=\"http://localhost:8080/MobiShop/");
      out.print(inf.getUrl());
      out.write('"');
      out.write('>');
      out.print(inf.getIfaseName());
      out.write("</a></li>\n");
      out.write("\n");
      out.write("                    ");

                        }
                    
      out.write("\n");
      out.write("                </ul>\n");
      out.write("            </li>\n");
      out.write("            ");

                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("        </ul>\n");
      out.write("\n");
      out.write("    </div>\n");
      out.write("</nav>\n");
      out.write(" \n");
      out.write("            <div id=\"page-wrapper\" class=\"gray-bg top-navigation\">\n");
      out.write("                <div class=\"row border-bottom\">\n");
      out.write("                    ");
      out.write('\n');
      out.write('\n');
      out.write("\n");
      out.write("<!--<!DOCTYPE html>-->\n");
      out.write("<!--<html>\n");
      out.write("    <head>\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <title>JSP Page</title>\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("        <h1>Hello World!</h1>\n");
      out.write("    </body>\n");
      out.write("</html>-->\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");

    User u = null;

    u = (User) session.getAttribute("user");

      out.write("\n");
      out.write("<nav class=\"navbar navbar-static-top\" role=\"navigation\">\n");
      out.write("    <div class=\"navbar-header\">\n");
      out.write("        <button aria-controls=\"navbar\" aria-expanded=\"false\" data-target=\"#navbar\" data-toggle=\"collapse\" class=\"navbar-toggle collapsed\" type=\"button\">\n");
      out.write("            <i class=\"fa fa-reorder\"></i>\n");
      out.write("        </button>\n");
      out.write("        <a href=\"http://localhost:8080/MobiShop/\" class=\"navbar-brand\"><strong style=\"font-family: Forte; font-size: x-large\" >MobiShop</strong></a>\n");
      out.write("    </div>\n");
      out.write("    <div class=\"navbar-collapse collapse\" id=\"navbar\">\n");
      out.write("        <ul class=\"nav navbar-nav\">\n");
      out.write("            <li class=\"\">\n");
      out.write("                <a aria-expanded=\"false\" role=\"button\" href=\"http://localhost:8080/MobiShop/search.jsp?category=1\"><h3 style=\"color: #222\">Mobile Phones</h3></a>\n");
      out.write("            </li>\n");
      out.write("            <li class=\"\">\n");
      out.write("                <a aria-expanded=\"false\" role=\"button\" href=\"http://localhost:8080/MobiShop/search.jsp?category=2\"><h3 style=\"color: #222\">Tab and Pads</h3></a>\n");
      out.write("            </li>\n");
      out.write("            <li class=\"\">\n");
      out.write("                <form role=\"search\" class=\"navbar-form-custom\" method=\"get\" action=\"search.jsp\">\n");
      out.write("                    <div class=\"form-group\">\n");
      out.write("                        <input type=\"text\" placeholder=\"Search for something...\" class=\"form-control\" name=\"search\" id=\"search\">\n");
      out.write("                    </div>                    \n");
      out.write("                </form>\n");
      out.write("            </li>\n");
      out.write("\n");
      out.write("\n");
      out.write("            <!--            \n");
      out.write("                        <li class=\"\">\n");
      out.write("                            <a aria-expanded=\"false\" role=\"button\" href=\"#\" class=\"dropdown-toggle\" data-toggle=\"dropdown\"> Menu item <span class=\"caret\"></span></a>\n");
      out.write("                            <ul role=\"menu\" class=\"dropdown-menu\">\n");
      out.write("                                <li><a href=\"\">Menu item</a></li>\n");
      out.write("                                <li><a href=\"\">Menu item</a></li>\n");
      out.write("                                <li><a href=\"\">Menu item</a></li>\n");
      out.write("                                <li><a href=\"\">Menu item</a></li>\n");
      out.write("                            </ul>\n");
      out.write("                        </li>-->\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("        </ul>\n");
      out.write("        <ul class=\"nav navbar-top-links navbar-right\">\n");
      out.write("            <li>\n");
      out.write("                <span class=\"m-r-sm text-muted welcome-message\"><strong>Welcome \n");
      out.write("                        ");

                            if (u != null) {
                        
      out.write("\n");
      out.write("                        <a href=\"http://localhost:8080/MobiShop/myprofile.jsp\">\n");
      out.write("                        ");

                        out.write(u.getPersonalDetails().getFName());
                        
      out.write("\n");
      out.write("                        </a>\n");
      out.write("                        ");

                            }
                        
      out.write("\n");
      out.write("                        to MobiShop</strong></span>\n");
      out.write("            </li>    \n");
      out.write("            <li>\n");
      out.write("\n");
      out.write("\n");
      out.write("                ");

                    if (u == null) {
                
      out.write("\n");
      out.write("                <a href=\"http://localhost:8080/MobiShop/login.jsp\">\n");
      out.write("                    <i class=\"fa fa-sign-in\"></i> \n");
      out.write("                    Log In\n");
      out.write("                </a>\n");
      out.write("                ");

                } else {
                
      out.write("\n");
      out.write("                <a href=\"http://localhost:8080/MobiShop/logout\">\n");
      out.write("                    <i class=\"fa fa-sign-in\"></i>\n");
      out.write("                    Log Out\n");
      out.write("                </a>\n");
      out.write("                ");

                    }
                
      out.write("\n");
      out.write("\n");
      out.write("            </li>\n");
      out.write("        </ul>\n");
      out.write("\n");
      out.write("    </div>\n");
      out.write("</nav>");
      out.write(" \n");
      out.write("                </div>\n");
      out.write("\n");
      out.write("                <div class=\"row\">\n");
      out.write("                    <div class=\"col-lg-12\">\n");
      out.write("                        <div class=\"wrapper wrapper-content animated fadeInRight\">\n");
      out.write("                            <div class=\"ibox-content p-xl\">\n");
      out.write("                                <div class=\"row\">\n");
      out.write("                                    <form name=\"frmInvoice\" action=\"\" method=\"post\" class=\"form form-horizontal\">\n");
      out.write("                                        <div class=\"row\" >\n");
      out.write("                                            <h3 class=\"inline\" style=\"margin-left: 20px;\">Customer Name : </h3>\n");
      out.write("                                            <h3 class=\"inline\" style=\"margin-left: 20px;\" class=\"text-navy\">Jjjjjjjjjj</h3>\n");
      out.write("                                        </div>\n");
      out.write("                                        <div class=\"row\">\n");
      out.write("                                            <h3 style=\"margin-left: 20px;\">Shipping Address :</h3>\n");
      out.write("                                        </div>\n");
      out.write("                                        <div class=\"col-sm-6\">\n");
      out.write("                                            <span>Home No</span><br/>\n");
      out.write("                                            <span>Address line 1</span><br/>\n");
      out.write("                                            <span>ddress line 2</span><br/>\n");
      out.write("                                            <span>city</span><br/>\n");
      out.write("                                            <span>Post Code</span><br/>\n");
      out.write("                                            <span>Mobile No</span>\n");
      out.write("                                            <p>\n");
      out.write("                                                <span><strong>Invoice Date:</strong> Marh 18, 2014</span><br/>\n");
      out.write("                                                <span><strong>Due Date:</strong> March 24, 2014</span>\n");
      out.write("                                            </p>\n");
      out.write("                                        </div>\n");
      out.write("\n");
      out.write("                                        <div class=\"col-sm-6 text-right\">\n");
      out.write("                                            <div class=\"text-right\">\n");
      out.write("                                                <button type=\"submit\" class=\"btn btn-primary\"><i class=\"fa fa-dollar\"></i>Make A Payment</button>\n");
      out.write("                                            </div>\n");
      out.write("                                        </div>\n");
      out.write("                                    </form>\n");
      out.write("                                </div>\n");
      out.write("\n");
      out.write("                                <div class=\"table-responsive m-t\">\n");
      out.write("                                    <table class=\"table invoice-table\">\n");
      out.write("                                        <thead>\n");
      out.write("                                            <tr>\n");
      out.write("                                                <th>Item List</th>\n");
      out.write("                                                <th>Quantity</th>\n");
      out.write("                                                <th>Unit Price</th>\n");
      out.write("                                                <th>Total Price</th>\n");
      out.write("                                            </tr>\n");
      out.write("                                        </thead>\n");
      out.write("                                        <tbody>\n");
      out.write("                                            <tr>\n");
      out.write("                                                <td><div><strong>Admin Theme with psd project layouts</strong></div>\n");
      out.write("                                                    <small>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</small></td>\n");
      out.write("                                                <td>1</td>\n");
      out.write("                                                <td>$26.00</td>\n");
      out.write("                                                <td>$5.98</td>\n");
      out.write("                                                <td>$31,98</td>\n");
      out.write("                                            </tr>\n");
      out.write("                                            <tr>\n");
      out.write("                                                <td><div><strong>Wodpress Them customization</strong></div>\n");
      out.write("                                                    <small>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\n");
      out.write("                                                        Eiusmod tempor incididunt ut labore et dolore magna aliqua.\n");
      out.write("                                                    </small></td>\n");
      out.write("                                                <td>2</td>\n");
      out.write("                                                <td>$80.00</td>\n");
      out.write("                                                <td>$36.80</td>\n");
      out.write("                                                <td>$196.80</td>\n");
      out.write("                                            </tr>\n");
      out.write("                                            <tr>\n");
      out.write("                                                <td><div><strong>Angular JS & Node JS Application</strong></div>\n");
      out.write("                                                    <small>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</small></td>\n");
      out.write("                                                <td>3</td>\n");
      out.write("                                                <td>$420.00</td>\n");
      out.write("                                                <td>$193.20</td>\n");
      out.write("                                                <td>$1033.20</td>\n");
      out.write("                                            </tr>\n");
      out.write("\n");
      out.write("                                        </tbody>\n");
      out.write("                                    </table>\n");
      out.write("                                </div><!-- /table-responsive -->\n");
      out.write("\n");
      out.write("                                <table class=\"table invoice-total\">\n");
      out.write("                                    <tbody>\n");
      out.write("                                        <tr>\n");
      out.write("                                            <td><strong>Sub Total :</strong></td>\n");
      out.write("                                            <td>$1026.00</td>\n");
      out.write("                                        </tr>\n");
      out.write("                                        <tr>\n");
      out.write("                                            <td><strong>TAX :</strong></td>\n");
      out.write("                                            <td>$235.98</td>\n");
      out.write("                                        </tr>\n");
      out.write("                                        <tr>\n");
      out.write("                                            <td><strong>TOTAL :</strong></td>\n");
      out.write("                                            <td>$1261.98</td>\n");
      out.write("                                        </tr>\n");
      out.write("                                    </tbody>\n");
      out.write("                                </table>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("                            </div>\n");
      out.write("                        </div>\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("\n");
      out.write("            </div>\n");
      out.write("            ");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<div class=\"footer\" style=\"position: relative\">\n");
      out.write("    <strong>Copyright</strong> Example Company &copy; 2015-2016\n");
      out.write("</div>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
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
      out.write("        ");
                } catch (Exception e) {
                e.printStackTrace();
            }
        
      out.write("\n");
      out.write("    </body>\n");
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
