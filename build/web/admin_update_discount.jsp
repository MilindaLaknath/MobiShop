<%-- 
    Document   : admin_update_discount
    Created on : Dec 15, 2015, 10:32:24 PM
    Author     : Milinda
--%>

<%@page import="hiben.Stock"%>
<%@page import="conn.FactoryManager"%>
<%@page import="org.hibernate.Session"%>
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
                        if (user.getUserType().getType().equals("Admin") || user.getUserType().getType().equals("Root")) {
                        } else {
                            response.sendRedirect("login.jsp");
                            return;
                        }

                        String batchid = "";

                        batchid = request.getParameter("batchid");

                        Stock stk = null;

                        if (batchid != null && !batchid.equals("")) {

                            Session con = FactoryManager.getSessionFactory().openSession();

                            stk = (Stock) con.load(Stock.class, Integer.parseInt(batchid));
                        } else {
                            response.sendRedirect("admin_stock.jsp");
                        }
                %>

                <div class="container col-sm-12" style="margin-top: 15px;">
                    <div class="ibox-title">
                        <h5>Update Discount</h5>                            
                    </div>
                    <div class="ibox-content">
                        <div class="row">
                            <form role="form" method="post" class="form-horizontal" action="updateStockDiscount">
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">Batch ID : </label>
                                    <div class="col-sm-6">
                                        <input name="batchid" readonly="" type="text" class="form-control" value="<%=batchid%>" >
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">Product Code : </label>
                                    <div class="col-sm-6">
                                        <input name="pcode" disabled="" type="text" class="form-control" value="<%=stk.getProducts().getProdCode()%>" >
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">Product Name : </label>
                                    <div class="col-sm-6">
                                        <input name="pname" disabled="" type="text" class="form-control" value="<%=stk.getProducts().getItmName()%>" >
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">Product Price : </label>
                                    <div class="col-sm-6">
                                        <input class="form-control" type="number" readonly="" value="<%=stk.getItmPrice()%>" min="0" step="0.01" name="price" required="" id="price">
                                    </div> <h3>LKR</h3>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">Product Color : </label>
                                    <div class="col-sm-6">
                                        <input class="form-control" type="text" disabled="" value="<%=stk.getColor()%>"  name="color" id="color">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">Product Storage : </label>
                                    <div class="col-sm-6">
                                        <input class="form-control" type="number" disabled="" value="<%=stk.getStorage()%>"  name="storage" id="storage">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">Added Date : </label>
                                    <div class="col-sm-6">
                                        <input class="form-control" type="text" disabled="" value="<%=stk.getStockDate()%>" min="0" step="0.01" name="adate" id="adate">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">Discount : </label>
                                    <div class="col-sm-6">
                                        <input class="form-control" type="number" min="0" step="0.01" name="discount" value="<%=stk.getDiscount()%>" required="" id="discount">
                                    </div> <h3>LKR</h3>
                                </div>


                                <div class="form-group" >
                                    <div class="col-sm-3 pull-right"><input class="form-control btn btn-outline btn-primary" type="submit" value="Update Discount"></div>
                                    <a href="http://localhost:8080/MobiShop/admin_stock.jsp" style=" color: #ff6666;"><div class="col-sm-3 pull-right"><lable class="form-control btn btn-outline btn-default" style="text-align: center;" >Clear</lable></div></a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <%                    } catch (Exception e) {
                        out.print(e.toString());
                        response.sendError(500);
                    }
                %>
            </div>
            <%@include file="/partials/footer.jsp" %>
        </div>
        <%@include file="/partials/commonjs.jsp" %>
    </body>
</html>
