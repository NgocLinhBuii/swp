/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import config.PasswordUtil;
import model.Student;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author BuiNgocLinh
 */
public class StudentDAO extends DBContext {

    private final PasswordUtil passwordEncode = new PasswordUtil();

    public List<Student> searchByKeyword(String keyword) throws SQLException {
        List<Student> list = new ArrayList<>();
        String sql = "SELECT * FROM student WHERE full_name LIKE ? OR username LIKE ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            String likePattern = "%" + keyword + "%";
            stmt.setString(1, likePattern);
            stmt.setString(2, likePattern);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Student s = new Student();
                    s.setId(rs.getInt("id"));
                    s.setGrade_id(rs.getInt("grade_id"));
                    s.setParent_id(rs.getInt("parent_id"));
                    s.setUsername(rs.getString("username"));
                    s.setPassword(rs.getString("password"));
                    s.setFull_name(rs.getString("full_name"));
                    s.setDob(rs.getDate("dob").toLocalDate());
                    s.setSex(rs.getBoolean("sex"));
                    s.setImage_id(rs.getInt("image_id"));
                    list.add(s);
                }
            }
        }
        return list;
    }

    public List<Student> findAll() throws SQLException {
        List<Student> list = new ArrayList<>();
        String sql = "SELECT * FROM student";
        try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Student s = new Student(
                        rs.getInt("id"),
                        rs.getInt("grade_id"),
                        rs.getInt("parent_id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("full_name"),
                        rs.getDate("dob").toLocalDate(),
                        rs.getBoolean("sex"),
                        rs.getInt("image_id")
                );
                list.add(s);
            }
        }
        return list;
    }

    public void insert(Student student) throws SQLException {
        String sql = "INSERT INTO student (id, grade_id, parent_id, username, password, full_name, dob, sex, image_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, student.getId());
            stmt.setInt(2, student.getGrade_id());
            stmt.setInt(3, student.getParent_id());
            stmt.setString(4, student.getUsername());
            stmt.setString(5, passwordEncode.hashPassword(student.getPassword()));
            stmt.setString(6, student.getFull_name());
            stmt.setDate(7, java.sql.Date.valueOf(student.getDob()));
            stmt.setBoolean(8, student.isSex());
            stmt.setInt(9, student.getImage_id());
            stmt.executeUpdate();
        }
    }

    public void update(Student student) throws SQLException {
        String sql = "UPDATE Student SET grade_id = ?, parent_id = ?, username = ?, password = ?, full_name = ?, dob = ?, sex = ?, image_id = ? WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, student.getGrade_id());
            stmt.setInt(2, student.getParent_id());
            stmt.setString(3, student.getUsername());
            stmt.setString(4, passwordEncode.hashPassword(student.getPassword()));
            stmt.setString(5, student.getFull_name());
            stmt.setDate(6, java.sql.Date.valueOf(student.getDob()));
            stmt.setBoolean(7, student.isSex());
            stmt.setInt(8, student.getImage_id());
            stmt.setInt(9, student.getId());

            stmt.executeUpdate();
        }
    }

    public void delete(int id) throws SQLException {
        String sql = "DELETE FROM student WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

    public Student findById(int id) throws SQLException {
        String sql = "SELECT * FROM student WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Student(
                            rs.getInt("id"),
                            rs.getInt("grade_id"),
                            rs.getInt("parent_id"),
                            rs.getString("username"),
                            rs.getString("password"),
                            rs.getString("full_name"),
                            rs.getDate("dob").toLocalDate(),
                            rs.getBoolean("sex"),
                            rs.getInt("image_id")
                    );
                }
            }
        }
        return null;
    }

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

    public static void main(String[] args) {
        StudentDAO dao = new StudentDAO();

        try {
            dao.delete(3);
            System.out.println("Xóa thành công!");
        } catch (SQLException e) {
            System.out.println("Lỗi khi xóa: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
