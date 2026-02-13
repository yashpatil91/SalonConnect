package com.servlet;

import com.dao.DBConnection;
import com.util.EmailUtility;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/rejectAppointment")
public class RejectAppointmentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int appointmentId = Integer.parseInt(request.getParameter("id"));

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "UPDATE appointments SET status='REJECTED' WHERE id=?"
            );
            ps.setInt(1, appointmentId);
            int rows = ps.executeUpdate();

            if (rows > 0) {
                // Send email notification
                try {
                    String emailSql = "SELECT u.email, u.name, s.name as salon_name, a.appointment_date, a.appointment_time " +
                                     "FROM appointments a " +
                                     "JOIN users u ON a.user_id = u.id " +
                                     "JOIN salons s ON a.salon_id = s.id " +
                                     "WHERE a.id = ?";
                    PreparedStatement emailPs = con.prepareStatement(emailSql);
                    emailPs.setInt(1, appointmentId);
                    ResultSet emailRs = emailPs.executeQuery();
                    
                    if (emailRs.next()) {
                        String userEmail = emailRs.getString("email");
                        String userName = emailRs.getString("name");
                        String salonName = emailRs.getString("salon_name");
                        String date = emailRs.getDate("appointment_date").toString();
                        String time = emailRs.getTime("appointment_time").toString();
                        
                        EmailUtility.sendRejectionEmail(userEmail, userName, salonName, date, time);
                    }
                    
                    emailRs.close();
                    emailPs.close();
                } catch (Exception emailEx) {
                    System.err.println("Failed to send email notification");
                    emailEx.printStackTrace();
                }
            }

            response.sendRedirect(request.getContextPath() + "/owner/view-bookings.jsp");


        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
