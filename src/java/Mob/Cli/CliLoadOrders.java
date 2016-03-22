/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Mob.Cli;

import conn.FactoryManager;
import hiben.Invoice;
import hiben.User;
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
public class CliLoadOrders extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            PrintWriter pw = resp.getWriter();
            DataInputStream ds = new DataInputStream(req.getInputStream());
            String uid = ds.readUTF();
            String index = ds.readUTF();
            ds.close();

            Session con = FactoryManager.getSessionFactory().openSession();
            User u = (User) con.load(User.class, Integer.parseInt(uid));

            Criteria cri = con.createCriteria(Invoice.class);
            Criteria cri2 = cri.createCriteria("transaction");
            cri2.add(Restrictions.eq("user", u));
            int x = Integer.parseInt(index);
            if (x != 2) {
                cri2.add(Restrictions.eq("isSend", x));
//                System.out.println(x);
            }

            List<Invoice> list = cri.list();
            String out = "";
            for (Invoice in : list) {
                out += "Invoice No : " + in.getInvoiceNo();
                out += " ";
                out += "Invoice Date : " + in.getInvoiceDate().toString();
                out += " ";
                out += "Quantity : " + in.getTransaction().getTotItms();
                out += " ";
                out += "Paid : " + in.getPaid();
                out += ",";
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
