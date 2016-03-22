package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import hiben.Brand;
import org.hibernate.criterion.MatchMode;
import hiben.Category;
import hiben.Products;
import java.util.List;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import hiben.Stock;
import org.hibernate.Criteria;
import conn.FactoryManager;
import org.hibernate.Session;

public final class search_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.ArrayList<String>(3);
    _jspx_dependants.add("/partials/header.jsp");
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
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("        <div id=\"wrapper\">\n");
      out.write("\n");
      out.write("\n");
      out.write("            ");
                        try {
                    String search = "";
                    String brid = "";
                    String catid = "";
                    String strfrest = "";
                    int frest = 0;

                    search = request.getParameter("search");
                    brid = request.getParameter("brand");
                    catid = request.getParameter("category");
                    strfrest = request.getParameter("frest");

                    if (strfrest != null && !strfrest.equals("")) {
                        frest = Integer.parseInt(strfrest);
                    } else {
                        frest = 0;
                    }

                    Session con = FactoryManager.getSessionFactory().openSession();
                    Criteria cri = con.createCriteria(Stock.class);
                    Criteria cri2 = cri.createCriteria("products");

                    if (search != null && !search.equals("")) {
                        cri2.add(Restrictions.or(Restrictions.like("itmName", search, MatchMode.ANYWHERE)));
                    }
                    if (brid != null && !brid.equals("")) {
                        Brand b = (Brand) con.load(Brand.class, Integer.parseInt(brid));
                        cri2.add(Restrictions.or(Restrictions.eq("brand", b)));
                    }
                    if (catid != null && !catid.equals("")) {
                        Category c = (Category) con.load(Category.class, Integer.parseInt(catid));
                        cri2.add(Restrictions.or(Restrictions.eq("category", c)));
                    }

//                        cri = con.createCriteria(Stock.class);
                    cri.add(Restrictions.gt("quentity", 0));
                    cri.addOrder(Order.desc("quentity"));
                    cri.setFirstResult(0);
                    cri.setMaxResults(8);

//                            
                    List<Stock> stklist = cri.list();
            
      out.write("\n");
      out.write("            ");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "/partials/sidebar.jsp", out, false);
      out.write(" \n");
      out.write("            <div id=\"page-wrapper\" class=\"gray-bg top-navigation\">\n");
      out.write("                <div class=\"row border-bottom\">\n");
      out.write("                    ");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "/partials/top_bar.jsp", out, false);
      out.write("\n");
      out.write("                </div>\n");
      out.write("\n");
      out.write("                <div class=\"container col-sm-12\" style=\"margin-top: 15px;\">\n");
      out.write("\n");
      out.write("\n");
      out.write("                    ");
                        for (Stock stk : stklist) {
                            if (stk.getProducts().getActive().equals(0)) {

                    
      out.write("\n");
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
      out.print(stk.getProducts().getItmName());
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
                                                String dis = ((stk.getDiscount() / stk.getItmPrice()) * 100) + "%";
                                                out.print(" | ");
                                                out.print(dis);
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
      out.write("                    <div class=\"btn-group pull-right\">\n");
      out.write("                        ");

                            if (frest != 0) {
                        
      out.write("\n");
      out.write("                        <a href=\"http://localhost:8080/MobiShop/productinfo.jsp?frest=");
      out.print(frest - 8);
      out.write("&search=");
      out.print(search);
      out.write("&brand=");
      out.print(brid);
      out.write("&category=");
      out.print(catid);
      out.write("\">\n");
      out.write("                            <button type=\"button\" class=\"btn btn-white\"><i class=\"fa fa-chevron-left\"></i>Previous</button>\n");
      out.write("                        </a>\n");
      out.write("                        ");

                            }
                            if ((frest + 8) < stklist.size()) {
                        
      out.write("\n");
      out.write("                        <a href=\"http://localhost:8080/MobiShop/productinfo.jsp?frest=");
      out.print(frest + 8);
      out.write("&search=");
      out.print(search);
      out.write("&brand=");
      out.print(brid);
      out.write("&category=");
      out.print(catid);
      out.write("\">\n");
      out.write("                            <button type=\"button\" class=\"btn btn-white\"><i class=\"fa fa-chevron-right\"></i>Next</button>\n");
      out.write("                        </a>\n");
      out.write("                        ");

                            }
                        
      out.write("\n");
      out.write("                    </div>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("                </div>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("            </div>\n");
      out.write("\n");
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
      out.write("            ");

                } catch (Exception e) {
                    e.printStackTrace();
                }
            
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
