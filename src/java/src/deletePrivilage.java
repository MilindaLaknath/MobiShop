/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package src;

import conn.FactoryManager;
import hiben.Privilage;
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
public class deletePrivilage extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {

            User user = (User) req.getSession().getAttribute("user");

            if (user == null) {
                resp.sendRedirect("login.jsp");
                return;
            }
            if (user.getUserType().getType().equals("Root")) {
            } else {
                resp.sendRedirect("login.jsp");
                return;
            }

            String prvid = req.getParameter("idprv");

            if (prvid != null && !prvid.equals("")) {
                Session con = FactoryManager.getSessionFactory().openSession();
                Transaction t = con.beginTransaction();
                Privilage prv = (Privilage) con.load(Privilage.class, Integer.parseInt(prvid));
                con.delete(prv);
                t.commit();
                String msg = "success!";
                int type = 0;
                resp.sendRedirect("root_privilage.jsp?msg=" + msg + "&msgtype=" + type);

            } else {
                String msg = "Something Wrong!";
                int type = 1;
                resp.sendRedirect("root_privilage.jsp?msg=" + msg + "&msgtype=" + type);
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(500);
        }
    }

}
