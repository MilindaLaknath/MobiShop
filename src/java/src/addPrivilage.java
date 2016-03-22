/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package src;

import conn.FactoryManager;
import hiben.IntfGroup;
import hiben.Privilage;
import hiben.User;
import hiben.UserType;
import java.io.IOException;
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
public class addPrivilage extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
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

            String strut = req.getParameter("utype");
            String strint = req.getParameter("intf");

            if (strint != null && !strint.equals("") && strut != null && !strut.equals("")) {
                Session con = FactoryManager.getSessionFactory().openSession();
                Transaction t = con.beginTransaction();

                UserType ut = (UserType) con.load(UserType.class, Integer.parseInt(strut));
                IntfGroup intf = (IntfGroup) con.load(IntfGroup.class, Integer.parseInt(strint));

                Criteria cri = con.createCriteria(Privilage.class);
                cri.add(Restrictions.eq("intfGroup", intf));
                cri.add(Restrictions.eq("userType", ut));

                if (cri.list().size() > 0) {
                    String msg = "Already There!";
                    int type = 1;
                    resp.sendRedirect("root_privilage.jsp?msg=" + msg + "&msgtype=" + type);
                    return;
                }

                Privilage pvg = new Privilage(intf, ut);

                con.save(pvg);

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
