/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package src;

import conn.FactoryManager;
import hiben.Products;
import hiben.Stock;
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
public class updateStock extends HttpServlet {

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

            String pid = req.getParameter("pid");
            String price = req.getParameter("price");
            String storage = req.getParameter("storage");
            String color = req.getParameter("color");
            String quantity = req.getParameter("quantity");
            String discount = req.getParameter("discount");

            if (!pid.equals("") && !price.equals("") && !storage.equals("") && !color.equals("") && !quantity.equals("") && !discount.equals("")) {
                if (Integer.parseInt(quantity) <= 0) {
                    resp.sendRedirect("index.jsp");
                    return;
                }

                Session con = FactoryManager.getSessionFactory().openSession();
                Transaction t = con.beginTransaction();

                Products p = (Products) con.load(Products.class, Integer.parseInt(pid));

                Stock stk = new Stock();
                stk.setProducts(p);
                stk.setItmPrice(Double.parseDouble(price));
                stk.setStorage(Integer.parseInt(storage));
                stk.setColor(color);
                stk.setQuentity(Integer.parseInt(quantity));
                stk.setDiscount(Double.parseDouble(discount));

                con.save(stk);

                t.commit();

                String msg = "Success!";
                int type = 0;
                resp.sendRedirect("admin_update_stock.jsp?msg=" + msg + "&msgtype=" + type);

            } else {
                String msg = "Something wrong with your inputs!";
                int type = 1;
                resp.sendRedirect("admin_update_stock.jsp?msg=" + msg + "&msgtype=" + type);
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(500);
        }
    }

}
