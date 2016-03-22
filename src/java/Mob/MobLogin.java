/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Mob;

import conn.FactoryManager;
import hiben.LoginSession;
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
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Milinda
 */
public class MobLogin extends HttpServlet {

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */

            DataInputStream da = new DataInputStream(request.getInputStream());
            String email = da.readUTF(); //readLine();
            String password = da.readUTF(); //readLine();
            da.close();
            System.out.println(email);  // email
            System.out.println(password);  // password

            password = password.hashCode() + "";

            Session con = FactoryManager.getSessionFactory().openSession();

            User u = null;

            Criteria c = con.createCriteria(User.class);
            c.add(Restrictions.eq("email", email));

            List<User> l = c.list();

            for (User l1 : l) {
                u = l1;
            }

            String msg = "";

            if (u != null) {

                Transaction t = con.beginTransaction();

                LoginSession lses = new LoginSession();
                lses.setUser(u);
                lses.setIpAdd(request.getRemoteAddr());

                con.save(lses);
                t.commit();
            }
            
            if (password != null && u.getPassword() != null && u.getPassword().equals(password)) {
                switch (u.getUserType().getType()) {
                        case "Admin": 
                            msg = u.getUserId().toString();
                            break;
                        case "Client":
                            msg = "c";
                            break;
                        case "Deleted":
                            msg = "d";
                            break;
                        case "Banned":
                            msg = "b";
                            break;
                        case "Root":      
                            msg = u.getUserId().toString();
                            break;
                }
            }
            
            System.out.println(msg);
            out.write(msg);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
@Override
    protected void doHead(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.getWriter().print("");
    }
}
