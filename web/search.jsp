<%-- 
    Document   : search
    Created on : Dec 1, 2015, 11:23:31 AM
    Author     : Milinda
--%>
<%@page import="hiben.Brand"%>
<%@page import="org.hibernate.criterion.MatchMode"%>
<%@page import="hiben.Category"%>
<%@page import="hiben.Products"%>
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
    </head>
    <body>
        <div id="wrapper">


            <%                        try {
                    String search = "";
                    String brid = "";
                    String catid = "";
                    String strfrest = "";
                    int frest = 0;

                    search = request.getParameter("search");
                    brid = request.getParameter("brand");
                    catid = request.getParameter("category");
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
                    Criteria cri = con.createCriteria(Stock.class);
                    Criteria cri2 = cri.createCriteria("products");

                    if (search != null && !search.equals("")) {
                        cri2.add(Restrictions.or(Restrictions.like("itmName", search, MatchMode.ANYWHERE)));
                    }
                    if (brid != null && !brid.equals("")) {
                        Brand b = (Brand) con.load(Brand.class, Integer.parseInt(brid));
                        cri2.add(Restrictions.or(Restrictions.eq("brand", b)));
                    }
                    if (catid != null && !catid.equals("")) {
                        Category c = (Category) con.load(Category.class, Integer.parseInt(catid));
                        cri2.add(Restrictions.or(Restrictions.eq("category", c)));
                    }

//                        cri = con.createCriteria(Stock.class);
                    cri.add(Restrictions.gt("quentity", 0));

                    cri.addOrder(Order.desc("discount"));
                    cri.addOrder(Order.asc("itmPrice"));
                    cri.setFirstResult(frest);
                    cri.setMaxResults(8);

//                            
                    List<Stock> stklist = cri.list();
            %>
            <jsp:include page="/partials/sidebar.jsp" /> 
            <div id="page-wrapper" class="gray-bg top-navigation">
                <div class="row border-bottom">
                    <jsp:include page="/partials/top_bar.jsp" />
                </div>

                <div class="container col-sm-12" style="margin-top: 15px;">


                    <%                        for (Stock stk : stklist) {
                            if (stk.getProducts().getActive().equals(0)) {

                    %>

                    <a href="http://localhost:8080/MobiShop/productinfo.jsp?pid=<%=stk.getProducts().getItmCode()%>">
                        <div class="col-sm-3">
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    <h4><%=stk.getProducts().getBrand().getBrandName()%> <%=stk.getProducts().getItmName()%></h4>
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
                                                if (dis.length() > 4) {
                                                    out.print(dis.charAt(0) +""+ dis.charAt(1) +""+ dis.charAt(2) +""+ dis.charAt(3) + "%");
                                                } else {
                                                    out.print(dis + "%");
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
                    <div class="row col-sm-12">
                        <div class="btn-group pull-right">
                            <%
                                String url = "";
                                if (search != null) {
                                    url += "&search=" + search;
                                }
                                if (brid != null) {
                                    url += "&brand=" + brid;
                                }
                                if (catid != null) {
                                    url += "&category=" + catid;
                                }
                                if (frest != 0) {
                            %>
                            <a href="http://localhost:8080/MobiShop/search.jsp?frest=<%=frest - 8%><%=url%>">
                                <button type="button" class="btn btn-primary"><i class="fa fa-chevron-left"></i>Previous</button>
                            </a>
                            <%
                                }
                                if (stklist.size() == 8) {
                            %>
                            <a href="http://localhost:8080/MobiShop/search.jsp?frest=<%=frest + 8%><%=url%>">
                                <button type="button" class="btn btn-primary"><i class="fa fa-chevron-right"></i>Next</button>
                            </a>
                            <%
                                }
                            %>
                        </div>
                    </div>


                </div>



            </div>

            <%@include file="partials/footer.jsp" %>
            <%
                } catch (Exception e) {
                    e.printStackTrace();
                    response.sendError(500);
                }
            %>


        </div>
        <%@include file="partials/commonjs.jsp" %>
    </body>
</html>
