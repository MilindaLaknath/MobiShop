/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Mob;

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
public class MobLoadInvoData extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            PrintWriter pw = resp.getWriter();
            
            DataInputStream ds = new DataInputStream(req.getInputStream());
            String data = ds.readUTF();
            
            String arr[] = data.split(" ");
            String arr2[] = arr[0].split(":");
            
            Session con = FactoryManager.getSessionFactory().openSession();
            Criteria cri = con.createCriteria(Invoice.class);
            cri.add(Restrictions.eq("invoiceNo", arr2[1]));
            
            Invoice inv = (Invoice) cri.uniqueResult();
            
            String out = "";
            
            out+="Invoice : "+inv.getInvoiceNo();
            out+=",";
            out+="Name : "+inv.getTransaction().getUser().getPersonalDetails().getFName()+" "+inv.getTransaction().getUser().getPersonalDetails().getLName();
            out+=",";
            out+="Contact : "+inv.getTransaction().getUser().getPersonalDetails().getPhone();
            out+=",";
            out+="Date : "+inv.getInvoiceDate();
            out+=",";
            out+="Address : "+inv.getTransaction().getUser().getPersonalDetails().getAddress().getAddl1()+" ";
            out+=inv.getTransaction().getUser().getPersonalDetails().getAddress().getAddl2()+" ";
            out+=inv.getTransaction().getUser().getPersonalDetails().getAddress().getCity()+" ";
            out+=",";
            for (TransProd tp : inv.getTransaction().getTransProds()) {
                out+="ProductCode : "+tp.getStock().getProducts().getProdCode();
                out+=" ";
                out+="ProductName : "+tp.getStock().getProducts().getBrand().getBrandName()+" "+tp.getStock().getProducts().getItmName();
                out+=" ";
                out+="Color : "+tp.getStock().getColor();
                out+=" ";
                out+="Storage : "+tp.getStock().getStorage()+"GB";
                out+=" ";
                out+="Quantity : "+tp.getQty();
                out+=" ";
                out+="Price : "+tp.getItmPrice();
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