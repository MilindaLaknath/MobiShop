<%-- 
    Document   : client_invoice
    Created on : Dec 18, 2015, 11:37:35 PM
    Author     : Milinda
--%>

<%@page import="hiben.TransProd"%>
<%@page import="hiben.CartProd"%>
<%@page import="conn.FactoryManager"%>
<%@page import="org.hibernate.Session"%>
<%@page import="hiben.Invoice"%>
<%@page import="hiben.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="/partials/header.jsp" %>

    </head>
    <body class="white-bg">
        <%
            try {
        %>
        <div class="wrapper wrapper-content p-xl">

            <%
                User user = (User) session.getAttribute("user");

                if (user == null) {
                    response.sendRedirect("login.jsp");
                    return;
                }

                String invoiceid = request.getParameter("invoiceid");
                if (invoiceid == null && invoiceid.equals("")) {
                    response.sendRedirect("client_user_orders.jsp");
                    return;
                }

                Session con = FactoryManager.getSessionFactory().openSession();

                Invoice inv = (Invoice) con.load(Invoice.class, Integer.parseInt(invoiceid));

                if (inv == null) {
                    response.sendRedirect("client_user_orders.jsp");
                    return;
                }

            %>



            <div class="ibox-content p-xl">
                <div class="row">
                    <div class="col-sm-6">
                        <h5>From:</h5>
                        <h2>Mobile Shop</h2>
                    </div>

                    <div class="col-sm-6 text-right">
                        <h4>Invoice No.</h4>
                        <h4 class="text-navy"><%=inv.getInvoiceNo()%></h4>
                        <span>To:</span>
                        <address>
                            <strong><%=user.getPersonalDetails().getFName() + " " + user.getPersonalDetails().getLName()%></strong><br>
                            <span>${user.getPersonalDetails().getAddress().getHomeNo()}</span><br/>
                            <span>${user.getPersonalDetails().getAddress().getAddl1() }</span><br/>
                            <span>${user.getPersonalDetails().getAddress().getAddl2()}</span><br/>
                            <span>${user.getPersonalDetails().getAddress().getCity()}</span><br/>
                            <span>${user.getPersonalDetails().getAddress().getPostCode()}</span><br/>
                            <span>${user.getPersonalDetails().getPhone()}</span>
                        </address>
                        <p>
                            <span><strong>Invoice Date : </strong><%=inv.getInvoiceDate()%></span>
                        </p>
                    </div>
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
                                for (TransProd tp : inv.getTransaction().getTransProds()) {
                            %>
                            <tr>
                                <td><div><strong><%=tp.getStock().getProducts().getBrand().getBrandName() + " " + tp.getStock().getProducts().getItmName()%></strong></div>                                                    
                                <td><%=tp.getQty()%></td>
                                <td>Rs. <%=tp.getStock().getItmPrice() - tp.getStock().getDiscount()%></td>
                                <td>Rs. <%=tp.getQty() * (tp.getStock().getItmPrice() - tp.getStock().getDiscount())%></td>
                            </tr>
                            <%
                                }
                            %>

                        </tbody>


                    </table>
                </div><!-- /table-responsive -->

                <table class="table invoice-total">
                    <tbody>
                        <tr>
                            <td><strong>SUB TOTAL :</strong></td>
                            <td>Rs. <%=inv.getAmount()%></td>
                        </tr>
                    </tbody>
                </table>
                <%
                    if (user.getUserType().getType().equals("Admin")) {
                %>
                <button id="print" class="btn btn-primary pull-left">Print</button>
                <%
                    if (inv.getTransaction().getIsSend().equals(0)) {
                %>
                <a href="http://localhost:8080/MobiShop/makeSend?transid=<%=inv.getTransaction().getIdtransaction()%>"><button class="btn btn-primary pull-right">Make as Send</button></a>
                <%
                        }
                    }
                %>
            </div>






        </div>
        <%@include file="/partials/commonjs.jsp" %>

        <%
            if (user.getUserType().getType().equals("Client")) {

        %>
        <script type="text/javascript">
            window.print();
        </script>
        <%            } else {
        %>
        <script type="text/javascript">
            $('#print').click(function () {
                window.print();
            });
        </script>
        <%
            }
        %>


        <%                    } catch (Exception e) {
                e.printStackTrace();
                        response.sendError(500);
            }
        %>
    </body>


</html>
