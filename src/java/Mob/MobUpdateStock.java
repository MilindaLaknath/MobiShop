/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Mob;

import conn.FactoryManager;
import hiben.Products;
import hiben.Stock;
import java.io.DataInputStream;
import java.io.IOException;
import java.io.PrintWriter;
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
public class MobUpdateStock extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (PrintWriter pr = resp.getWriter()){
            DataInputStream ds = new DataInputStream(req.getInputStream());
            String pcode = ds.readUTF();
            String price = ds.readUTF();
            String qty = ds.readUTF();
            String color = ds.readUTF();
            String storage = ds.readUTF();
            ds.close();
            
            if(pcode.equals("")||price.equals("")||qty.equals("")||color.equals("")||storage.equals("")){
                pr.print("1");
                return;
            }
            
            double dp = Double.parseDouble(price);
            int iq = Integer.parseInt(qty);
            int is = Integer.parseInt(storage);
            
            if(dp<1||iq<1||is<1){
                pr.print("1");
                return;
            }
            
            Session con = FactoryManager.getSessionFactory().openSession();
            Transaction t = con.beginTransaction();
            
            Stock st = new Stock();
            
            Criteria cri = con.createCriteria(Products.class);
            cri.add(Restrictions.eq("prodCode", pcode));
            Products p = (Products) cri.uniqueResult();
            
            st.setProducts(p);
            st.setItmPrice(dp);
            st.setQuentity(iq);
            st.setDiscount(0.0);
            st.setColor(color);
            st.setStorage(is);
            
            con.save(st);
            t.commit();
            
            pr.print("0");
            
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    @Override
    protected void doHead(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.getWriter().print("");
    }
}