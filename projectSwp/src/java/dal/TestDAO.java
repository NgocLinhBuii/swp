package dal;

import model.Test;
import java.sql.*;
import java.util.*;

public class TestDAO extends DBContext {
    private Connection conn;

    // ✅ Constructor khởi tạo kết nối
    public TestDAO() {
        try {
            this.conn = getConnection(); // Lấy connection từ DBContext
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void addTest(Test test) {
        String sql = "INSERT INTO test (name, description, is_practice, category_id) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, test.getName());
            ps.setString(2, test.getDescription());
            ps.setBoolean(3, test.isIs_practice());
            ps.setInt(4, test.getCategory_id());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateTest(Test test) {
        String sql = "UPDATE test SET name = ?, description = ?, is_practice = ?, category_id = ? WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, test.getName());
            ps.setString(2, test.getDescription());
            ps.setBoolean(3, test.isIs_practice());
            ps.setInt(4, test.getCategory_id());
            ps.setInt(5, test.getId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteTest(int id) {
        String sql = "DELETE FROM test WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Test getTestById(int id) {
        String sql = "SELECT * FROM test WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Test(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("description"),
                    rs.getBoolean("is_practice"),
                    rs.getInt("category_id")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Test> getAllTests() {
        List<Test> list = new ArrayList<>();
        String sql = "SELECT * FROM test";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Test(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("description"),
                    rs.getBoolean("is_practice"),
                    rs.getInt("category_id")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
