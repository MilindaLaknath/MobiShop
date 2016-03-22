/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package src;

import conn.FactoryManager;
import hiben.Cart;
import hiben.CartProd;
import hiben.Invoice;
import hiben.TransProd;
import hiben.User;
//import hiben.Transaction;
import java.io.IOException;
import java.util.Date;
import java.util.List;
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
public class addTransaction extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {

            User user = null;

            user = (User) req.getSession().getAttribute("user");

            if (user == null) {
                resp.sendRedirect("login.jsp");
                return;
            }

            Cart cart = null;

            Session con = FactoryManager.getSessionFactory().openSession();
            Criteria cri = con.createCriteria(Cart.class);
            cri.add(Restrictions.eq("user", user));

            if (cri.list().size() < 1) {
                resp.sendRedirect("client_cart.jsp");
                return;
            } else {
                cart = (Cart) cri.list().get(0);
            }

            cri = con.createCriteria(CartProd.class);
            cri.add(Restrictions.eq("cart", cart));

            List<CartProd> cplist = cri.list();

            Transaction t = con.beginTransaction();

            hiben.Transaction trans = new hiben.Transaction();
            trans.setUser(user);
//            System.out.println(cart);
            trans.setTotItms(cart.getTotProd());
            trans.setTotAmount(cart.getTotVal());
            trans.setShipingCost(0.0);
            trans.setIsSend(0);

            con.save(trans);

            Invoice inv = new Invoice();
            inv.setTransaction(trans);
            inv.setAmount(cart.getTotVal());
            inv.setPaid(cart.getTotVal());
            Date date = new Date();
            String invoiceno = "INV-" + date.hashCode();
            inv.setInvoiceNo(invoiceno);

            con.save(inv);

            // update cart
            cart.setTotVal(0.0);
            cart.setTotProd(0);
            con.save(cart);

            for (CartProd cp : cplist) {
                if (cp.getStock().getQuentity() < cp.getQty()) {
                    cp.setQty(0);
                }

                TransProd trp = new TransProd(cp.getStock(), trans);
                trp.setItmPrice(cp.getStock().getItmPrice());
                trp.setSoldPrice(cp.getStock().getItmPrice() - cp.getStock().getDiscount());
                trp.setDiscount(cp.getStock().getDiscount());
                trp.setQty(cp.getQty());
                con.save(trp);

                // Cart Has Product isPerchase = 1
                cp.setIsPurches(1);
                con.save(cp);

                // Stock reduce.
                cp.getStock().setQuentity(cp.getStock().getQuentity() - cp.getQty());
                con.save(cp.getStock());

//                con.delete(cp);
                
            }

            t.commit();

            String msg = "Success!";
            int type = 0;
            resp.sendRedirect("client_user_orders.jsp?msg=" + msg + "&msgtype=" + type);

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(500);
        }
    }

}
