package com.util;

import java.util.Properties;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;


public class EmailUtility {

    // Email configuration - Update these with your SMTP settings
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String FROM_EMAIL = "patilsoftwares22@gmail.com"; // Update this
    private static final String FROM_PASSWORD = "ixsvbbqhnoiexrur"; // Update this (use app password for Gmail)

    /**
     * Send email notification
     * @param toEmail Recipient email address
     * @param subject Email subject
     * @param message Email body
     * @return true if email sent successfully, false otherwise
     */
    public static boolean sendEmail(String toEmail, String subject, String message) {
        // Set up mail server properties
        Properties properties = new Properties();
        properties.put("mail.smtp.host", SMTP_HOST);
        properties.put("mail.smtp.port", SMTP_PORT);
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");

        // Create session with authentication
        Session session = Session.getInstance(properties, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, FROM_PASSWORD);
            }
        });

        try {
            // Create message
            Message mimeMessage = new MimeMessage(session);
            mimeMessage.setFrom(new InternetAddress(FROM_EMAIL));
            mimeMessage.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            mimeMessage.setSubject(subject);
            mimeMessage.setText(message);

            // Send message
            Transport.send(mimeMessage);
            System.out.println("Email sent successfully to: " + toEmail);
            return true;

        } catch (MessagingException e) {
            System.err.println("Failed to send email to: " + toEmail);
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Send appointment approval notification
     */
    public static boolean sendApprovalEmail(String toEmail, String customerName, 
                                           String salonName, String date, String time) {
        String subject = "Appointment Approved - " + salonName;
        String message = "Dear " + customerName + ",\n\n" +
                        "Great news! Your appointment has been approved.\n\n" +
                        "Details:\n" +
                        "Salon: " + salonName + "\n" +
                        "Date: " + date + "\n" +
                        "Time: " + time + "\n\n" +
                        "We look forward to seeing you!\n\n" +
                        "Best regards,\n" +
                        "SalonConnect Team";
        
        return sendEmail(toEmail, subject, message);
    }

    /**
     * Send appointment rejection notification
     */
    public static boolean sendRejectionEmail(String toEmail, String customerName, 
                                            String salonName, String date, String time) {
        String subject = "Appointment Update - " + salonName;
        String message = "Dear " + customerName + ",\n\n" +
                        "We regret to inform you that your appointment request could not be accommodated.\n\n" +
                        "Details:\n" +
                        "Salon: " + salonName + "\n" +
                        "Date: " + date + "\n" +
                        "Time: " + time + "\n\n" +
                        "Please try booking a different time slot.\n\n" +
                        "Best regards,\n" +
                        "SalonConnect Team";
        
        return sendEmail(toEmail, subject, message);
    }

    /**
     * Send booking confirmation notification
     */
    public static boolean sendBookingConfirmation(String toEmail, String customerName, 
                                                  String salonName, String date, String time) {
        String subject = "Booking Received - " + salonName;
        String message = "Dear " + customerName + ",\n\n" +
                        "Your appointment request has been received and is pending approval.\n\n" +
                        "Details:\n" +
                        "Salon: " + salonName + "\n" +
                        "Date: " + date + "\n" +
                        "Time: " + time + "\n\n" +
                        "You will receive a notification once the salon owner reviews your request.\n\n" +
                        "Best regards,\n" +
                        "SalonConnect Team";
        
        return sendEmail(toEmail, subject, message);
    }
}
