package org.example.dao;

import org.apache.commons.dbcp2.BasicDataSource;
import org.example.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {
    private final BasicDataSource dataSource;

    public UserDAO(BasicDataSource dataSource) {
        this.dataSource = dataSource;
    }

    public User getUserByUsernameAndPassword(String username, String password) throws SQLException {
        String sql = "select * from users where username = ? and password = ?";


        Connection connection = dataSource.getConnection();
        PreparedStatement ps = connection.prepareStatement(sql);

        ps.setString(1, username);
        ps.setString(2, password);

        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return new User(rs.getString("id"), rs.getString("username"), rs.getString("password"), rs.getString("role"));

        }

        return null;
    }

    public User getUserById(String id) throws SQLException {
        String sql = "select * from users where id = ?";

        Connection connection = dataSource.getConnection();
        PreparedStatement ps = connection.prepareStatement(sql);

        ps.setString(1, id);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return new User(rs.getString("id"), rs.getString("username"), rs.getString("password"), rs.getString("role"));
        }
        return null;
    }


    public User validateLogin(String username, String password) throws SQLException {
        User user = null;

        try(Connection connection = dataSource.getConnection()){
            String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setId(rs.getString("id"));
                user.setUsername(rs.getString("username"));
                user.setRole(rs.getString("role"));
        }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    public User getUserByUsername(String username) throws SQLException {
        String sql = "SELECT * FROM users WHERE username = ?";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new User(
                        rs.getString("id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("role")
                );
            }
        }
        return null;
    }


    public boolean createUser(User user) throws SQLException {
        String sql = "insert into users(id, username, password, role) values(?, ?, ?,?)";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setString(1, user.getId());
            ps.setString(2, user.getUsername());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getRole());

            return ps.executeUpdate() > 0;
        }
    }

}

