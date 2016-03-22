/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Mob;

import conn.FactoryManager;
import hiben.Products;
import java.io.DataInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;

/**
 *
 * @author Milinda
 */
public class MobLoadProdData extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (PrintWriter pr = resp.getWriter()) {
            DataInputStream ds = new DataInputStream(req.getInputStream());
            String data = ds.readUTF();

            String arr[] = data.split(" ");

            if (arr.length > 0) {
                Session con = FactoryManager.getSessionFactory().openSession();
                Products p = (Products) con.load(Products.class, Integer.parseInt(arr[0]));
                
                String output = "";
                output+=p.getProdCode();
                output+=",";
                output+=p.getItmName();
                output+=",";
                output+=p.getBrand().getBrandName();
                output+=",";
                output+=p.getCategory().getCatName();
                output+=",";
                
                pr.print(output);
                
            }else{
                pr.print("");
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
