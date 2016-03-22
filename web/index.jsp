<%-- 
    Document   : index
    Created on : Nov 27, 2015, 10:08:09 AM
    Author     : Milinda
--%>

<%@page import="java.util.List"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="hiben.Stock"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="conn.FactoryManager"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <%@include file="/partials/header.jsp" %>

        <!-- Custom CSS -->
        <link href="http://localhost:8080/MobiShop/partials/assets/css/modern-business.css" rel="stylesheet">

    </head>


    <body class="top-navigation">
        <div id="wrapper">
            <div id="page-wrapper" class="gray-bg">
                <div class="row border-bottom">
                    <%@include file="/partials/top_bar.jsp" %> 
                </div>

               
                <div style="width: auto; height: 350px;" >
                    <!-- Header Carousel -->
                    <header id="myCarousel" class="carousel slide">
                        <!--Indicators--> 
                        <ol class="carousel-indicators">
                            <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                            <li data-target="#myCarousel" data-slide-to="1"></li>
                            <li data-target="#myCarousel" data-slide-to="2"></li>
                        </ol>

                        <!-- Wrapper for slides -->
                        <div class="carousel-inner">
                            <div class="item active">
                                <div class="fill" style="background-image:url('partials/assets/img/slider/one.png');"></div>
                            </div>
                            <div class="item">
                                <div class="fill" style="background-image:url('partials/assets/img/slider/two.png');"></div>
                            </div>
                            <div class="item">
                                <div class="fill" style="background-image:url('partials/assets/img/slider/three.png');"></div>                                
                            </div>
                        </div>

                        <!--Controls--> 
                        <a class="left carousel-control" href="#myCarousel" data-slide="prev">
                            <span class="icon-prev"></span>
                        </a>
                        <a class="right carousel-control" href="#myCarousel" data-slide="next">
                            <span class="icon-next"></span>
                        </a>
                    </header>
                </div>

                <div class="container" style="margin-top: 15px;">

                    <%                        Session con = FactoryManager.getSessionFactory().openSession();
                        Criteria cri = con.createCriteria(Stock.class);
                        cri.add(Restrictions.gt("quentity", 0));
                        cri.addOrder(Order.desc("quentity"));
//                        cri.setFirstResult(0);
                        cri.setMaxResults(8);

                        List<Stock> stklist = cri.list();

                        for (Stock stk : stklist) {
                            if (stk.getProducts().getActive().equals(0)) {

                    %>
                    <a href="http://localhost:8080/MobiShop/productinfo.jsp?pid=<%=stk.getProducts().getItmCode()%>">
                        <div class="col-sm-3">
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    <h4><%=stk.getProducts().getBrand().getBrandName()%> <%=stk.getProducts().getItmName() %></h4>
                                </div>
                                <div class="panel-body" align="center">
                                    <img class="img-thumbnail img-shadow" alt="Bootstrap Image Preview" src="http://localhost:8080/MobiShop/<%=stk.getProducts().getImgUrl()%>" />
                                    <h3><%=stk.getItmPrice() - stk.getDiscount()%> LKR 
                                        <%
                                            if (stk.getDiscount() > 0.0) {
                                                String dis = ((stk.getDiscount() / stk.getItmPrice()) * 100)+"";
//                                                String []arr = dis.split(".");
//                                                String []arr2 = arr[1].split("");
//                                                out.print(" | ");
//                                                out.print(arr[0]+arr2[0]+arr[1]+"%");
                                                if(dis.length()>4){
                                                out.print(dis.charAt(0)+""+dis.charAt(1)+""+dis.charAt(2)+""+dis.charAt(3)+"%");
                                                }else{
                                                out.print(dis+"%");
                                                }
//                                            out.print(" Discount");
                                            }
                                        %>
                                    </h3>
                                    <h3><%=stk.getColor()%> &nbsp;|&nbsp; <%=stk.getStorage()%> GB</h3>

                                </div>
                            </div>
                        </div>
                    </a>
                    <%                        }
                        }
                    %>


                </div>

            </div>
            <%@include file="partials/footer.jsp" %>
        </div>


        <%@include file="partials/commonjs.jsp" %>
        <script>
            $('.carousel').carousel({
                interval: 5000 //changes the speed
            })
        </script>

    </body>



</html>
