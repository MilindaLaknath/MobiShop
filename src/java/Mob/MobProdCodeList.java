/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Mob;

import conn.FactoryManager;
import hiben.Products;
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

/**
 *
 * @author Milinda
 */
public class MobProdCodeList extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            PrintWriter pw = resp.getWriter();
            
            Session con = FactoryManager.getSessionFactory().openSession();
            Criteria cri = con.createCriteria(Products.class);
            cri.addOrder(Order.asc("prodCode"));
            
            List<Products> list = cri.list();
            
            String out = "";
            
            for (Products ll : list) {
                out+=ll.getProdCode();
                out+=",";
            }
            
            pw.print(out);
            
        } catch (Exception e) {
        }
    }
    @Override
    protected void doHead(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.getWriter().print("");
    }
}
