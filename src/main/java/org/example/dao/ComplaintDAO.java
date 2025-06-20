package org.example.dao;

import org.apache.commons.dbcp2.BasicDataSource;
import org.example.model.Complaint;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ComplaintDAO {
    private final BasicDataSource dataSource;

    public ComplaintDAO(BasicDataSource dataSource) {
        this.dataSource = dataSource;
    }

    public List<Complaint> getAllComplaints() throws SQLException {
        String sql = "select * from complaints order by created_at desc";
        List<Complaint> complaints = new ArrayList<>();

        try (Connection conn = dataSource.getConnection()) {
            PreparedStatement   ps = conn.prepareStatement(sql);

            ResultSet rs = ps.executeQuery(sql);
            while (rs.next()){
                complaints.add(extractComplaint(rs));
            }
        }
        return complaints;
    }

    public boolean updateComplaintStatus(int id, String status, String remarks) throws SQLException {
        String sql = "update complaints set status=?, remarks=?, updated_at = CURRENT_TIMESTAMP where id=?";
        try (Connection conn = dataSource.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, status);
            ps.setString(2, remarks);
            ps.setInt(3, id);

            return ps.executeUpdate() > 0;
        }
    }

    public boolean deleteComplaint(int id) throws SQLException {
        String sql = "delete from complaints where id=?";
        try (Connection conn = dataSource.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    private Complaint extractComplaint(ResultSet rs) throws SQLException {
        return new Complaint(
            rs.getInt("id"),
            rs.getString("title"),
            rs.getString("description"),
            rs.getString("status"),
            rs.getString("remarks"),
            rs.getTimestamp("created_at"),
            rs.getTimestamp("updated_at"),
            rs.getString("user_id")
        );
    }

    public boolean submitComplaint(Complaint complaint) throws SQLException {
        String sql = "INSERT INTO complaints (title, description, status, user_id) VALUES (?, ?, ?, ?)";
        try (Connection con = dataSource.getConnection()){
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, complaint.getTitle());
            stm.setString(2, complaint.getDescription());
            stm.setString(3, complaint.getStatus());
            stm.setString(4, complaint.getUserId());

            return stm.executeUpdate() > 0;
        }
    }

    public Complaint getComplaintById(String id) throws SQLException {
        String sql = "SELECT * FROM complaints WHERE id = ?";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Complaint c = new Complaint();
                    c.setId(Integer.parseInt(rs.getString("id")));
                    c.setUserId(rs.getString("user_id"));
                    c.setTitle(rs.getString("title"));
                    c.setDescription(rs.getString("description"));
                    c.setStatus(rs.getString("status"));
                    c.setRemarks(rs.getString("remarks"));
                    c.setCreatedAt(rs.getTimestamp("created_at"));
                    c.setUpdatedAt(rs.getTimestamp("updated_at"));
                    return c;
                }
            }
        }
        return null;
    }

    public boolean updateComplaint(Complaint complaint) throws SQLException {
        String sql = "UPDATE complaints SET title = ?, description = ?, status = ?, remarks = ?, updated_at = CURRENT_TIMESTAMP WHERE id = ?";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, complaint.getTitle());
            ps.setString(2, complaint.getDescription());
            ps.setString(3, complaint.getStatus());
            ps.setString(4, complaint.getRemarks());
            ps.setString(5, String.valueOf(complaint.getId()));
            return ps.executeUpdate() > 0;
        }
    }


    public List<Complaint> getComplaintsByUserId(String userId) throws SQLException {
        List<Complaint> complaints = new ArrayList<>();
        String sql = "SELECT * FROM complaints WHERE user_id = ?";

        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                complaints.add(extractComplaint(rs));
            }
        }
        return complaints;
    }
}


