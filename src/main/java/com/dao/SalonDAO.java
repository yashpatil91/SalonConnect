package com.dao;

import com.model.Salon;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class SalonDAO {

    // ===============================
    // Therapist Browse: Get all salons
    // ===============================
    public List<Salon> getAllSalons() {

        List<Salon> salons = new ArrayList<>();

        String sql = "SELECT * FROM salons ORDER BY rating DESC, name";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Salon salon = new Salon();
                salon.setId(rs.getInt("id"));
                salon.setOwnerId(rs.getInt("owner_id"));
                salon.setName(rs.getString("name"));
                salon.setAddress(rs.getString("address"));
                salon.setCity(rs.getString("city"));
                salon.setPhone(rs.getString("phone"));
                salon.setDescription(rs.getString("description"));
                salon.setImageUrl(rs.getString("image_url"));
                salon.setRating(rs.getDouble("rating"));
                salon.setCreatedAt(rs.getTimestamp("created_at"));

                salons.add(salon);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return salons;
    }
}
