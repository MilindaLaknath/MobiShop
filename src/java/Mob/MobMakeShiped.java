/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Mob;

import conn.FactoryManager;
import hiben.Invoice;
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
public class MobMakeShiped extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            PrintWriter pw = resp.getWriter();
            
            DataInputStream ds = new DataInputStream(req.getInputStream());
            String data = ds.readUTF();
            String arr[]=data.split(" ");
            String invid = arr[2];
            
            Session con = FactoryManager.getSessionFactory().openSession();
            Criteria c = con.createCriteria(Invoice.class);
            c.add(Restrictions.eq("invoiceNo", invid));
            
            Invoice iv = (Invoice) c.uniqueResult();
            
            if(iv==null){
                pw.print("1");
            }
            
            Transaction t = con.beginTransaction();
            
            hiben.Transaction trans = iv.getTransaction();
            
            trans.setIsSend(1);
            
            con.save(trans);
            t.commit();
            
            pw.print("0");
            
            
        } catch (Exception e) {
        }
    }
    @Override
    protected void doHead(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.getWriter().print("");
    }
}