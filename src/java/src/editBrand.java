/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package src;

import conn.FactoryManager;
import hiben.Brand;
import hiben.User;
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
public class editBrand extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */

            User user = (User) request.getSession().getAttribute("user");

            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }
            if (user.getUserType().getType().equals("Admin") || user.getUserType().getType().equals("Root")) {
            } else {
                response.sendRedirect("login.jsp");
                return;
            }

            String id = request.getParameter("id");
            String name = request.getParameter("name");

//            out.print(id);
//            out.print(name);
            Session con = FactoryManager.getSessionFactory().openSession();

            if (id != null && !id.equals("")) {
                Brand b = (Brand) con.load(Brand.class, Integer.parseInt(id));
                out.print(b.getBrandName());

                Transaction t = con.beginTransaction();

                b.setBrandName(name);

                con.save(b);

                t.commit();
                String msg = "Success!";
                int type = 0;
                response.sendRedirect("admin_brand.jsp?msg=" + msg + "&msgtype=" + type);
            } else {
                String msg = "Something wrong with your inputs!";
                int type = 1;
                response.sendRedirect("admin_brand.jsp?msg=" + msg + "&msgtype=" + type);
            }

        } catch (Exception e) {
//            response.getWriter().print(e.toString());
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
