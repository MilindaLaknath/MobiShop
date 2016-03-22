<%-- 
    Document   : admin_ordered_items
    Created on : Dec 8, 2015, 12:23:07 AM
    Author     : Milinda
--%>

<%@page import="hiben.Invoice"%>
<%@page import="hiben.Transaction"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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

                <%                     String msg = "";
                    String typ = "";
                    int swit = 0;
                    msg = request.getParameter("msg");
                    typ = request.getParameter("msgtype");

                    if (msg != null && !msg.equals("")) {
                        if (typ != null && !typ.equals("")) {
                            swit = Integer.parseInt(typ);
                        }

                        switch (swit) {
                            case 0:
                %>
                <div class="alert alert-success alert-dismissable">
                    <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                    <%=msg%>
                </div>
                <%
                        break;
                    case 1:
                %>
                <div class="alert alert-danger alert-dismissable">
                    <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                    <%=msg%>
                </div>
                <%
                                break;
                        }
                    }
                %>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel blank-panel">
                            <%                                try {
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
                                    cri.addOrder(Order.asc("transDate"));
                                    cri.add(Restrictions.eq("isSend", 0));
                                    cri.setFirstResult(frest);
                                    cri.setMaxResults(20);

                                    List<Transaction> trlist = cri.list();

                                    cri = con.createCriteria(Transaction.class);
                                    cri.addOrder(Order.asc("transDate"));
                                    cri.add(Restrictions.eq("isSend", 1));
                                    cri.setFirstResult(frest2);
                                    cri.setMaxResults(20);

                                    List<Transaction> trlist2 = cri.list();

                                    cri = con.createCriteria(Transaction.class);
                                    cri.addOrder(Order.asc("transDate"));
                                    cri.setFirstResult(frest3);
                                    cri.setMaxResults(20);

                                    List<Transaction> trlist3 = cri.list();

                            %>

                            <!--                            <div class="ibox-title">
                                                            <h3>Orders </h3>
                                                        </div>-->

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
                                                    <tr>
                                                    <tr><th>Invoice Id</th>
                                                        <th>Total Items</th>
                                                        <th>Total Amount</th>
                                                        <th>Invoice Date</th>
                                                        <th></th>
                                                    </tr>
                                                    </tr>

                                                    <%                                                    if (trlist.size() > 0) {
                                                            for (Transaction trn : trlist) {

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
                                                        <a href="http://localhost:8080/MobiShop/admin_ordered_items.jsp?frest=<%=frest - 20%>">
                                                            <button type="button" class="btn btn-primary"><i class="fa fa-chevron-left"></i>Previous</button>
                                                        </a>
                                                        <%
                                                            }
                                                            if (trlist.size() == 20) {
                                                        %>
                                                        <a href="http://localhost:8080/MobiShop/admin_ordered_items.jsp?frest=<%=frest + 20%>">
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
                                                    <tr>
                                                    <tr><th>Invoice Id</th>
                                                        <th>Total Items</th>
                                                        <th>Total Amount</th>
                                                        <th>Invoice Date</th>
                                                        <th></th>
                                                    </tr>
                                                    </tr>

                                                    <%                                                    if (trlist.size() > 0) {
                                                            for (Transaction trn : trlist2) {

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
                                                        <a href="http://localhost:8080/MobiShop/admin_ordered_items.jsp?frest2=<%=frest2 - 20%>">
                                                            <button type="button" class="btn btn-primary"><i class="fa fa-chevron-left"></i>Previous</button>
                                                        </a>
                                                        <%
                                                            }
                                                            if (trlist.size() == 20) {
                                                        %>
                                                        <a href="http://localhost:8080/MobiShop/admin_ordered_items.jsp?frest2=<%=frest2 + 20%>">
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
                                                    <tr>
                                                    <tr><th>Invoice Id</th>
                                                        <th>Total Items</th>
                                                        <th>Total Amount</th>
                                                        <th>Invoice Date</th>
                                                        <th>Is Send</th>
                                                        <th></th>
                                                    </tr>
                                                    </tr>

                                                    <%                                                    if (trlist.size() > 0) {
                                                            for (Transaction trn : trlist3) {

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
                                                        <a href="http://localhost:8080/MobiShop/admin_ordered_items.jsp?frest3=<%=frest3 - 20%>">
                                                            <button type="button" class="btn btn-primary"><i class="fa fa-chevron-left"></i>Previous</button>
                                                        </a>
                                                        <%
                                                            }
                                                            if (trlist.size() == 20) {
                                                        %>
                                                        <a href="http://localhost:8080/MobiShop/admin_ordered_items.jsp?frest3=<%=frest3 + 20%>">
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

                            <%
                                } catch (Exception e) {
                                    e.printStackTrace();
                                    response.sendError(500);
                                }
                            %>

                        </div>
                    </div>
                </div>


            </div>
            <%@include file="/partials/footer.jsp" %>
        </div>
        <%@include file="/partials/commonjs.jsp" %>

    </body>
</html>
