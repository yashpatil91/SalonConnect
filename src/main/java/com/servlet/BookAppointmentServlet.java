package com.servlet;

import com.dao.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import java.time.LocalTime;

@WebServlet("/bookAppointment")
public class BookAppointmentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        int salonId = Integer.parseInt(request.getParameter("salonId"));
        int serviceId = Integer.parseInt(request.getParameter("serviceId"));
        int therapistId = Integer.parseInt(request.getParameter("therapistId"));

        String date = request.getParameter("date");
        String startTimeStr = request.getParameter("time");

        try {
            Connection con = DBConnection.getConnection();

            /* -------------------------------
             * 1. GET SERVICE DURATION
             * ------------------------------- */
            int duration = 0;
            String durationSql = "SELECT duration FROM services WHERE id=?";
            PreparedStatement dps = con.prepareStatement(durationSql);
            dps.setInt(1, serviceId);
            ResultSet drs = dps.executeQuery();

            if (drs.next()) {
                duration = drs.getInt("duration");
            }

            /* -------------------------------
             * 2. CALCULATE END TIME
             * ------------------------------- */
            LocalTime startTime = LocalTime.parse(startTimeStr);
            LocalTime endTime = startTime.plusMinutes(duration);

            /* -------------------------------
             * 3. CHECK OVERLAPPING BOOKINGS
             * ------------------------------- */
            String checkSql =
                "SELECT id FROM appointments " +
                "WHERE therapist_id=? " +
                "AND appointment_date=? " +
                "AND status != 'REJECTED' " +
                "AND (? < end_time AND ? > appointment_time)";

            PreparedStatement checkPs = con.prepareStatement(checkSql);
            checkPs.setInt(1, therapistId);
            checkPs.setString(2, date);
            checkPs.setString(3, startTime.toString());
            checkPs.setString(4, endTime.toString());

            ResultSet rs = checkPs.executeQuery();

            if (rs.next()) {
                response.sendRedirect("customer/book-appointment.jsp?salonId=" + salonId + "&error=slot_taken");
                return;
            }

            /* -------------------------------
             * 4. INSERT APPOINTMENT
             * ------------------------------- */
            String insertSql =
                "INSERT INTO appointments " +
                "(user_id, salon_id, service_id, therapist_id, appointment_date, appointment_time, end_time, status) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, 'PENDING')";

            PreparedStatement ps = con.prepareStatement(insertSql);
            ps.setInt(1, userId);
            ps.setInt(2, salonId);
            ps.setInt(3, serviceId);
            ps.setInt(4, therapistId);
            ps.setString(5, date);
            ps.setString(6, startTime.toString());
            ps.setString(7, endTime.toString());

            ps.executeUpdate();

            response.sendRedirect("customer/my-appointments.jsp?success=booked");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("customer/book-appointment.jsp?salonId=" + salonId + "&error=exception");
        }
    }
}
