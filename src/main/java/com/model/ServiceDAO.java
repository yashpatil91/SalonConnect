package com.model;

import com.dao.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ServiceDAO {

    // 🔹 Get all services (for services.jsp)
    public static List<Service> getAllServices() {

        List<Service> services = new ArrayList<>();

        String sql = "SELECT id, salon_id, name, description, price, duration, category, image_url FROM services";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Service s = new Service();

                s.setId(rs.getInt("id"));
                s.setSalonId(rs.getInt("salon_id"));
                s.setName(rs.getString("name"));
                s.setDescription(rs.getString("description"));
                s.setPrice(rs.getDouble("price"));
                s.setDuration(rs.getInt("duration"));
               
                s.setCategory(rs.getString("category"));
                s.setImageUrl(rs.getString("image_url"));


                services.add(s);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return services;
    }

    // 🔹 Get services by salon (used in salon details page)
    public static List<Service> getServicesBySalonId(int salonId) {

        List<Service> services = new ArrayList<>();

        String sql = "SELECT * FROM services WHERE salon_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, salonId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Service s = new Service();

                s.setId(rs.getInt("id"));
                s.setSalonId(rs.getInt("salon_id"));
                s.setName(rs.getString("name"));
                s.setDescription(rs.getString("description"));
                s.setPrice(rs.getDouble("price"));
                s.setDuration(rs.getInt("duration"));
                s.setCategory(rs.getString("category"));
                s.setImageUrl(rs.getString("image_url"));


                services.add(s);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return services;
    }

    // 🔹 Add new service (owner side)
    public static boolean addService(Service s) {


    	String sql = "INSERT INTO services (salon_id, name, description, price, duration, category, image_url) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

        	ps.setInt(1, s.getSalonId());
        	ps.setString(2, s.getName());
        	ps.setString(3, s.getDescription());
        	ps.setDouble(4, s.getPrice());
        	ps.setInt(5, s.getDuration());
        	ps.setString(6, s.getCategory());
        	ps.setString(7, s.getImageUrl());


            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}
