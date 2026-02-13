package com.dao;

import com.model.Appointment;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AppointmentDAO {

    // ===============================
    // 1️⃣ Total appointments today
    // ===============================
    public int getTodayAppointmentCount(int therapistId) {

        String sql = """
                SELECT COUNT(*)
                FROM appointments
                WHERE therapist_id = ?
                  AND appointment_date = CURDATE()
                """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, therapistId);
            ResultSet rs = ps.executeQuery();

            if (rs.next())
                return rs.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    // ===============================
    // 2️⃣ Next upcoming appointment
    // ===============================
    public Appointment getNextUpcomingAppointment(int therapistId) {

        String sql = """
                SELECT
                    a.id,
                    a.appointment_date,
                    a.appointment_time,
                    a.status,
                    u.name AS client_name,
                    s.name AS service_name
                FROM appointments a
                JOIN users u ON a.user_id = u.id
                JOIN services s ON a.service_id = s.id
                WHERE a.therapist_id = ?
                  AND a.status IN ('APPROVED', 'CONFIRMED')
                  AND a.appointment_date >= CURDATE()
                ORDER BY a.appointment_date, a.appointment_time
                LIMIT 1
                """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, therapistId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Appointment appt = new Appointment();
                appt.setId(rs.getInt("id"));
                appt.setClientName(rs.getString("client_name"));
                appt.setServiceName(rs.getString("service_name"));
                appt.setAppointmentDate(rs.getDate("appointment_date"));   // ✅ Correct
                appt.setAppointmentTime(rs.getTime("appointment_time"));   // ✅ Correct
                appt.setStatus(rs.getString("status"));
                return appt;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    // ===============================
    // 3️⃣ Weekly earnings
    // ===============================
    public double getWeeklyEarnings(int therapistId) {

        String sql = """
                SELECT COALESCE(SUM(s.price), 0)
                FROM appointments a
                JOIN services s ON a.service_id = s.id
                WHERE a.therapist_id = ?
                  AND a.status = 'COMPLETED'
                  AND YEAR(a.appointment_date) = YEAR(CURDATE())
                  AND WEEK(a.appointment_date, 1) = WEEK(CURDATE(), 1)
                """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, therapistId);
            ResultSet rs = ps.executeQuery();

            if (rs.next())
                return rs.getDouble(1);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0.0;
    }

    // ===============================
    // 4️⃣ Today’s agenda
    // ===============================
    public List<Appointment> getTodayAppointments(int therapistId) {

        List<Appointment> list = new ArrayList<>();

        String sql = """
                SELECT
                    a.id,
                    a.appointment_date,
                    a.appointment_time,
                    a.status,
                    u.name AS client_name,
                    s.name AS service_name
                FROM appointments a
                JOIN users u ON a.user_id = u.id
                JOIN services s ON a.service_id = s.id
                WHERE a.therapist_id = ?
                  AND a.appointment_date = CURDATE()
                ORDER BY a.appointment_time
                """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, therapistId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Appointment appt = new Appointment();
                appt.setId(rs.getInt("id"));
                appt.setClientName(rs.getString("client_name"));
                appt.setServiceName(rs.getString("service_name"));
                appt.setAppointmentDate(rs.getDate("appointment_date"));   // ✅ Correct
                appt.setAppointmentTime(rs.getTime("appointment_time"));   // ✅ Correct
                appt.setStatus(rs.getString("status"));
                list.add(appt);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ===============================
    // 5️⃣ Upcoming schedule
    // ===============================
    public List<Appointment> getUpcomingAppointments(int therapistId) {

        List<Appointment> list = new ArrayList<>();

        String sql = """
                SELECT
                    a.id,
                    a.appointment_date,
                    a.appointment_time,
                    a.status,
                    u.name AS client_name,
                    s.name AS service_name
                FROM appointments a
                JOIN users u ON a.user_id = u.id
                JOIN services s ON a.service_id = s.id
                WHERE a.therapist_id = ?
                  AND a.appointment_date >= CURDATE()
                ORDER BY a.appointment_date, a.appointment_time
                """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, therapistId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Appointment appt = new Appointment();
                appt.setId(rs.getInt("id"));
                appt.setClientName(rs.getString("client_name"));
                appt.setServiceName(rs.getString("service_name"));
                appt.setAppointmentDate(rs.getDate("appointment_date"));   // ✅ Correct
                appt.setAppointmentTime(rs.getTime("appointment_time"));   // ✅ Correct
                appt.setStatus(rs.getString("status"));
                list.add(appt);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
