<%-- 
    Document   : admin_stock
    Created on : Dec 15, 2015, 9:15:08 PM
    Author     : Milinda
--%>

<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="hiben.Products"%>
<%@page import="hiben.Category"%>
<%@page import="hiben.Brand"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="hiben.Stock"%>
<%@page import="java.util.List"%>
<%@page import="conn.FactoryManager"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="/partials/header.jsp" %>

        <!-- Data Tables -->
        <link href="http://localhost:8080/MobiShop/partials/assets/css/plugins/dataTables/dataTables.bootstrap.css" rel="stylesheet">
        <link href="http://localhost:8080/MobiShop/partials/assets/css/plugins/dataTables/dataTables.responsive.css" rel="stylesheet">
        <link href="http://localhost:8080/MobiShop/partials/assets/css/plugins/dataTables/dataTables.tableTools.min.css" rel="stylesheet">
        <link href="http://localhost:8080/MobiShop/partials/assets/css/plugins/datapicker/datepicker3.css" rel="stylesheet">

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
                        if (user.getUserType().getType().equals("Admin") || user.getUserType().getType().equals("Root")) {
                        } else {
                            response.sendRedirect("login.jsp");
                            return;
                        }

                        String pid = "";
                        String datefrm = "";
                        String dateto = "";

                        datefrm = request.getParameter("date_from");
                        dateto = request.getParameter("date_to");

                        pid = request.getParameter("pid");

                        String strfrest = "";
                        int frest = 0;

                        strfrest = request.getParameter("frest");

                        if (strfrest != null && !strfrest.equals("")) {
                            frest = Integer.parseInt(strfrest);
                        } else {
                            frest = 0;
                        }

                        Session con = FactoryManager.getSessionFactory().openSession();

                        List<Stock> list;

                        List<Products> prdlist;

                        Criteria c1 = con.createCriteria(Products.class);
                        prdlist = c1.list();

                        Criteria cri = con.createCriteria(Stock.class);

                        SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");

                        if (datefrm != null && dateto != null && pid != null) {
                            if (!datefrm.equals("")) {
                                Date d = sdf.parse(datefrm);
                                cri.add(Restrictions.ge("stockDate", d));
                            }
                            if (!dateto.equals("")) {
                                Date d = sdf.parse(dateto);
                                cri.add(Restrictions.lt("stockDate", d));
                            }
                            if (!pid.equals("")) {
                                Products p = (Products) con.load(Products.class, Integer.parseInt(pid));
                                cri.add(Restrictions.eq("products", p));
                            }
                        }

                        cri.add(Restrictions.gt("quentity", Integer.parseInt("0")));

                        cri.addOrder(Order.asc("batchid"));
                        cri.addOrder(Order.asc("stockDate"));

                        cri.setFirstResult(frest);
                        cri.setMaxResults(20);

                        list = cri.list();

                %>

                <div class="container col-sm-12" style="margin-top: 15px;">
                    <div class="ibox-title" style="height: 60px;">
                        <h3 class="inline font-bold">Stock Details</h3>    
                        <a href="http://localhost:8080/MobiShop/admin_stock_report.jsp?date_to=<%=dateto%>&date_from=<%=datefrm%>&pid=<%=pid%>" target="_blank" class="btn btn-primary pull-right" style="margin-right: 20px;">Print Report</a>
                    </div>
                    <div class="ibox-content">
                        <div class="row">
                            <form role="form" class="form-inline" action="admin_stock.jsp">
                                <div id="date_from" class="col-sm-4">
                                    <label class="control-label">Date From : </label>
                                    <div class="input-group date">
                                        <span class="input-group-addon"><i
                                                class="fa fa-calendar"></i></span>
                                        <input name="date_from" type="text" class="form-control"
                                               value="<% if (datefrm != null) {
                                                       if (!datefrm.equals("")) {
                                                           out.print(datefrm);
                                                       }
                                                   } %>"
                                               >
                                    </div>
                                </div>
                                <div id="date_to" class="col-sm-4">
                                    <label class="control-label">Date To : </label>
                                    <div class="input-group date">
                                        <span class="input-group-addon"><i
                                                class="fa fa-calendar"></i></span>
                                        <input name="date_to" type="text" class="form-control"
                                               value="<% if (dateto != null) {
                                                       if (!dateto.equals("")) {
                                                           out.print(dateto);
                                                       }
                                                   } %>"
                                               >
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <label class="control-label">Item Code : </label>
                                    <div class="input-group">
                                        <select class="form-control" name="pid">
                                            <option value="">---</option>
                                            <%            for (Products prd : prdlist) {

                                                    if (pid != null && pid.equals(prd.getItmCode())) {
                                            %>
                                            <option selected="" value="<%=prd.getItmCode()%>"><%=prd.getProdCode()%></option>
                                            <%

                                            } else {
                                            %>
                                            <option value="<%=prd.getItmCode()%>"><%=prd.getProdCode()%></option>
                                            <%
                                                    }
                                                }
                                            %>
                                        </select>
                                    </div>
                                </div>
                                <div class="">
                                    <button class="btn btn-primary" type="submit">Filter</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <div class="ibox-content">
                    <table class="table table-hover">
                        <tr>
                            <th>Batch ID</th>
                            <th>Item Code</th>
                            <th>Name</th>
                            <!--<th>Category</th>-->
                            <th>Brand</th>
                            <th>Price</th>
                            <th>Discount</th>
                            <th>Quantity</th>
                            <th>Color</th>
                            <th>Storage</th>
                            <th>Added Date</th>
                            <th></th>
                        </tr>

                        <%                        for (Stock s : list) {
                        %>
                        <tr>
                            <td><%=s.getBatchid()%></td>
                            <td><%=s.getProducts().getProdCode()%></td>
                            <td><%=s.getProducts().getItmName()%></td>
                            <!--<td><%=s.getProducts().getCategory().getCatName()%></td>-->
                            <td><%=s.getProducts().getBrand().getBrandName()%></td>
                            <td><%=s.getItmPrice()%></td>
                            <td>
                                <% if (s.getDiscount() > 0.0) {
                                %>
                                <a href="http://localhost:8080/MobiShop/admin_update_discount.jsp?batchid=<%=s.getBatchid()%>" title="Update Discount">
                                    <%out.print(s.getDiscount());
                                    %>
                                </a>
                                <%
                                } else {
                                %>
                                <a href="http://localhost:8080/MobiShop/admin_update_discount.jsp?batchid=<%=s.getBatchid()%>"><button class=" btn-default">Update Discount</button></a>
                                <%
                                    }
                                %>
                            </td>
                            <td><%=s.getQuentity()%></td>
                            <td><%=s.getColor()%></td>
                            <td><%=s.getStorage()%></td>
                            <td><%=sdf.format(s.getStockDate())%></td>
                            <td>
                                <a href="http://localhost:8080/MobiShop/admin_update_stock.jsp?id=<%=s.getProducts().getItmCode()%>"><button class=" btn-default pull-right">Update Stock</button></a>
                                <!--<a href=""><button class="btn btn-primary pull-right">View</button></a>-->
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </table>

                    <div class="row col-sm-12">
                        <div class="btn-group pull-right">
                            <%
                                String url = "";
                                if (datefrm != null) {
                                    url += "&date_from=" + datefrm;
                                }
                                if (dateto != null) {
                                    url += "&date_to=" + dateto;
                                }
                                if (pid != null) {
                                    url += "&pid=" + pid;
                                }

                                if (frest != 0) {
                            %>
                            <a href="http://localhost:8080/MobiShop/admin_stock.jsp?frest=<%=frest - 20%><%=url%>">
                                <button type="button" class="btn btn-primary"><i class="fa fa-chevron-left"></i>Previous</button>
                            </a>
                            <%
                                }
                                if (list.size() == 20) {
                            %>
                            <a href="http://localhost:8080/MobiShop/admin_stock.jsp?frest=<%=frest + 20%><%=url%>">
                                <button type="button" class="btn btn-primary"><i class="fa fa-chevron-right"></i>Next</button>
                            </a>
                            <%
                                }
                            %>
                        </div>
                    </div>

                    <%
                        } catch (Exception e) {
                            out.print(e.toString());

                            response.sendError(500);
                        }
                    %>
                </div>
            </div>
            <%@include file="/partials/footer.jsp" %>
        </div>
        <%@include file="/partials/commonjs.jsp" %>

        <script src="http://localhost:8080/MobiShop/partials/assets/js/plugins/datapicker/bootstrap-datepicker.js"></script>

        <script type="text/javascript">
            $(document).ready(function () {
                $('#date_from .input-group.date').datepicker({
                    todayBtn: "linked",
                    keyboardNavigation: false,
                    forceParse: false,
                    calendarWeeks: true,
                    autoclose: true
                });
                $('#date_to .input-group.date').datepicker({
                    todayBtn: "linked",
                    keyboardNavigation: false,
                    forceParse: false,
                    calendarWeeks: true,
                    autoclose: true
                });
            });
        </script>

    </body>
</html>
