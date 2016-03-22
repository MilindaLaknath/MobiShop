/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Mob.Cli;

import conn.FactoryManager;
import hiben.Cart;
import hiben.CartProd;
import hiben.User;
import java.io.DataInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Milinda
 */
public class CliLoadCart extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            PrintWriter pw = resp.getWriter();
            DataInputStream ds = new DataInputStream(req.getInputStream());
            String uid = ds.readUTF();
            ds.close();

            Session con = FactoryManager.getSessionFactory().openSession();
            User u = (User) con.load(User.class, Integer.parseInt(uid));

            Criteria cri = con.createCriteria(Cart.class);
            cri.add(Restrictions.eq("user", u));

            Cart c = (Cart) cri.uniqueResult();
            
            if(c==null){
                pw.write("");
                return;
            }
            
            String out = "";

            out += "Total Products : " + c.getTotProd();
            out += ",";
            out += "Total Value : " + c.getTotVal();
            out += ",";

            for (CartProd cp : c.getCartProds()) {
                if (cp.getIsPurches().equals(0)) {
                    out += "Product Name : " + cp.getStock().getProducts().getBrand().getBrandName() + " " + cp.getStock().getProducts().getItmName();
                    out += ",";
                    out += "Quantity : " + cp.getQty()+"/"+cp.getStock().getQuentity();
                    out += ",";
                    out += "Amount : " + (cp.getStock().getItmPrice() - cp.getStock().getDiscount()) * cp.getQty();
                    out += ",";
                }
            }

            pw.print(out);
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
@Override
    protected void doHead(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.getWriter().print("");
    }
}
