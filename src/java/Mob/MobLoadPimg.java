/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Mob;

import conn.FactoryManager;
import hiben.Products;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.DataInputStream;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;

/**
 *
 * @author Milinda
 */
public class MobLoadPimg extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            PrintWriter pw = resp.getWriter();
            Session con = FactoryManager.getSessionFactory().openSession();
            Products p = (Products) con.load(Products.class, Integer.parseInt("1"));

            File f = new File(req.getServletContext().getRealPath("/") + p.getImgUrl());
            if (f.exists()) {
                pw.print(f.getCanonicalFile());
            } else {
//                pw.write(req.getServletContext().getRealPath("/") + p.getImgUrl());
            }
        } catch (Exception e) {
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (PrintWriter pw = resp.getWriter()) {

            DataInputStream ds = new DataInputStream(req.getInputStream());
            String data = ds.readUTF();

            String arr[] = data.split(" ");
            if (arr.length > 0) {
                Session con = FactoryManager.getSessionFactory().openSession();
                Products p = (Products) con.load(Products.class, Integer.parseInt(arr[0]));

                File f = new File(req.getServletContext().getRealPath("/") + p.getImgUrl());

                BufferedImage bi = ImageIO.read(f);
                ByteArrayOutputStream bout = new ByteArrayOutputStream();
                ImageIO.write(bi, "PNG", bout);
                byte imgbr[] = bout.toByteArray();
                String s = "";
                for (int i = 0; i < arr.length; i++) {                    
                        s +=arr[i];                    
                        s += ",";                    
                }
                pw.print(s);

            } else {
                pw.print("");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
@Override
    protected void doHead(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.getWriter().print("");
    }
}
