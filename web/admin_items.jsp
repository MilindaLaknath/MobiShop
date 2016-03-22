<%-- 
    Document   : admin_items
    Created on : Dec 1, 2015, 9:37:18 PM
    Author     : Milinda
--%>

<%@page import="hiben.Category"%>
<%@page import="hiben.Brand"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="java.util.List"%>
<%@page import="hiben.Products"%>
<%@page import="conn.FactoryManager"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="/partials/header.jsp" %>

        <!-- Data Tables -->
        <link href="http://localhost:8080/MobiShop/partials/assets/css/plugins/dataTables/dataTables.bootstrap.css" rel="stylesheet">
        <link href="http://localhost:8080/MobiShop/partials/assets/css/plugins/dataTables/dataTables.responsive.css" rel="stylesheet">
        <link href="http://localhost:8080/MobiShop/partials/assets/css/plugins/dataTables/dataTables.tableTools.min.css" rel="stylesheet">
        <link href="http://localhost:8080/MobiShop/partials/assets/css/plugins/datapicker/datepicker3.css" rel="stylesheet">

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

                        String catStr = null;
                        String brdStr = null;

                        String strfrest = "";
                        int frest = 0;
                        strfrest = request.getParameter("frest");

                        if (strfrest != null && !strfrest.equals("")) {
                            frest = Integer.parseInt(strfrest);
                            if (frest < 0) {
                                frest = 0;
                            }
                        } else {
                            frest = 0;
                        }

                        catStr = request.getParameter("category");
                        brdStr = request.getParameter("brand");

                        Session con = FactoryManager.getSessionFactory().openSession();

                        List<Products> list;

                        List<Brand> brd;
                        List<Category> cat;

                        Criteria c1 = con.createCriteria(Brand.class);
                        brd = c1.list();

                        c1 = con.createCriteria(Category.class);
                        cat = c1.list();

                        Criteria cri = con.createCriteria(Products.class);

                        if (catStr != null && brdStr != null) {
                            if (!catStr.equals("")) {
                                Category c = (Category) con.load(Category.class, Integer.parseInt(catStr));
                                cri.add(Restrictions.eq("category", c));
                            }
                            if (!brdStr.equals("")) {
                                Brand b = (Brand) con.load(Brand.class, Integer.parseInt(brdStr));
                                cri.add(Restrictions.eq("brand", b));
                            }
                        }

                        cri.add(Restrictions.eq("active", Integer.parseInt("0")));

                        cri.addOrder(Order.asc("prodCode"));
//                        cri.addOrder(Order.asc("brand"));
                        cri.setFirstResult(frest);
                        cri.setMaxResults(15);

                        list = cri.list();

                %>

                <div class="container col-sm-12" style="margin-top: 15px;">
                    <div class="ibox-title">
                        <h5>Filter Items</h5>                            
                    </div>
                    <div class="ibox-content">
                        <div class="row">
                            <form role="form" class="form-inline" action="admin_items.jsp">
                                <div class="col-sm-4">
                                    <label class="control-label">Category : </label>
                                    <div class="input-group">
                                        <select class="form-control" name="category">
                                            <%                                                for (Category ctgr : cat) {
                                            %>
                                            <option value="<%=ctgr.getIdcat()%>"><%=ctgr.getCatName()%></option>
                                            <%
                                                }
                                            %>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <label class="control-label">Brand : </label>
                                    <div class="input-group">
                                        <select class="form-control" name="brand">
                                            <%                                                for (Brand brnd : brd) {
                                            %>
                                            <option value="<%=brnd.getIdbrand()%>"><%=brnd.getBrandName()%></option>
                                            <%
                                                }
                                            %>
                                        </select>
                                    </div>
                                </div>
                                <div class="">
                                    <button class="btn btn-primary" type="submit">Filter</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="ibox-content" style="margin-top: 10px;">
                    <table class="table table-hover">
                        <tr>
                            <th>Item ID</th>
                            <th>Item Code</th>
                            <th>Name</th>
                            <th>Category</th>
                            <th>Brand</th>
                            <th></th>
                        </tr>

                        <%                        for (Products p : list) {
                        %>
                        <tr>
                            <td><%=p.getItmCode()%></td>
                            <td><%=p.getProdCode()%></td>
                            <td><%=p.getItmName()%></td>
                            <td><%=p.getCategory().getCatName()%></td>
                            <td><%=p.getBrand().getBrandName()%></td>
                            <td>
                                <a href="http://localhost:8080/MobiShop/deleteProduct?pid=<%=p.getItmCode()%>"><button class="btn btn-danger pull-right">Delete</button></a>
                                <a href="http://localhost:8080/MobiShop/admin_edit_items.jsp?id=<%=p.getItmCode()%>"><button class="btn btn-primary pull-right">View/Edit</button></a>
                                
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </table>

                    <div class="row col-sm-12">
                        <div class="btn-group pull-right">
                            <%
                                String url = "";
                                if (brdStr != null) {
                                    url += "&brand=" + brdStr;
                                }
                                if (catStr != null) {
                                    url += "&category=" + catStr;
                                }
                                if (frest != 0) {
                            %>
                            <a href="http://localhost:8080/MobiShop/admin_items.jsp?frest=<%=frest - 15%><%=url%>">
                                <button type="button" class="btn btn-primary"><i class="fa fa-chevron-left"></i>Previous</button>
                            </a>
                            <%
                                }
                                if (list.size() == 15) {
                            %>
                            <a href="http://localhost:8080/MobiShop/admin_items.jsp?frest=<%=frest + 15%><%=url%>">
                                <button type="button" class="btn btn-primary"><i class="fa fa-chevron-right"></i>Next</button>
                            </a>
                            <%
                                }
                            %>
                        </div>
                    </div>

                </div>
                <%
                    } catch (Exception e) {
                        out.print(e.toString());
                        response.sendError(500);
                    }
                %>
            </div>
            <%@include file="/partials/footer.jsp" %>
        </div>
        <%@include file="/partials/commonjs.jsp" %>


    </body>
</html>
