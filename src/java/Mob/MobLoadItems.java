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
import java.util.List;
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
public class MobLoadItems extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (PrintWriter pr = resp.getWriter()){
            DataInputStream ds = new DataInputStream(req.getInputStream());
            String strcat = ds.readUTF();
            String strbrd = ds.readUTF();
            
            Session con = FactoryManager.getSessionFactory().openSession();
            Criteria cri = con.createCriteria(Products.class);
            
            if(!strcat.equals("0")){
                Category c = (Category) con.load(Category.class, Integer.parseInt(strcat));
                cri.add(Restrictions.eq("category", c));
            }
            if(!strbrd.equals("0")){
                Brand b = (Brand) con.load(Brand.class, Integer.parseInt(strbrd));
                cri.add(Restrictions.eq("brand", b));
            }
            
            List<Products> list = cri.list();
            String out = "";
            
            for (Products ll : list) {
                out+=ll.getItmCode()+"";
                out+=" ";
                out+="Code:"+ll.getProdCode();
                out+=" ";
                out+=ll.getBrand().getBrandName()+" "+ll.getItmName();
                out+=" ";
                out+="Reorder:"+ll.getReorderLevel()+"";
                out+=",";
            }
            
            pr.print(out);
            
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    @Override
    protected void doHead(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.getWriter().print("");
    }
}