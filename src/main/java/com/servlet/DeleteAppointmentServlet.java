package com.servlet;

import com.dao.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/deleteAppointment")
public class DeleteAppointmentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));

        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = DBConnection.getConnection();

            // 🔐 Security: user can delete only THEIR appointment
            String sql = "DELETE FROM appointments WHERE id = ? AND user_id = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, appointmentId);
            ps.setInt(2, userId);

            ps.executeUpdate();

            response.sendRedirect(
            	    request.getContextPath() + "/customer/my-appointments.jsp?success=deleted"
            	);

        } 
        catch (Exception e) 
        {
            e.printStackTrace();
            
            response.sendRedirect(
            	    request.getContextPath() + "/customer/my-appointments.jsp?error=deleteFailed");
        } finally {
            try { if (ps != null) ps.close(); } catch (Exception ignored) {}
            try { if (con != null) con.close(); } catch (Exception ignored) {}
        }
    }
}
