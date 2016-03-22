<%-- 
    Document   : error404
    Created on : Dec 19, 2015, 6:42:54 PM
    Author     : Milinda
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <%@include file="/partials/header.jsp" %>

    </head>
    <body class="gray-bg">

       
            <div class="middle-box text-center animated fadeInDown">
                <h1>404</h1>
                <h3 class="font-bold">Page Not Found</h3>

                <div class="error-desc">
                    Sorry, but the page you are looking for has note been found. Try checking the URL for error, then hit the refresh button on your browser or try found something else in our app.<br>
                    <a href="index.jsp" class="btn btn-primary m-t">Home</a>
                    <!--                    <form class="form-inline m-t" role="form">
                                            <div class="form-group">
                                                <input type="text" class="form-control" placeholder="Search for page">
                                            </div>
                                            <button type="submit" class="btn btn-primary">Search</button>
                                        </form>-->
                </div>
                <%@include file="partials/footer.jsp" %>
            </div>
            
        
        <%@include file="partials/commonjs.jsp" %>
    </body>
</html>
