<%-- 
    Document   : sidebar_search
    Created on : Dec 1, 2015, 12:02:34 PM
    Author     : Milinda
--%>

<%@page import="hiben.Privilage"%>
<%@page import="java.util.ArrayList"%>
<%@page import="hiben.User"%>
<%@page import="java.util.Set"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="hiben.Interfaces"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="hiben.IntfGroup"%>
<%@page import="conn.FactoryManager"%>
<%@page import="org.hibernate.Session"%>
<nav class="navbar-default navbar-static-side" role="navigation">
    <div class="sidebar-collapse">
        <ul class="nav" id="side-menu">
            <li class="nav-header">
                <div class="dropdown profile-element"> <span>
                        <!--                        <img alt="image" class="img-circle" src="img/profile_small.jpg" />
                                            </span>
                                            <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                                                <span class="clear"> <span class="block m-t-xs"> <strong class="font-bold">David Williams</strong>
                                                    </span> <span class="text-muted text-xs block">Art Director <b class="caret"></b></span> </span> </a>
                                            <ul class="dropdown-menu animated fadeInRight m-t-xs">
                                                <li><a href="profile.html">Profile</a></li>
                                                <li><a href="contacts.html">Contacts</a></li>
                                                <li><a href="mailbox.html">Mailbox</a></li>
                                                <li class="divider"></li>
                                                <li><a href="login.html">Logout</a></li>
                                            </ul>-->
                </div>
                <!--                <div class="logo-element">
                                    IN+
                                </div>-->
            </li>

            <%
                try {
                    Session con = FactoryManager.getSessionFactory().openSession();
//                IntfGroup intgrp = null;

                    Criteria cri = con.createCriteria(Privilage.class);
                    cri.addOrder(Order.asc("idprivilage"));
                    
                    User sesuser = (User)session.getAttribute("user");
                    cri.add(Restrictions.eq("userType", sesuser.getUserType()));
//                    List<IntfGroup> intgrplist = cri.list();
                    
                    
                    List<Privilage> prvlist = cri.list();

                    for (Privilage prv : prvlist) {
                        

                        if (prv.getIntfGroup().getGroupName().equals("NoGroup")) {

                            for (Interfaces inf : prv.getIntfGroup().getInterfaceses()) {
            %>
            <li>
                <a href="http://localhost:8080/MobiShop/<%=inf.getUrl()%>"><i class="fa fa-flask"></i> <span class="nav-label"><%=inf.getIfaseName()%></span> </a>
            </li>
            <%
                }
            %>


            <%
            } else {
            %>
            <li>
                <a href=""><i class="fa fa-th-large"></i> <span class="nav-label"><%=prv.getIntfGroup().getGroupName()%></span> <span class="fa arrow"></span></a>
                <ul class="nav nav-second-level">
                    <%

                        for (Interfaces inf : prv.getIntfGroup().getInterfaceses()) {
                    %>

                    <li ><a href="http://localhost:8080/MobiShop/<%=inf.getUrl()%>"><%=inf.getIfaseName()%></a></li>

                    <%
                        }
                    %>
                </ul>
            </li>
            <%
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>


        </ul>

    </div>
</nav>
