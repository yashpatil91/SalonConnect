package com.servlet;

import com.dao.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/owner/editTherapist")
public class EditTherapistServlet extends HttpServlet {

    // LOAD DATA FOR EDIT PAGE
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        int salonId = Integer.parseInt(request.getParameter("salonId"));

        try (Connection conn = DBConnection.getConnection()) {

            String sql = "SELECT name, email, phone, specialization, image_url " +
                         "FROM therapists WHERE id=? AND salon_id=?";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ps.setInt(2, salonId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                request.setAttribute("id", id);
                request.setAttribute("salonId", salonId);
                request.setAttribute("name", rs.getString("name"));
                request.setAttribute("email", rs.getString("email"));
                request.setAttribute("phone", rs.getString("phone"));
                request.setAttribute("specialization", rs.getString("specialization"));
                request.setAttribute("imageUrl", rs.getString("image_url"));
            }

            request.getRequestDispatcher("/owner/edit-therapist.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 🔥 HANDLE UPDATE (THIS WAS MISSING)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        int salonId = Integer.parseInt(request.getParameter("salonId"));

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String specialization = request.getParameter("specialization");
        String imageUrl = request.getParameter("imageUrl");

        try (Connection conn = DBConnection.getConnection()) {

            String sql = "UPDATE therapists SET name=?, email=?, phone=?, specialization=?, image_url=? " +
                         "WHERE id=? AND salon_id=?";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, specialization);
            ps.setString(5, imageUrl);
            ps.setInt(6, id);
            ps.setInt(7, salonId);

            ps.executeUpdate();

            // redirect after success
            response.sendRedirect(
                request.getContextPath() + "/owner/view-therapists.jsp?salonId=" + salonId
            );

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
