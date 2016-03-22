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
import hiben.ProdProperty;
import hiben.Products;
import hiben.User;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Milinda
 */
public class addProduct extends HttpServlet {

//    @Override
//    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        resp.getWriter().write("LOL GET");
//        try {
////            String strid = req.getParameter("pid");
//            String strpcode = req.getParameter("pcode");
//            String strname = req.getParameter("name");
//            String strbrand = req.getParameter("bid");
//            String strcat = req.getParameter("catid");
//            String strreorder = req.getParameter("reorder_level");
//
//            if (strpcode != null && strname != null && strbrand != null && strcat != null && strreorder != null) {
//            } else {
////                resp.sendRedirect("admin_edit_items.jsp");
//                resp.getWriter().write("\nLOL");
//                resp.getWriter().write(strpcode+"");
//                resp.getWriter().write(strname+"");
//                resp.getWriter().write(strbrand+"");
//                resp.getWriter().write(strcat+"");
//                resp.getWriter().write(strreorder+"");
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }
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

//            String strid = req.getParameter("pid");
            String strpcode = req.getParameter("pcode");
            String strname = req.getParameter("name");
            String strbrand = req.getParameter("bid");
            String strcat = req.getParameter("catid");
            String strreorder = req.getParameter("reorder_level");

            if (strpcode != null && strname != null && strbrand != null && strcat != null && strreorder != null) {
//            if (!strpcode.equals("") && !strname.equals("") && !strbrand.equals("") && !strcat.equals("") && !strreorder.equals("")) {

                Session con = FactoryManager.getSessionFactory().openSession();

                Products p = new Products();
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

                Criteria cri = con.createCriteria(ProdProperty.class);

                List<ProdProperty> pplisr = cri.list();

                for (ProdProperty pplisr1 : pplisr) {
                    String tmp = req.getParameter(pplisr1.getIdprodProperty().toString());
                    ProdHasProp php = new ProdHasProp(pplisr1, p, tmp);
                    con.save(php);

                }

                t.commit();

                String msg = "Success!";
                int type = 0;
                resp.sendRedirect("admin_edit_items.jsp?msg=" + msg + "&msgtype=" + type);

            } else {
//                resp.sendRedirect("admin_edit_items.jsp");
//                resp.getWriter().write("LOL");
//                resp.getWriter().write(strpcode);
//                resp.getWriter().write(strname);
//                resp.getWriter().write(strbrand);
//                resp.getWriter().write(strcat);
//                resp.getWriter().write(strreorder);
                String msg = "Something wrong with your inputs!";
                int type = 1;
                resp.sendRedirect("admin_edit_items.jsp?msg=" + msg + "&msgtype=" + type);
            }
        } catch (Exception e) {
//            resp.getWriter().print(e.toString());
            e.printStackTrace();
            resp.sendError(500);
        }
    }

}
