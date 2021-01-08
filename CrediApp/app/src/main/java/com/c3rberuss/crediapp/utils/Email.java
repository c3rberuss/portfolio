package com.c3rberuss.crediapp.utils;

import android.os.AsyncTask;

import com.sun.mail.smtp.SMTPTransport;

import java.util.List;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

public class Email {

    // for example, smtp.mailgun.org
    private static final String SMTP_SERVER = "imap.gmail.com";
    private static final String USERNAME = "crediappapp@gmail.com";
    private static final String PASSWORD = "Adm1n$*2019";

    private static final String EMAIL_FROM = "crediappapp@gmail.com";
    private static final String EMAIL_TO = "c3rberuss@gmail.com";
    private static final String EMAIL_TO_CC = "";

    private static final String EMAIL_SUBJECT = "Backup";
    private static final String EMAIL_TEXT = "Últimos procesos realizados desde la App";

    public static void send(String url){

        new AsyncTask<Void, Void, Void>() {
            @Override
            protected Void doInBackground(Void... voids) {

                Properties prop = System.getProperties();
                prop.put("mail.transport.protocol", "smtp");
                prop.put("mail.smtp.port", "587");
                prop.put("mail.smtp.starttls.enable", "true");

                Session session = Session.getDefaultInstance(prop);
                session.setDebug(false);

                MimeMessage msg = new MimeMessage(session);

                try {

                    msg.setFrom(new InternetAddress(EMAIL_FROM));

                    msg.setRecipients(Message.RecipientType.TO,
                            InternetAddress.parse(EMAIL_TO, false));

                    msg.setSubject(EMAIL_SUBJECT);

                    // text
                    MimeBodyPart p1 = new MimeBodyPart();
                    p1.setText(EMAIL_TEXT);

                    // file
                    MimeBodyPart p2 = new MimeBodyPart();
                    FileDataSource fds = new FileDataSource(url);
                    p2.setDataHandler(new DataHandler(fds));
                    p2.setFileName(fds.getName());

                    Multipart mp = new MimeMultipart();
                    mp.addBodyPart(p1);
                    mp.addBodyPart(p2);

                    msg.setContent(mp);


                    SMTPTransport t = new SMTPTransport(session, null);

                    // connect
                    t.connect(SMTP_SERVER, USERNAME, PASSWORD);
                    // send
                    t.sendMessage(msg, msg.getAllRecipients());

                    t.close();

                } catch (MessagingException e) {
                    e.printStackTrace();
                }

                return null;
            }
        }.execute();

    }

    public static void sendMultiFiles(List<String> urls, String text, String subject){

        new AsyncTask<Void, Void, Void>() {
            @Override
            protected Void doInBackground(Void... voids) {

                Properties prop = System.getProperties();
                prop.put("mail.transport.protocol", "smtp");
                prop.put("mail.smtp.port", "587");
                prop.put("mail.smtp.starttls.enable", "true");

                Session session = Session.getDefaultInstance(prop);
                session.setDebug(false);

                MimeMessage msg = new MimeMessage(session);

                try {

                    msg.setFrom(new InternetAddress(EMAIL_FROM));

                    msg.setRecipients(Message.RecipientType.TO,
                            InternetAddress.parse(EMAIL_TO, false));

                    msg.setSubject(subject);

                    // text
                    MimeBodyPart p1 = new MimeBodyPart();
                    p1.setText(text);

                    Multipart mp = new MimeMultipart();
                    mp.addBodyPart(p1);


                    for (String url: urls){
                        // file
                        final MimeBodyPart p2 = new MimeBodyPart();
                        final FileDataSource fds = new FileDataSource(url);
                        p2.setDataHandler(new DataHandler(fds));
                        p2.setFileName(fds.getName());
                        mp.addBodyPart(p2);

                    }

                    msg.setContent(mp);


                    SMTPTransport t = new SMTPTransport(session, null);

                    // connect
                    t.connect(SMTP_SERVER, USERNAME, PASSWORD);
                    // send
                    t.sendMessage(msg, msg.getAllRecipients());

                    t.close();

                } catch (MessagingException e) {
                    e.printStackTrace();
                }

                return null;
            }
        }.execute();

    }

}
