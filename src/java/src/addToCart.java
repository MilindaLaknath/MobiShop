/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package src;

import conn.FactoryManager;
import hiben.Cart;
import hiben.CartProd;
import hiben.Stock;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import hiben.User;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Milinda
 */
public class addToCart extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {

            String batchid = "";
            String quantity = "";

            User u = null;
            u = (User) req.getSession().getAttribute("user");
            if (u == null) {
                resp.sendRedirect("index.jsp");
                return;
            }

            batchid = req.getParameter("batchid");
            quantity = req.getParameter("quantity");
            if (batchid == null || batchid.equals("")) {
                resp.sendRedirect("index.jsp");
                return;
            }
            if (quantity == null || quantity.equals("")) {
                resp.sendRedirect("index.jsp");
                return;
            }
            if (Integer.parseInt(quantity) <= 0) {
                resp.sendRedirect("index.jsp");
                return;
            }

            Cart crt = null;
            Stock stk = null;

            Session con = FactoryManager.getSessionFactory().openSession();
            Transaction t = con.beginTransaction();

            stk = (Stock) con.load(Stock.class, Integer.parseInt(batchid));

            Criteria cri = con.createCriteria(Cart.class);
            cri.add(Restrictions.eq("user", u));
//            System.out.println("1");
            if (cri.list().size() > 0) {
                crt = (Cart) cri.list().get(0);
                crt.setTotProd(crt.getTotProd() + Integer.parseInt(quantity));
                crt.setTotVal(crt.getTotVal() + ((stk.getItmPrice() - stk.getDiscount())*Integer.parseInt(quantity)));
//                System.out.println("3");
            } else {
//                System.out.println("4");
                crt = new Cart(u);
                crt.setTotProd(Integer.parseInt(quantity));
                crt.setTotVal((stk.getItmPrice() - stk.getDiscount()));
//                System.out.println("5");
            }
//            System.out.println("6");
            CartProd cpd = null;
            cri = con.createCriteria(CartProd.class);
            cri.add(Restrictions.eq("cart", crt));
            cri.add(Restrictions.eq("stock", stk));
            cri.add(Restrictions.eq("isPurches", 0));

            if (cri.list().size() > 0) {
                System.out.println("7");
                cpd = (CartProd) cri.list().get(0);
                cpd.setQty(cpd.getQty() + Integer.parseInt(quantity));
            } else {
//                System.out.println("8");
                cpd = new CartProd(crt, stk);
                cpd.setQty(Integer.parseInt(quantity));
            }

            cpd.setIsPurches(0);

            con.save(crt);
            con.save(cpd);

            t.commit();

            String msg = "Success!";
            int type = 0;
            resp.sendRedirect("client_cart.jsp?msg=" + msg + "&msgtype=" + type);

        } catch (Exception e) {
            e.printStackTrace();

            resp.sendError(500);
        }
    }

}
