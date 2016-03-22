/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Mob.Cli;

import conn.FactoryManager;
import hiben.Invoice;
import hiben.TransProd;
import java.io.DataInputStream;
import java.io.IOException;
import java.io.PrintWriter;
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
public class CliLoadTransaction extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            PrintWriter pw = resp.getWriter();
            DataInputStream ds = new DataInputStream(req.getInputStream());
            String invid = ds.readUTF();
            ds.close();

            System.out.println(invid);
            String arr[] = invid.split(" ");

            Session con = FactoryManager.getSessionFactory().openSession();
            Criteria cri = con.createCriteria(Invoice.class);
            cri.add(Restrictions.eq("invoiceNo", arr[3]));

            Invoice in = (Invoice) cri.uniqueResult();

            if (in == null) {
                pw.write("");
                return;
            }
            String out = "";

            out += "Invoice No : " + in.getInvoiceNo();
            out += ",";
            out += "Invoice Date : " + in.getInvoiceDate().toString();
            out += ",";
            out += "Paid : " + in.getPaid();
            out += ",";

            for (TransProd tp : in.getTransaction().getTransProds()) {
                out += "Product Name : " + tp.getStock().getProducts().getBrand().getBrandName() + " " + tp.getStock().getProducts().getItmName();
                out += ",";
                out += "Quantity : " + tp.getQty();
                out += ",";
                out += "Amount : " + (tp.getSoldPrice()) * tp.getQty();
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
