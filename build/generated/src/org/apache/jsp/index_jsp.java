package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.List;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import hiben.Stock;
import org.hibernate.Criteria;
import conn.FactoryManager;
import org.hibernate.Session;
import conn.FactoryManager;
import org.hibernate.Session;
import hiben.User;

public final class index_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.ArrayList<String>(4);
    _jspx_dependants.add("/partials/header.jsp");
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
      out.write("\n");
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
      out.write("        <!-- Custom CSS -->\n");
      out.write("        <link href=\"http://localhost:8080/MobiShop/partials/assets/css/modern-business.css\" rel=\"stylesheet\">\n");
      out.write("\n");
      out.write("    </head>\n");
      out.write("\n");
      out.write("\n");
      out.write("    <body class=\"top-navigation\">\n");
      out.write("        <div id=\"wrapper\">\n");
      out.write("            <div id=\"page-wrapper\" class=\"gray-bg\">\n");
      out.write("                <div class=\"row border-bottom\">\n");
      out.write("                    ");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
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

    if (u == null) {
        Cookie cookie = null;
        Cookie[] cookies = null;
        // Get an array of Cookies associated with this domain
        cookies = request.getCookies();
        if (cookies != null) {
            for (int i = 0; i < cookies.length; i++) {
                cookie = cookies[i];
                if (cookie.getName().equals("uid")) {
                    String uid = cookie.getValue();
                    if (uid != null && !uid.equals("")) {
                        Session con = FactoryManager.getSessionFactory().openSession();
                        u = (User) con.load(User.class, Integer.parseInt(uid));
                        session.setAttribute("user", u);
                    }
                }
            }
        }
    }

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
      out.write("                <a aria-expanded=\"false\" role=\"button\" href=\"http://localhost:8080/MobiShop/search.jsp?category=2\"><h3 style=\"color: #222\">Tabs and iPads</h3></a>\n");
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
      out.write("                            ");

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
      out.write("</nav>\n");
      out.write("                \n");
      out.write(" \n");
      out.write("                </div>\n");
      out.write("\n");
      out.write("               \n");
      out.write("                <div style=\"width: auto; height: 350px;\" >\n");
      out.write("                    <!-- Header Carousel -->\n");
      out.write("                    <header id=\"myCarousel\" class=\"carousel slide\">\n");
      out.write("                        <!--Indicators--> \n");
      out.write("                        <ol class=\"carousel-indicators\">\n");
      out.write("                            <li data-target=\"#myCarousel\" data-slide-to=\"0\" class=\"active\"></li>\n");
      out.write("                            <li data-target=\"#myCarousel\" data-slide-to=\"1\"></li>\n");
      out.write("                            <li data-target=\"#myCarousel\" data-slide-to=\"2\"></li>\n");
      out.write("                        </ol>\n");
      out.write("\n");
      out.write("                        <!-- Wrapper for slides -->\n");
      out.write("                        <div class=\"carousel-inner\">\n");
      out.write("                            <div class=\"item active\">\n");
      out.write("                                <div class=\"fill\" style=\"background-image:url('partials/assets/img/slider/one.png');\"></div>\n");
      out.write("                            </div>\n");
      out.write("                            <div class=\"item\">\n");
      out.write("                                <div class=\"fill\" style=\"background-image:url('partials/assets/img/slider/two.png');\"></div>\n");
      out.write("                            </div>\n");
      out.write("                            <div class=\"item\">\n");
      out.write("                                <div class=\"fill\" style=\"background-image:url('partials/assets/img/slider/three.png');\"></div>                                \n");
      out.write("                            </div>\n");
      out.write("                        </div>\n");
      out.write("\n");
      out.write("                        <!--Controls--> \n");
      out.write("                        <a class=\"left carousel-control\" href=\"#myCarousel\" data-slide=\"prev\">\n");
      out.write("                            <span class=\"icon-prev\"></span>\n");
      out.write("                        </a>\n");
      out.write("                        <a class=\"right carousel-control\" href=\"#myCarousel\" data-slide=\"next\">\n");
      out.write("                            <span class=\"icon-next\"></span>\n");
      out.write("                        </a>\n");
      out.write("                    </header>\n");
      out.write("                </div>\n");
      out.write("\n");
      out.write("                <div class=\"container\" style=\"margin-top: 15px;\">\n");
      out.write("\n");
      out.write("                    ");
                        Session con = FactoryManager.getSessionFactory().openSession();
                        Criteria cri = con.createCriteria(Stock.class);
                        cri.add(Restrictions.gt("quentity", 0));
                        cri.addOrder(Order.desc("quentity"));
