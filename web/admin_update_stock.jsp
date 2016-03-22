<%-- 
    Document   : admin_update_stock
    Created on : Dec 15, 2015, 11:22:41 AM
    Author     : Milinda
--%>

<%@page import="java.util.List"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="hiben.Products"%>
<%@page import="conn.FactoryManager"%>
<%@page import="org.hibernate.Session"%>
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

                        Session con = FactoryManager.getSessionFactory().openSession();

                        Products p = null;
                        String pid = "";
                        String id = request.getParameter("id");

                        if (id != null) {
                            p = (Products) con.load(Products.class, Integer.parseInt(id));
                            pid = p.getItmCode() + "";
                        }


                %>
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

                <div class="container col-sm-12" style="margin-top: 15px;">
                    <div class="ibox-title">
                        <h5>Items Stock Update</h5>                            
                    </div>
                    <div class="ibox-content">
                        <form name="stkUpdate" id="stkUpdate" action="updateStock" class="form-horizontal" method="post">
                            <div class="row">
                                <div class="col-lg-12">                                    
                                    <%                                        if (p != null) {
                                    %>
                                    <div class="form-group" >
                                        <label class="col-sm-3 control-label">Product ID : </label>
                                        <div class="col-sm-6"><input class="form-control" type="number" min="1" value="<%=pid%>" name="pid" required="" id="pid"></div>
                                    </div>
                                    <%
                                        }
                                    %>
                                    <div class="form-group" >
                                        <label class="col-sm-3 control-label">Product Code : </label>
                                        <%
                                            if (p != null) {
                                        %>
                                        <div class="col-sm-6"><input class="form-control" type="text" value="<%=p.getProdCode()%>" name="pcode" required="" id="pcode"></div>
                                            <%
                                            } else {
                                            %>
                                        <div class="col-sm-6"><input class="form-control" type="text" name="pcode" required="" id="pcode"><p class="text-danger" id="errmsg"></p></div> <button id="loadinfo" class="btn btn-primary" onclick="loadProduct();">Load Info</button>
                                        <input class="form-control" type="hidden" value="" name="pid" id="pid">
                                        <%
                                            }
                                        %>
                                    </div>
                                    <div class="form-group" >
                                        <label class="col-sm-3 control-label">Product Name : </label>
                                        <%
                                            if (p != null) {
                                        %>
                                        <div class="col-sm-6"><input class="form-control" disabled="" type="text" value="<%=p.getItmName()%>" name="itmname" required="" id="itmname"></div>
                                            <%
                                            } else {
                                            %>
                                        <div class="col-sm-6"><input class="form-control" disabled="" type="text" name="itmname" required="" id="itmname"></div>                                        
                                            <%
                                                }
                                            %>
                                    </div>
                                    <div class="form-group" >
                                        <label class="col-sm-3 control-label">Brand : </label>
                                        <%
                                            if (p != null) {
                                        %>
                                        <div class="col-sm-6"><input class="form-control" disabled="" type="text" value="<%=p.getBrand().getBrandName()%>" name="brand" required="" id="brand"></div>
                                            <%
                                            } else {
                                            %>
                                        <div class="col-sm-6"><input class="form-control" disabled="" type="text" name="brand" required="" id="brand"></div>
                                            <%
                                                }
                                            %>
                                    </div>
                                    <div class="form-group" >
                                        <label class="col-sm-3 control-label">Category : </label>
                                        <%
                                            if (p != null) {
                                        %>
                                        <div class="col-sm-6"><input class="form-control" disabled="" type="text" value="<%=p.getCategory().getCatName()%>" name="category" required="" id="category"></div>
                                            <%
                                            } else {
                                            %>
                                        <div class="col-sm-6"><input class="form-control" disabled="" type="text" name="category" required="" id="category"></div>
                                            <%
                                                }
                                            %>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Item Price : </label>
                                        <div class="col-sm-6"><input class="form-control" type="number" min="0" step="0.01" name="price" required="" id="price"></div> <h3>LKR</h3>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Discount : </label>
                                        <div class="col-sm-6"><input class="form-control" type="number" min="0" step="0.01" name="discount" value="0.0" required="" id="discount"></div> <h3>LKR</h3>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Storage : </label>
                                        <div class="col-sm-6"><input class="form-control" type="number" min="0" name="storage" required="" id="storage"></div> <h3>GB</h3>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Color : </label>
                                        <div class="col-sm-6"><input class="form-control" type="text" name="color" required="" id="color"></div>(Ex : Silver)
                                    </div>
                                    <div class="form-group" >
                                        <label class="col-sm-3 control-label">Quantity : </label>
                                        <div class="col-sm-6"><input class="form-control" type="number" min="1" value="1" name="quantity" required="" id="quantity"></div>
                                    </div>


                                    <div class="form-group" >
                                        <%
                                            if (p != null) {
                                        %>
                                        <div class="col-sm-3 pull-right"><input class="form-control btn btn-outline btn-primary" type="submit" value="Update Stock"></div>
                                            <%
                                            } else {
                                            %>
                                        <div class="col-sm-3 pull-right"><input class="form-control btn btn-outline btn-primary" type="submit" value="Update Stock"></div>
                                            <%
                                                }
                                            %>
                                        <a href="http://localhost:8080/MobiShop/admin_update_stock.jsp" style=" color: #ff6666;"><div class="col-sm-3 pull-right"><lable class="form-control btn btn-outline btn-default" style="text-align: center;" >Clear</lable></div></a>
                                    </div>
                                </div>
                            </div>
                        </form>

                    </div>
                </div>
                <%
                    } catch (Exception e) {
                        e.printStackTrace();
                        response.sendError(500);
                    }
                %>
            </div>
            <%@include file="/partials/footer.jsp" %>
        </div>
        <%@include file="/partials/commonjs.jsp" %>

        <script type="text/javascript">
            var xmlHttp;
            function createXMLHttpReq() {
                if (window.ActiveXObject) {
                    xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
                }
                else if (window.XMLHttpRequest) {
                    xmlHttp = new XMLHttpRequest();
                }
                else {
                    alert("Your Browser dosn't support. Please Use New Browser.");
                }
            }
            function loadProduct() {
                var url = "http://localhost:8080/MobiShop/getProduct?pcode=" + document.getElementById("pcode").value;
                createXMLHttpReq();
                xmlHttp.onreadystatechange = handleStateChange;
                xmlHttp.open("GET", url, true);
                xmlHttp.send(null);
            }
            function handleStateChange() {
                if (xmlHttp.readyState === 4 && xmlHttp.status === 200) {
                    var t = xmlHttp.responseText;
                    if (t == 0) {
                        document.getElementById("errmsg").innerHTML = "Wrong Input!";
                        document.getElementById("pid").value = "";
                        document.getElementById("itmname").value = "";
                        document.getElementById("brand").value = "";
                        document.getElementById("category").value = "";
                    } else {
                        var res = t.split("-");
                        document.getElementById("errmsg").innerHTML = "";
                        document.getElementById("pid").value = res[0];
                        document.getElementById("itmname").value = res[1];
                        document.getElementById("brand").value = res[2];
                        document.getElementById("category").value = res[3];
                    }
                }
            }
        </script>

    </body>
</html>
