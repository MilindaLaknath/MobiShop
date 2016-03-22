<%-- 
    Document   : login
    Created on : Nov 29, 2015, 9:43:24 PM
    Author     : Milinda
--%>
<%@page import="conn.FactoryManager"%>
<%@page import="org.hibernate.Session"%>
<%@page import="hiben.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <title>MobiShop | Login</title>

        <%@include file="/partials/header.jsp" %>
        <link href="http://localhost:8080/MobiShop/partials/assets/css/plugins/iCheck/custom.css" rel="stylesheet">


    </head>

    <body class="gray-bg">

        <div class="middle-box text-center loginscreen  animated fadeInDown">
            <div>
                <div>

                    <h1  class="logo-name" style="font-family: Forte;">MS</h1>

                </div>
                <h3>Welcome to MobiShop</h3>
                <!--                <p>Perfectly designed and precisely prepared admin theme with over 50 pages with extra new web app views.
                                    Continually expanded and constantly improved Inspinia Admin Them (IN+)
                                </p>-->

                <h4 class="danger" style="color: #ff4141;">
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

                        if (u != null) {
                            switch (u.getUserType().getGuestId()) {
                                case 1:
                                    response.sendRedirect("client_user_orders.jsp");
                                    break;
                                case 2:
                                    response.sendRedirect("admin_ordered_items.jsp");
                                    break;
                                case 3:
                                    response.sendRedirect("root_privilage.jsp");
                                    break;
                                default:
                                    response.sendRedirect("index.jsp");
                            }

                        }

                        String msg = null;
                        String color = null;
                        msg = (String) request.getAttribute("msg");
                        color = (String) request.getAttribute("color");
                        if (msg != null) {
                            if (color != null) {
                                out.print("<span style=\"color:" + color + "\">");
                                out.print(msg);
                                out.print("</span>");
                            } else {
                                out.print(msg);
                            }
                        }
                    %>
                </h4>
                <p>Login in. To see it in action.</p>

                <form class="m-t" role="form" method="post" id="form" action="logincheck">
                    <div class="form-group">
                        <input type="email" class="form-control" name="email" placeholder="Email" required="">
                    </div>
                    <div class="form-group">
                        <input type="password" class="form-control" name="password" placeholder="Password" required="">
                    </div>
                    <div class="checkbox i-checks">
                        <label class=""> 
                            <div class="icheckbox_square-green" style="position: relative;">
                                <input type="checkbox" name="remember" value="remember" style="position: absolute; opacity: 0;">
                                <ins class="iCheck-helper" style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; border: 0px; opacity: 0; background: rgb(255, 255, 255);"></ins>
                            </div><i></i> 
                            Remember me 
                        </label>
                    </div>

                    <button type="submit" class="btn btn-primary block full-width m-b">Login</button>

                    <a href="http://localhost:8080/MobiShop/fogotpw.jsp"><small>Forgot password?</small></a>
                    <p class="text-muted text-center"><small>Do not have an account?</small></p>
                    <a class="btn btn-md btn-white btn-block" style="background-color: #1ab394; color: #FFF" href="register.jsp">Create an account</a>
                </form>
                <!--<p class="m-t"> <small>Inspinia we app framework base on Bootstrap 3 &copy; 2014</small> </p>-->
            </div>
            <%@include file="partials/footer.jsp" %>
        </div>       


        <%@include file="partials/commonjs.jsp" %>

        <script src="http://localhost:8080/MobiShop/partials/assets/js/plugins/iCheck/icheck.min.js"></script>

        <script src="http://localhost:8080/MobiShop/partials/assets/js/plugins/validate/jquery.validate.min.js"></script>

        <script>
            $(document).ready(function () {

                $("#form").validate({
                    rules: {
                        password: {
                            required: true,
                            minlength: 5
                        },
                        email: {
                            required: true,
                            email: true
                        }
                    }
                });
            });
        </script>

        <script>
            $(document).ready(function () {
                $('.i-checks').iCheck({
                    checkboxClass: 'icheckbox_square-green',
                    radioClass: 'iradio_square-green',
                });
            });
        </script>

    </body>

</html>