package com.servlet;

import com.dao.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/owner/EditServiceServlet")
public class EditServiceServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int serviceId = Integer.parseInt(request.getParameter("serviceId"));
        int salonId = Integer.parseInt(request.getParameter("salonId"));
        String name = request.getParameter("name");
        String category = request.getParameter("category");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        int duration = Integer.parseInt(request.getParameter("duration"));
        String imageUrl = request.getParameter("imageUrl");

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "UPDATE services SET name=?, category=?, description=?, price=?, duration=?, image_url=? " +
                         "WHERE id=? AND salon_id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, category);
            ps.setString(3, description);
            ps.setDouble(4, price);
            ps.setInt(5, duration);
            ps.setString(6, imageUrl);
            ps.setInt(7, serviceId);
            ps.setInt(8, salonId);

            int updated = ps.executeUpdate();
            if (updated > 0) {
                response.sendRedirect("view-services.jsp?msg=Service updated successfully");
            } else {
                response.sendRedirect("view-services.jsp?error=Failed to update service");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("view-services.jsp?error=Exception occurred");
        }
    }
}
