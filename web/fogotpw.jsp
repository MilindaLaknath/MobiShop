<%-- 
    Document   : fogotpw
    Created on : Dec 21, 2015, 3:07:38 PM
    Author     : Milinda
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="/partials/header.jsp" %>
        <link href="http://localhost:8080/MobiShop/partials/assets/css/plugins/iCheck/custom.css" rel="stylesheet">


    </head>

    <body class="gray-bg">

        <div class="middle-box text-center loginscreen  animated fadeInDown">
            <div>
                <div>

                    <h1  class="logo-name" style="font-family: Forte;">MS</h1>

                </div>
                <h3>Password Reset</h3>

                <p>Enter Email to send new Password.</p>

                <form class="m-t" role="form" method="post" id="form" action="resetPass">
                    <div class="form-group">
                        <input type="email" class="form-control" name="email" placeholder="Email" required="">
                    </div>

                    <button type="submit" class="btn btn-primary block full-width m-b">Reset Password</button>                    
                </form>
                <!--<p class="m-t"> <small>Inspinia we app framework base on Bootstrap 3 &copy; 2014</small> </p>-->
            </div>
            <%@include file="partials/footer.jsp" %>
        </div>       


        <%@include file="partials/commonjs.jsp" %>

        <script>
            $(document).ready(function () {

                $("#form").validate({
                    rules: {
                        email: {
                            required: true,
                            email: true
                        }
                    }
                });
            });
        </script>

    </body>
</html>
