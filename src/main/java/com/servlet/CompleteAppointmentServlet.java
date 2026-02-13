package com.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.dao.DBConnection;

@WebServlet("/owner/completeAppointment")
public class CompleteAppointmentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String appointmentIdStr = request.getParameter("appointmentId");

        if (appointmentIdStr == null || appointmentIdStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/owner/view-bookings.jsp");
            return;
        }

        int appointmentId = Integer.parseInt(appointmentIdStr);

        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = DBConnection.getConnection();

            String sql = "UPDATE appointments SET status = 'COMPLETED' WHERE id = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, appointmentId);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (ps != null) ps.close(); } catch (Exception ignored) {}
            try { if (con != null) con.close(); } catch (Exception ignored) {}
        }

        // redirect back to manage bookings page
        response.sendRedirect(request.getContextPath() + "/owner/view-bookings.jsp");
    }
}
