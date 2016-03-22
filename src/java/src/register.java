/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package src;

import com.src.EmailSessionBean;
import conn.FactoryManager;
import hiben.Address;
import hiben.PersonalDetails;
import hiben.User;
import hiben.UserType;
import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Milinda
 */
public class register extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        try {

            String email = req.getParameter("email");
            String pass = req.getParameter("password");
            String fname = req.getParameter("fname");
            String lname = req.getParameter("lname");
            String mobile = req.getParameter("mobile");
            String addl1 = req.getParameter("addl1");
            String addl2 = req.getParameter("addl2");
            String city = req.getParameter("city");
            String postcode = req.getParameter("postcode");

            email = email.trim();
            pass = pass.trim();
            fname = fname.trim();
            lname = lname.trim();
            mobile = mobile.trim();
            addl1 = addl1.trim();
            addl2 = addl2.trim();
            city = city.trim();
            postcode = postcode.trim();
            
            if (pass == null || pass.equals("")) {
                String msg = "Something wrong with your inputs!";
                int msgtype = 1;
                resp.sendRedirect("register.jsp?msg=" + msg + "&msgtype=" + msgtype);
                return;
            }

            Session con = FactoryManager.getSessionFactory().openSession();

            Criteria c = con.createCriteria(User.class);
            c.add(Restrictions.eq("email", email));

            List<User> li = c.list();

            if (li.size() > 0) {
                // already have acc
                String msg = "You already have Account !";
                req.setAttribute("msg", msg);
                RequestDispatcher rd = req.getRequestDispatcher("/login.jsp");
                rd.forward(req, resp);
            } else {

                Transaction t = con.beginTransaction();

                c = con.createCriteria(UserType.class);
                c.add(Restrictions.eq("type", "Client"));
                List<UserType> utli = c.list();

                UserType ut = null;

                for (UserType utli1 : utli) {
                    ut = utli1;
                }

                Address ad = new Address();
                ad.setAddl1(addl1);
                ad.setAddl2(addl2);
                ad.setCity(city);
                ad.setPostCode(Integer.parseInt(postcode));

                PersonalDetails pd = new PersonalDetails();
                pd.setFName(fname);
                pd.setLName(lname);
                pd.setPhone(mobile);
                pd.setAddress(ad);

                User u = new User();
                u.setEmail(email);
                u.setPassword(pass.hashCode() + "");
                u.setUserType(ut);
                u.setPersonalDetails(pd);

                con.save(ad);
                con.save(pd);
                con.save(u);

                t.commit();

                EmailSessionBean emailsession = new EmailSessionBean();
                String body = "Welcome to the MobiShop. Happy Shopping.";
                emailsession.sendEmail(email, "Welcome to the MobiShop", body);
                
                String msg = "You Account created successfully !";
                req.setAttribute("msg", msg);
                req.setAttribute("color", "#1ab394");
                RequestDispatcher rd = req.getRequestDispatcher("/login.jsp");
                rd.forward(req, resp);

            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(500);
        }

    }

}
