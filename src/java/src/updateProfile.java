/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package src;

import conn.FactoryManager;
import hiben.Address;
import hiben.PersonalDetails;
import hiben.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Milinda
 */
public class updateProfile extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            User u = (User) req.getSession().getAttribute("user");

            if (u == null) {
                resp.sendRedirect("login.jsp");
                return;
            }

            String pass = req.getParameter("password");
            String passnew = req.getParameter("passwordnew");
            String fname = req.getParameter("fname");
            String lname = req.getParameter("lname");
            String mobile = req.getParameter("mobile");
            String addl1 = req.getParameter("addl1");
            String addl2 = req.getParameter("addl2");
            String city = req.getParameter("city");
            String postcode = req.getParameter("postcode");

            pass = pass.trim();
            passnew = passnew.trim();

            if (pass == null || pass.equals("")) {
                String msg = "Something wrong with your inputs!";
                int msgtype = 1;
                resp.sendRedirect("myprofile.jsp?msg=" + msg + "&msgtype=" + msgtype);
                return;
            }

            if (!u.getPassword().equals(pass.hashCode() + "")) {
                String msg = "Password did not match!";
                int msgtype = 1;
                resp.sendRedirect("myprofile.jsp?msg=" + msg + "&msgtype=" + msgtype);
                return;
            }

            Session con = FactoryManager.getSessionFactory().openSession();
            Transaction t = con.beginTransaction();

            User user = (User) con.load(User.class, u.getUserId());

            if (passnew != null && !passnew.equals("") && !passnew.equals(pass)) {
                user.setPassword(passnew.hashCode() + "");
            }

            PersonalDetails psd = user.getPersonalDetails();

            if (fname != null && !fname.equals("")) {
                psd.setFName(fname);
            }
            if (lname != null && !lname.equals("")) {
                psd.setLName(lname);
            }
            if (mobile != null && !mobile.equals("")) {
                psd.setPhone(mobile);
            }

            Address ads = psd.getAddress();

            if (addl1 != null && !addl1.equals("")) {
                ads.setAddl1(addl1);
            }
            if (addl2 != null && !addl2.equals("")) {
                ads.setAddl2(addl2);
            }
            if (city != null && !city.equals("")) {
                ads.setCity(city);
            }
            if (postcode != null && !postcode.equals("")) {
                ads.setPostCode(Integer.parseInt(postcode));
            }
            con.save(ads);
            con.save(psd);
            con.save(user);

            req.getSession().removeAttribute("user");
            req.getSession().setAttribute("user", user);

            t.commit();

            String msg = "Success!";
            int msgtype = 0;
            resp.sendRedirect("myprofile.jsp?msg=" + msg + "&msgtype=" + msgtype);

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(500);
        }
    }

}
