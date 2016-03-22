/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Mob.Cli;

import conn.FactoryManager;
import hiben.User;
import java.io.DataInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;

/**
 *
 * @author Milinda
 */
public class CliLoadUserData extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            PrintWriter pw = new PrintWriter(resp.getWriter());
            DataInputStream ds = new DataInputStream(req.getInputStream());
            String uid = ds.readUTF();
            
            ds.close();
            
            Session con = FactoryManager.getSessionFactory().openSession();
            User u = (User) con.load(User.class, Integer.parseInt(uid));
            
            if(u == null){
                pw.print("");
                return;
            }
            
            String out = "";
            
            out+= u.getEmail();
            out+= ",";
            out+= u.getPassword();
            out+= ",";
            out+= u.getPersonalDetails().getFName();
            out+= ",";
            out+= u.getPersonalDetails().getLName();
            out+= ",";
            out+= u.getPersonalDetails().getPhone();
            out+= ",";
            out+= u.getPersonalDetails().getAddress().getAddl1();
            out+= ",";
            out+= u.getPersonalDetails().getAddress().getAddl2();
            out+= ",";
            out+= u.getPersonalDetails().getAddress().getCity();
            out+= ",";
            out+= u.getPersonalDetails().getAddress().getPostCode();
            out+= ",";
            
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