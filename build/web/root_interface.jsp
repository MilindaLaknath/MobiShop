<%-- 
    Document   : root_interface
    Created on : Dec 16, 2015, 4:28:37 PM
    Author     : Milinda
--%>

<%@page import="hiben.IntfGroup"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="hiben.Interfaces"%>
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
                        if (user.getUserType().getType().equals("Root")) {
                        } else {
                            response.sendRedirect("login.jsp");
                            return;
                        }

                        String strfrest = "";
                        int frest = 0;

                        strfrest = request.getParameter("frest");

                        if (strfrest != null && !strfrest.equals("")) {
                            frest = Integer.parseInt(strfrest);
                            if (frest < 0) {
                                frest = 0;
                            }
                        } else {
                            frest = 0;
                        }

                        Session con = FactoryManager.getSessionFactory().openSession();

                        Interfaces intf = null;
                        String action = "";
                        String id = request.getParameter("id");
                        if (id == null) {
                            action = "addInterface";
                        } else {
                            action = "editInterface";
                            intf = (Interfaces) con.load(Interfaces.class, Integer.parseInt(id));
                        }

                        Criteria cri = con.createCriteria(Interfaces.class);
                        cri.setFirstResult(frest);
                        cri.setMaxResults(12);

                        List<Interfaces> intflist = cri.list();

                        cri = con.createCriteria(IntfGroup.class);

                        List<IntfGroup> intfgrplist = cri.list();
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


                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel blank-panel">

                            <div class="panel-heading">
                                <div class="panel-title m-b-md"><h3>User Interfaces and Interface Group</h3></div>
                                <div class="panel-options">

                                    <ul class="nav nav-tabs">
                                        <li class="active"><a data-toggle="tab" href="#tab-1">User Interfaces</a></li>
                                        <li class=""><a data-toggle="tab" href="#tab-2">Interface Group</a></li>
                                    </ul>
                                </div>
                            </div>

                            <div class="panel-body">

                                <div class="tab-content">
                                    <div id="tab-1" class="tab-pane active">
                                        <div class="col-lg-12">
                                            <div class="ibox float-e-margins">
                                                <div class="ibox-title">
                                                    <h5> Interfaces
                                                        <!--<small>Enter the details of the journal you want to create</small>-->
                                                    </h5>
                                                </div>

                                                <div class="ibox-content">
                                                    <form name="add_interface" method="post" id="add_interface" class="form-horizontal"
                                                          action="<%=action%>">
                                                        <div class="row">
                                                            <div class="col-lg-12">
                                                                <div class="form-group">
                                                                    <label class="col-sm-3 control-label">Interface Group : </label>
                                                                    <div class="col-sm-6">
                                                                        <select class="form-control" name="igid">  
                                                                            <%
                                                                                for (IntfGroup intfygp : intfgrplist) {
                                                                                    if (intf != null && intfygp.equals(intf.getIntfGroup())) {
                                                                            %>
                                                                            <option value="<%=intfygp.getIdintfGroup()%>" selected=""><%=intfygp.getGroupName()%></option>
                                                                            <%
                                                                            } else {
                                                                            %>
                                                                            <option value="<%=intfygp.getIdintfGroup()%>"><%=intfygp.getGroupName()%></option>
                                                                            <%
                                                                                    }
                                                                                }
                                                                            %>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label class="col-sm-3 control-label">Interface Name : </label>
                                                                    <% if (intf != null) {%>
                                                                    <div class="col-sm-6">
                                                                        <input type="hidden" name="id" value="<%=intf.getIdinterfaces()%>">
                                                                        <input name="name" required="" type="text" class="form-control"
                                                                               value="<%=intf.getIfaseName()%>" placeholder="Enter Interface Name">
                                                                    </div>                                                                    
                                                                    <% } else { %>
                                                                    <div class="col-sm-6">   
                                                                        <input type="hidden" name="id" value="">
                                                                        <input name="name" required="" type="text" class="form-control" placeholder="Enter Interface Name">
                                                                    </div>                                                                    
                                                                    <% } %>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label class="col-sm-3 control-label">Interface URL : </label>
                                                                    <% if (intf != null) {%>
                                                                    <div class="col-sm-6">                                                                        
                                                                        <input name="url" required="" type="text" class="form-control"
                                                                               value="<%=intf.getUrl()%>" placeholder="Enter Interface URL">
                                                                    </div>
                                                                    <div class="col-sm-3 ">
                                                                        <button class="btn btn-primary" type="submit">Update Interface
                                                                            <span class="fa fa-plus"></span></button>
                                                                        <a href="http://localhost:8080/MobiShop/root_interface.jsp" class="btn btn-primary">
                                                                            Clear
                                                                        </a>
                                                                    </div>
                                                                    <% } else { %>
                                                                    <div class="col-sm-6">
                                                                        <input name="url" required="" type="text" class="form-control" placeholder="Enter Interface URL">
                                                                    </div>
                                                                    <div class="col-sm-3 ">
                                                                        <button class="btn btn-primary" type="submit">Add Interface
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
                                                                    Interface
                                                                    <!--<small>Enter the details of the journal you want to create</small>-->
                                                                </h5>                                          
                                                            </div>

                                                            <div class="ibox-content">
                                                                <div class="row">
                                                                    <table class="table table-hover">
                                                                        <tr>
                                                                            <th><h3>Interface Group</h3></th>
                                                                        <th><h3>Interface</h3></th>
                                                                        <th><h3>URL</h3></th>
                                                                        <th></th>
                                                                        </tr>
                                                                        <%
                                                                            for (Interfaces inerface : intflist) {
                                                                        %>
                                                                        <tr>
                                                                            <td>                                                                                
                                                                                <h4> <%=inerface.getIntfGroup().getGroupName()%></h4>
                                                                            </td>
                                                                            <td>
                                                                                <h4><%=inerface.getIfaseName()%></h4>
                                                                            </td>
                                                                            <td >
                                                                                <h4><%=inerface.getUrl()%></h4>
                                                                            </td>
                                                                            <td>
                                                                                <a href="<%="http://localhost:8080/MobiShop/root_interface.jsp?id=" + inerface.getIdinterfaces()%>">
                                                                                    <button class="btn btn-default pull-right" type="button">Edit</button>
                                                                                </a> 
                                                                            </td>
                                                                        </tr>
                                                                        <%
                                                                            }
                                                                        %>
                                                                    </table>

                                                                    <div class="row col-sm-12">
                                                                        <div class="btn-group pull-right">
                                                                            <%
                                                                                if (frest > 0) {
                                                                            %>
                                                                            <a href="http://localhost:8080/MobiShop/root_interface.jsp?frest=<%=frest - 12%>">
                                                                                <button type="button" class="btn btn-primary"><i class="fa fa-chevron-left"></i>Previous</button>
                                                                            </a>
                                                                            <%
                                                                                }
                                                                                if (intflist.size() == 12) {
                                                                            %>
                                                                            <a href="http://localhost:8080/MobiShop/root_interface.jsp?frest=<%=frest + 12%>">
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
                                            IntfGroup ig = null;
                                            String actionig = "";
                                            String idig = request.getParameter("idgroup");
                                            if (idig == null) {
                                                actionig = "addIntfGroup";
                                            } else {
                                                actionig = "editIntfGroup";
                                                ig = (IntfGroup) con.load(IntfGroup.class, Integer.parseInt(idig));
                                            }
                                        %>

                                        <div class="col-lg-12">
                                            <div class="ibox float-e-margins">
                                                <div class="ibox-title">
                                                    <h5>Interface Group
                                                        <!--<small>Enter the details of the journal you want to create</small>-->
                                                    </h5>
                                                </div>

                                                <div class="ibox-content">
                                                    <form name="add_Interface_group" method="post" id="add_Interface_group" class="form-horizontal"
                                                          action="<%=actionig%>">
                                                        <div class="row">
                                                            <div class="col-lg-12">
                                                                <div class="form-group">
                                                                    <label class="col-sm-3 control-label">Interface Group Name : </label>
                                                                    <% if (ig != null) {%>
                                                                    <div class="col-sm-6">
                                                                        <input type="hidden" name="idgroup" value="<%=ig.getIdintfGroup()%>">
                                                                        <input name="name" required="" type="text" class="form-control"
                                                                               value="<%=ig.getGroupName()%>" placeholder="Enter Group Name">
                                                                    </div>
                                                                    <div class="col-sm-3 ">
                                                                        <button class="btn btn-primary" type="submit">Update Interface Group
                                                                            <span class="fa fa-plus"></span></button>
                                                                        <a href="http://localhost:8080/MobiShop/root_interface.jsp" class="btn btn-primary">Clear</a>
                                                                    </div>
                                                                    <% } else { %>

                                                                    <div class="col-sm-6">
                                                                        <input type="hidden" name="idgroup" value="">
                                                                        <input name="name" required="" type="text" class="form-control" placeholder="Enter Group Name">
                                                                    </div>
                                                                    <div class="col-sm-3 ">
                                                                        <button class="btn btn-primary" type="submit">Add Interface Group
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
                                                                    Interface Group
                                                                    <!--<small>Enter the details of the journal you want to create</small>-->
                                                                </h5>                                          
                                                            </div>

                                                            <div class="ibox-content">
                                                                <div class="row">
                                                                    <table class="table">
                                                                        <%
                                                                            for (IntfGroup intfgp : intfgrplist) {
                                                                        %>
                                                                        <tr>
                                                                            <td>
                                                                                <div class="col-sm-8">
                                                                                    <input name="idgroup" type="hidden" class="form-control" value="">

                                                                                    <h3 style="padding-left: 20px"><%=intfgp.getGroupName()%></h3>
                                                                                </div>
                                                                                <div class="col-sm-4">                                                                    
                                                                                    <a href="<%="http://localhost:8080/MobiShop/root_interface.jsp?idgroup=" + intfgp.getIdintfGroup()%>">
                                                                                        <button class="btn btn-default pull-right" type="button">Edit</button>
                                                                                    </a>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                        <%
                                                                            }
                                                                        %>
                                                                    </table>
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
