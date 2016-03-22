<%-- 
    Document   : client_view_cart_prd
    Created on : Dec 18, 2015, 4:39:13 AM
    Author     : Milinda
--%>

<%@page import="hiben.CartProd"%>
<%@page import="hiben.ProdHasProp"%>
<%@page import="hiben.ProdProperty"%>
<%@page import="java.util.List"%>
<%@page import="hiben.PropertyGroup"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="hiben.Stock"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="hiben.Products"%>
<%@page import="conn.FactoryManager"%>
<%@page import="org.hibernate.Session"%>
<%@page import="hiben.User"%>
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
                    User user = (User) session.getAttribute("user");

                    if (user == null) {
                        response.sendRedirect("login.jsp");
                        return;
                    }

                    String chpid = "";
                    chpid = request.getParameter("chpid");

                    if (chpid == null || chpid.equals("")) {
                        response.sendRedirect("search.jsp");
                    }

                    Session con = FactoryManager.getSessionFactory().openSession();
                    CartProd chp = (CartProd) con.load(CartProd.class, Integer.parseInt(chpid));


            %>

            <jsp:include page="/partials/sidebar_search.jsp" /> 
            <div id="page-wrapper" class="gray-bg top-navigation">
                <div class="row border-bottom">
                    <jsp:include page="/partials/top_bar.jsp" />
                </div>

                <%                    if (chp != null) {

                        Stock stk = chp.getStock();

                        Products p = stk.getProducts();

                        Criteria cri = con.createCriteria(PropertyGroup.class);

                        List<PropertyGroup> pglist = cri.list();
                %>

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
                            <h4 class="h4">Unit Price : <%=(stk.getItmPrice() - stk.getDiscount())%> LKR</h4>
                            <h4 class="h4">Total Price : <%=(stk.getItmPrice() - stk.getDiscount()) * chp.getQty()%> LKR</h4>
                            <h4 class="h4">Color : <%=stk.getColor()%></h4>
                            <h4 class="h4">Storage : <%=stk.getStorage()%> GB</h4>
                            <h4 class="h4">Quantity :<%=chp.getQty()%>&nbsp;/<%=stk.getQuentity()%></h4>

                            <a href="http://localhost:8080/MobiShop/client_cart.jsp"><button type="submit" class="btn btn-primary">Go Back</button></a>

                        </div>
                    </div>

                    <div class="ibox-content col-lg-12">
                        <div class="form-group col-sm-12">
                            <table class="table col-sm-12">
                                <%
                                    for (PropertyGroup prgrp : pglist) {
                                %>
                                <tr>
                                    <td class="col-sm-3 form-control font-bold" style="width: 200px" rowspan="<%=prgrp.getProdProperties().size()%>"><%=prgrp.getGroupName()%></td>
                                    <%
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
                                %>
                            </table>
                        </div>
                    </div>

                </div>
                <%
                } else {
                    response.sendRedirect("client_cart.jsp");
                %>


                <%
                    }
                %>
            </div>

            <%@include file="partials/footer.jsp" %>
            <%
                } catch (Exception e) {
                    e.printStackTrace();
                        response.sendError(500);
                }
            %>


        </div>
        <%@include file="partials/commonjs.jsp" %>

    </body>
</html>
