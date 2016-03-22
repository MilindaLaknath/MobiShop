/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Mob;

import conn.FactoryManager;
import hiben.User;
import hiben.UserType;
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
public class MobChangeUserType extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (PrintWriter out = resp.getWriter()) {
            DataInputStream da = new DataInputStream(req.getInputStream());
            String email = da.readUTF(); //readLine();
            String utype = da.readUTF(); //readLine();
            da.close();

            Session con = FactoryManager.getSessionFactory().openSession();
            Criteria cri = con.createCriteria(User.class);

            if (email.equals("")) {
                out.print("1");
                return;
            }
            if(utype.equals("0")){
                out.print("2");
                return;
            }
            cri.add(Restrictions.eq("email", email));
            
            User u = (User) cri.uniqueResult();
            if(u == null){
                out.print("3");
                return;
            }
            if(u.getUserType().getType().equals("Root")){
                out.print("4");
                return;
            }
            
            Transaction t = con.beginTransaction();
            
            UserType ut = (UserType) con.load(UserType.class, Integer.parseInt(utype));
            u.setUserType(ut);
            con.save(u);
            t.commit();
            out.print("0");
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doHead(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.getWriter().print("");
    }
    
}
