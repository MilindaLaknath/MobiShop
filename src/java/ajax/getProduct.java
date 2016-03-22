/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ajax;

import conn.FactoryManager;
import hiben.Products;
import java.io.IOException;
import java.io.PrintWriter;
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
public class getProduct extends HttpServlet {

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        try (PrintWriter out = response.getWriter()) {
//            String pcode = request.getParameter("pcode");
//            if (pcode != null && pcode.equals("")) {
//                Session con = FactoryManager.getSessionFactory().openSession();
//                Criteria cri = con.createCriteria(Products.class);
//                cri.add(Restrictions.eq("prodCode", pcode));
//                Products p = (Products) cri.list().get(0);
//
//                String resptext = p.getItmCode() + "," + p.getBrand().getBrandName() + "," + p.getCategory().getCatName();
//                out.write(resptext);
////                System.out.println(resptext);
//            }
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (PrintWriter out = resp.getWriter()) {
            String pcode = req.getParameter("pcode");
            if (pcode != null && !pcode.equals("")) {
                Session con = FactoryManager.getSessionFactory().openSession();
                Criteria cri = con.createCriteria(Products.class);
                cri.add(Restrictions.eq("prodCode", pcode));
                Products p = (Products) cri.list().get(0);

                String resptext = p.getItmCode() + "-" +p.getItmName() + "-" + p.getBrand().getBrandName() + "-" + p.getCategory().getCatName();
                out.write(resptext);
            }else{
                out.write("0");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
