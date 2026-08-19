package com.charity.dao;

import com.charity.model.Volunteer;
import com.charity.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class VolunteerDAO {

    public void insert(Volunteer v) throws SQLException {
        String sql = "INSERT INTO volunteers (name, phone, org_id) VALUES (?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, v.getName());
            ps.setString(2, v.getPhone());
            ps.setInt(3, v.getOrgId());
            ps.executeUpdate();
        }
    }

    /**
     * JOIN so the list shows the organization NAME instead of a meaningless
     * org_id number. The volunteers table stores only the id; the name lives
     * in one place (organizations) and is looked up when needed.
     */
    public List<Volunteer> findAll() throws SQLException {
        String sql = "SELECT v.volunteer_id, v.name, v.phone, v.org_id, o.name AS org_name " +
                     "FROM volunteers v " +
                     "JOIN organizations o ON v.org_id = o.org_id " +
                     "ORDER BY v.name";
        List<Volunteer> list = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Volunteer(
                        rs.getInt("volunteer_id"),
                        rs.getString("name"),
                        rs.getString("phone"),
                        rs.getInt("org_id"),
                        rs.getString("org_name")));
            }
        }
        return list;
    }
}
