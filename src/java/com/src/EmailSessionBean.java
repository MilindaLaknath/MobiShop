/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.src;

import java.util.Date;
import java.util.Properties;
import javax.ejb.Stateless;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author Milinda
 */
@Stateless
public class EmailSessionBean {

    private int port = 465;
    private String host = "smtp.gmail.com";
    private String from = "email@gmail.com";
    private boolean auth = true;
    private String username = "email@gmail.com";
    private String password = "password";
    private Protocol protocol = Protocol.SMTPS;
    private boolean debug = true;

    // Add business logic below. (Right-click in editor and choose
    // "Insert Code > Add Business Method")
    public void sendEmail(String to, String subject, String body) {
//    public void sendEmail() {
        try {

            Properties props = new Properties();
            props.put("mail.smtp.host", host);
            props.put("mail.smtp.port", port);
            switch (protocol) {
                case SMTPS:
                    props.put("mail.smtp.ssl.enable", true);
                    break;
                case TLS:
                    props.put("mail.smtp.starttls.enable", true);
                    break;
            }

            Authenticator authenticator = null;
            if (auth) {
                props.put("mail.smtp.auth", true);
                authenticator = new Authenticator() {
                    private PasswordAuthentication pa = new PasswordAuthentication(username, password);

                    @Override
                    public PasswordAuthentication getPasswordAuthentication() {
                        return pa;
                    }
                };
            }

            Session session = Session.getInstance(props, authenticator);
            session.setDebug(debug);

            MimeMessage message = new MimeMessage(session);

            message.setFrom(new InternetAddress(from));
            InternetAddress[] address = {new InternetAddress(to)};
            message.setRecipients(Message.RecipientType.TO, address);
            message.setSubject(subject);
            message.setSentDate(new Date());
            message.setText(body);
            Transport.send(message);
        } catch (Exception ex) {
            ex.printStackTrace();
            System.out.println(ex.toString());
        }

    }

}
