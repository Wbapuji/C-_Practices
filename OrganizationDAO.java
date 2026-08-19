package com.charity.dao;

import com.charity.model.Organization;
import com.charity.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO = Data Access Object.
 *
 * This class is the ONLY place in the project that knows the SQL for the
 * organizations table. Nothing above it (service, web) contains SQL.
 * If we moved from MySQL to PostgreSQL, only DAO classes would change.
 */
public class OrganizationDAO {

    public void insert(Organization org) throws SQLException {
        String sql = "INSERT INTO organizations (name, city, contact_email) VALUES (?, ?, ?)";

        // try-with-resources: Connection and PreparedStatement are closed
        // automatically at the end of the block, even if an exception is thrown.
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, org.getName());
            ps.setString(2, org.getCity());
            ps.setString(3, org.getContactEmail());
            ps.executeUpdate();          // executeUpdate() for INSERT/UPDATE/DELETE
        }
    }

    public List<Organization> findAll() throws SQLException {
        String sql = "SELECT org_id, name, city, contact_email FROM organizations ORDER BY name";
        List<Organization> list = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {   // executeQuery() for SELECT

            while (rs.next()) {              // rs.next() moves to the next row
                list.add(new Organization(
                        rs.getInt("org_id"),
                        rs.getString("name"),
                        rs.getString("city"),
                        rs.getString("contact_email")));
            }
        }
        return list;
    }

    public void deleteById(int orgId) throws SQLException {
        String sql = "DELETE FROM organizations WHERE org_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, orgId);
            ps.executeUpdate();
        }
    }
}
