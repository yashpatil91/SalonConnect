package com.servlet;

import com.dao.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/owner/deleteTherapist")
public class DeleteTherapistServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int ownerId = (int) session.getAttribute("userId");
        int therapistId = Integer.parseInt(request.getParameter("id"));
        int salonId = Integer.parseInt(request.getParameter("salonId"));

        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = DBConnection.getConnection();

            // Delete therapist ONLY if salon belongs to this owner
            String sql =
                "DELETE t FROM therapists t " +
                "JOIN salons s ON t.salon_id = s.id " +
                "WHERE t.id = ? AND t.salon_id = ? AND s.owner_id = ?";

            ps = con.prepareStatement(sql);
            ps.setInt(1, therapistId);
            ps.setInt(2, salonId);
            ps.setInt(3, ownerId);

            ps.executeUpdate();

            response.sendRedirect("view-therapists.jsp?success=deleted");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("view-therapists.jsp?error=deleteFailed");
        } finally {
            try { if (ps != null) ps.close(); } catch (Exception ignored) {}
            try { if (con != null) con.close(); } catch (Exception ignored) {}
        }
    }
}
