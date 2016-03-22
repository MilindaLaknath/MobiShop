/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Mob;

import conn.FactoryManager;
import hiben.Invoice;
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
public class MobLoadOrders extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            PrintWriter pw = resp.getWriter();
            
            Session con = FactoryManager.getSessionFactory().openSession();
            Criteria cri = con.createCriteria(Invoice.class);
            Criteria c2 = cri.createCriteria("transaction");
            c2.add(Restrictions.eq("isSend", 0));
            
            List<Invoice> list = cri.list();
            
            String out="";
            
            for (Invoice ll : list) {
                out+="Invoice:"+ll.getInvoiceNo();
                out+=" ";
                out+="Items:"+ll.getTransaction().getTotItms();
                out+=" ";
                out+="Amount:"+ll.getPaid();
                out+=" ";
                out+="Date:"+ll.getInvoiceDate();
                out+=",";
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
    