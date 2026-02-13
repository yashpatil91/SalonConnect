package com.servlet;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import com.dao.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/owner/addSalon")
public class AddSalonServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        int ownerId = (int) session.getAttribute("userId");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String phone = request.getParameter("phone");
        String description = request.getParameter("description");

        String imageUrl = request.getParameter("imageUrl");
        if (imageUrl != null && imageUrl.trim().isEmpty()) {
            imageUrl = null;
        }

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(
                 "INSERT INTO salons (owner_id, name, address, city, phone, description, image_url) VALUES (?, ?, ?, ?, ?, ?, ?)")) {

            ps.setInt(1, ownerId);
            ps.setString(2, name);
            ps.setString(3, address);
            ps.setString(4, city);
            ps.setString(5, phone);
            ps.setString(6, description);

            if (imageUrl != null) {
                ps.setString(7, imageUrl);
            } else {
                ps.setNull(7, java.sql.Types.VARCHAR); // DB DEFAULT applies
            }

            int rows = ps.executeUpdate();
            response.sendRedirect(
                rows > 0 ? "view-salon.jsp?success=added"
                         : "add-salon.jsp?error=failed"
            );

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("add-salon.jsp?error=exception");
        }
    }
}
