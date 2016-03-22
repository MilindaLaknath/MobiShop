/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package src;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Milinda
 */
public class logout extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try{
        req.getSession().invalidate();
        resp.setHeader("Cache-Control", "no-cache");
        resp.setHeader("Cache-Control", "no-store");
        resp.setHeader("Pragma", "no-cache");
        resp.setDateHeader("Expires", 0);

        //delete Cookies
        Cookie[] cookies = req.getCookies();

        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("uid")) {
                    cookie.setValue("");
                    cookie.setMaxAge(0);
//                    cookie.setPath("/");
                    resp.addCookie(cookie);
                    resp.sendRedirect("index.jsp");
                    return;
                }
            }
        }
        resp.sendRedirect("index.jsp");
        }catch(Exception e){
            e.printStackTrace();
            resp.sendError(500);
        }

    }

}
