<%-- 
    Document   : admin_users
    Created on : Dec 1, 2015, 9:38:35 PM
    Author     : Milinda
--%>

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
                        if (user.getUserType().getType().equals("Admin") || user.getUserType().getType().equals("Root")) {
                        } else {
                            response.sendRedirect("login.jsp");
                            return;
                        }

                        String utype = "";

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

                        utype = request.getParameter("utype");

                        Session con = FactoryManager.getSessionFactory().openSession();

                        List<User> list;

                        List<UserType> utlist;

                        Criteria c1 = con.createCriteria(UserType.class);
                        utlist = c1.list();

                        Criteria cri = con.createCriteria(User.class);

                        if (utype != null) {
                            if (!utype.equals("")) {
                                UserType ut = (UserType) con.load(UserType.class, Integer.parseInt(utype));
                                cri.add(Restrictions.eq("userType", ut));
                            }
                        }

                        cri.addOrder(Order.asc("email"));
//                        cri.addOrder(Order.asc("brand"));
                        cri.setFirstResult(frest);
                        cri.setMaxResults(15);

                        list = cri.list();

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
                        <h5>Users</h5>                            
                    </div>
                    <div class="ibox-content">
                        <div class="row">
                            <form role="form" class="form-inline" action="admin_users.jsp">
                                <div class="col-sm-4">
                                    <label class="control-label">User Type : </label>
                                    <div class="input-group">
                                        <select class="form-control" name="utype">
                                            <%                                                for (UserType utp : utlist) {
                                            %>
                                            <option value="<%=utp.getGuestId()%>"><%=utp.getType()%></option>
                                            <%
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
                <div class="ibox-content" style="margin-top: 10px;">
                    <table class="table table-hover">
                        <tr>
                            <th>Email</th>
                            <th>Name</th>
                            <th>User Type</th>
                            <th>Phone</th>
                            <th>Address</th>
                            <th></th>
                        </tr>

                        <%                        for (User usr : list) {
                        %>
                        <tr>
                            <td><%=usr.getEmail()%></td>
                            <td><%=usr.getPersonalDetails().getFName() + " " + usr.getPersonalDetails().getLName()%></td>
                            <td><%=usr.getUserType().getType()%></td>
                            <td><%=usr.getPersonalDetails().getPhone()%></td>
                            <td><%=usr.getPersonalDetails().getAddress().getCity()%></td>
                            <td>                                
                                <a href="http://localhost:8080/MobiShop/admin_edit_users.jsp?id=<%=usr.getUserId()%>"><button class="btn btn-primary pull-right">View</button></a>                                
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
                                if (utype != null) {
                                    url += "&utype=" + utype;
                                }

                                if (frest != 0) {
                            %>
                            <a href="http://localhost:8080/MobiShop/admin_users.jsp?frest=<%=frest - 15%><%=url%>">
                                <button type="button" class="btn btn-primary"><i class="fa fa-chevron-left"></i>Previous</button>
                            </a>
                            <%
                                }
                                if (list.size() == 15) {
                            %>
                            <a href="http://localhost:8080/MobiShop/admin_users.jsp?frest=<%=frest + 15%><%=url%>">
                                <button type="button" class="btn btn-primary"><i class="fa fa-chevron-right"></i>Next</button>
                            </a>
                            <%
                                }
                            %>
                        </div>
                    </div>

                </div>
                <%
                    } catch (Exception e) {
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
