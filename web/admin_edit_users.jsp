<%-- 
    Document   : admin_edit_users
    Created on : Dec 1, 2015, 9:38:52 PM
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

                        String uid = "";

                        uid = request.getParameter("id");

                        Session con = FactoryManager.getSessionFactory().openSession();

                        User usr = null;
                        if (uid != null && !uid.equals("")) {
                            usr = (User) con.load(User.class, Integer.parseInt(uid));
                        }
                        if (usr == null) {
                            response.sendRedirect("admin_users.jsp");
                            return;
                        }

                        Criteria cri = con.createCriteria(UserType.class);
                        List<UserType> utplist = cri.list();

                %>


                <div class="ibox-title">
                    <h3>User Details</h3> 
                </div>
                <div class="ibox-content">
                    <div class="row">
                        <div class="col-sm-3 font-bold">
                            <h4 class="font-bold">User Details</h4>
                        </div>
                        <div class="col-sm-9">
                            <h4 class="col-sm-3">Email : </h4><h4 class="col-sm-9"><%=usr.getEmail()%></h4>
                            <h4 class="col-sm-3">Created Time : </h4><h4 class="col-sm-9"><%=usr.getCreateTime()%></h4>
                            <h4 class="col-sm-3">User Type : </h4><h4 class="col-sm-9"><%=usr.getUserType().getType()%></h4>
                        </div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col-sm-3 font-bold">
                            <h4 class="font-bold">Personal Details</h4>
                        </div>
                        <div class="col-sm-9">
                            <h4 class="col-sm-3">Name : </h4><h4 class="col-sm-9"><%=usr.getPersonalDetails().getFName() + " " + usr.getPersonalDetails().getLName()%></h4>
                            <h4 class="col-sm-3">Phone : </h4><h4 class="col-sm-9"><%=usr.getPersonalDetails().getPhone()%></h4>
                            <h4 class="col-sm-3">Address : </h4>
                            <h4 class="col-sm-9">
                                <%
                                    out.println(usr.getPersonalDetails().getAddress().getAddl1());
                                    out.println(usr.getPersonalDetails().getAddress().getAddl2());
                                    out.println(usr.getPersonalDetails().getAddress().getCity());
                                    out.println(usr.getPersonalDetails().getAddress().getPostCode());

                                %>
                            </h4>
                        </div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col-sm-3 ">
                            <h4 class="font-bold">Change User Type</h4>
                        </div>
                        <div class="col-sm-9">
                            <h4 class="col-sm-3">User Type : </h4>
                            <h4 class="col-sm-9">
                                <form method="post" action="editUserType" id="form1" name="form1"> 
                                    <input type="hidden" name="uid" value="<%=usr.getUserId()%>">
                                    <div class="form-group col-sm-8">
                                        <select name="type" class="form-control">
                                            <%
                                                if (utplist.size() > 0) {
                                                    for (UserType ut : utplist) {
                                                        if (ut.equals(usr.getUserType())) {
                                            %>
                                            <option selected="" value="<%=ut.getGuestId() %>"><%=ut.getType() %></option>
                                            <%
                                            } else {
                                            %>
                                            <option value="<%=ut.getGuestId() %>"><%=ut.getType() %></option>
                                            <%
                                                        }
                                                    }
                                                }
                                            %>
                                        </select>                                        
                                    </div>
                                    <div class="form-group col-sm-4">
                                        <input type="submit" class="btn btn-primary" value="Change Type">                               
                                    </div>

                                </form>
                            </h4>

                        </div>
                    </div>
                    <hr>

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
