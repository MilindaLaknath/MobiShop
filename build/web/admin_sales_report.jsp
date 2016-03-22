<%-- 
    Document   : admin_sales_report
    Created on : Dec 20, 2015, 2:00:48 AM
    Author     : Milinda
--%>

<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="java.util.List"%>
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
                if (user.getUserType().getType().equals("Admin") || user.getUserType().getType().equals("Root")) {
                } else {
                    response.sendRedirect("login.jsp");
                    return;
                }

                Session con = FactoryManager.getSessionFactory().openSession();
                String datefrm = "";
                String dateto = "";

                datefrm = request.getParameter("date_from");
                dateto = request.getParameter("date_to");
                List<TransProd> list;
                Criteria cri = con.createCriteria(TransProd.class);

                SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");

                if (datefrm != null && dateto != null) {
                    Criteria cri2 = cri.createCriteria("transaction");
                    if (!datefrm.equals("") && !datefrm.equals("null")) {
                        Date d = sdf.parse(datefrm);
                        cri2.add(Restrictions.ge("transDate", d));
                    }
                    if (!dateto.equals("") && !dateto.equals("null")) {
                        Date d = sdf.parse(dateto);
                        cri2.add(Restrictions.le("transDate", d));
                    }
                }

                list = cri.list();

                double subtotal = 0.0;

            %>



            <div class="ibox-content p-xl">
                <div class="row">
                    <div class="col-sm-6">
                        <h3>From : ${datefrm}</h3>
                        <h3>TO : ${dateto}</h3>
                    </div>
                </div>

                <div class="table-responsive m-t">
                    <table class="table invoice-table">
                        <thead>
                            <tr>
                                <th>Product Code</th>
                                <th>Batch ID</th>
                                <th>Product Name</th>
                                <th>Quantity</th>
                                <th>Price</th>
                                <th>Discount</th>
                                <th>Total</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%                                for (TransProd tp : list) {
                            %>
                            <tr>
                                <td><%=tp.getStock().getProducts().getProdCode()%></td>
                                <td><%=tp.getStock().getBatchid()%></td>
                                <td><%=tp.getStock().getProducts().getItmName()%></td>
                                <td><%=tp.getQty()%></td>
                                <td><%=tp.getStock().getItmPrice()%></td>
                                <td><%=tp.getStock().getDiscount()%></td>
                                <td><%=(tp.getStock().getItmPrice() - tp.getStock().getDiscount()) * tp.getQty()%></td>
                                <%
                                    subtotal += (tp.getStock().getItmPrice() - tp.getStock().getDiscount()) * tp.getQty();
                                %>
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
                            <td>Rs. <%=subtotal%></td>
                        </tr>
                    </tbody>
                </table>

            </div>






        </div>
        <%@include file="/partials/commonjs.jsp" %>


        <script type="text/javascript">
            window.print();
        </script>      


        <%                    } catch (Exception e) {
                e.printStackTrace();

                response.sendError(500);
            }
        %>
    </body>


</html>
