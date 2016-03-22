/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Mob;

import conn.FactoryManager;
import hiben.Brand;
import java.io.DataInput;
import java.io.DataInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.HEAD;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Milinda
 */
public class MobAddBrand extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            DataInputStream ds = new DataInputStream(req.getInputStream());
            String bname = ds.readUTF();

            ds.close();

            if (bname.equals("")) {
                resp.getWriter().print("1");
                return;
            }

            Session con = FactoryManager.getSessionFactory().openSession();

            Criteria c = con.createCriteria(Brand.class);

            List<Brand> l = c.list();

            for (Brand l1 : l) {
                if (l1.getBrandName().equals(bname)) {
                    resp.getWriter().print("1");
                    return;
                }
            }

            Transaction t = con.beginTransaction();

            Brand b = new Brand();
            b.setBrandName(bname);

            con.save(b);
            t.commit();
            resp.getWriter().print("0");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doHead(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.getWriter().print("");
    }

    
}
