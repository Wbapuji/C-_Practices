package com.charity.dao;

import com.charity.model.Allocation;
import com.charity.util.DBConnection;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AllocationDAO {

    public void insert(Allocation a) throws SQLException {
        String sql = "INSERT INTO allocations (purpose, amount, allocated_on, org_id) " +
                     "VALUES (?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, a.getPurpose());
            ps.setDouble(2, a.getAmount());
            ps.setDate(3, Date.valueOf(a.getAllocatedOn()));
            ps.setInt(4, a.getOrgId());
            ps.executeUpdate();
        }
    }

    public List<Allocation> findAll() throws SQLException {
        String sql = "SELECT a.allocation_id, a.purpose, a.amount, a.allocated_on, " +
                     "       a.org_id, o.name AS org_name " +
                     "FROM allocations a " +
                     "JOIN organizations o ON a.org_id = o.org_id " +
                     "ORDER BY a.allocated_on DESC";
        List<Allocation> list = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Allocation(
                        rs.getInt("allocation_id"),
                        rs.getString("purpose"),
                        rs.getDouble("amount"),
                        rs.getDate("allocated_on").toLocalDate(),
                        rs.getInt("org_id"),
                        rs.getString("org_name")));
            }
        }
        return list;
    }

    /** How much this organization has already spent. Used to block over-allocation. */
    public double totalAllocatedForOrg(int orgId) throws SQLException {
        String sql = "SELECT COALESCE(SUM(amount), 0) AS total FROM allocations WHERE org_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, orgId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? rs.getDouble("total") : 0.0;
            }
        }
    }
}
