/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Mob;

import conn.FactoryManager;
import hiben.Brand;
import hiben.Category;
import hiben.Stock;
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
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Milinda
 */
public class MobLoadStock extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (PrintWriter pr = resp.getWriter()){
            DataInputStream da = new DataInputStream(req.getInputStream());
            String strbrd = da.readUTF();
            String strcat = da.readUTF();
            String strpcode = da.readUTF();
            
            Session con = FactoryManager.getSessionFactory().openSession();
            Criteria cri = con.createCriteria(Stock.class);
            
            if(!strpcode.equals("")){                
                Criteria cri2 = cri.createCriteria("products");
                cri2.add(Restrictions.eq("prodCode", strpcode));
            }
            if(!strbrd.equals("0")){
                Brand b = (Brand) con.load(Brand.class, Integer.parseInt(strbrd));
                Criteria cri2 = cri.createCriteria("products");
                cri2.add(Restrictions.eq("brand", b));
            }
            if(!strcat.equals("0")){
                Category c = (Category) con.load(Category.class, Integer.parseInt(strcat));
                Criteria cri2 = cri.createCriteria("products");
                cri2.add(Restrictions.eq("category", c));
            }    
            cri.addOrder(Order.asc("products"));
            
            List<Stock> list = cri.list();
            String output = "";
            
            for (Stock ll : list) {
                 output+="Batch:"+ll.getBatchid();
                 output+=" ";
                 output+="Code:"+ll.getProducts().getProdCode();
                 output+=" ";
                 output+=ll.getProducts().getBrand().getBrandName()+" "+ll.getProducts().getItmName();
                 output+=" ";
                 output+="Rs."+ll.getItmPrice();
                 output+=" ";
                 output+="Qty:"+ll.getQuentity();
                 output+=" ";
                 output+=ll.getColor()+" "+ll.getStorage()+"GB";
                 output+=",";
            }
            
            pr.print(output);
            
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    @Override
    protected void doHead(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.getWriter().print("");
    }
}
