package com.servlet;

import com.dao.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/owner/deleteService")
public class DeleteServiceServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int serviceId = Integer.parseInt(request.getParameter("serviceId"));

        try (Connection con = DBConnection.getConnection()) {

            String sql = "DELETE FROM services WHERE id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, serviceId);

            ps.executeUpdate();

            // Redirect back to services page
            response.sendRedirect("view-services.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("services.jsp?error=deleteFailed");
        }
    }
}
