<%-- 
    Document   : sidebar
    Created on : Dec 1, 2015, 11:39:10 AM
    Author     : Milinda
--%>

<%@page import="java.util.List"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="hiben.Brand"%>
<%@page import="org.hibernate.Criteria"%>
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
                    String catid = request.getParameter("category");
//                    String search = request.getParameter("search");
                    
//                    if(search == null || search.equals("null") ){
//                        search = "";
//                    }
                    if(catid == null || catid.equals("null") ){
                        catid = "";
                    }
                    
                    Session con = FactoryManager.getSessionFactory().openSession();
                    Criteria cri = con.createCriteria(Brand.class);
                    cri.addOrder(Order.asc("brandName"));
                    List<Brand> brlist = cri.list();
                    for (Brand brd : brlist) {
            %>
            <li>
                <a href="http://localhost:8080/MobiShop/search.jsp?brand=<%=brd.getIdbrand()%>&category=<%=catid%>"><i class="fa fa-mobile"></i> <span class="nav-label"><%=brd.getBrandName()%></span> </a>
            </li>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>


        </ul>

    </div>
</nav>