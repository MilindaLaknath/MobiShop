<%-- 
    Document   : myprofile
    Created on : Dec 20, 2015, 8:48:11 PM
    Author     : Milinda
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="/partials/header.jsp" %>

    </head>
    <body>
        <div id="wrapper">
            <%@include file="/partials/sidebar_search.jsp" %> 
            <div id="page-wrapper" class="gray-bg top-navigation">
                <div class="row border-bottom">
                    <%@include file="/partials/top_bar.jsp" %> 
                </div>

                <%                    try {
//                        User user = (User) session.getAttribute("user");

                        if (u == null) {
                            response.sendRedirect("login.jsp");
                            return;
                        }
                        

                %>

                <div class="col-lg-12">
                    <div class="ibox-title">
                        <h3 class="font-bold">My Profile</h3>
                    </div>

                    <div class="ibox-content">
                        <form class="m-t" id="form" name="frmProfile" action="updateProfile" method="post">
                            <div class="form-group">
                                <label>Email</label>
                                <input type="email" value="<%=u.getEmail() %>" class="form-control" name="email" placeholder="Email" readonly="" required="">
                            </div>
                            <div class="form-group">
                                <label>Password</label>
                                <input type="password" class="form-control" name="password" placeholder="Password" required="">
                            </div>
                            <div class="form-group">
                                <label>New Password</label>
                                <input type="password" class="form-control" name="passwordnew" placeholder="New Password">
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>First Name</label>
                                        <input type="text" value="<%=u.getPersonalDetails().getFName() %>" class="form-control" name="fname" placeholder="First Name" required="">
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>Last Name</label>
                                        <input type="text" value="<%=u.getPersonalDetails().getLName() %>" class="form-control" name="lname" placeholder="Last Name" required="">
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Mobile No</label>
                                <input type="number" class="form-control" value="<%=u.getPersonalDetails().getPhone() %>" name="mobile" min="0" maxlength="10" placeholder="Mobile Number (0777123456)" required="">
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>Address Line 1</label>
                                        <input type="text" class="form-control" value="<%=u.getPersonalDetails().getAddress().getAddl1() %>" name="addl1" placeholder="Address Line 1" required="">
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>Address Line 2</label>
                                        <input type="text" class="form-control" value="<% 
                                            if(u.getPersonalDetails().getAddress().getAddl2() != null){
                                                out.print(u.getPersonalDetails().getAddress().getAddl2());
                                            }else{
                                            out.print("");
                                            }
                                        %>" name="addl2" placeholder="Address Line 2">
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>City</label>
                                <input type="text" class="form-control" value="<%=u.getPersonalDetails().getAddress().getCity() %>" name="city" placeholder="City" required="">
                            </div>
                            <div class="form-group">
                                <label>Postal Code</label>
                                <input type="number" class="form-control" value="<%=u.getPersonalDetails().getAddress().getPostCode() %>" name="postcode" min="0" maxlength="5" placeholder="Postal Code" required="">
                            </div>

                            <button type="submit" class="btn btn-primary block full-width m-b">Update Info</button>

                        </form>
                    </div>

                </div>

                <%                    } catch (Exception e) {
                    System.out.print(u);
                        e.printStackTrace();
                        response.sendError(500);
                    }
                %>

            </div>
            <%@include file="/partials/footer.jsp" %>
        </div>
        <%@include file="/partials/commonjs.jsp" %>

        <script src="http://localhost:8080/MobiShop/partials/assets/js/plugins/validate/jquery.validate.min.js"></script>

        <script>
            $(document).ready(function () {

                $("#form").validate({
                    rules: {
                        password: {
                            required: true,
                            minlength: 5
                        },
                        passwordnew: {
//                            required: true,
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
