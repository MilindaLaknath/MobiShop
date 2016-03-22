<%-- 
    Document   : admin_stock_report
    Created on : Dec 20, 2015, 2:29:30 AM
    Author     : Milinda
--%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="hiben.Stock"%>
<%@page import="hiben.Products"%>
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

                String datefrm = request.getParameter("date_from");
                String dateto = request.getParameter("date_to");
                String pid = request.getParameter("pid");

                List<Stock> list;
//                List<Products> prdlist;

//                Criteria c1 = con.createCriteria(Products.class);
//                prdlist = c1.list();
                Criteria cri = con.createCriteria(Stock.class);

                SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");

                if (datefrm != null && dateto != null) {
                    if (!datefrm.equals("")&& !datefrm.equals("null")) {
                        Date d = sdf.parse(datefrm);
                        cri.add(Restrictions.ge("stockDate", d));
                    } else {
                        datefrm = "";
                    }
                    if (!dateto.equals("") && !dateto.equals("null")) {
                        Date d = sdf.parse(dateto);
                        cri.add(Restrictions.lt("stockDate", d));
                    } else {
                        dateto = "";
                    }
                }
                if (!pid.equals("") && pid != null && !pid.equals("null")) {
                    Products p = (Products) con.load(Products.class, Integer.parseInt(pid));
                    cri.add(Restrictions.eq("products", p));
                } else {
                    pid = "";
                }

                cri.add(Restrictions.gt("quentity", Integer.parseInt("0")));

                cri.addOrder(Order.asc("batchid"));
                cri.addOrder(Order.asc("stockDate"));

                list = cri.list();

            %>



            <div class="ibox-content p-xl">
                <div class="row">
                    <div class="col-sm-6">
                        <h3>From : <%=datefrm %></h3>
                        <h3>TO : <%=dateto %></h3>
                    </div>
                    <div class="col-sm-6">
                        <%                            if (pid != null && !pid.equals("")) {
                        %>
                        <h3>Item Code : <%=pid %></h3>
                        <%
                            }
                        %>
                    </div>
                </div>

                <div class="table-responsive m-t">
                    <table class="table invoice-table">
                        <thead>
                            <tr>
                                <th>Batch ID</th>
                                <th>Item Code</th>
                                <th>Name</th>
                                <th>Category</th>
                                <th>Brand</th>
                                <th>Price</th>
                                <th>Discount</th>
                                <th>Quantity</th>
                                <th>Color</th>
                                <th>Storage</th>
                                <th>Added Date</th>
                            </tr>
                        </thead>
                        <tbody>

                            <%                        for (Stock s : list) {
                            %>
                            <tr>
                                <td><%=s.getBatchid()%></td>
                                <td><%=s.getProducts().getProdCode()%></td>
                                <td><%=s.getProducts().getItmName()%></td>
                                <td><%=s.getProducts().getCategory().getCatName()%></td>
                                <td><%=s.getProducts().getBrand().getBrandName()%></td>
                                <td><%=s.getItmPrice()%></td>
                                <td><%=s.getDiscount() %></td>
                                <td><%=s.getQuentity()%></td>
                                <td><%=s.getColor()%></td>
                                <td><%=s.getStorage()%></td>
                                <td><%=sdf.format(s.getStockDate())%></td>
                            </tr>
                            <%
                                }
                            %>

                        </tbody>


                    </table>
                </div><!-- /table-responsive -->

                <!--                <table class="table invoice-total">
                                    <tbody>
                                        <tr>
                                            <td><strong>SUB TOTAL :</strong></td>
                                            <td>Rs. </td>
                                        </tr>
                                    </tbody>
                                </table>-->

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
