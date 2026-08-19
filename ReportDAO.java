package com.charity.dao;

import com.charity.model.OrgReport;
import com.charity.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * The dashboard report: one row per organization, with its volunteer count,
 * total money received, and total money allocated.
 *
 * NOTE ON THE QUERY DESIGN (a good thing to be able to explain):
 * The obvious approach is to JOIN organizations to volunteers, donations and
 * allocations all at once and then SUM. That gives WRONG numbers - if an
 * organization has 3 volunteers and 4 donations, the join produces 12 rows and
 * every donation amount gets counted 3 times. Using a separate sub-query per
 * total keeps each SUM independent, so each one counts its rows exactly once.
 */
public class ReportDAO {

    public List<OrgReport> organizationSummary() throws SQLException {
        String sql =
            "SELECT o.name, o.city, " +
            "  (SELECT COUNT(*)                FROM volunteers  v WHERE v.org_id = o.org_id) AS volunteer_count, " +
            "  (SELECT COALESCE(SUM(d.amount), 0) FROM donations   d WHERE d.org_id = o.org_id) AS total_donated, " +
            "  (SELECT COALESCE(SUM(a.amount), 0) FROM allocations a WHERE a.org_id = o.org_id) AS total_allocated " +
            "FROM organizations o " +
            "ORDER BY total_donated DESC";

        List<OrgReport> report = new ArrayList<>();
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                report.add(new OrgReport(
                        rs.getString("name"),
                        rs.getString("city"),
                        rs.getInt("volunteer_count"),
                        rs.getDouble("total_donated"),
                        rs.getDouble("total_allocated")));
            }
        }
        return report;
    }
}
