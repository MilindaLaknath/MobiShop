<%-- 
    Document   : top_bar
    Created on : Nov 27, 2015, 11:10:39 AM
    Author     : Milinda
--%>

<%@page import="conn.FactoryManager"%>
<%@page import="org.hibernate.Session"%>
<%--<%@page contentType="text/html" pageEncoding="UTF-8"%>--%>
<!--<!DOCTYPE html>-->
<!--<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>-->
<%@page import="hiben.User"%>


<%

    User u = null;

    u = (User) session.getAttribute("user");

    if (u == null) {
        Cookie cookie = null;
        Cookie[] cookies = null;
        // Get an array of Cookies associated with this domain
        cookies = request.getCookies();
        if (cookies != null) {
            for (int i = 0; i < cookies.length; i++) {
                cookie = cookies[i];
                if (cookie.getName().equals("uid")) {
                    String uid = cookie.getValue();
                    if (uid != null && !uid.equals("")) {
                        Session con = FactoryManager.getSessionFactory().openSession();
                        u = (User) con.load(User.class, Integer.parseInt(uid));
                        session.setAttribute("user", u);
                    }
                }
            }
        }
    }
%>
<nav class="navbar navbar-static-top" role="navigation">
    <div class="navbar-header">
        <button aria-controls="navbar" aria-expanded="false" data-target="#navbar" data-toggle="collapse" class="navbar-toggle collapsed" type="button">
            <i class="fa fa-reorder"></i>
        </button>
        <a href="http://localhost:8080/MobiShop/" class="navbar-brand"><strong style="font-family: Forte; font-size: x-large" >MobiShop</strong></a>
    </div>
    <div class="navbar-collapse collapse" id="navbar">
        <ul class="nav navbar-nav">
            <li class="">
                <a aria-expanded="false" role="button" href="http://localhost:8080/MobiShop/search.jsp?category=1"><h3 style="color: #222">Mobile Phones</h3></a>
            </li>
            <li class="">
                <a aria-expanded="false" role="button" href="http://localhost:8080/MobiShop/search.jsp?category=2"><h3 style="color: #222">Tabs and iPads</h3></a>
            </li>
            <li class="">
                <form role="search" class="navbar-form-custom" method="get" action="search.jsp">
                    <div class="form-group">
                        <input type="text" placeholder="Search for something..." class="form-control" name="search" id="search">
                    </div>                    
                </form>
            </li>


            <!--            
                        <li class="">
                            <a aria-expanded="false" role="button" href="#" class="dropdown-toggle" data-toggle="dropdown"> Menu item <span class="caret"></span></a>
                            <ul role="menu" class="dropdown-menu">
                                <li><a href="">Menu item</a></li>
                                <li><a href="">Menu item</a></li>
                                <li><a href="">Menu item</a></li>
                                <li><a href="">Menu item</a></li>
                            </ul>
                        </li>-->




        </ul>
        <ul class="nav navbar-top-links navbar-right">
            <li>
                <span class="m-r-sm text-muted welcome-message"><strong>Welcome 
                        <%
                            if (u != null) {
                        %>
                        <a href="http://localhost:8080/MobiShop/myprofile.jsp">
                            <%
                                out.write(u.getPersonalDetails().getFName());
                            %>
                        </a>
                        <%
                            }
                        %>
                        to MobiShop</strong></span>
            </li>    
            <li>


                <%
                    if (u == null) {
                %>
                <a href="http://localhost:8080/MobiShop/login.jsp">
                    <i class="fa fa-sign-in"></i> 
                    Log In
                </a>
                <%
                } else {
                %>
                <a href="http://localhost:8080/MobiShop/logout">
                    <i class="fa fa-sign-in"></i>
                    Log Out
                </a>
                <%
                    }
                %>

            </li>
        </ul>

    </div>
</nav>
                
