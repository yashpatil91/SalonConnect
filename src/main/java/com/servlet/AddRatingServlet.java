package com.servlet;

import com.dao.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/customer/addRating")
public class AddRatingServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));
        int rating = Integer.parseInt(request.getParameter("rating"));
        String review = request.getParameter("review");

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBConnection.getConnection();
            
            // Get appointment details
            String appointmentSql = "SELECT salon_id, therapist_id, user_id FROM appointments WHERE id = ?";
            ps = con.prepareStatement(appointmentSql);
            ps.setInt(1, appointmentId);
            rs = ps.executeQuery();
            
            if (!rs.next()) {
                response.sendRedirect("my-appointments.jsp?error=notfound");
                return;
            }
            
            int salonId = rs.getInt("salon_id");
            int therapistId = rs.getInt("therapist_id");
            int appointmentUserId = rs.getInt("user_id");
            
            // Verify user owns this appointment
            if (appointmentUserId != userId) {
                response.sendRedirect("my-appointments.jsp?error=unauthorized");
                return;
            }
            
            rs.close();
            ps.close();

            // Insert rating
            String sql = "INSERT INTO ratings (user_id, salon_id, therapist_id, appointment_id, rating, review) VALUES (?, ?, ?, ?, ?, ?)";
            ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, salonId);
            ps.setInt(3, therapistId);
            ps.setInt(4, appointmentId);
            ps.setInt(5, rating);
            ps.setString(6, review);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                // Update salon average rating
                updateSalonRating(con, salonId);
                // Update therapist average rating
                updateTherapistRating(con, therapistId);
                
                response.sendRedirect("my-appointments.jsp?success=rated");
            } else {
                response.sendRedirect("add-rating.jsp?appointmentId=" + appointmentId + "&error=failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("add-rating.jsp?appointmentId=" + appointmentId + "&error=exception");
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception ignored) {}
            try { if (ps != null) ps.close(); } catch (Exception ignored) {}
            try { if (con != null) con.close(); } catch (Exception ignored) {}
        }
    }

    private void updateSalonRating(Connection con, int salonId) {
        try {
            String sql = "UPDATE salons SET rating = (SELECT AVG(rating) FROM ratings WHERE salon_id = ?) WHERE id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, salonId);
            ps.setInt(2, salonId);
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void updateTherapistRating(Connection con, int therapistId) {
        try {
            String sql = "UPDATE therapists SET rating = (SELECT AVG(rating) FROM ratings WHERE therapist_id = ?) WHERE id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, therapistId);
            ps.setInt(2, therapistId);
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
