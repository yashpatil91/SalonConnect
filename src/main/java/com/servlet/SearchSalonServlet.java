package com.servlet;

import com.dao.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/searchSalons")
public class SearchSalonServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String city = request.getParameter("city");
        String serviceName = request.getParameter("service");
        String minRatingStr = request.getParameter("minRating");

        Connection con = null;

        try {
            con = DBConnection.getConnection();

            /* =========================
               1️⃣ SEARCH SALONS
            ========================= */
            StringBuilder sql = new StringBuilder(
                "SELECT DISTINCT s.* FROM salons s "
            );

            List<Object> params = new ArrayList<>();
            List<String> conditions = new ArrayList<>();

            if (serviceName != null && !serviceName.trim().isEmpty()) {
                sql.append("INNER JOIN services srv ON s.id = srv.salon_id ");
                conditions.add("srv.name LIKE ?");
                params.add("%" + serviceName + "%");
            }

            if (city != null && !city.trim().isEmpty()) {
                conditions.add("s.city LIKE ?");
                params.add("%" + city + "%");
            }

            if (minRatingStr != null && !minRatingStr.trim().isEmpty()) {
                try {
                    double minRating = Double.parseDouble(minRatingStr);
                    conditions.add("s.rating >= ?");
                    params.add(minRating);
                } catch (NumberFormatException ignored) {}
            }

            if (!conditions.isEmpty()) {
                sql.append(" WHERE ").append(String.join(" AND ", conditions));
            }

            sql.append(" ORDER BY s.rating DESC, s.name");

            PreparedStatement ps = con.prepareStatement(sql.toString());

            for (int i = 0; i < params.size(); i++) {
                Object p = params.get(i);
                if (p instanceof String) {
                    ps.setString(i + 1, (String) p);
                } else {
                    ps.setDouble(i + 1, (Double) p);
                }
            }

            ResultSet rs = ps.executeQuery();

            List<Map<String, Object>> salons = new ArrayList<>();

            while (rs.next()) {
                Map<String, Object> salon = new HashMap<>();
                salon.put("id", rs.getInt("id"));
                salon.put("name", rs.getString("name"));
                salon.put("address", rs.getString("address"));
                salon.put("city", rs.getString("city"));
                salon.put("description", rs.getString("description"));
                salon.put("rating", rs.getDouble("rating"));
                salon.put("image_url", rs.getString("image_url"));
                salons.add(salon);
            }

            rs.close();
            ps.close();

            /* =========================
               2️⃣ CITY DROPDOWN
            ========================= */
            PreparedStatement cityPs = con.prepareStatement(
                "SELECT DISTINCT city FROM salons ORDER BY city"
            );
            ResultSet cityRs = cityPs.executeQuery();

            List<String> cities = new ArrayList<>();
            while (cityRs.next()) {
                cities.add(cityRs.getString("city"));
            }

            cityRs.close();
            cityPs.close();

            /* =========================
               3️⃣ SERVICE DROPDOWN
            ========================= */
            PreparedStatement servicePs = con.prepareStatement(
                "SELECT DISTINCT name FROM services ORDER BY name"
            );
            ResultSet serviceRs = servicePs.executeQuery();

            List<String> services = new ArrayList<>();
            while (serviceRs.next()) {
                services.add(serviceRs.getString("name"));
            }

            serviceRs.close();
            servicePs.close();

            /* =========================
               4️⃣ SEND TO JSP
            ========================= */
            request.setAttribute("salons", salons);
            request.setAttribute("cities", cities);
            request.setAttribute("services", services);

            request.getRequestDispatcher("/customer/search-salon.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("customer/search-salon.jsp?error=exception");
        } finally {
            try { if (con != null) con.close(); } catch (Exception ignored) {}
        }
    }
}
