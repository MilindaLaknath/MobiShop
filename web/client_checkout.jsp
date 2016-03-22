<%-- 
    Document   : client_checkout
    Created on : Dec 18, 2015, 12:42:02 PM
    Author     : Milinda
--%>

<%@page import="hiben.CartProd"%>
<%@page import="hiben.Cart"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="/partials/header.jsp" %>

    </head>
    <body>
        <%


        %>
        <div id="wrapper">
            <%@include file="/partials/sidebar_search.jsp" %> 
            <div id="page-wrapper" class="gray-bg top-navigation">
                <div class="row border-bottom">
                    <%@include file="/partials/top_bar.jsp" %> 
                </div>

                <div class="row">
                    <%                        try {

                            User user = (User) session.getAttribute("user");

                            if (user == null) {
                                response.sendRedirect("login.jsp");
                                return;
                            }

                            Cart cart = null;

                            Session con = FactoryManager.getSessionFactory().openSession();
                            Criteria cri = con.createCriteria(Cart.class);
                            cri.add(Restrictions.eq("user", user));

                            if (cri.list().size() < 1) {
                                response.sendRedirect("client_cart.jsp");
                                return;
                            }

                            cart = (Cart) cri.list().get(0);

                            cri = con.createCriteria(CartProd.class);
                            cri.add(Restrictions.eq("cart", cart));

                            List<CartProd> cplist = cri.list();
                          

                    %>
                    <div class="col-lg-12">
                        <div class="wrapper wrapper-content animated fadeInRight">
                            <div class="ibox-content p-xl">
                                <div class="row">
                                    <form name="frmInvoice" action="addTransaction" method="post" class="form form-horizontal">
                                        <div class="row" >
                                            <h3 class="inline" style="margin-left: 20px;">Customer Name : </h3>
                                            <h3 class="inline" style="margin-left: 20px;" class="text-navy"><%=user.getPersonalDetails().getFName() + " " + user.getPersonalDetails().getLName()%></h3>
                                        </div>
                                        <div class="row">
                                            <h3 style="margin-left: 20px;">Shipping Address :</h3>
                                        </div>
                                        <div class="col-sm-6">
                                            <span>${user.getPersonalDetails().getAddress().getHomeNo()}</span><br/>
                                            <span>${user.getPersonalDetails().getAddress().getAddl1() }</span><br/>
                                            <span>${user.getPersonalDetails().getAddress().getAddl2()}</span><br/>
                                            <span>${user.getPersonalDetails().getAddress().getCity()}</span><br/>
                                            <span>${user.getPersonalDetails().getAddress().getPostCode()}</span><br/>
                                            <span>${user.getPersonalDetails().getPhone()}</span>
                                            <!--<p>
                                                <span><strong>Invoice Date:</strong> Marh 18, 2014</span><br/>
                                                <span><strong>Due Date:</strong> March 24, 2014</span>
                                                </p>-->
                                        </div>

                                        <div class="col-sm-6 text-right">
                                            <div class="text-right">
                                                <button type="submit" class="btn btn-primary"><i class="fa fa-dollar"></i>Make A Payment</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>

                                <div class="table-responsive m-t">
                                    <table class="table invoice-table">
                                        <thead>
                                            <tr>
                                                <th>Item List</th>
                                                <th>Quantity</th>
                                                <th>Unit Price</th>
                                                <th>Total Price</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                for (CartProd cp : cplist) {
                                                    if (cp.getIsPurches().equals(0)) {
                                            %>
                                            <tr>
                                                <td><div><strong><%=cp.getStock().getProducts().getBrand().getBrandName() + " " + cp.getStock().getProducts().getItmName()%></strong></div>                                                    
                                                <td><%=cp.getQty()%></td>
                                                <td>Rs. <%=cp.getStock().getItmPrice() - cp.getStock().getDiscount()%></td>
                                                <td>Rs. <%=cp.getQty() * (cp.getStock().getItmPrice() - cp.getStock().getDiscount())%></td>
                                            </tr>
                                            <%
                                                    }
                                                }
                                            %>

                                        </tbody>
                                    </table>
                                </div><!-- /table-responsive -->

                                <table class="table invoice-total">
                                    <tbody>
                                        <!--                                        <tr>
                                                                                    <td><strong>Sub Total :</strong></td>
                                                                                    <td>$1026.00</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td><strong>TAX :</strong></td>
                                                                                    <td>$235.98</td>
                                                                                </tr>-->
                                        <tr>
                                            <td><strong>SUB TOTAL :</strong></td>
                                            <td>Rs. <%=cart.getTotVal()%></td>
                                        </tr>
                                    </tbody>
                                </table>



                            </div>
                        </div>
                    </div>

                    <%                } catch (Exception e) {
                            e.printStackTrace();
                            response.sendError(500);
                        }
                    %>
                </div>
            </div>
            <%@include file="/partials/footer.jsp" %>
        </div>
        <%@include file="/partials/commonjs.jsp" %>

    </body>
</html>
