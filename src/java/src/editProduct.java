/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package src;

import conn.FactoryManager;
import hiben.Brand;
import hiben.Category;
import hiben.ProdHasProp;
import hiben.Products;
import hiben.User;
import java.io.IOException;
import java.util.Set;
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
public class editProduct extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {

            User user = (User) req.getSession().getAttribute("user");

            if (user == null) {
                resp.sendRedirect("login.jsp");
                return;
            }
            if (user.getUserType().getType().equals("Admin") || user.getUserType().getType().equals("Root")) {
            } else {
                resp.sendRedirect("login.jsp");
                return;
            }

            String strid = req.getParameter("pid");
            String strpcode = req.getParameter("pcode");
            String strname = req.getParameter("name");
            String strbrand = req.getParameter("bid");
            String strcat = req.getParameter("catid");
            String strreorder = req.getParameter("reorder_level");

            if (!strid.equals("") && !strpcode.equals("") && !strname.equals("") && !strbrand.equals("") && !strcat.equals("") && !strreorder.equals("")) {

                Session con = FactoryManager.getSessionFactory().openSession();

                Products p = (Products) con.load(Products.class, Integer.parseInt(strid));
                p.setProdCode(strpcode);
                p.setItmName(strname);

                Brand b = (Brand) con.load(Brand.class, Integer.parseInt(strbrand));
                Category c = (Category) con.load(Category.class, Integer.parseInt(strcat));

                p.setBrand(b);
                p.setCategory(c);

                p.setReorderLevel(Integer.parseInt(strreorder));
                p.setActive(0);

                Transaction t = con.beginTransaction();
                con.save(p);

//                Criteria cri = con.createCriteria(ProdProperty.class);
//
//                List<ProdProperty> pplisr = cri.list();
                Set<ProdHasProp> prodHasProps = p.getProdHasProps();

                for (ProdHasProp phpone : prodHasProps) {
                    String tmp = req.getParameter(phpone.getProdProperty().getIdprodProperty().toString());
                    phpone.setValue(tmp);
                    con.save(phpone);
                }

                t.commit();

                String msg = "Success!";
                int type = 0;
                resp.sendRedirect("admin_edit_items.jsp?msg=" + msg + "&msgtype=" + type);

            } else {
                String msg = "Something wrong with your inputs!";
                int type = 1;
                resp.sendRedirect("admin_edit_items.jsp?msg=" + msg + "&msgtype=" + type);
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(500);
        }
    }

}