//                        cri.setFirstResult(0);
                        cri.setMaxResults(8);

                        List<Stock> stklist = cri.list();

                        for (Stock stk : stklist) {
                            if (stk.getProducts().getActive().equals(0)) {

                    
      out.write("\n");
      out.write("                    <a href=\"http://localhost:8080/MobiShop/productinfo.jsp?pid=");
      out.print(stk.getProducts().getItmCode());
      out.write("\">\n");
      out.write("                        <div class=\"col-sm-3\">\n");
      out.write("                            <div class=\"panel panel-primary\">\n");
      out.write("                                <div class=\"panel-heading\">\n");
      out.write("                                    <h4>");
      out.print(stk.getProducts().getBrand().getBrandName());
      out.write(' ');
      out.print(stk.getProducts().getItmName() );
      out.write("</h4>\n");
      out.write("                                </div>\n");
      out.write("                                <div class=\"panel-body\" align=\"center\">\n");
      out.write("                                    <img class=\"img-thumbnail img-shadow\" alt=\"Bootstrap Image Preview\" src=\"http://localhost:8080/MobiShop/");
      out.print(stk.getProducts().getImgUrl());
      out.write("\" />\n");
      out.write("                                    <h3>");
      out.print(stk.getItmPrice() - stk.getDiscount());
      out.write(" LKR \n");
      out.write("                                        ");

                                            if (stk.getDiscount() > 0.0) {
                                                String dis = ((stk.getDiscount() / stk.getItmPrice()) * 100)+"";
//                                                String []arr = dis.split(".");
//                                                String []arr2 = arr[1].split("");
//                                                out.print(" | ");
//                                                out.print(arr[0]+arr2[0]+arr[1]+"%");
                                                if(dis.length()>4){
                                                out.print(dis.charAt(0)+""+dis.charAt(1)+""+dis.charAt(2)+""+dis.charAt(3)+"%");
                                                }else{
                                                out.print(dis+"%");
                                                }
//                                            out.print(" Discount");
                                            }
                                        
      out.write("\n");
      out.write("                                    </h3>\n");
      out.write("                                    <h3>");
      out.print(stk.getColor());
      out.write(" &nbsp;|&nbsp; ");
      out.print(stk.getStorage());
      out.write(" GB</h3>\n");
      out.write("\n");
      out.write("                                </div>\n");
      out.write("                            </div>\n");
      out.write("                        </div>\n");
      out.write("                    </a>\n");
      out.write("                    ");
                        }
                        }
                    
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("                </div>\n");
      out.write("\n");
      out.write("            </div>\n");
      out.write("            ");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<div class=\"footer\" style=\"position: relative\">\n");
      out.write("    <strong>Copyright</strong> MobiShop Company &copy; 2015-2016\n");
      out.write("    <div class=\"pull-right\"><a  href=\"aboutus.jsp\" target=\"_blank\">About Us</a></div>\n");
      out.write("</div>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("        </div>\n");
      out.write("\n");
      out.write("\n");
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
      out.write("        <script>\n");
      out.write("            $('.carousel').carousel({\n");
      out.write("                interval: 5000 //changes the speed\n");
      out.write("            })\n");
      out.write("        </script>\n");
      out.write("\n");
      out.write("    </body>\n");
      out.write("\n");
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
