package com.charity.dao;

import com.charity.model.Donation;
import com.charity.util.DBConnection;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DonationDAO {

    public void insert(Donation d) throws SQLException {
        String sql = "INSERT INTO donations (donor_name, amount, donation_date, org_id) " +
                     "VALUES (?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, d.getDonorName());
            ps.setDouble(2, d.getAmount());
            // java.time.LocalDate -> java.sql.Date, the type JDBC understands
            ps.setDate(3, Date.valueOf(d.getDonationDate()));
            ps.setInt(4, d.getOrgId());
            ps.executeUpdate();
        }
    }

    public List<Donation> findAll() throws SQLException {
        String sql = "SELECT d.donation_id, d.donor_name, d.amount, d.donation_date, " +
                     "       d.org_id, o.name AS org_name " +
                     "FROM donations d " +
                     "JOIN organizations o ON d.org_id = o.org_id " +
                     "ORDER BY d.donation_date DESC";
        List<Donation> list = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Donation(
                        rs.getInt("donation_id"),
                        rs.getString("donor_name"),
                        rs.getDouble("amount"),
                        rs.getDate("donation_date").toLocalDate(),
                        rs.getInt("org_id"),
                        rs.getString("org_name")));
            }
        }
        return list;
    }

    /** SUM() returns NULL when there are no rows, so COALESCE turns that into 0. */
    public double totalDonated() throws SQLException {
        String sql = "SELECT COALESCE(SUM(amount), 0) AS total FROM donations";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            return rs.next() ? rs.getDouble("total") : 0.0;
        }
    }

    /** How much this one organization has received. Used to block over-allocation. */
    public double totalDonatedForOrg(int orgId) throws SQLException {
        String sql = "SELECT COALESCE(SUM(amount), 0) AS total FROM donations WHERE org_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, orgId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? rs.getDouble("total") : 0.0;
            }
        }
    }
}
