<%-- 
    Document   : admin_brand
    Created on : Dec 1, 2015, 9:41:22 PM
    Author     : Milinda
--%>

<%@page import="java.util.List"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="conn.FactoryManager"%>
<%@page import="org.hibernate.Session"%>
<%@page import="hiben.Brand"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="/partials/header.jsp" %>
    </head>
    <body>
        <div id="wrapper">
            <%@include file="/partials/sidebar_search.jsp" %> 
            <div id="page-wrapper" class="gray-bg top-navigation">
                <div class="row border-bottom">
                    <%@include file="/partials/top_bar.jsp" %> 
                </div>

                <%                    try {
                        User user = (User) session.getAttribute("user");

                        if (user == null) {
                            response.sendRedirect("login.jsp");
                            return;
                        }
                        if (user.getUserType().getType().equals("Admin") || user.getUserType().getType().equals("Root")) {
                        } else {
                            response.sendRedirect("login.jsp");
                            return;
                        }

                        String strfrest = "";
                        int frest = 0;

                        strfrest = request.getParameter("frest");

                        if (strfrest != null && !strfrest.equals("")) {
                            frest = Integer.parseInt(strfrest);
                        } else {
                            frest = 0;
                        }

                        Session con = FactoryManager.getSessionFactory().openSession();

                        Brand bd = null;
                        String action = "";
                        String id = request.getParameter("id");
                        if (id == null) {
                            action = "addBrand";
                        } else {
                            action = "editBrand";
                            bd = (Brand) con.load(Brand.class, Integer.parseInt(id));
                        }

                %>

                <%                     String msg = "";
                    String typ = "";
                    int swit = 0;
                    msg = request.getParameter("msg");
                    typ = request.getParameter("msgtype");

                    if (msg != null && !msg.equals("")) {
                        if (typ != null && !typ.equals("")) {
                            swit = Integer.parseInt(typ);
                        }

                        switch (swit) {
                            case 0:
                %>
                <div class="alert alert-success alert-dismissable">
                    <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                    <%=msg%>
                </div>
                <%
                        break;
                    case 1:
                %>
                <div class="alert alert-danger alert-dismissable">
                    <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                    <%=msg%>
                </div>
                <%
                                break;
                        }
                    }
                %>

                <div class="wrapper wrapper-content animated fadeInRight">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="ibox float-e-margins">
                                <div class="ibox-title">
                                    <h5>Mobile Brand
                                        <!--<small>Enter the details of the journal you want to create</small>-->
                                    </h5>
                                </div>

                                <div class="ibox-content">
                                    <form name="create_category" method="post" id="add_cad_user" class="form-horizontal"
                                          action="<%=action%>">
                                        <div class="row">
                                            <div class="col-lg-12">
                                                <div class="form-group">
                                                    <label class="col-sm-3 control-label">Brand Name : </label>
                                                    <% if (bd != null) {%>
                                                    <div class="col-sm-6">
                                                        <input type="hidden" name="id" value="<%=bd.getIdbrand()%>">
                                                        <input name="name" required="" type="text" class="form-control"
                                                               value="<%=bd.getBrandName()%>" placeholder="Enter Brand Name">
                                                    </div>
                                                    <div class="col-sm-3 ">
                                                        <button class="btn btn-primary" type="submit">Update Brand
                                                            <span class="fa fa-plus"></span></button>
                                                        <a href="http://localhost:8080/MobiShop/admin_brand.jsp" class="btn btn-primary">
                                                            Clear
                                                        </a>
                                                    </div>
                                                    <% } else { %>

                                                    <div class="col-sm-6">
                                                        <input type="hidden" name="id">
                                                        <input name="name" required="" type="text" class="form-control" placeholder="Enter Brand Name">
                                                    </div>
                                                    <div class="col-sm-3 ">
                                                        <button class="btn btn-primary" type="submit">Add Brand
                                                            <span class="fa fa-plus"></span></button>
                                                    </div>
                                                    <% } %>

                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>

                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="ibox float-e-margins">
                                            <div class="ibox-title">
                                                <h5>
                                                    Mobile Brand
                                                    <!--<small>Enter the details of the journal you want to create</small>-->
                                                </h5>                                          
                                            </div>

                                            <div class="ibox-content">
                                                <div class="row">
                                                    <table class="table">
                                                        <%  Criteria cri = con.createCriteria(Brand.class);
                                                            cri.setFirstResult(frest);
                                                            cri.setMaxResults(10);
                                                            List<Brand> brandlist = cri.list();

                                                            for (Brand brand : brandlist) {
                                                        %>
                                                        <tr>
                                                            <td>
                                                                <div class="col-sm-8">
                                                                    <input name="id" type="hidden" class="form-control" value="">

                                                                    <h3 style="padding-left: 20px"><%=brand.getBrandName()%></h3>
                                                                </div>
                                                                <div class="col-sm-4">                                                                    
                                                                    <a href="<%="http://localhost:8080/MobiShop/admin_brand.jsp?id=" + brand.getIdbrand()%>">
                                                                        <button class="btn btn-default pull-right" type="button">Edit</button>
                                                                    </a>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <%
                                                            }
                                                        %>
                                                    </table>
                                                    <div class="row col-sm-12">
                                                        <div class="btn-group pull-right">
                                                            <%
                                                                
                                                                if (frest != 0) {
                                                            %>
                                                            <a href="http://localhost:8080/MobiShop/admin_brand.jsp?frest=<%=frest - 10%>">
                                                                <button type="button" class="btn btn-primary"><i class="fa fa-chevron-left"></i>Previous</button>
                                                            </a>
                                                            <%
                                                                }
                                                                if (brandlist.size() == 10) {
                                                            %>
                                                            <a href="http://localhost:8080/MobiShop/admin_brand.jsp?frest=<%=frest + 10%>">
                                                                <button type="button" class="btn btn-primary"><i class="fa fa-chevron-right"></i>Next</button>
                                                            </a>
                                                            <%
                                                                }
                                                            %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>


                            </div>
                        </div>
                    </div>

                    <%
                        } catch (Exception e) {
                            e.printStackTrace();
                            response.sendError(500);
                        }
                    %>
                </div>

                <%@include file="partials/footer.jsp" %>
            </div>
            <%@include file="partials/commonjs.jsp" %>
    </body>
</html>
