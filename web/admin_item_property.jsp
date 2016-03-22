<%-- 
    Document   : admin_item_property
    Created on : Dec 8, 2015, 9:59:52 AM
    Author     : Milinda
--%>

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

                        String strfrest = "";
                        int frest = 0;
                        String strfrest2 = "";
                        int frest2 = 0;
                        strfrest = request.getParameter("frest");
                        strfrest2 = request.getParameter("frest2");

                        if (strfrest != null && !strfrest.equals("")) {
                            frest = Integer.parseInt(strfrest);
                        } else {
                            frest = 0;
                        }
                        if (strfrest2 != null && !strfrest2.equals("")) {
                            frest2 = Integer.parseInt(strfrest2);
                        } else {
                            frest2 = 0;
                        }
                        Session con = FactoryManager.getSessionFactory().openSession();

                        ProdProperty pp = null;
                        String action = "";
                        String id = request.getParameter("id");
                        if (id == null) {
                            action = "addProperty";
                        } else {
                            action = "editProperty";
                            pp = (ProdProperty) con.load(ProdProperty.class, Integer.parseInt(id));
                        }

                        Criteria cri = con.createCriteria(ProdProperty.class);
                        cri.setFirstResult(frest);
                        cri.setMaxResults(10);

                        List<ProdProperty> pplist = cri.list();

                        cri = con.createCriteria(PropertyGroup.class);
                        cri.setFirstResult(frest2);
                        cri.setMaxResults(10);

                        List<PropertyGroup> pglist = cri.list();
                %>

                <%
                    String msg = "";
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

                            <div class="panel-heading">
                                <div class="panel-title m-b-md"><h3>Item Property and Property Group</h3></div>
                                <div class="panel-options">

                                    <ul class="nav nav-tabs">
                                        <li class="active"><a data-toggle="tab" href="#tab-1">Item Property</a></li>
                                        <li class=""><a data-toggle="tab" href="#tab-2">Property Group</a></li>
                                    </ul>
                                </div>
                            </div>

                            <div class="panel-body">

                                <div class="tab-content">
                                    <div id="tab-1" class="tab-pane active">
                                        <div class="col-lg-12">
                                            <div class="ibox float-e-margins">
                                                <div class="ibox-title">
                                                    <h5>Product Property
                                                        <!--<small>Enter the details of the journal you want to create</small>-->
                                                    </h5>
                                                </div>

                                                <div class="ibox-content">
                                                    <form name="add_property" method="post" id="add_property" class="form-horizontal"
                                                          action="<%=action%>">
                                                        <div class="row">
                                                            <div class="col-lg-12">
                                                                <div class="form-group">
                                                                    <label class="col-sm-3 control-label">Property Group : </label>
                                                                    <div class="col-sm-6">
                                                                        <select class="form-control" name="pgid">
                                                                            <%
                                                                                for (PropertyGroup propertygp : pglist) {
                                                                                    if (pp != null && propertygp.equals(pp.getPropertyGroup())) {
                                                                            %>
                                                                            <option value="<%=propertygp.getIdproGrop()%>" selected=""><%=propertygp.getGroupName()%></option>
                                                                            <%
                                                                            } else {
                                                                            %>
                                                                            <option value="<%=propertygp.getIdproGrop()%>"><%=propertygp.getGroupName()%></option>
                                                                            <%
                                                                                    }
                                                                                }
                                                                            %>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label class="col-sm-3 control-label">Property Name : </label>
                                                                    <% if (pp != null) {%>
                                                                    <div class="col-sm-6">
                                                                        <input type="hidden" name="id" value="<%=pp.getIdprodProperty()%>">
                                                                        <input name="name" required="" type="text" class="form-control"
                                                                               value="<%=pp.getPropertyName()%>" placeholder="Enter Property Name">
                                                                    </div>
                                                                    <div class="col-sm-3 ">
                                                                        <button class="btn btn-primary" type="submit">Update Property
                                                                            <span class="fa fa-plus"></span></button>
                                                                        <a href="http://localhost:8080/MobiShop/admin_item_property.jsp" class="btn btn-primary">
                                                                            Clear
                                                                        </a>
                                                                    </div>
                                                                    <% } else { %>

                                                                    <div class="col-sm-6">
                                                                        <input type="hidden" name="id">
                                                                        <input name="name" required="" type="text" class="form-control" placeholder="Enter Property Name">
                                                                    </div>
                                                                    <div class="col-sm-3 ">
                                                                        <button class="btn btn-primary" type="submit">Add Property
                                                                            <span class="fa fa-plus"></span></button>
                                                                    </div>
                                                                    <% } %>

                                                                </div>
                                                            </div>
                                                        </div>
                                                    </form>
                                                </div>

                                                <div class="row">
                                                    <div class="col-lg-12">
                                                        <div class="ibox float-e-margins">
                                                            <div class="ibox-title">
                                                                <h5>
                                                                    Product Property
                                                                    <!--<small>Enter the details of the journal you want to create</small>-->
                                                                </h5>                                          
                                                            </div>

                                                            <div class="ibox-content">
                                                                <div class="row">
                                                                    <table class="table">
                                                                        <%
                                                                            for (ProdProperty property : pplist) {
                                                                        %>
                                                                        <tr>
                                                                            <td>
                                                                                <div class="col-sm-5">
                                                                                    <input name="id" type="hidden" class="form-control" value="">

                                                                                    <h3 style="padding-left: 20px"><%=property.getPropertyName()%></h3>
                                                                                </div>
                                                                                <div class="col-sm-3">
                                                                                    <h3 style="padding-left: 20px"><%=property.getPropertyGroup().getGroupName()%></h3>
                                                                                </div>
                                                                                <div class="col-sm-4">                                                                    
                                                                                    <a href="<%="http://localhost:8080/MobiShop/admin_item_property.jsp?id=" + property.getIdprodProperty()%>">
                                                                                        <button class="btn btn-default pull-right" type="button">Edit</button>
                                                                                    </a>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                        <%
                                                                            }
                                                                        %>
                                                                    </table>

                                                                    <div class="row col-sm-12">
                                                                        <div class="btn-group pull-right">
                                                                            <%
                                                                                if (frest != 0) {
                                                                            %>
                                                                            <a href="http://localhost:8080/MobiShop/admin_item_property.jsp?frest=<%=frest - 10%>">
                                                                                <button type="button" class="btn btn-primary"><i class="fa fa-chevron-left"></i>Previous</button>
                                                                            </a>
                                                                            <%
                                                                                }
                                                                                if (pplist.size() == 10) {
                                                                            %>
                                                                            <a href="http://localhost:8080/MobiShop/admin_item_property.jsp?frest=<%=frest + 10%>">
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
                                    </div>
                                    <div id="tab-2" class="tab-pane">

                                        <%
                                            PropertyGroup pg = null;
                                            String actionpg = "";
                                            String idpg = request.getParameter("idgroup");
                                            if (idpg == null) {
                                                actionpg = "addPropertyGroup";
                                            } else {
                                                actionpg = "editPropertyGroup";
                                                pg = (PropertyGroup) con.load(PropertyGroup.class, Integer.parseInt(idpg));
                                            }
                                        %>

                                        <div class="col-lg-12">
                                            <div class="ibox float-e-margins">
                                                <div class="ibox-title">
                                                    <h5>Property Group
                                                        <!--<small>Enter the details of the journal you want to create</small>-->
                                                    </h5>
                                                </div>

                                                <div class="ibox-content">
                                                    <form name="add_property_group" method="post" id="add_property_group" class="form-horizontal"
                                                          action="<%=actionpg%>">
                                                        <div class="row">
                                                            <div class="col-lg-12">
                                                                <div class="form-group">
                                                                    <label class="col-sm-3 control-label">Property Group Name : </label>
                                                                    <% if (pg != null) {%>
                                                                    <div class="col-sm-6">
                                                                        <input type="hidden" name="idgroup" value="<%=pg.getIdproGrop()%>">
                                                                        <input name="name" required="" type="text" class="form-control"
                                                                               value="<%=pg.getGroupName()%>" placeholder="Enter Group Name">
                                                                    </div>
                                                                    <div class="col-sm-3 ">
                                                                        <button class="btn btn-primary" type="submit">Update Property Group
                                                                            <span class="fa fa-plus"></span></button>
                                                                        <a href="http://localhost:8080/MobiShop/admin_item_property.jsp" class="btn btn-primary">
                                                                            Clear
                                                                        </a>
                                                                    </div>
                                                                    <% } else { %>

                                                                    <div class="col-sm-6">
                                                                        <input type="hidden" name="idgroup">
                                                                        <input name="name" required="" type="text" class="form-control" placeholder="Enter Group Name">
                                                                    </div>
                                                                    <div class="col-sm-3 ">
                                                                        <button class="btn btn-primary" type="submit">Add Property Group
                                                                            <span class="fa fa-plus"></span></button>
                                                                    </div>
                                                                    <% } %>

                                                                </div>
                                                            </div>
                                                        </div>
                                                    </form>
                                                </div>

                                                <div class="row">
                                                    <div class="col-lg-12">
                                                        <div class="ibox float-e-margins">
                                                            <div class="ibox-title">
                                                                <h5>
                                                                    Property Group
                                                                    <!--<small>Enter the details of the journal you want to create</small>-->
                                                                </h5>                                          
                                                            </div>

                                                            <div class="ibox-content">
                                                                <div class="row">
                                                                    <table class="table">
                                                                        <%
                                                                            for (PropertyGroup propertygp : pglist) {
                                                                        %>
                                                                        <tr>
                                                                            <td>
                                                                                <div class="col-sm-8">
                                                                                    <input name="idgroup" type="hidden" class="form-control" value="">

                                                                                    <h3 style="padding-left: 20px"><%=propertygp.getGroupName()%></h3>
                                                                                </div>
                                                                                <div class="col-sm-4">                                                                    
                                                                                    <a href="<%="http://localhost:8080/MobiShop/admin_item_property.jsp?idgroup=" + propertygp.getIdproGrop()%>">
                                                                                        <button class="btn btn-default pull-right" type="button">Edit</button>
                                                                                    </a>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                        <%
                                                                            }
                                                                        %>
                                                                    </table>

                                                                    <div class="row col-sm-12">
                                                                        <div class="btn-group pull-right">
                                                                            <%
                                                                                if (frest != 0) {
                                                                            %>
                                                                            <a href="http://localhost:8080/MobiShop/admin_item_property.jsp?frest2=<%=frest - 10%>">
                                                                                <button type="button" class="btn btn-primary"><i class="fa fa-chevron-left"></i>Previous</button>
                                                                            </a>
                                                                            <%
                                                                                }
                                                                                if (pplist.size() == 10) {
                                                                            %>
                                                                            <a href="http://localhost:8080/MobiShop/admin_item_property.jsp?frest2=<%=frest + 10%>">
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
