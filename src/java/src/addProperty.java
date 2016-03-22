/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package src;

import conn.FactoryManager;
import hiben.ProdProperty;
import hiben.PropertyGroup;
import hiben.User;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Milinda
 */
public class addProperty extends HttpServlet {

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

            String pgid = req.getParameter("pgid");
            String id = req.getParameter("id");
            String name = req.getParameter("name");

            if (!pgid.equals("") && !name.equals("")) {

                Session con = FactoryManager.getSessionFactory().openSession();

                Criteria c = con.createCriteria(ProdProperty.class);

                List<ProdProperty> l = c.list();

                for (ProdProperty l1 : l) {
                    if (l1.getPropertyName().equals(name)) {
//                    out.print(l1.getBrandName());
                        String msg = "Already there!";
                        int type = 1;
                        resp.sendRedirect("admin_item_property.jsp?msg=" + msg + "&msgtype=" + type);
                        return;
                    }
                }

                PropertyGroup pg = (PropertyGroup) con.load(PropertyGroup.class, Integer.parseInt(pgid));

                Transaction t = con.beginTransaction();

                ProdProperty b = new ProdProperty();

                b.setPropertyName(name);
                b.setPropertyGroup(pg);

                con.save(b);

                t.commit();

                String msg = "Success!";
                int type = 0;
                resp.sendRedirect("admin_item_property.jsp?msg=" + msg + "&msgtype=" + type);
            } else {
                String msg = "omething wrong with your inputs!";
                int type = 1;
                resp.sendRedirect("admin_item_property.jsp?msg=" + msg + "&msgtype=" + type);
            }
        } catch (Exception e) {
            e.printStackTrace();
            
            resp.sendError(500);
        }
    }

}
