/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package src;

import conn.FactoryManager;
import hiben.CartProd;
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
public class removeItmFrmCrt extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            User u = (User) req.getSession().getAttribute("user");

            if (u == null) {
                resp.sendRedirect("login.jsp");
                return;
            }

            String chpid = "";
            chpid = req.getParameter("chpid");

            if (chpid != null && !chpid.equals("")) {

                Session con = FactoryManager.getSessionFactory().openSession();
                Transaction t = con.beginTransaction();

                CartProd cpd = (CartProd) con.load(CartProd.class, Integer.parseInt(chpid));

                //cart
                cpd.getCart().setTotProd(cpd.getCart().getTotProd() - cpd.getQty());
                cpd.getCart().setTotVal(cpd.getCart().getTotVal() - (cpd.getStock().getItmPrice() - cpd.getStock().getDiscount()));

                con.delete(cpd);

                t.commit();

                String msg = "Success!";
                int type = 0;
                resp.sendRedirect("client_cart.jsp?msg=" + msg + "&msgtype=" + type);
            } else {
                String msg = "Something wrong with your inputs!";
                int type = 1;
                resp.sendRedirect("error.jsp?msg=" + msg + "&msgtype=" + type);
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(500);
        }
    }

}
