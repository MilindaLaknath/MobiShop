/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Mob;

import conn.FactoryManager;
import hiben.LoginSession;
import java.io.DataInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
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
public class MobLoginLog extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (PrintWriter out = resp.getWriter()) {
            DataInputStream da = new DataInputStream(req.getInputStream());
            String datefrm = da.readUTF(); //readLine();
            String dateto = da.readUTF(); //readLine();
            String utype = da.readUTF(); //readLine();
            da.close();

//            System.out.println(datefrm);
//            System.out.println(dateto);
//            System.out.println(utype);
            String datefrmarr[] = datefrm.split(" ");
            String datetoarr[] = dateto.split(" ");

            SimpleDateFormat sdf = new SimpleDateFormat("MMM/dd/yyyy");

            Session con = FactoryManager.getSessionFactory().openSession();
            Criteria cri = con.createCriteria(LoginSession.class);

            if (datefrm != null && dateto != null) {
                if (!datefrm.equals("")) {
                    Date d = sdf.parse(datefrmarr[1] + "/" + datefrmarr[2] + "/" + datefrmarr[5]);
                    cri.add(Restrictions.ge("loginTime", d));
                }
                if (!dateto.equals("")) {
                    Date d = sdf.parse(datetoarr[1] + "/" + datetoarr[2] + "/" + datetoarr[5]);
                    cri.add(Restrictions.lt("loginTime", d));
                }
            }

            List<LoginSession> list = cri.list();

            int type = 0;
            if (utype.equals("1") || utype.equals("2")) {
                type = 1;
            }

            String output = "";
            for (LoginSession ll : list) {
                if (type == 1) {
                    if (ll.getUser().getUserType().getGuestId().equals(2)||ll.getUser().getUserType().getGuestId().equals(3)) {
                        output += ll.getUser().getEmail();
                        output += "-";
                        output += ll.getUser().getUserType().getType();
                        output += "-";
                        output += ll.getLoginTime().toString();
                        output += ",";
                    }
                } else if (type == 0) {
                    output += ll.getUser().getEmail();
                    output += "-";
                    output += ll.getUser().getUserType().getType();
                    output += "-";
                    output += ll.getLoginTime().toString();
                    output += ",";
                }
            }

            out.print(output);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
@Override
    protected void doHead(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.getWriter().print("");
    }
}
