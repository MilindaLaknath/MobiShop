/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Mob;

import conn.FactoryManager;
import hiben.Brand;
import hiben.Category;
import hiben.Products;
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
public class MobAddItem extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            PrintWriter pw = resp.getWriter();

            DataInputStream ds = new DataInputStream(req.getInputStream());
            String pcode = ds.readUTF();
            String pname = ds.readUTF();
            String reodlv = ds.readUTF();
            String bid = ds.readUTF();
            String catid = ds.readUTF();

            if (reodlv.equals("")) {
                pw.print("1");
                return;
            }
            if (Integer.parseInt(reodlv) < 0) {
                reodlv = "0";
            }
            if (Integer.parseInt(bid) == 0) {
                pw.print("1");
                return;
            }
            if (Integer.parseInt(catid) == 0) {
                pw.print("1");
                return;
            }
            

            Session con = FactoryManager.getSessionFactory().openSession();
            Criteria cri = con.createCriteria(Products.class);
            cri.add(Restrictions.eq("prodCode", pcode));

            Products p = (Products) cri.uniqueResult();

            Transaction t = con.beginTransaction();

            if (p == null) {
                p = new Products();
                p.setProdCode(pcode);
                p.setItmName(pname);
                p.setReorderLevel(Integer.parseInt(reodlv));
                Brand b = (Brand) con.load(Brand.class, Integer.parseInt(bid));
                Category c = (Category) con.load(Category.class, Integer.parseInt(catid));
                p.setBrand(b);
                p.setCategory(c);
                
                con.save(p);
                t.commit();
                
                pw.print("0");
            } else {
                p.setItmName(pname);
                p.setReorderLevel(Integer.parseInt(reodlv));
                Brand b = (Brand) con.load(Brand.class, Integer.parseInt(bid));
                Category c = (Category) con.load(Category.class, Integer.parseInt(catid));
                p.setBrand(b);
                p.setCategory(c);
                
                con.save(p);
                t.commit();
                
                pw.print("2");
            }
          
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    
    @Override
    protected void doHead(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.getWriter().print("");
    }
}
