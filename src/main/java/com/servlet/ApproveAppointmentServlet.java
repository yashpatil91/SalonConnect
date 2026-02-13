package com.servlet;

import com.dao.DBConnection;
import com.util.EmailUtility;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import java.text.SimpleDateFormat;

@WebServlet("/ApproveAppointmentServlet")
public class ApproveAppointmentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 🔍 1. Read appointment id safely
        String idParam = request.getParameter("id");

        if (idParam == null || idParam.isEmpty()) {
            System.out.println("❌ Appointment ID is missing");
            response.sendRedirect("view-bookings.jsp?error=invalid_id");
            return;
        }

        int appointmentId = Integer.parseInt(idParam);
        System.out.println("✅ Approve request for appointment ID: " + appointmentId);

        Connection con = null;
        PreparedStatement ps = null;

        try {
            // 🔗 2. Get DB connection
            con = DBConnection.getConnection();

            // 🛠️ 3. Update status
            String sql = "UPDATE appointments SET status = ? WHERE id = ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, "APPROVED");
            ps.setInt(2, appointmentId);

            int rows = ps.executeUpdate();
            System.out.println("🧾 Rows updated: " + rows);

            if (rows == 0) {
                // Means ID not found in DB
                System.out.println("⚠️ No appointment found with ID: " + appointmentId);
            } else {
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
                        
                        EmailUtility.sendApprovalEmail(userEmail, userName, salonName, date, time);
                    }
                    
                    emailRs.close();
                    emailPs.close();
                } catch (Exception emailEx) {
                    System.err.println("Failed to send email notification");
                    emailEx.printStackTrace();
                }
            }

            // 🔁 4. Redirect back to owner page
            response.sendRedirect("owner/view-bookings.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("view-bookings.jsp?error=exception");
        } finally {
            // 🧹 5. Close resources (important)
            try { if (ps != null) ps.close(); } catch (Exception ignored) {}
            try { if (con != null) con.close(); } catch (Exception ignored) {}
        }
    }
}
