/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package src;

import conn.FactoryManager;
import hiben.Products;
import hiben.User;
import java.io.File;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Milinda
 */
public class addImage extends HttpServlet {

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

            String pid = "";
            String pcode = "";
            String imgpath = "";

            FileItemFactory factory = new DiskFileItemFactory();

            ServletFileUpload upload = new ServletFileUpload(factory);

            List<Object> items = upload.parseRequest(req);

            for (Object element : items) {
                FileItem fileitem = (FileItem) element;
                if (fileitem.isFormField()) {
                    if (fileitem.getFieldName().equals("pid")) {      //getFieldName()  -  FIELD eke variable name(HTML) eka   
                        pid = fileitem.getString();          // getString()  -  FIELD eke value eka.
                    }
                    if (fileitem.getFieldName().equals("pcode")) {
                        pcode = fileitem.getString();
                    }
                } else {
                    imgpath = "partials/assets/img/gallery/" + System.currentTimeMillis() + fileitem.getName();
//                    File savedFile = new File("http://localhost:8080/MobiShop/" + imgpath);                   
                    File savedFile = new File(req.getServletContext().getRealPath("/") + imgpath);
//                    System.out.println(req.getServletContext().getRealPath("/"));
                    fileitem.write(savedFile);
                }
            }

            Session con = FactoryManager.getSessionFactory().openSession();
            Transaction t = con.beginTransaction();
            Products p;
            if (!pid.equals("") && !imgpath.equals("")) {
                p = (Products) con.load(Products.class, Integer.parseInt(pid));
            } else if (!pcode.equals("") && !imgpath.equals("")) {
                Criteria cri = con.createCriteria(Products.class);
                cri.add(Restrictions.eq("prodCode", pcode));
                p = (Products) cri.list().get(0);
            } else {
                String msg = "Something wrong with your inputs!";
                int type = 1;
                resp.sendRedirect("admin_edit_items.jsp?msg=" + msg + "&msgtype=" + type);
                return;
            }

            p.setImgUrl(imgpath);
            con.save(p);
            t.commit();

            String msg = "Success!";
            int type = 0;
            resp.sendRedirect("admin_edit_items.jsp?msg=" + msg + "&msgtype=" + type);

        } catch (Exception e) {
//            resp.getWriter().write(e.toString());
            e.printStackTrace();
            resp.sendError(500);
        }
    }

}
