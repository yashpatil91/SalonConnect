package com.dao;

import com.model.Therapist;
import com.model.Rating;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TherapistDAO {

    // ===============================
    // Get Therapist by logged-in user
    // ===============================
    public Therapist getTherapistByUserId(int userId) {

        Therapist therapist = null;

        String sql = """
            SELECT
                t.id,
                t.user_id,
                t.salon_id,
                t.name,
                t.specialization,
                t.experience,
                t.phone,
                t.rating,
                t.image_url,
                t.status,
                t.created_at,
                t.email,
                s.name AS salon_name
            FROM therapists t
            LEFT JOIN salons s ON t.salon_id = s.id
            WHERE t.user_id = ?
        """;

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                therapist = new Therapist();

                therapist.setId(rs.getInt("id"));
                therapist.setUserId(rs.getInt("user_id"));
                therapist.setSalonId(rs.getObject("salon_id", Integer.class));
                therapist.setName(rs.getString("name"));
                therapist.setSpecialization(rs.getString("specialization"));
                therapist.setExperience(rs.getInt("experience"));
                therapist.setPhone(rs.getString("phone"));
                therapist.setRating(rs.getDouble("rating"));
                therapist.setImageUrl(rs.getString("image_url"));
                therapist.setStatus(rs.getString("status"));
                therapist.setCreatedAt(rs.getTimestamp("created_at"));
                therapist.setEmail(rs.getString("email"));

                // Salon name
                therapist.setSalonName(rs.getString("salon_name"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return therapist;
    }

    // ===============================
    // Get recent ratings for therapist
    // ===============================
    public List<Rating> getRatingsByTherapist(int therapistId) {

        List<Rating> list = new ArrayList<>();

        String sql = """
            SELECT r.id, r.rating, r.review, r.created_at, u.name AS customer_name
            FROM ratings r
            JOIN users u ON r.user_id = u.id
            WHERE r.therapist_id = ?
            ORDER BY r.created_at DESC
            LIMIT 5
        """;

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, therapistId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Rating rating = new Rating();
                rating.setId(rs.getInt("id"));
                rating.setRating(rs.getInt("rating"));
                rating.setReview(rs.getString("review"));
                rating.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(rating);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
