/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package src;

import conn.FactoryManager;
import hiben.IntfGroup;
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
public class editIntfGroup extends HttpServlet {

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

            String id = req.getParameter("idgroup");
            String grpname = req.getParameter("name");

            if (id != null && !id.equals("") && grpname != null && !grpname.equals("")) {
                Session con = FactoryManager.getSessionFactory().openSession();
                Transaction t = con.beginTransaction();

                IntfGroup ig = (IntfGroup) con.load(IntfGroup.class, Integer.parseInt(id));
                ig.setGroupName(grpname);

                con.save(ig);
                t.commit();

                String msg = "Success!";
                int type = 0;
                resp.sendRedirect("root_interface.jsp?msg=" + msg + "&msgtype=" + type);

            } else {
                String msg = "Something wrong with your inputs!";
                int type = 1;
                resp.sendRedirect("root_interface.jsp?msg=" + msg + "&msgtype=" + type);
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(500);
        }
    }

}
