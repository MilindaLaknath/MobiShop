/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package src;

import com.src.EmailSessionBean;
import com.src.RandomString;
import conn.FactoryManager;
import hiben.User;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
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
public class resetPass extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String email = req.getParameter("email");
            
            User u = null;
            u = (User) req.getSession().getAttribute("user");
            if (u != null) {
                resp.sendRedirect("index.jsp");
                return;
            }
            
            Session con = FactoryManager.getSessionFactory().openSession();
            Transaction t = con.beginTransaction();
            Criteria cri = con.createCriteria(User.class);
            cri.add(Restrictions.eq("email", email));
            
            if(cri.list().size()>0){
                u = (User) cri.list().get(0);
                
                String pass = RandomString.randomString(8);
                
                u.setPassword(pass.hashCode()+"");
                con.save(u);                
                t.commit();
                
                EmailSessionBean sesemail = new EmailSessionBean();
                sesemail.sendEmail(email, "Reset Password", "New Password is "+pass);
                
                resp.sendRedirect("index.jsp");
                return;
                
            }else{
            String msg = "You don't have an Account !";
                req.setAttribute("msg", msg);
                RequestDispatcher rd = req.getRequestDispatcher("/login.jsp");
                rd.forward(req, resp);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(500);
        }
    }
    
}