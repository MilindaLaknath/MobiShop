/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Mob.Cli;

import conn.FactoryManager;
import hiben.Address;
import hiben.PersonalDetails;
import hiben.User;
import java.io.DataInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Milinda
 */
public class CliUpdateUser extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            PrintWriter pw = resp.getWriter();
            DataInputStream ds = new DataInputStream(req.getInputStream());
            String uid = ds.readUTF();
            String newp = ds.readUTF();
            String fn = ds.readUTF();
            String ln = ds.readUTF();
            String mob = ds.readUTF();
            String ad1 = ds.readUTF();
            String ad2 = ds.readUTF();
            String ct = ds.readUTF();
            String pc = ds.readUTF();

            ds.close();

            Session con = FactoryManager.getSessionFactory().openSession();
            Transaction t = con.beginTransaction();

            User u = (User) con.load(User.class, Integer.parseInt(uid));
            PersonalDetails pdet = u.getPersonalDetails();
            Address a = pdet.getAddress();

            a.setAddl1(ad1);
            a.setAddl2(ad2);
            a.setCity(ct);
            a.setPostCode(Integer.parseInt(pc));

            con.save(a);

            pdet.setFName(fn);
            pdet.setLName(ln);
            pdet.setPhone(mob);

            con.save(pdet);

            if (!newp.equals("")) {
                u.setPassword(newp.hashCode() + "");
                con.save(u);
            }
            t.commit();

            pw.print("0");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doHead(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.getWriter().print("");
    }
}
