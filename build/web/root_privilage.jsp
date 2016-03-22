<%-- 
    Document   : root_privilage
    Created on : Dec 16, 2015, 5:42:49 PM
    Author     : Milinda
--%>

<%@page import="hiben.Privilage"%>
<%@page import="hiben.UserType"%>
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

                        String strfrest = request.getParameter("frest");
                        int frest = 0;

                        if (strfrest != null && !strfrest.equals("")) {
                            frest = Integer.parseInt(strfrest);
                            if (frest < 0) {
                                frest = 0;
                            }
                        } else {
                            frest = 0;
                        }

                        String idprv = request.getParameter("idprv");
                        String action = "";
                        
                        Privilage prv = null;

                        Session con = FactoryManager.getSessionFactory().openSession();
                        
                        if (idprv == null || idprv.equals("")) {
                            action = "addPrivilage";
                        } else {
                            action = "editPrivilage";
                            prv = (Privilage) con.load(Privilage.class, Integer.parseInt(idprv));
                        }

                        Criteria cri = con.createCriteria(UserType.class);

                        List<UserType> utplist = cri.list();

                        cri = con.createCriteria(IntfGroup.class);

                        List<IntfGroup> intflist = cri.list();

                        cri = con.createCriteria(Privilage.class);
                        cri.addOrder(Order.asc("userType"));
                        cri.setFirstResult(frest);
                        cri.setMaxResults(12);

                        List<Privilage> privlist = cri.list();

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
                
                <div class="col-lg-12">
                    <div class="ibox float-e-margins">
                        <div class="ibox-title">
                            <h5> Set Privilege
                                <!--<small>Enter the details of the journal you want to create</small>-->
                            </h5>
                        </div>

                        <div class="ibox-content">
                            <form name="add_priv" method="post" id="add_priv" class="form-horizontal"
                                  action="<%=action%>">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="form-group">
                                            <%
                                                if (idprv != null && !idprv.equals("")) {
                                            %>
                                            <input type="hidden" name="idprv" id="idprv" value="<%=prv.getIdprivilage() %>" />
                                            <%
                                                }
                                            %>
                                            <label class="col-sm-3 control-label">User Type : </label>
                                            <div class="col-sm-6">
                                                <select class="form-control" name="utype">
                                                    <%                                                        for (UserType utpy : utplist) {
                                                            if (prv != null && prv.getUserType().equals(utpy)) {
                                                    %>
                                                    <option value="<%=utpy.getGuestId()%>" selected=""><%=utpy.getType()%></option>
                                                    <%
                                                    } else {
                                                    %>
                                                    <option value="<%=utpy.getGuestId()%>"><%=utpy.getType()%></option>
                                                    <%
                                                            }
                                                        }
                                                    %>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">Interfaces Group: </label>
                                            <div class="col-sm-6">
                                                <select class="form-control" name="intf">
                                                    <%                                                        for (IntfGroup intfa : intflist) {
                                                            if (prv != null && prv.getIntfGroup().equals(intfa)) {
                                                    %>
                                                    <option value="<%=intfa.getIdintfGroup()%>" selected=""><%=intfa.getGroupName()%></option>
                                                    <%
                                                    } else {
                                                    %>
                                                    <option value="<%=intfa.getIdintfGroup()%>"><%=intfa.getGroupName()%></option>
                                                    <%
                                                            }
                                                        }
                                                    %>
                                                </select>
                                            </div>
                                            <% if (prv != null) {%>                                            
                                            <div class="col-sm-3">
                                                <button class="btn btn-primary inline " type="submit">Update Privilege
                                                    <span class="fa fa-plus"></span></button>
                                                <a href="http://localhost:8080/MobiShop/root_privilage.jsp" class="btn btn-primary inline">
                                                    Clear
                                                </a>
                                            </div>
                                            <% } else { %>                                            
                                            <div class="col-sm-3">
                                                <button class="btn btn-primary center-block" type="submit">Add Privilege
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
                                            Privileges
                                            <!--<small>Enter the details of the journal you want to create</small>-->
                                        </h5>                                          
                                    </div>

                                    <div class="ibox-content">
                                        <div class="row">
                                            <table class="table table-hover">
                                                <tr>
                                                    <th><h3>User Type</h3></th>
                                                <th><h3>Interface Group</h3></th>
                                                <!--<th><h3>URL</h3></th>-->
                                                <th></th>
                                                </tr>
                                                <%
                                                    for (Privilage priv : privlist) {
                                                %>
                                                <tr>
                                                    <td>                                                                                
                                                        <h4> <%=priv.getUserType().getType()%></h4>
                                                    </td>
                                                    <td>
                                                        <h4><%=priv.getIntfGroup().getGroupName()%></h4>
                                                    </td>

                                                    <td>
                                                        <a href="http://localhost:8080/MobiShop/deletePrivilage?idprv=<%=priv.getIdprivilage()%>">
                                                            <button class="btn btn-danger pull-right" type="button">Delete</button>
                                                        </a>
                                                        <a href="http://localhost:8080/MobiShop/root_privilage.jsp?idprv=<%=priv.getIdprivilage()%>">
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
                                                        String url = "";
                                                        if (prv != null) {
                                                            url += "&idprv=" + prv;
                                                        }

                                                        if (frest != 0) {
                                                    %>
                                                    <a href="http://localhost:8080/MobiShop/root_privilage.jsp?frest=<%=frest - 12%><%=url%>">
                                                        <button type="button" class="btn btn-primary"><i class="fa fa-chevron-left"></i>Previous</button>
                                                    </a>
                                                    <%
                                                        }
                                                        if (privlist.size() == 12) {
                                                    %>
                                                    <a href="http://localhost:8080/MobiShop/root_privilage.jsp?frest=<%=frest + 12%><%=url%>">
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


                <%    } catch (Exception e) {
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
