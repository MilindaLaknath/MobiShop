<%-- 
    Document   : productinfo
    Created on : Dec 17, 2015, 10:42:01 AM
    Author     : Milinda
--%>

<%@page import="hiben.ProdHasProp"%>
<%@page import="hiben.ProdProperty"%>
<%@page import="java.util.List"%>
<%@page import="hiben.PropertyGroup"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="hiben.Stock"%>
<%@page import="hiben.Products"%>
<%@page import="hiben.User"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="conn.FactoryManager"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="/partials/header.jsp" %>
    </head>
    <body>
        <div id="wrapper">
            <%
                try {
                    User u = null;

                    u = (User) session.getAttribute("user");

                    String pid = "";
                    pid = request.getParameter("pid");

                    if (pid == null || pid.equals("")) {
                        response.sendRedirect("search.jsp");
                    }

                    Session con = FactoryManager.getSessionFactory().openSession();
                    Products p = (Products) con.load(Products.class, Integer.parseInt(pid));

                    if (p == null) {
                        response.sendRedirect("search.jsp");
                    }

                    Criteria cri = con.createCriteria(Stock.class);
                    cri.add(Restrictions.eq("products", p));
                    cri.add(Restrictions.gt("quentity", 0));
                    cri.addOrder(Order.asc("stockDate"));

                    Stock stk = null;
                    if (cri.list().size() > 0) {
                        stk = (Stock) cri.list().get(0);
                    } else {
                        response.sendRedirect("search.jsp");
                    }

                    cri = con.createCriteria(PropertyGroup.class);

                    List<PropertyGroup> pglist = cri.list();

            %>

            <jsp:include page="/partials/sidebar.jsp" /> 
            <div id="page-wrapper" class="gray-bg top-navigation">
                <div class="row border-bottom">
                    <jsp:include page="/partials/top_bar.jsp" />
                </div>

                <div class="container col-sm-12" style="margin-top: 15px;">
                    <div class="ibox-title" style="height: 55px;">
                        <h3 class="h3"> <%=p.getBrand().getBrandName()%> <%=p.getItmName()%> </h3>
                    </div>

                    <div class="ibox-content col-lg-12" style="margin-top: 5px;">
                        <div class="col-lg-4 image">
                            <img  src="<%=p.getImgUrl()%>" />
                        </div>
                        <div class="col-lg-8">
                            <h3 class="h3"> <%=p.getBrand().getBrandName()%> <%=p.getItmName()%> </h3>  
                            <h4 class="h4">Price : <%=stk.getItmPrice() - stk.getDiscount()%> LKR</h4>
                            <h4 class="h4">Color : <%=stk.getColor()%></h4>
                            <h4 class="h4">Storage : <%=stk.getStorage()%> GB</h4>

                            <%
                                if (u != null) {
                            %>
                            <form method="post" action="addToCart">
                                <input type="hidden" name="batchid" value="<%=stk.getBatchid()%>">
                                <h4>Quantity : <input type="number" name="quantity" min="1" max="<%=stk.getQuentity()%>" required="" value="1">&nbsp;/<%=stk.getQuentity()%></h4>
                                <button type="submit" class="btn btn-primary">Add to Cart</button>
                            </form>
                            <%
                                }
                                if (u != null) {
                                    if (u.getUserType().getType().equals("Admin") || u.getUserType().getType().equals("Root")) {
                            %>
                            <a href="http://localhost:8080/MobiShop/admin_update_stock.jsp?id=<%=p.getItmCode()%>"><button type="submit" class="btn btn-primary">Update Stock</button></a>
                            <%
                                    }
                                }
                            %>
                        </div>
                    </div>

                    <div class="ibox-content col-lg-12">
                        <div class="form-group col-sm-12">
                            <table class="table col-sm-12">
                                <%
                                    if (pglist.size() > 0) {
                                        for (PropertyGroup prgrp : pglist) {
                                %>
                                <tr>
                                    <td class="col-sm-3 form-control font-bold" style="width: 200px" rowspan="<%=prgrp.getProdProperties().size()%>"><%=prgrp.getGroupName()%></td>

                                    <% if (prgrp.getProdProperties().size() > 0) {
                                            for (ProdProperty prop : prgrp.getProdProperties()) {
                                                cri = con.createCriteria(ProdHasProp.class);
                                                cri.add(Restrictions.eq("prodProperty", prop));
                                                cri.add(Restrictions.eq("products", p));
                                                ProdHasProp php = (ProdHasProp) cri.list().get(0);
                                    %>

                                    <td class="col-sm-3 form-control font-bold" style="width: 200px"><%=prop.getPropertyName()%></td>
                                    <td class="col-sm-4 form-control" style="width: 500px" ><%=php.getValue()%></td>
                                </tr>
                                <%
                                                }
                                            }
                                        }
                                    }

                                %>
                            </table>
                        </div>
                    </div>

                </div>

            </div>

            <%@include file="partials/footer.jsp" %>
            <%                } catch (Exception e) {
                    e.printStackTrace();
                    response.sendError(500);
                }
            %>


        </div>
        <%@include file="partials/commonjs.jsp" %>

    </body>
</html>
