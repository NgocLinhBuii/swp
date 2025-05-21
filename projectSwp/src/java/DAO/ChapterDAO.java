/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Account;
import model.Chapter;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Na
 */
public class ChapterDAO extends DBContext {

    //hien thi all chapter
    public List<Chapter> getChapter(String sql) {
        List<Chapter> list = new ArrayList<>();

        try {
            Statement state = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = state.executeQuery(sql);
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String description = rs.getString("description");
                int subject_id = rs.getInt("subject_id");
                Chapter chapter = new Chapter(id, name, description, subject_id);
                list.add(chapter);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ChapterDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    //add them new chapter
    public int addChapter(Chapter chapter) {
        int n = 0;
        String sql = "INSERT INTO chapter (id, name, description, subject_id)\n"
                + "     VALUES\n"
                + "(?, ?, ?, ?)";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, chapter.getId());
            pre.setString(2, chapter.getName());
            pre.setString(3, chapter.getDescription());
            pre.setInt(4, chapter.getSubject_id());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ChapterDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }
    
    //edit chapter
    public int editChapter(Chapter chapter) {
        int n = 0;
        String sql = """
                     UPDATE chapter
                        SET name = ?
                           ,description = ?
                           ,subject_id = ?
                     WHERE id = ?
                     """;
        
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, chapter.getName());
            pre.setString(2,chapter.getDescription());
            pre.setInt(3, chapter.getSubject_id());
            pre.setInt(4, chapter.getId());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ChapterDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }
    
    //delete chapter theo id
    public int deleteChapter(int id) {
        int n = 0;
        String sql = "DELETE FROM chapter WHERE id = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, id);
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ChapterDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }
    
    public static void main(String[] args) {
        ChapterDAO daoC = new ChapterDAO();
        List<Chapter> list = daoC.getChapter("select * from chapter");
        int n = daoC.addChapter(new Chapter(3, ":Rơi tự do", "Giới thiệu về rơi tự do",1));
        for (Chapter chapter : list) {
            System.out.println(chapter);
        }
    }
}
