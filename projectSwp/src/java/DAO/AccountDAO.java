/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Account;

/**
 *
 * @author BuiNgocLinh
 */
public class AccountDAO extends DBContext {

    //hien thi all acc
    public List<Account> findAll() throws SQLException {
        String sql = "SELECT * FROM account";
        List<Account> accounts = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Account acc = new Account();
                acc.setId(rs.getInt("id"));
                acc.setEmail(rs.getString("email"));
                acc.setPassword(rs.getString("password"));
                acc.setStatus(rs.getString("status"));
                acc.setRole(rs.getString("role"));
                acc.setFull_name(rs.getString("full_name"));
                acc.setSex(rs.getObject("sex") == null ? null : rs.getInt("sex"));
                acc.setDob(rs.getDate("dob") == null ? null : rs.getDate("dob").toLocalDate());
                acc.setImage_id(rs.getObject("image_id") == null ? null : rs.getInt("image_id"));
                accounts.add(acc);
            }
        }
        return accounts;
    }

    // Tìm account theo email
    public List<Account> findByEmail(String email) throws SQLException {
        String sql = "SELECT * FROM account WHERE email = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                List<Account> accounts = new ArrayList<>();
                while (rs.next()) {
                    Account acc = new Account();
                    acc.setId(rs.getInt("id"));
                    acc.setEmail(rs.getString("email"));
                    acc.setPassword(rs.getString("password"));
                    acc.setStatus(rs.getString("status"));
                    acc.setRole(rs.getString("role"));
                    acc.setFull_name(rs.getString("full_name"));
                    acc.setSex(rs.getObject("sex") == null ? null : rs.getInt("sex"));
                    java.sql.Date sqlDate = rs.getDate("dob");
                    acc.setDob(sqlDate == null ? null : sqlDate.toLocalDate());
                    acc.setImage_id(rs.getInt("image_id"));
                    accounts.add(acc);
                }
                return accounts;
            }
        }
    }

    public boolean insert(Account account) throws SQLException {
        String sql = "INSERT INTO account (email, password, status, role, full_name, sex, dob, image_id) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, account.getEmail());
            ps.setString(2, account.getPassword());
            ps.setString(3, account.getStatus());
            ps.setString(4, account.getRole());
            ps.setString(5, account.getFull_name());

            // Handle nullable Integer fields
            if (account.getSex() != null) {
                ps.setInt(6, account.getSex());
            } else {
                ps.setNull(6, java.sql.Types.INTEGER);
            }

            if (account.getDob() != null) {
                ps.setDate(7, java.sql.Date.valueOf(account.getDob()));
            } else {
                ps.setNull(7, java.sql.Types.INTEGER);
            }

            if (account.getImage_id() != null) {
                ps.setInt(8, account.getImage_id());
            } else {
                ps.setNull(8, java.sql.Types.INTEGER);
            }

            return ps.executeUpdate() > 0;
        }
    }

    public Account findByEmailAndPassword(String email, String password) throws SQLException {
        String sql = "SELECT * FROM account WHERE email = ? AND password = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setString(1, email);
        ps.setString(2, password);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            Account account = new Account();
            account.setId(rs.getInt("id"));
            account.setEmail(rs.getString("email"));
            account.setPassword(rs.getString("password"));
            account.setFull_name(rs.getString("full_name"));
            account.setStatus(rs.getString("status"));
            account.setRole(rs.getString("role"));
            account.setSex(rs.getObject("sex") == null ? null : rs.getInt("sex"));
            account.setDob(rs.getDate("dob").toLocalDate());
            account.setImage_id(rs.getInt("image_id"));
            return account;
        }
        return null;
    }

}
