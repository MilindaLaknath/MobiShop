<%-- 
    Document   : client_trans_items
    Created on : Dec 18, 2015, 11:37:45 PM
    Author     : Milinda
--%>

<%@page import="hiben.Transaction"%>
<%@page import="hiben.TransProd"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
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

                        String transid = request.getParameter("transid");
                        if (transid == null && transid.equals("")) {
                            response.sendRedirect("client_user_orders.jsp");
                            return;
                        }

                        Session con = FactoryManager.getSessionFactory().openSession();
                        Transaction trans = (Transaction) con.load(Transaction.class, Integer.parseInt(transid));


                %>

                <div class="row">
                    <div class="col-lg-12">
                        <div class="ibox-title">
                            <h3 class="font-bold">Transaction Items</h3>
                        </div>

                        <div class="ibox-content">
                            <%
                                String url = "http://localhost:8080/MobiShop/client_user_orders.jsp";
                                if(user.getUserType().equals("Admin")||user.getUserType().equals("Root")){
                                    url = "http://localhost:8080/MobiShop/admin_ordered_items.jsp";
                                }
                            %>
                            <a href="<%=url %>"><button class="btn btn-primary pull-right" style="margin-bottom: 5px;">Go Back</button></a>
                            <table class="table table-hover">
                                <tr>
                                    <th>Item Name</th>                                    
                                    <th>Color</th>
                                    <th>Storage</th>
                                    <th>Quantity</th>
                                    <th>Price</th>
                                    <th>Total Price</th>
                                </tr>
                                <%                                    if (trans != null) {
                                        for (TransProd tp : trans.getTransProds()) {
                                %>
                                <tr>
                                    <td><a href="http://localhost:8080/MobiShop/productinfo.jsp?pid=<%=tp.getStock().getProducts().getItmCode()%>"><%=tp.getStock().getProducts().getBrand().getBrandName() + " " + tp.getStock().getProducts().getItmName()%></a></td>
                                    <td><%=tp.getStock().getColor()%></td>
                                    <td><%=tp.getStock().getStorage()%></td>
                                    <td><%=tp.getQty()%></td>
                                    <td><%=tp.getItmPrice() - tp.getDiscount()%></td>
                                    <td><%=(tp.getItmPrice() - tp.getDiscount()) * tp.getQty()%></td>
                                </tr>
                                <%
                                        }
                                    } else {
                                        response.sendRedirect("client_user_orders.jsp");
                                    }
                                %>
                            </table>
                        </div>
                    </div>
                </div>


                <%                    } catch (Exception e) {
                        e.printStackTrace();
                        response.sendError(500);
                    }
                %>
            </div>
            <%@include file="/partials/footer.jsp" %>
        </div>
        <%@include file="/partials/commonjs.jsp" %>
    </body>
</html>
