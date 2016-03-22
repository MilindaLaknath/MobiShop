/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package src;

import conn.FactoryManager;
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
public class makeSend extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
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
            
            
            
            String transid = req.getParameter("transid");

            if (transid == null || transid.equals("")) {
                String msg = "Something wrong with your inputs!";
                int type = 1;
                resp.sendRedirect("admin_ordered_items.jsp?msg=" + msg + "&msgtype=" + type);
                return;
            }

            Session con = FactoryManager.getSessionFactory().openSession();
            Transaction t = con.beginTransaction();

            hiben.Transaction trans = (hiben.Transaction) con.load(hiben.Transaction.class, Integer.parseInt(transid));
            trans.setIsSend(1);

            con.save(trans);

            t.commit();

            String msg = "Success!";
            int type = 0;
            resp.sendRedirect("admin_ordered_items.jsp?msg=" + msg + "&msgtype=" + type);
            
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(500);
        }
    }

}
