<%-- 
    Document   : admin_loginlog
    Created on : Dec 1, 2015, 9:33:40 PM
    Author     : Milinda
--%>

<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="hiben.PersonalDetails"%>
<%@page import="hiben.User"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="org.hibernate.Query"%>
<%@page import="hiben.LoginSession"%>
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

                        Session con = FactoryManager.getSessionFactory().openSession();
                        String datefrm = "";
                        String dateto = "";

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

                        datefrm = request.getParameter("date_from");
                        dateto = request.getParameter("date_to");
                        List<LoginSession> list;
                        Criteria cri = con.createCriteria(LoginSession.class);

                        SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");

                        if (datefrm != null && dateto != null) {
                            if (!datefrm.equals("")) {
                                Date d = sdf.parse(datefrm);
                                cri.add(Restrictions.ge("loginTime", d));
                            }
                            if (!dateto.equals("")) {
                                Date d = sdf.parse(dateto);
                                cri.add(Restrictions.lt("loginTime", d));
                            }
                        }
                        cri.setFirstResult(frest);
                        cri.setMaxResults(20);

                        list = cri.list();

                %>
                
                <div class="row col-lg-12">
                    <div class="ibox-title">
                        <h3>Login Log</h3>
                    </div>
                </div>
                <div class="container col-sm-12" style="margin-top: 15px;">
                    <div class="ibox-title">
                        <h5>Select Date Range</h5>                            
                    </div>
                    <div class="ibox-content">
                        <div class="row">
                            <form role="form" class="form-inline" action="admin_loginlog.jsp">
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
                                <div class="">
                                    <button class="btn btn-primary" type="submit">Filter</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="container col-sm-12" style="margin-top: 15px;">
                    <table class="table">
                        <thead>
                        <th>Name</th>
                        <th>Email</th>
                        <th>IP Address</th>
                        <th>Date &AMP; Time</th>
                        </thead>
                        <tbody>
                            <%                                for (LoginSession ls : list) {
                            %>
                            <tr>
                                <td><%=ls.getUser().getPersonalDetails().getFName() + " " + ls.getUser().getPersonalDetails().getLName()%></td>
                                <td><%=ls.getUser().getEmail()%></td>
                                <td><%=ls.getIpAdd()%></td>
                                <td><%=ls.getLoginTime()%></td>
                            </tr>
                            <%
                                }
                            %>

                        </tbody>
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

                                if (frest != 0) {
                            %>
                            <a href="http://localhost:8080/MobiShop/admin_loginlog.jsp?frest=<%=frest - 20%><%=url%>">
                                <button type="button" class="btn btn-primary"><i class="fa fa-chevron-left"></i>Previous</button>
                            </a>
                            <%
                                }
                                if (list.size() == 20) {
                            %>
                            <a href="http://localhost:8080/MobiShop/admin_loginlog.jsp?frest=<%=frest + 20%><%=url%>">
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
                        e.printStackTrace();
                        response.sendError(500);
                    }
                %>

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
