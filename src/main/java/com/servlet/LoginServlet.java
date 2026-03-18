package com.servlet;

import com.dao.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        System.out.println("Login attempt: " + email + " | " + password); // 🔥 DEBUG

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBConnection.getConnection();

            // 🔴 CHECK if connection failed
            if (con == null) {
                System.out.println("DB Connection is NULL ❌");
                response.sendRedirect(request.getContextPath() + "/login.jsp?error=exception");
                return;
            }

            System.out.println("DB Connected ✅");

            String sql = "SELECT id, name, email, role FROM users WHERE email = ? AND password = ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);

            rs = ps.executeQuery();

            if (rs.next()) {

                int userId = rs.getInt("id");
                String role = rs.getString("role") != null
                        ? rs.getString("role").trim()
                        : "";

                System.out.println("Login SUCCESS for: " + email + " Role: " + role); // 🔥 DEBUG

                // ✅ Create session
                HttpSession session = request.getSession();
                session.setAttribute("userId", userId);
                session.setAttribute("userName", rs.getString("name"));
                session.setAttribute("userEmail", rs.getString("email"));
                session.setAttribute("userRole", role);

                // 🔁 Role-based redirect
                if ("OWNER".equalsIgnoreCase(role)) {
                    response.sendRedirect(request.getContextPath() + "/owner/dashboard.jsp");

                } else if ("CUSTOMER".equalsIgnoreCase(role)) {
                    response.sendRedirect(request.getContextPath() + "/customer/dashboard.jsp");

                } else if ("THERAPIST".equalsIgnoreCase(role)) {
                    response.sendRedirect(request.getContextPath() + "/therapist/dashboard");

                } else {
                    response.sendRedirect(request.getContextPath() + "/index.jsp");
                }

            } else {
                System.out.println("Login FAILED ❌ for: " + email); // 🔥 DEBUG
                response.sendRedirect(request.getContextPath() + "/login.jsp?error=invalid");
            }

        } catch (Exception e) {
            System.out.println("EXCEPTION OCCURRED ❌");
            e.printStackTrace(); // 🔥 VERY IMPORTANT

            response.sendRedirect(request.getContextPath() + "/login.jsp?error=exception");

        } finally {
            try { if (rs != null) rs.close(); } catch (Exception ignored) {}
            try { if (ps != null) ps.close(); } catch (Exception ignored) {}
            try { if (con != null) con.close(); } catch (Exception ignored) {}
        }
    }
}