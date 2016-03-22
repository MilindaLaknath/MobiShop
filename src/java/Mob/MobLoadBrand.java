/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Mob;

import conn.FactoryManager;
import hiben.Brand;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;

/**
 *
 * @author Milinda
 */
public class MobLoadBrand extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (PrintWriter pr = resp.getWriter()){
            Session con = FactoryManager.getSessionFactory().openSession();
            Criteria cri = con.createCriteria(Brand.class);
            List<Brand> list = cri.list();
            
            String output = "";
            for (Brand ll : list) {
                output+=ll.getBrandName();
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