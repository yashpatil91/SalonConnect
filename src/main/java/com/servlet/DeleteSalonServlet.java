package com.servlet;

import com.dao.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/deleteSalon")
public class DeleteSalonServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int salonId = Integer.parseInt(request.getParameter("salonId"));

        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = DBConnection.getConnection();

            // 🔥 First delete therapists (FK safety)
            ps = con.prepareStatement("DELETE FROM therapists WHERE salon_id = ?");
            ps.setInt(1, salonId);
            ps.executeUpdate();
            ps.close();

            // 🔥 Then delete services
            ps = con.prepareStatement("DELETE FROM services WHERE salon_id = ?");
            ps.setInt(1, salonId);
            ps.executeUpdate();
            ps.close();

            // 🔥 Finally delete salon
            ps = con.prepareStatement("DELETE FROM salons WHERE id = ?");
            ps.setInt(1, salonId);
            ps.executeUpdate();

            response.sendRedirect("view-salon.jsp?success=deleted");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("view-salon.jsp?error=true");
        } finally {
            try { if (ps != null) ps.close(); } catch (Exception ignored) {}
            try { if (con != null) con.close(); } catch (Exception ignored) {}
        }
    }
}


