<%-- 
    Document   : register
    Created on : Nov 29, 2015, 9:59:12 PM
    Author     : Milinda
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <title>MobiShop | Login</title>

        <%@include file="/partials/header.jsp" %>

    </head>

    <body class="gray-bg">

        <div class="middle-box text-center  animated fadeInDown">
            <div>

                <h3>Welcome to MobiShop</h3>

                <p>Fill the form and hit Register.</p>
                <form class="m-t" role="form" id="form" method="post" action="register">
                    <div class="form-group">
                        <input type="email" class="form-control" name="email" placeholder="Email" required="">
                    </div>
                    <div class="form-group">
                        <input type="password" class="form-control" name="password" placeholder="Password" required="">
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <input type="text" class="form-control" name="fname" placeholder="First Name" required="">
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <input type="text" class="form-control" name="lname" placeholder="Last Name" required="">
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <input type="number" class="form-control" name="mobile" min="0" maxlength="10" placeholder="Mobile Number (0777123456)" required="">
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <input type="text" class="form-control" name="addl1" placeholder="Address Line 1" required="">
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <input type="text" class="form-control" name="addl2" placeholder="Address Line 2">
                                <p class="pull-left">*Not required</p>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control" name="city" placeholder="City" required="">
                    </div>
                    <div class="form-group">
                        <input type="number" class="form-control" name="postcode" min="0" maxlength="5" placeholder="Postal Code" required="">
                    </div>


                    <button type="submit" class="btn btn-primary block full-width m-b">Register</button>


                    <p class="text-muted text-center">Already have an account</p>
                    <a class="btn btn-md btn-white btn-block" style="background-color: #1ab394; color: #FFF" href="login.jsp">Login</a>
                </form>
                <!--<p class="m-t"> <small>Inspinia we app framework base on Bootstrap 3 &copy; 2014</small> </p>-->
            </div>
            <%@include file="partials/footer.jsp" %>
        </div>       


        <%@include file="partials/commonjs.jsp" %>

        <script src="http://localhost:8080/MobiShop/partials/assets/js/plugins/validate/jquery.validate.min.js"></script>

        <script>
            $(document).ready(function () {

                $("#form").validate({
                    rules: {
                        password: {
                            required: true,
                            minlength: 5
                        },
                        mobile: {
                            required: true,
                            number: true
                        },
                        postcode: {
                            required: true,
                            number: true
                        },
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