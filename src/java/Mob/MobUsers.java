/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Mob;

import conn.FactoryManager;
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
public class MobUsers extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (PrintWriter out = resp.getWriter()) {
            DataInputStream da = new DataInputStream(req.getInputStream());
            String email = da.readUTF(); //readLine();
            String utype = da.readUTF(); //readLine();
            da.close();

            Session con = FactoryManager.getSessionFactory().openSession();
            Criteria cri = con.createCriteria(User.class);

            List<User> list;
            String output = "";
            if (!email.equals("")) {
                cri.add(Restrictions.eq("email", email));
            }

            list = cri.list();
            for (User u : list) {
                if (utype.equals("0")) {
                    if (!u.getUserType().getType().equals("Root")) {
                        output += u.getEmail();
                        output += " ";
                        output += u.getPersonalDetails().getFName() + " " + u.getPersonalDetails().getLName();
                        output += " ";
                        output += u.getPersonalDetails().getPhone();
                        output += " ";
                        output += u.getPersonalDetails().getAddress().getCity();
                        output += " ";
                        output += u.getUserType().getType();
                        output += ",";
                    }
                } else {
                    if (u.getUserType().getGuestId().equals(Integer.parseInt(utype))) {
                        output += u.getEmail();
                        output += " ";
                        output += u.getPersonalDetails().getFName() + " " + u.getPersonalDetails().getLName();
                        output += " ";
                        output += u.getPersonalDetails().getPhone();
                        output += " ";
                        output += u.getPersonalDetails().getAddress().getCity();
                        output += " ";
                        output += u.getUserType().getType();
                        output += ",";
                    }
                }
            }
            out.print(output);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doHead(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.getWriter().print("");
    }
}
