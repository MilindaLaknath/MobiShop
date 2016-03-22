<%-- 
    Document   : admin_edit_items
    Created on : Dec 1, 2015, 9:37:39 PM
    Author     : Milinda
--%>

<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="hiben.ProdHasProp"%>
<%@page import="java.util.Set"%>
<%@page import="hiben.Category"%>
<%@page import="hiben.Brand"%>
<%@page import="hiben.Products"%>
<%@page import="hiben.PropertyGroup"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="hiben.ProdProperty"%>
<%@page import="org.hibernate.Session"%>
<%@page import="conn.FactoryManager"%>
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

                        Session con = FactoryManager.getSessionFactory().openSession();

                        Products p = null;
                        String action = "";
                        String pid = "";
                        String id = request.getParameter("id");

                        if (id == null) {
                            action = "addProduct";
                            Criteria crit = con.createCriteria(Products.class);
                            List<Products> plist = crit.list();
                            pid = plist.size() + 1 + "";
                        } else {
                            action = "editProduct";
                            p = (Products) con.load(Products.class, Integer.parseInt(id));
                            pid = p.getItmCode() + "";
                        }

                        Criteria cri = con.createCriteria(Brand.class);
                        List<Brand> blist = cri.list();

                        cri = con.createCriteria(Category.class);
                        List<Category> catList = cri.list();

                        cri = con.createCriteria(PropertyGroup.class);
                        List<PropertyGroup> pglist = cri.list();
                %>

                <%
                    String msg = "";
                    String typ = "";
                    int swit = 0;
                    msg = request.getParameter("msg");

                    if (msg != null && !msg.equals("")) {
                        if (typ != null && !typ.equals("")) {
                            swit = Integer.parseInt(typ);
                        }
                %>

                <%
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

                            <div class="panel-heading">
                                <div class="panel-title m-b-md"><h3>Add/Update Item Details and Add Images</h3></div>
                                <div class="panel-options">

                                    <ul class="nav nav-tabs">
                                        <li class="active"><a data-toggle="tab" href="#tab-1">Add Item Details</a></li>
                                        <li class=""><a data-toggle="tab" href="#tab-2">Add Item Images</a></li>
                                    </ul>
                                </div>
                            </div>

                            <div class="panel-body">

                                <div class="tab-content">
                                    <div id="tab-1" class="tab-pane active">

                                        <div class="col-lg-12">
                                            <div class="ibox float-e-margins">
                                                <div class="ibox-title">
                                                    <h5>Item Details
                                                        <!--<small>Enter the details of the journal you want to create</small>-->
                                                    </h5>
                                                </div>

                                                <div class="ibox-content">
                                                    <form name="add_property" method="post" id="add_property" class="form-horizontal" action="<%=action%>">
                                                        <div class="row">
                                                            <div class="col-lg-12">
                                                                <%
                                                                    if (p != null) {
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
                                                                    <div class="col-sm-6"><input class="form-control" type="text" name="pcode" required="" id="pcode"></div>
                                                                        <%
                                                                            }
                                                                        %>
                                                                </div>
                                                                <div class="form-group" >
                                                                    <label class="col-sm-3 control-label">Product Name : </label>
                                                                    <%
                                                                        if (p != null) {
                                                                    %>
                                                                    <div class="col-sm-6"><input class="form-control" type="text" value="<%=p.getItmName()%>" name="name" required="" id="name"></div>
                                                                        <%
                                                                        } else {
                                                                        %>
                                                                    <div class="col-sm-6"><input class="form-control" type="text" name="name" required="" id="name"></div>
                                                                        <%
                                                                            }
                                                                        %>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label class="col-sm-3 control-label">Brand : </label>
                                                                    <div class="col-sm-6">
                                                                        <select class="form-control" name="bid">
                                                                            <%
                                                                                for (Brand brd : blist) {
                                                                                    if (p != null && brd.equals(p.getBrand())) {
                                                                            %>
                                                                            <option value="<%=brd.getIdbrand()%>" selected=""><%=brd.getBrandName()%></option>
                                                                            <%
                                                                            } else {
                                                                            %>
                                                                            <option value="<%=brd.getIdbrand()%>"><%=brd.getBrandName()%></option>
                                                                            <%
                                                                                    }
                                                                                }
                                                                            %>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label class="col-sm-3 control-label">Category : </label>
                                                                    <div class="col-sm-6">
                                                                        <select class="form-control" name="catid">
                                                                            <%
                                                                                for (Category cat : catList) {
                                                                                    if (p != null && cat.equals(p.getCategory())) {
                                                                            %>
                                                                            <option value="<%=cat.getIdcat()%>" selected=""><%=cat.getCatName()%></option>
                                                                            <%
                                                                            } else {
                                                                            %>
                                                                            <option value="<%=cat.getIdcat()%>"><%=cat.getCatName()%></option>
                                                                            <%
                                                                                    }
                                                                                }
                                                                            %>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                                <div class="form-group" >
                                                                    <label class="col-sm-3 control-label">Reorder Level : </label>
                                                                    <%
                                                                        if (p != null) {
                                                                    %>
                                                                    <div class="col-sm-6"><input class="form-control" type="number" value="<%=p.getReorderLevel()%>" name="reorder_level" min="0" required="" id="name"></div>
                                                                        <%
                                                                        } else {
                                                                        %>
                                                                    <div class="col-sm-6"><input class="form-control" type="number" value="0" name="reorder_level" min="0" required="" id="name"></div>
                                                                        <%
                                                                            }
                                                                        %>
                                                                </div>

                                                                <div class="form-group col-sm-12">
                                                                    <table class="table col-sm-12">
                                                                        <%
                                                                            if (p == null) {
                                                                                for (PropertyGroup prgrp : pglist) {

                                                                        %>
                                                                        <tr>
                                                                            <td class="col-sm-3 form-control" style="width: 200px" rowspan="<%=prgrp.getProdProperties().size()%>"><%=prgrp.getGroupName()%></td>

                                                                            <%
                                                                                for (ProdProperty prop : prgrp.getProdProperties()) {
                                                                            %>

                                                                            <td class="col-sm-3 form-control" style="width: 200px"><%=prop.getPropertyName()%></td>
                                                                            <td class="col-sm-4 form-control" style="width: 500px" ><input class="form-control" type="text" style="width: 500px" name="<%=prop.getIdprodProperty()%>"> </td>
                                                                        </tr>
                                                                        <%
                                                                                }
                                                                            }
                                                                        } else {
                                                                            for (PropertyGroup prgrp : pglist) {
                                                                        %>
                                                                        <tr>
                                                                            <td class="col-sm-3 form-control" style="width: 200px" rowspan="<%=prgrp.getProdProperties().size()%>"><%=prgrp.getGroupName()%></td>

                                                                            <%
                                                                                for (ProdProperty prop : prgrp.getProdProperties()) {
                                                                                    cri = con.createCriteria(ProdHasProp.class);
                                                                                    cri.add(Restrictions.eq("prodProperty", prop));
                                                                                    cri.add(Restrictions.eq("products", p));
                                                                                    ProdHasProp php = (ProdHasProp) cri.list().get(0);
                                                                            %>

                                                                            <td class="col-sm-3 form-control" style="width: 200px"><%=prop.getPropertyName()%></td>
                                                                            <td class="col-sm-4 form-control" style="width: 500px" ><input class="form-control" type="text" style="width: 500px" name="<%=prop.getIdprodProperty()%>" value="<%=php.getValue()%>"> </td>
                                                                        </tr>
                                                                        <%
                                                                                    }
                                                                                }
                                                                            }
                                                                        %>
                                                                    </table>
                                                                </div>

                                                                <div class="form-group" >
                                                                    <%
                                                                        if (p != null) {
                                                                    %>
                                                                    <div class="col-sm-3 pull-right"><input class="form-control btn btn-outline btn-primary" type="submit" value="Edit Product"></div>
                                                                        <%
                                                                        } else {
                                                                        %>
                                                                    <div class="col-sm-3 pull-right"><input class="form-control btn btn-outline btn-primary" type="submit" value="Enter Product"></div>
                                                                        <%
                                                                            }
                                                                        %>
                                                                    <a href="#" style=" color: #ff6666;"><div class="col-sm-3 pull-right"><lable class="form-control btn btn-outline btn-default" style="text-align: center;" >Clear</lable></div></a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>

                                    </div>

                                    <div id="tab-2" class="tab-pane">

                                        <div class="col-lg-12">
                                            <div class="ibox float-e-margins">
                                                <div class="ibox-title">
                                                    <h5>Add Images for Items
                                                        <!--<small>Enter the details of the journal you want to create</small>-->
                                                    </h5>
                                                </div>
                                                <div class="ibox-content">   
                                                    <form name="add_img" method="post" id="add_img" class="form-horizontal" action="addImage" enctype="multipart/form-data">
                                                        <div class="row">
                                                            <div class="col-lg-12">
                                                                <div class="form-group" >
                                                                    <label class="col-sm-3 control-label">Product ID : </label>
                                                                    <%
                                                                        if (p != null) {
                                                                    %>
                                                                    <div class="col-sm-6"><input class="form-control" type="number" min="1" value="<%=pid%>" name="pid" required="" id="pid"></div>
                                                                        <%
                                                                        } else {
                                                                        %>
                                                                    <div class="col-sm-6"><input class="form-control" type="number" min="1" value="" name="pid" required="" id="pid"></div>* Enter if you know.
                                                                        <%
                                                                            }
                                                                        %>
                                                                </div>

                                                                <div class="form-group" >
                                                                    <label class="col-sm-3 control-label">Product Code : </label>
                                                                    <%
                                                                        if (p != null) {
                                                                    %>
                                                                    <div class="col-sm-6"><input class="form-control" type="text" value="<%=p.getProdCode()%>" name="pcode" required="" id="pcode"></div>
                                                                        <%
                                                                        } else {
                                                                        %>
                                                                    <div class="col-sm-6"><input class="form-control" type="text" name="pcode" required="" id="pcode"></div>* Required. 
                                                                        <%
                                                                            }
                                                                        %>
                                                                </div>
                                                                <div class="form-group" >
                                                                    <label class="col-sm-3 control-label">Image : </label>
                                                                    <div class="col-sm-6"><input class="form-control" type="file" accept="image/*" name="prdimg" id="prdimg" placeholder="Upload Image" ></div> Dimensions : 186 x 260
                                                                </div>
                                                                <%
                                                                    if (p != null) {
                                                                %>
                                                                <div class="form-group" >
                                                                    <label class="col-sm-3 control-label">Present Image : </label>
                                                                    <div class="col-sm-6"><img src="<%=p.getImgUrl()%>" class="image"></div> 
                                                                </div>
                                                                <%
                                                                    }
                                                                %>
                                                                <div class="form-group" >
                                                                    <div class="col-sm-3 pull-right"><input class="form-control btn btn-outline btn-primary" type="submit" value="Upload Image"></div>
                                                                    <a href="#" style=" color: #ff6666;"><div class="col-sm-3 pull-right"><lable class="form-control btn btn-outline btn-default" style="text-align: center;" >Clear</lable></div></a>
                                                                </div>

                                                            </div>
                                                        </div>  
                                                    </form>
                                                </div>
                                            </div>
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
            <%@include file="/partials/footer.jsp" %>
        </div>
        <%@include file="/partials/commonjs.jsp" %>

    </body>
</html>
