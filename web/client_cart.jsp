<%-- 
    Document   : client_cart
    Created on : Dec 17, 2015, 11:23:42 PM
    Author     : Milinda
--%>

<%@page import="org.hibernate.Transaction"%>
<%@page import="hiben.Cart"%>
<%@page import="hiben.CartProd"%>
<%@page import="hiben.Stock"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="/partials/header.jsp" %>

    </head>
    <body>
        <%
            try {
        %>
        <div id="wrapper">
            <%@include file="/partials/sidebar_search.jsp" %> 
            <div id="page-wrapper" class="gray-bg top-navigation">
                <div class="row border-bottom">
                    <%@include file="/partials/top_bar.jsp" %> 
                </div>

                <%                    User user = (User) session.getAttribute("user");

                    if (user == null) {
                        response.sendRedirect("login.jsp");
                    }

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

                    Session con = FactoryManager.getSessionFactory().openSession();

                    Criteria cri = con.createCriteria(CartProd.class);

                    Criteria cri2 = con.createCriteria(Cart.class);
                    Cart cart = null;
                    cri2.add(Restrictions.eq("user", user));
                    if (cri2.list().size() > 0) {
                        cart = (Cart) cri2.list().get(0);
                    }

                    Criteria cri3 = cri.createCriteria("stock");
                    cri3.add(Restrictions.gt("quentity", 0));
                    cri.add(Restrictions.eq("cart", cart));
                    cri.add(Restrictions.eq("isPurches", 0));

                    cri.setFirstResult(frest);
                    cri.setMaxResults(15);

                    List<CartProd> crtprdlist = cri.list();


                %>             

                <div class="container">
                    <div class="row">
                        <div class="col-sm-11">
                            <%                                if (cart != null) {
                            %>
                            <div class="ibox-title">
                                <h3>My Cart &nbsp; <i class="fa fa-shopping-cart"></i></h3>
                            </div>
                            <div class="ibox-content">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <h3 class="">&nbsp;&nbsp;You have <%=cart.getTotProd()%> items in your cart</h3>
                                        <h3 class="">&nbsp;&nbsp;Total value of your cart is <%=cart.getTotVal()%> LKR</h3>
                                    </div>
                                    <div class="col-sm-5">
                                        <%
                                            if (crtprdlist.size() > 0) {
                                        %>
                                        <h3><a href="client_checkout.jsp"><button class="btn btn-primary">Checkout</button></a></h3>
                                        <%
                                            }
                                        %>
                                    </div>
                                </div>
                            </div>  
                            <div class="ibox-title">
                                <h3>Cart Products</h3>
                            </div>
                            <div class="ibox-content">
                                <table class="table table-hover">
                                    <tr>
                                        <th>Type</th>
                                        <th>Brand</th>
                                        <th>Name</th>
                                        <th>Quantity</th>
                                        <th>Unit Price</th>
                                        <th>Total</th>
                                        <th>Color</th>
                                        <th>Storage</th>
                                        <th></th>
                                    </tr>
                                    <%
                                        if (crtprdlist.size() > 0) {
                                            for (CartProd cpd : crtprdlist) {
                                    %>
                                    <tr class="font-bold">
                                        <td><%=cpd.getStock().getProducts().getCategory().getCatName()%></td>
                                        <td><%=cpd.getStock().getProducts().getBrand().getBrandName()%></td>
                                        <td><%=cpd.getStock().getProducts().getItmName()%></td>
                                        <td><%=cpd.getQty()%> / <%=cpd.getStock().getQuentity()%></td>
                                        <td><%=cpd.getStock().getItmPrice() - cpd.getStock().getDiscount()%></td>
                                        <td><%=(cpd.getStock().getItmPrice() - cpd.getStock().getDiscount()) * cpd.getQty()%></td>
                                        <td><%=cpd.getStock().getColor()%></td>
                                        <td><%=cpd.getStock().getStorage()%>GB</td>
                                        <td>
                                            <a href="http://localhost:8080/MobiShop/removeItmFrmCrt?chpid=<%=cpd.getIdcartProd()%>"><button class="btn btn-danger pull-right">Remove</button></a>
                                            <a href="http://localhost:8080/MobiShop/client_view_cart_prd.jsp?chpid=<%=cpd.getIdcartProd()%>"><button class="btn btn-primary pull-right">View</button></a>
                                        </td>
                                    </tr>
                                    <%
                                            }
                                        }
                                    %>
                                </table>

                                <div class="row col-sm-12">
                                    <div class="btn-group pull-right">
                                        <%
                                            
                                            if (frest != 0) {
                                        %>
                                        <a href="http://localhost:8080/MobiShop/client_cart.jsp?frest=<%=frest - 15%>">
                                            <button type="button" class="btn btn-primary"><i class="fa fa-chevron-left"></i>Previous</button>
                                        </a>
                                        <%
                                            }
                                            if (crtprdlist.size() == 15) {
                                        %>
                                        <a href="http://localhost:8080/MobiShop/client_cart.jsp?frest=<%=frest + 15%>">
                                            <button type="button" class="btn btn-primary"><i class="fa fa-chevron-right"></i>Next</button>
                                        </a>
                                        <%
                                            }
                                        %>
                                    </div>
                                </div>

                            </div>
                            <%
                                } else {
                                    Transaction t = con.beginTransaction();
                                    cart = new Cart(user);
                                    cart.setTotProd(0);
                                    cart.setTotVal(0.0);
                                    con.save(cart);
                                    t.commit();
                                    response.sendRedirect("client_cart.jsp");
                                }
                            %>
                        </div>
                    </div>
                </div> 



            </div>
            <%@include file="/partials/footer.jsp" %>
        </div>
        <%@include file="/partials/commonjs.jsp" %>
        <%
            } catch (Exception e) {
                e.printStackTrace();
                response.sendError(500);
            }
        %>
    </body>
</html>
