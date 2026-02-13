package com.servlet;

import com.dao.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/owner/addTherapist")
public class AddTherapistServlet extends HttpServlet {

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
        String specialization = request.getParameter("specialization");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String imageUrl = request.getParameter("imageUrl");

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBConnection.getConnection();

            // 🔒 Verify owner owns salon
            ps = con.prepareStatement(
                "SELECT id FROM salons WHERE id = ? AND owner_id = ?"
            );
            ps.setInt(1, salonId);
            ps.setInt(2, ownerId);
            rs = ps.executeQuery();

            if (!rs.next()) {
                response.sendRedirect("view-therapists.jsp?error=unauthorized");
                return;
            }
            rs.close();
            ps.close();

            // ✅ LET DATABASE DEFAULT HANDLE IMAGE
            if (imageUrl == null || imageUrl.trim().isEmpty()) {

                ps = con.prepareStatement(
                    "INSERT INTO therapists (salon_id, name, specialization, phone, email) " +
                    "VALUES (?, ?, ?, ?, ?)"
                );
                ps.setInt(1, salonId);
                ps.setString(2, name);
                ps.setString(3, specialization);
                ps.setString(4, phone);
                ps.setString(5, email);

            } else {

                ps = con.prepareStatement(
                    "INSERT INTO therapists (salon_id, name, specialization, phone, image_url, email) " +
                    "VALUES (?, ?, ?, ?, ?, ?)"
                );
                ps.setInt(1, salonId);
                ps.setString(2, name);
                ps.setString(3, specialization);
                ps.setString(4, phone);
                ps.setString(5, imageUrl.trim());
                ps.setString(6, email);
            }

            ps.executeUpdate();
            response.sendRedirect("view-therapists.jsp?success=added");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("add-therapist.jsp?salonId=" + salonId + "&error=exception");
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception ignored) {}
            try { if (ps != null) ps.close(); } catch (Exception ignored) {}
            try { if (con != null) con.close(); } catch (Exception ignored) {}
        }
    }
}
