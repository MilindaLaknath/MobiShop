/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package src;

import conn.FactoryManager;
import hiben.Products;
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
public class deleteProduct extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            User user = (User) req.getSession().getAttribute("user");

            if (user == null) {
                resp.sendRedirect("login.jsp");
                return;
            }
            if (user.getUserType().getType().equals("Root") || user.getUserType().getType().equals("Admin")) {
            } else {
                resp.sendRedirect("login.jsp");
                return;
            }

            String pid = req.getParameter("pid");

            if (pid != null && !pid.equals("")) {

                Session con = FactoryManager.getSessionFactory().openSession();
                Transaction t = con.beginTransaction();

                Products p = (Products) con.load(Products.class, Integer.parseInt(pid));

                if (p == null) {
                    resp.getWriter().write(pid + "No Product");
                    return;
                } else {
                    p.setActive(1);
                    con.save(p);
                    t.commit();

                    String msg = "Success!";
                    int type = 0;
                    resp.sendRedirect("admin_items.jsp?msg=" + msg + "&msgtype=" + type);
                }
            } else {
//                resp.getWriter().write(pid);
                String msg = "Something wrong!";
                int type = 1;
                resp.sendRedirect("admin_items.jsp?msg=" + msg + "&msgtype=" + type);
            }
        } catch (Exception e) {
            
            e.printStackTrace();
            resp.sendError(500);
        }
    }

}
