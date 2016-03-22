/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Mob.Cli;

import com.src.EmailSessionBean;
import com.src.RandomString;
import conn.FactoryManager;
import hiben.User;
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
public class CliPwReset extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (PrintWriter out = resp.getWriter()) {
            DataInputStream da = new DataInputStream(req.getInputStream());
            String email = da.readUTF(); //readLine();
            da.close();
//            System.out.println(email);  // email

            Session con = FactoryManager.getSessionFactory().openSession();
            Transaction t = con.beginTransaction();
            Criteria cri = con.createCriteria(User.class);
            cri.add(Restrictions.eq("email", email));

            User u = null;
            
            if (cri.list().size() > 0) {
                u = (User) cri.list().get(0);

                String pass = RandomString.randomString(8);

                u.setPassword(pass.hashCode() + "");
                con.save(u);
                t.commit();

                EmailSessionBean sesemail = new EmailSessionBean();
                sesemail.sendEmail(email, "Reset Password", "New Password is " + pass);

                out.print("0");                
            } else {
                out.print("1");
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
