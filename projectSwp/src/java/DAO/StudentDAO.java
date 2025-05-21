/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import config.PasswordUtil;
import model.Student;
import java.sql.*;
import java.time.LocalDate;

/**
 *
 * @author BuiNgocLinh
 */
public class StudentDAO extends DBContext {

    private final PasswordUtil passwordEncode = new PasswordUtil();

    public Student checkLogin(String username, String password) {
        Student student = null;
        String sql = "SELECT * FROM student WHERE username = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int id = rs.getInt("id");
                    String passwordHash = rs.getString("password");
                    if (passwordEncode.checkPassword(password, passwordHash)) {
                        int grade_id = rs.getInt("grade_id");
                        int parent_id = rs.getInt("parent_id");
                        String fullName = rs.getString("full_name");
                        LocalDate dob = rs.getDate("dob").toLocalDate();
                        boolean sex = rs.getBoolean("sex");
                        int image_id = rs.getInt("image_id");
                        student = new Student(id, grade_id, parent_id, username, password, fullName, dob, sex, image_id);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return student;
    }
}
