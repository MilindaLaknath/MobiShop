/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Mob;

import conn.FactoryManager;
import hiben.Stock;
import hiben.TransProd;
import java.io.DataInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Milinda
 */
public class MobLoadMonthlySales extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            PrintWriter pw = resp.getWriter();
            DataInputStream ds = new DataInputStream(req.getInputStream());
            String dfr = ds.readUTF();
            String dto = ds.readUTF();
            String cat = ds.readUTF();
            String pcd = ds.readUTF();
            ds.close();

            
            String datefrmarr[] = dfr.split(" ");
            String datetoarr[] = dto.split(" ");

            Session con = FactoryManager.getSessionFactory().openSession();

            List<Object[]> list;

            Criteria cri = con.createCriteria(TransProd.class);

            SimpleDateFormat sdf = new SimpleDateFormat("MMM/dd/yyyy");

            if (dfr != null && dto != null) {
                Criteria cri2 = cri.createCriteria("transaction");
                if (!dfr.equals("")) {
                    Date d = sdf.parse(datefrmarr[1] + "/" + datefrmarr[2] + "/" + datefrmarr[5]);
                    cri2.add(Restrictions.ge("transDate", d));
                }
                if (!dto.equals("")) {
                    Date d = sdf.parse(datetoarr[1] + "/" + datetoarr[2] + "/" + datetoarr[5]);
                    cri2.add(Restrictions.le("transDate", d));
                }
            }
            cri.setProjection(Projections.projectionList().add(Projections.groupProperty("stock")).add(Projections.count("qty")));
//                        cri.createAlias("stock", "s").add(Projections.groupProperty("s.batchid"));

            list = cri.list();
            String out = "";
            double subtot = 0.0;

            for (Object[] obj : list) {
                Stock stk = (Stock) obj[0];
                long qty = (Long) obj[1];
                if (!pcd.equals("All")) {
                    if (stk.getProducts().getProdCode().equals(pcd)) {
                        out += "Product Code : " + stk.getProducts().getProdCode();
                        out+=" ";
                        out += "Batch ID : " + stk.getBatchid();
                        out+=" ";
                        out += "Product Name : " + stk.getProducts().getBrand().getBrandName() + " " + stk.getProducts().getItmName();
                        out+=" ";
                        out += "Quantity : " + qty;
                        out+=" ";
                        out += "Price : " + stk.getItmPrice();
                        out+=" ";
                        out += "Discount : " + stk.getDiscount();
                        out+=" ";
                        out += "Total : " + (stk.getItmPrice() - stk.getDiscount()) * qty;
                        subtot +=(stk.getItmPrice() - stk.getDiscount()) * qty;
                        out+=",";
                    }
                } else if (!cat.equals("0")) {
                    if (stk.getProducts().getCategory().getIdcat().equals(Integer.parseInt(cat))) {
                        out += "Product Code : " + stk.getProducts().getProdCode();
                        out+=" ";
                        out += "Batch ID : " + stk.getBatchid();
                        out+=" ";
                        out += "Product Name : " + stk.getProducts().getBrand().getBrandName() + " " + stk.getProducts().getItmName();
                        out+=" ";
                        out += "Quantity : " + qty;
                        out+=" ";
                        out += "Price : " + stk.getItmPrice();
                        out+=" ";
                        out += "Discount : " + stk.getDiscount();
                        out+=" ";
                        out += "Total : " + (stk.getItmPrice() - stk.getDiscount()) * qty;
                        subtot +=(stk.getItmPrice() - stk.getDiscount()) * qty;
                        out+=",";
                    }
                } else {
                    out += "Product Code : " + stk.getProducts().getProdCode();
                    out+=" ";                    
                    out += "Batch ID : " + stk.getBatchid();
                    out+=" ";
                    out += "Product Name : " + stk.getProducts().getBrand().getBrandName() + " " + stk.getProducts().getItmName();
                    out+=" ";
                    out += "Quantity : " + qty;
                    out+=" ";
                    out += "Price : " + stk.getItmPrice();
                    out+=" ";
                    out += "Discount : " + stk.getDiscount();
                    out+=" ";
                    out += "Total : " + (stk.getItmPrice() - stk.getDiscount()) * qty;
                    subtot +=(stk.getItmPrice() - stk.getDiscount()) * qty;
                    out+=",";
                }
            }
            out+="Sub Total : Rs."+subtot;
            out+=",";
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
