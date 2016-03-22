<%-- 
    Document   : client_user_orders
    Created on : Dec 7, 2015, 10:47:32 PM
    Author     : Milinda
--%>

<%@page import="hiben.Invoice"%>
<%@page import="hiben.Transaction"%>
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
                        }

                        String strfrest = "";
                        int frest = 0;
                        String strfrest2 = "";
                        int frest2 = 0;
                        String strfrest3 = "";
                        int frest3 = 0;

                        strfrest = request.getParameter("frest");
                        strfrest2 = request.getParameter("frest2");
                        strfrest3 = request.getParameter("frest3");

                        if (strfrest != null && !strfrest.equals("")) {
                            frest = Integer.parseInt(strfrest);
                            if (frest < 0) {
                                frest = 0;
                            }
                        } else {
                            frest = 0;
                        }
                        if (strfrest2 != null && !strfrest2.equals("")) {
                            frest2 = Integer.parseInt(strfrest2);
                            if (frest2 < 0) {
                                frest2 = 0;
                            }
                        } else {
                            frest = 0;
                        }
                        if (strfrest3 != null && !strfrest3.equals("")) {
                            frest3 = Integer.parseInt(strfrest3);
                            if (frest3 < 0) {
                                frest3 = 0;
                            }
                        } else {
                            frest3 = 0;
                        }

                        Session con = FactoryManager.getSessionFactory().openSession();
                        Criteria cri = con.createCriteria(Transaction.class);
                        cri.add(Restrictions.eq("user", user));
                        cri.add(Restrictions.eq("isSend", 0));
                        cri.setFirstResult(frest);
                        cri.setMaxResults(20);

                        List<Transaction> trnslist = cri.list();

                        cri = con.createCriteria(Transaction.class);
                        cri.add(Restrictions.eq("user", user));
                        cri.add(Restrictions.eq("isSend", 1));
                        cri.setFirstResult(frest2);
                        cri.setMaxResults(20);

                        List<Transaction> trnslist2 = cri.list();

                        cri = con.createCriteria(Transaction.class);
                        cri.add(Restrictions.eq("user", user));
                        cri.setFirstResult(frest3);
                        cri.setMaxResults(20);

                        List<Transaction> trnslist3 = cri.list();

                %>

                <div class="row">
                    <div class="col-lg-12">
                        <div class="ibox-title">
                            <h3 class="font-bold">My Orders</h3>
                        </div>

                        <div class="ibox-content">

                            <div class="panel blank-panel">

                                <div class="panel-heading">
                                    <div class="panel-title m-b-md"><h3>Orders</h3></div>
                                    <div class="panel-options">

                                        <ul class="nav nav-tabs">
                                            <li class="active"><a data-toggle="tab" href="#tab-1">To Ship</a></li>
                                            <li class=""><a data-toggle="tab" href="#tab-2">Shipped</a></li>
                                            <li class=""><a data-toggle="tab" href="#tab-3">All Orders</a></li>
                                        </ul>
                                    </div>
                                </div>

                                <div class="panel-body">
                                    <div class="tab-content col-lg-12">
                                        <div id="tab-1" class="tab-pane active">
                                            <table class="table table-hover">
                                                <tr><th>Invoice Id</th>
                                                    <th>Total Items</th>
                                                    <th>Total Amount</th>
                                                    <th>Invoice Date</th>
                                                    <th>Is Send</th>
                                                    <th></th>
                                                </tr>
                                                <%                                        if (trnslist.size() > 0) {
                                                        for (Transaction trn : trnslist) {
                                                            cri = con.createCriteria(Invoice.class);
                                                            cri.add(Restrictions.eq("transaction", trn));

                                                            Invoice inv = null;
                                                            if (cri.list().size() > 0) {
                                                                inv = (Invoice) cri.list().get(0);
                                                            }

                                                %>

                                                <tr>
                                                    <td><%=inv.getInvoiceNo()%></td>
                                                    <td><%=trn.getTotItms()%></td>
                                                    <td><%=trn.getTotAmount()%></td>
                                                    <td><%=inv.getInvoiceDate()%></td>
                                                    <td>
                                                        <%
                                                            if (trn.getIsSend().equals(0)) {
                                                                out.print("Not Send");
                                                            } else {
                                                                out.print("Send");
                                                            }
                                                        %>
                                                    </td>
                                                    <td>
                                                        <a href="http://localhost:8080/MobiShop/client_invoice.jsp?invoiceid=<%=inv.getIdinvoice()%>" target="_blank"><button style="margin-left: 5px;" class="btn btn-primary pull-right">Invoice</button></a>
                                                        <a href="http://localhost:8080/MobiShop/client_trans_items.jsp?transid=<%=trn.getIdtransaction()%>"><button class="btn btn-primary pull-right">Items</button></a>
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
                                                    <a href="http://localhost:8080/MobiShop/client_user_orders.jsp?frest=<%=frest - 20%>">
                                                        <button type="button" class="btn btn-primary"><i class="fa fa-chevron-left"></i>Previous</button>
                                                    </a>
                                                    <%
                                                        }
                                                        if (trnslist.size() == 20) {
                                                    %>
                                                    <a href="http://localhost:8080/MobiShop/client_user_orders.jsp?frest=<%=frest + 20%>">
                                                        <button type="button" class="btn btn-primary"><i class="fa fa-chevron-right"></i>Next</button>
                                                    </a>
                                                    <%
                                                        }
                                                    %>
                                                </div>
                                            </div>

                                        </div>


                                        <div id="tab-2" class="tab-pane">
                                            <table class="table table-hover">
                                                <tr><th>Invoice Id</th>
                                                    <th>Total Items</th>
                                                    <th>Total Amount</th>
                                                    <th>Invoice Date</th>
                                                    <th>Is Send</th>
                                                    <th></th>
                                                </tr>
                                                <%                                        if (trnslist2.size() > 0) {
                                                        for (Transaction trn : trnslist2) {
                                                            cri = con.createCriteria(Invoice.class);
                                                            cri.add(Restrictions.eq("transaction", trn));

                                                            Invoice inv = null;
                                                            if (cri.list().size() > 0) {
                                                                inv = (Invoice) cri.list().get(0);
                                                            }

                                                %>

                                                <tr>
                                                    <td><%=inv.getInvoiceNo()%></td>
                                                    <td><%=trn.getTotItms()%></td>
                                                    <td><%=trn.getTotAmount()%></td>
                                                    <td><%=inv.getInvoiceDate()%></td>
                                                    <td>
                                                        <%
                                                            if (trn.getIsSend().equals(0)) {
                                                                out.print("Not Send");
                                                            } else {
                                                                out.print("Send");
                                                            }
                                                        %>
                                                    </td>
                                                    <td>
                                                        <a href="http://localhost:8080/MobiShop/client_invoice.jsp?invoiceid=<%=inv.getIdinvoice()%>" target="_blank"><button style="margin-left: 5px;" class="btn btn-primary pull-right">Invoice</button></a>
                                                        <a href="http://localhost:8080/MobiShop/client_trans_items.jsp?transid=<%=trn.getIdtransaction()%>"><button class="btn btn-primary pull-right">Items</button></a>
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
                                                    <a href="http://localhost:8080/MobiShop/client_user_orders.jsp?frest2=<%=frest2 - 20%>">
                                                        <button type="button" class="btn btn-primary"><i class="fa fa-chevron-left"></i>Previous</button>
                                                    </a>
                                                    <%
                                                        }
                                                        if (trnslist2.size() == 20) {
                                                    %>
                                                    <a href="http://localhost:8080/MobiShop/client_user_orders.jsp?frest2=<%=frest2 + 20%>">
                                                        <button type="button" class="btn btn-primary"><i class="fa fa-chevron-right"></i>Next</button>
                                                    </a>
                                                    <%
                                                        }
                                                    %>
                                                </div>
                                            </div>


                                        </div>

                                        <div id="tab-3" class="tab-pane">
                                            <table class="table table-hover">
                                                <tr><th>Invoice Id</th>
                                                    <th>Total Items</th>
                                                    <th>Total Amount</th>
                                                    <th>Invoice Date</th>
                                                    <th>Is Send</th>
                                                    <th></th>
                                                </tr>
                                                <%                                        if (trnslist3.size() > 0) {
                                                        for (Transaction trn : trnslist3) {
                                                            cri = con.createCriteria(Invoice.class);
                                                            cri.add(Restrictions.eq("transaction", trn));

                                                            Invoice inv = null;
                                                            if (cri.list().size() > 0) {
                                                                inv = (Invoice) cri.list().get(0);
                                                            }

                                                %>

                                                <tr>
                                                    <td><%=inv.getInvoiceNo()%></td>
                                                    <td><%=trn.getTotItms()%></td>
                                                    <td><%=trn.getTotAmount()%></td>
                                                    <td><%=inv.getInvoiceDate()%></td>
                                                    <td>
                                                        <%
                                                            if (trn.getIsSend().equals(0)) {
                                                                out.print("Not Send");
                                                            } else {
                                                                out.print("Send");
                                                            }
                                                        %>
                                                    </td>
                                                    <td>
                                                        <a href="http://localhost:8080/MobiShop/client_invoice.jsp?invoiceid=<%=inv.getIdinvoice()%>" target="_blank"><button style="margin-left: 5px;" class="btn btn-primary pull-right">Invoice</button></a>
                                                        <a href="http://localhost:8080/MobiShop/client_trans_items.jsp?transid=<%=trn.getIdtransaction()%>"><button class="btn btn-primary pull-right">Items</button></a>
                                                    </td>
                                                </tr>

                                                <%                           }
                                                    }
                                                %>


                                            </table>

                                            <div class="row col-sm-12">
                                                <div class="btn-group pull-right">
                                                    <%
                                                        if (frest != 0) {
                                                    %>
                                                    <a href="http://localhost:8080/MobiShop/client_user_orders.jsp?frest3=<%=frest3 - 20%>">
                                                        <button type="button" class="btn btn-primary"><i class="fa fa-chevron-left"></i>Previous</button>
                                                    </a>
                                                    <%
                                                        }
                                                        if (trnslist3.size() == 20) {
                                                    %>
                                                    <a href="http://localhost:8080/MobiShop/client_user_orders.jsp?frest3=<%=frest3 + 20%>">
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
</body>
</html>
