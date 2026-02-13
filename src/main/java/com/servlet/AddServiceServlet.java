package com.servlet;

import com.dao.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/owner/AddServiceServlet")
public class AddServiceServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        int ownerId = (int) session.getAttribute("userId");
        int salonId = Integer.parseInt(request.getParameter("salonId"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        int duration = Integer.parseInt(request.getParameter("duration"));
        String category = request.getParameter("category");
        String imageUrl = request.getParameter("imageUrl");

        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = DBConnection.getConnection();
            
            // Verify owner owns this salon
            String checkSql = "SELECT id FROM salons WHERE id = ? AND owner_id = ?";
            ps = con.prepareStatement(checkSql);
            ps.setInt(1, salonId);
            ps.setInt(2, ownerId);
            ResultSet rs = ps.executeQuery();
            
            if (!rs.next()) {
                response.sendRedirect("view-services.jsp?error=unauthorized");
                return;
            }
            rs.close();
            ps.close();

            // Insert service
            String sql = "INSERT INTO services " +
                    "(salon_id, name, description, price, duration, category, image_url) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?)";

				       ps = con.prepareStatement(sql);
				       ps.setInt(1, salonId);
				       ps.setString(2, name);
				       ps.setString(3, description);
				       ps.setDouble(4, price);
				       ps.setInt(5, duration);
				       ps.setString(6, category);
				       ps.setString(7, imageUrl);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                response.sendRedirect("view-services.jsp?success=added");
            } else {
                response.sendRedirect("add-service.jsp?salonId=" + salonId + "&error=failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("add-service.jsp?error=exception");
        } finally {
            try { if (ps != null) ps.close(); } catch (Exception ignored) {}
            try { if (con != null) con.close(); } catch (Exception ignored) {}
        }
    }
}
