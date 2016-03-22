/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package src;

import conn.FactoryManager;
import hiben.LoginSession;
import hiben.User;
import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
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
public class logincheck extends HttpServlet {

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
        try {
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String remember = request.getParameter("remember");

            email = email.trim();
            password = password.trim();
            if (remember != null) {
                remember = remember.trim();
            }
            password = password.hashCode() + "";

            Session con = FactoryManager.getSessionFactory().openSession();

            User u = null;

            Criteria c = con.createCriteria(User.class);
            c.add(Restrictions.eq("email", email));

            List<User> l = c.list();

            for (User l1 : l) {
                u = l1;
            }

            String msg;
            RequestDispatcher rd;

            if (u != null) {

                Transaction t = con.beginTransaction();

                LoginSession lses = new LoginSession();
                lses.setUser(u);
                lses.setIpAdd(request.getRemoteAddr());

                con.save(lses);
                t.commit();

                if (password != null && u.getPassword() != null && u.getPassword().equals(password)) {
                    switch (u.getUserType().getType()) {
                        case "Admin":
                            request.getSession().setAttribute("user", u);
                            if (remember != null && remember.equals("remember")) {
                                Cookie cook = new Cookie("uid", u.getUserId().toString());
                                cook.setMaxAge(60 * 60 * 24 * 365);
                                response.addCookie(cook);
                            }
                            response.sendRedirect("admin_ordered_items.jsp");
                            break;
                        case "Client":
                            request.getSession().setAttribute("user", u);
                            if (remember != null && remember.equals("remember")) {
                                Cookie cook = new Cookie("uid", u.getUserId().toString());
                                cook.setMaxAge(60 * 60 * 24 * 365);
                                response.addCookie(cook);
                            }
                            response.sendRedirect("client_cart.jsp");
                            break;
                        case "Deleted":
                            msg = "You Account have been Deleted !";
                            request.setAttribute("msg", msg);
                            rd = request.getRequestDispatcher("/login.jsp");
                            rd.forward(request, response);
                            break;
                        case "Banned":
                            msg = "You Account have been Banned !";
                            request.setAttribute("msg", msg);
                            rd = request.getRequestDispatcher("/login.jsp");
                            rd.forward(request, response);
                            break;
                        case "Root":
                            request.getSession().setAttribute("user", u);
                            if (remember != null && remember.equals("remember")) {
                                Cookie cook = new Cookie("uid", u.getUserId().toString());
                                cook.setMaxAge(60 * 60 * 24 * 365);
                                response.addCookie(cook);
                            }
                            response.sendRedirect("root_privilage.jsp");
                            break;
                    }
                } else {
                    // password wrong
                    msg = "You password is wrong !";
                    request.setAttribute("msg", msg);
                    rd = request.getRequestDispatcher("/login.jsp");
                    rd.forward(request, response);
                }
            } else {
                msg = "You don't have an Account !";
                request.setAttribute("msg", msg);
                rd = request.getRequestDispatcher("/login.jsp");
                rd.forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
