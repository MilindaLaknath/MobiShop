/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package src;

import conn.FactoryManager;
import hiben.User;
import hiben.UserType;
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
public class editUserType extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            User user = (User) req.getSession().getAttribute("user");

            if (user == null) {
                resp.sendRedirect("login.jsp");
                return;
            }
            if (user.getUserType().getType().equals("Admin") || user.getUserType().getType().equals("Root")) {
            } else {
                resp.sendRedirect("login.jsp");
                return;
            }

            String id = req.getParameter("uid");
            String type = req.getParameter("type");

            if (id == null || id.equals("") || type == null || type.equals("")) {
                String msg = "Something wrong with your inputs!";
                int msgtype = 1;
                resp.sendRedirect("admin_users.jsp?msg=" + msg + "&msgtype=" + msgtype);
                return;
            }

            Session con = FactoryManager.getSessionFactory().openSession();
            Transaction t = con.beginTransaction();

            User u = (User) con.load(User.class, Integer.parseInt(id));
            UserType ut = (UserType) con.load(UserType.class, Integer.parseInt(type));

            if (ut.getType().equals("Root")||u.getUserType().getType().equals("Root")) {
                if (user.getUserType().getType().equals("Root")) {
                    u.setUserType(ut);

                    con.save(u);

                    t.commit();
                    String msg = "Success!";
                    int msgtype = 0;
                    resp.sendRedirect("admin_users.jsp?msg=" + msg + "&msgtype=" + msgtype);
                } else {
                    String msg = "Something wrong with your inputs!";
                    int msgtype = 1;
                    resp.sendRedirect("admin_users.jsp?msg=" + msg + "&msgtype=" + msgtype);
                }
            } else {
                u.setUserType(ut);

                con.save(u);

                t.commit();
                String msg = "Success!";
                int msgtype = 0;
                resp.sendRedirect("admin_users.jsp?msg=" + msg + "&msgtype=" + msgtype);
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(500);
        }
    }

}
