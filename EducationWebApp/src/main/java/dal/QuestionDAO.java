package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Question;

public class QuestionDAO extends DBContext {

    public Connection getDBConnection() {
        return this.connection;
    }
    public List<Question> findAllQuestion() throws SQLException {
        List<Question> list = new ArrayList<>();
        String sql = "SELECT * FROM Question";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Question q = new Question(
                        rs.getInt("id"),
                        rs.getString("question"),
                        rs.getInt("image_id"),
                        rs.getInt("lesson_id")
                );
                list.add(q);
            }
        }
        return list;
    }

    public Question getQuestionById(int id) throws SQLException {
        String sql = "SELECT * FROM Question WHERE id = ?";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Question(
                            rs.getInt("id"),
                            rs.getString("question"),
                            rs.getInt("image_id"),
                            rs.getInt("lesson_id")
                    );
                }
            }
        }
        return null;
    }

    public void insert(Question question) throws SQLException {
        String sql = "INSERT INTO Question (question, image_id, lesson_id) VALUES (?, ?, ?)";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, question.getQuestion());
            stmt.setInt(2, question.getImage_id());
            stmt.setInt(3, question.getLesson_id());
            stmt.executeUpdate();
        }
    }

    public void update(Question question) throws SQLException {
        String sql = "UPDATE Question SET question = ?, image_id = ?, lesson_id = ? WHERE id = ?";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, question.getQuestion());
            stmt.setInt(2, question.getImage_id());
            stmt.setInt(3, question.getLesson_id());
            stmt.setInt(4, question.getId());
            stmt.executeUpdate();
        }
    }

    public void delete(int id) throws SQLException {
        String sql = "DELETE FROM Question WHERE id = ?";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

    public List<Question> findByQuestion(String keyword) throws SQLException {
        List<Question> list = new ArrayList<>();
        String sql = "SELECT * FROM Question WHERE question LIKE ?";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, "%" + keyword + "%");
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Question q = new Question(
                            rs.getInt("id"),
                            rs.getString("question"),
                            rs.getInt("image_id"),
                            rs.getInt("lesson_id")
                    );
                    list.add(q);
                }
            }
        }
        return list;
    }
}
