package com.servlet;

import com.dao.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String role = request.getParameter("role");

        String specialization = request.getParameter("specialization");
        String experienceStr = request.getParameter("experience");

        // Backend validation
        if (name == null || !name.matches("[A-Za-z ]{2,}")) {
            response.sendRedirect("register.jsp?error=failed");
            return;
        }

        if (role == null || role.isEmpty()) {
            role = "CUSTOMER";
        }

        Connection con = null;

        try {
            con = DBConnection.getConnection();
            con.setAutoCommit(false); // 🔒 Start transaction

            // 1️⃣ Check if email already exists
            try (PreparedStatement checkPs =
                    con.prepareStatement("SELECT id FROM users WHERE email = ?")) {

                checkPs.setString(1, email);
                ResultSet rs = checkPs.executeQuery();
                if (rs.next()) {
                    con.rollback();
                    response.sendRedirect("register.jsp?error=exists");
                    return;
                }
            }

            // 2️⃣ Insert into users table
            int userId;
            try (PreparedStatement userPs = con.prepareStatement(
                    "INSERT INTO users (name, email, password, phone, role) VALUES (?, ?, ?, ?, ?)",
                    Statement.RETURN_GENERATED_KEYS)) {

                userPs.setString(1, name);
                userPs.setString(2, email);
                userPs.setString(3, password);
                userPs.setString(4, phone);
                userPs.setString(5, role);

                userPs.executeUpdate();

                ResultSet rs = userPs.getGeneratedKeys();
                rs.next();
                userId = rs.getInt(1);
            }

            // 3️⃣ If Therapist → Insert into therapists table
            if ("THERAPIST".equalsIgnoreCase(role)) {

                int experience = 0;
                if (experienceStr != null && !experienceStr.isEmpty()) {
                    experience = Integer.parseInt(experienceStr);
                }

                try (PreparedStatement tPs = con.prepareStatement(
                        "INSERT INTO therapists " +
                        "(name, specialization, experience, phone, rating, user_id, status, salon_id) " +
                        "VALUES (?, ?, ?, ?, 0.0, ?, 'PENDING', NULL)")) {

                    tPs.setString(1, name);
                    tPs.setString(2, specialization);
                    tPs.setInt(3, experience);
                    tPs.setString(4, phone);
                    tPs.setInt(5, userId);

                    tPs.executeUpdate();
                }
            }

            con.commit(); // ✅ Success
            response.sendRedirect("login.jsp?success=registered");

        } catch (Exception e) {
            try { if (con != null) con.rollback(); } catch (Exception ignored) {}
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=exception");
        } finally {
            try { if (con != null) con.close(); } catch (Exception ignored) {}
        }
    }
}
