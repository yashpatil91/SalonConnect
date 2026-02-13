package com.servlet;

import com.dao.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/owner/updateSalon")
public class UpdateSalonServlet extends HttpServlet {

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
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String phone = request.getParameter("phone");
        String description = request.getParameter("description");
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
                response.sendRedirect("view-salon.jsp?error=unauthorized");
                return;
            }
            rs.close();
            ps.close();

            // Update salon
            String sql = "UPDATE salons SET name=?, address=?, city=?, phone=?, description=?, image_url=? WHERE id=? AND owner_id=?";
            ps = con.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, address);
            ps.setString(3, city);
            ps.setString(4, phone);
            ps.setString(5, description);
            ps.setString(6, imageUrl);
            ps.setInt(7, salonId);
            ps.setInt(8, ownerId);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                response.sendRedirect("view-salon.jsp?success=updated");
            } else {
                response.sendRedirect("edit-salon.jsp?id=" + salonId + "&error=failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("view-salon.jsp?error=exception");
        } finally {
            try { if (ps != null) ps.close(); } catch (Exception ignored) {}
            try { if (con != null) con.close(); } catch (Exception ignored) {}
        }
    }
}
