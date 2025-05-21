package DAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Lesson;

public class LessonDAO extends DBContext {

    public List<Lesson> getAllLessons() {
        List<Lesson> lessons = new ArrayList<>();
        String sql = "SELECT * FROM lesson";
        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Lesson l = new Lesson(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("content"),
                        rs.getInt("chapter_id")
                );
                lessons.add(l);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lessons;
    }

    public Lesson getLessonById(int id) {
        String sql = "SELECT * FROM lesson WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Lesson(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("content"),
                        rs.getInt("chapter_id")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void insertLesson(Lesson lesson) {
        String sql = "INSERT INTO lesson (name, content, chapter_id) VALUES (?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, lesson.getName());
            stmt.setString(2, lesson.getContent());
            stmt.setInt(3, lesson.getChapter_id());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateLesson(Lesson lesson) {
        String sql = "UPDATE lesson SET name = ?, content = ?, chapter_id = ? WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, lesson.getName());
            stmt.setString(2, lesson.getContent());
            stmt.setInt(3, lesson.getChapter_id());
            stmt.setInt(4, lesson.getId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteLesson(int id) {
        String sql = "DELETE FROM lesson WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public static void main(String[] args) {
        LessonDAO dao = new LessonDAO();
        List<Lesson> lessons = dao.getAllLessons();
        for(Lesson le : lessons)
        {
            System.out.println(le);
        }
        
    }
}
