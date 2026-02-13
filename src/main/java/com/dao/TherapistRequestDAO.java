package com.dao;

import com.model.Therapist;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class TherapistRequestDAO {

    /* =====================================================
     * 1️⃣ Therapist Side
     * Prevent duplicate apply to SAME salon
     * (PENDING or APPROVED)
     * ===================================================== */
    public boolean hasExistingRequest(int therapistId, int salonId) {

        String sql = """
            SELECT 1
            FROM therapist_requests
            WHERE therapist_id = ?
              AND salon_id = ?
              AND status IN ('PENDING', 'APPROVED')
            LIMIT 1
        """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, therapistId);
            ps.setInt(2, salonId);
            return ps.executeQuery().next();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /* =====================================================
     * 2️⃣ Therapist Side
     * Create salon join request (PENDING)
     * ===================================================== */
    public void createRequest(int therapistId, int salonId) {

        String sql = """
            INSERT INTO therapist_requests (therapist_id, salon_id, status)
            VALUES (?, ?, 'PENDING')
        """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, therapistId);
            ps.setInt(2, salonId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /* =====================================================
     * 3️⃣ Owner Side
     * View pending requests for owner salons
     * ===================================================== */
    public List<Therapist> getPendingRequestsForOwner(int ownerId) {

        List<Therapist> list = new ArrayList<>();

        String sql = """
            SELECT
                t.id AS therapist_id,
                t.name,
                t.specialization,
                t.experience,
                tr.salon_id
            FROM therapist_requests tr
            JOIN therapists t ON tr.therapist_id = t.id
            JOIN salons s ON tr.salon_id = s.id
            WHERE tr.status = 'PENDING'
              AND s.owner_id = ?
            ORDER BY tr.created_at
        """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, ownerId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Therapist t = new Therapist();
                t.setId(rs.getInt("therapist_id"));
                t.setName(rs.getString("name"));
                t.setSpecialization(rs.getString("specialization"));
                t.setExperience(rs.getInt("experience"));
                t.setSalonId(rs.getInt("salon_id")); // temp holder
                list.add(t);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    /* =====================================================
     * 4️⃣ Owner Side (OPTION 3 CORE LOGIC)
     * FIRST approval wins, others auto-rejected
     * ===================================================== */
    public boolean approveRequest(int therapistId, int salonId) {

        Connection con = null;

        try {
            con = DBConnection.getConnection();
            con.setAutoCommit(false);

            /* 🔒 Check if therapist already approved elsewhere */
            Integer existingSalonId = null;

            try (PreparedStatement check = con.prepareStatement(
                    "SELECT salon_id FROM therapists WHERE id = ?")) {

                check.setInt(1, therapistId);
                ResultSet rs = check.executeQuery();

                if (rs.next()) {
                    existingSalonId = rs.getObject("salon_id", Integer.class);
                }
            }

            /* ❌ Already approved → block */
            if (existingSalonId != null && existingSalonId > 0) {
                con.rollback();
                return false;
            }

            /* ✅ Attach therapist to THIS salon */
            try (PreparedStatement ps1 = con.prepareStatement(
                    "UPDATE therapists SET salon_id = ?, status = 'APPROVED' WHERE id = ?")) {

                ps1.setInt(1, salonId);
                ps1.setInt(2, therapistId);
                ps1.executeUpdate();
            }

            /* ✅ Approve THIS request */
            try (PreparedStatement ps2 = con.prepareStatement(
                    "UPDATE therapist_requests SET status = 'APPROVED' " +
                    "WHERE therapist_id = ? AND salon_id = ?")) {

                ps2.setInt(1, therapistId);
                ps2.setInt(2, salonId);
                ps2.executeUpdate();
            }

            /* 🚫 Auto-reject ALL other pending requests */
            try (PreparedStatement ps3 = con.prepareStatement(
                    "UPDATE therapist_requests SET status = 'REJECTED' " +
                    "WHERE therapist_id = ? AND salon_id <> ? AND status = 'PENDING'")) {

                ps3.setInt(1, therapistId);
                ps3.setInt(2, salonId);
                ps3.executeUpdate();
            }

            con.commit();
            return true;

        } catch (Exception e) {
            try { if (con != null) con.rollback(); } catch (Exception ignored) {}
            e.printStackTrace();
        } finally {
            try { if (con != null) con.close(); } catch (Exception ignored) {}
        }

        return false;
    }

    /* =====================================================
     * 5️⃣ Owner Side
     * Reject therapist request
     * ===================================================== */
    public boolean rejectRequest(int therapistId, int salonId) {

        String sql = """
            UPDATE therapist_requests
            SET status = 'REJECTED'
            WHERE therapist_id = ? AND salon_id = ?
        """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, therapistId);
            ps.setInt(2, salonId);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
    
    /* =====================================================
     * Therapist Side
     * Get request status for a salon
     * ===================================================== */
    public String getRequestStatus(int therapistId, int salonId) {

        String sql = """
            SELECT status
            FROM therapist_requests
            WHERE therapist_id = ?
              AND salon_id = ?
            ORDER BY created_at DESC
            LIMIT 1
        """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, therapistId);
            ps.setInt(2, salonId);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("status");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null; // no request yet
    }
    /* =====================================================
     * Therapist Side
     * View all my applications
     * ===================================================== */
    public List<Object[]> getApplicationsForTherapist(int therapistId) {

        List<Object[]> list = new ArrayList<>();

        String sql = """
            SELECT
                s.name AS salon_name,
                s.city,
                tr.status,
                tr.created_at
            FROM therapist_requests tr
            JOIN salons s ON tr.salon_id = s.id
            WHERE tr.therapist_id = ?
            ORDER BY tr.created_at DESC
        """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, therapistId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(new Object[] {
                    rs.getString("salon_name"),
                    rs.getString("city"),
                    rs.getString("status"),
                    rs.getTimestamp("created_at")
                });
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

}
