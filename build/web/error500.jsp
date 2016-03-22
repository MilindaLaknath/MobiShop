<%-- 
    Document   : error500
    Created on : Dec 19, 2015, 6:42:42 PM
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
            <h1>500</h1>
            <h3 class="font-bold">Internal Server Error</h3>

            <div class="error-desc">
                The server encountered something unexpected that didn't allow it to complete the request. We apologize.<br/>
                You can go back to main page: <br/><a href="index.jsp" class="btn btn-primary m-t">Home</a>
            </div>
            <%@include file="partials/footer.jsp" %>
        </div>
        

        <%@include file="partials/commonjs.jsp" %>
    </body>
</html>
