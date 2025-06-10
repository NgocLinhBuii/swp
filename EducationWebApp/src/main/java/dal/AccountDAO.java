/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import at.favre.lib.crypto.bcrypt.BCrypt;
import config.PasswordUtil;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Account;

/**
 *
 * @author BuiNgocLinh
 */
public class AccountDAO extends DBContext {

    private final PasswordUtil passwordEncode = new PasswordUtil();

    //hien thi all acc
    public List<Account> findAll() throws SQLException {
        String sql = "SELECT * FROM account";
        List<Account> accounts = new ArrayList<>();
        PreparedStatement ps = connection.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
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

        return accounts;
    }

    public boolean existEmail(String email) {
        String sql = "SELECT * FROM account WHERE Email = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return true;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

//    public int deleteAccount(int id) throws SQLException {
//        String sqlSelectStudentIds = "SELECT id FROM student WHERE parent_id = ?";
//        String sqlSelectTestRecordIds = "SELECT id FROM test_record WHERE student_id = ?";
//        String sqlDeleteQuestionRecords = "DELETE FROM question_record WHERE test_record_id = ?";
//        String sqlDeleteTestRecords = "DELETE FROM test_record WHERE student_id = ?";
//        String sqlDeleteStudents = "DELETE FROM student WHERE parent_id = ?";
//        String sqlSelectInvoiceIds = "SELECT id FROM invoice WHERE parent_id = ?";
//        String sqlDeleteInvoiceLines = "DELETE FROM invoice_line WHERE invoice_id = ?";
//        String sqlDeleteInvoices = "DELETE FROM invoice WHERE parent_id = ?";
//        String sqlDeleteSubjects = "DELETE FROM subject WHERE grade_id IN (SELECT id FROM grade WHERE teacher_id = ?)";
//        String sqlDeleteGrades = "DELETE FROM grade WHERE teacher_id = ?";
//        String sqlDeleteImage = "DELETE FROM image WHERE id = ?";
//        String sqlDeleteAccount = "DELETE FROM account WHERE id = ?";
//
//        int rowsDeleted = 0;
//        boolean autoCommit = connection.getAutoCommit();
//        connection.setAutoCommit(false);
//
//        try (
//                PreparedStatement psSelectStudentIds = connection.prepareStatement(sqlSelectStudentIds); PreparedStatement psSelectTestRecordIds = connection.prepareStatement(sqlSelectTestRecordIds); PreparedStatement psDeleteQuestionRecords = connection.prepareStatement(sqlDeleteQuestionRecords); PreparedStatement psDeleteTestRecords = connection.prepareStatement(sqlDeleteTestRecords); PreparedStatement psDeleteStudents = connection.prepareStatement(sqlDeleteStudents); PreparedStatement psSelectInvoiceIds = connection.prepareStatement(sqlSelectInvoiceIds); PreparedStatement psDeleteInvoiceLines = connection.prepareStatement(sqlDeleteInvoiceLines); PreparedStatement psDeleteInvoices = connection.prepareStatement(sqlDeleteInvoices); PreparedStatement psDeleteSubjects = connection.prepareStatement(sqlDeleteSubjects); PreparedStatement psDeleteGrades = connection.prepareStatement(sqlDeleteGrades); PreparedStatement psDeleteImage = connection.prepareStatement(sqlDeleteImage); PreparedStatement psDeleteAccount = connection.prepareStatement(sqlDeleteAccount);) {
//            // 1. Lấy tất cả student_id liên quan tới account
//            psSelectStudentIds.setInt(1, id);
//            try (ResultSet rsStudents = psSelectStudentIds.executeQuery()) {
//                while (rsStudents.next()) {
//                    int studentId = rsStudents.getInt("id");
//
//                    // 2. Lấy tất cả test_record_id liên quan đến student
//                    psSelectTestRecordIds.setInt(1, studentId);
//                    try (ResultSet rsTestRecords = psSelectTestRecordIds.executeQuery()) {
//                        while (rsTestRecords.next()) {
//                            int testRecordId = rsTestRecords.getInt("id");
//
//                            // 3. Xóa tất cả question_record liên quan đến test_record
//                            psDeleteQuestionRecords.setInt(1, testRecordId);
//                            psDeleteQuestionRecords.executeUpdate();
//                        }
//                    }
//
//                    // 4. Xóa tất cả test_record của student
//                    psDeleteTestRecords.setInt(1, studentId);
//                    psDeleteTestRecords.executeUpdate();
//                }
//            }
//
//            // 5. Xóa tất cả student của account
//            psDeleteStudents.setInt(1, id);
//            psDeleteStudents.executeUpdate();
//
//            // 6. Xóa tất cả invoice_line -> invoice
//            psSelectInvoiceIds.setInt(1, id);
//            try (ResultSet rsInvoices = psSelectInvoiceIds.executeQuery()) {
//                while (rsInvoices.next()) {
//                    int invoiceId = rsInvoices.getInt("id");
//                    psDeleteInvoiceLines.setInt(1, invoiceId);
//                    psDeleteInvoiceLines.executeUpdate();
//                }
//            }
//            psDeleteInvoices.setInt(1, id);
//            psDeleteInvoices.executeUpdate();
//
//            // 7. Xóa subject liên quan đến grade của giáo viên này
//            psDeleteSubjects.setInt(1, id);
//            psDeleteSubjects.executeUpdate();
//
//            // 8. Xóa grade của giáo viên
//            psDeleteGrades.setInt(1, id);
//            psDeleteGrades.executeUpdate();
//
//            // 9. Xóa tài khoản
//            psDeleteAccount.setInt(1, id);
//            rowsDeleted = psDeleteAccount.executeUpdate();
//
//            // 10. Xóa ảnh liên quan nếu có
//            psDeleteImage.setInt(1, id);
//            psDeleteImage.executeUpdate();
//
//            // Commit tất cả
//            connection.commit();
//        } catch (SQLException e) {
//            connection.rollback();
//            throw e;
//        } finally {
//            connection.setAutoCommit(autoCommit);
//        }
//
//        return rowsDeleted;
//    }
    public Account findById(int id) throws SQLException {
        String sql = "SELECT * FROM account WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Account acc = new Account();
                    acc.setId(rs.getInt("id"));
                    acc.setEmail(rs.getString("email"));
                    acc.setPassword(rs.getString("password"));
                    acc.setStatus(rs.getString("status"));
                    acc.setRole(rs.getString("role"));
                    acc.setFull_name(rs.getString("full_name"));
                    acc.setSex(rs.getInt("sex"));
                    Date dob = rs.getDate("dob");
                    if (dob != null) {
                        acc.setDob(dob.toLocalDate());
                    }
                    acc.setImage_id(rs.getInt("image_id"));
                    return acc;
                }
            }
        }
        return null;
    }

    public boolean update(Account account) throws SQLException {
        String sql = "UPDATE account SET email = ?, password = ?, status = ?, role = ?, full_name = ?, sex = ?, dob = ?, image_id = ? WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, account.getEmail());
            ps.setString(2, passwordEncode.hashPassword(account.getPassword()));
            ps.setString(3, account.getStatus());
            ps.setString(4, account.getRole());
            ps.setString(5, account.getFull_name());
            ps.setInt(6, account.getSex());
            ps.setDate(7, Date.valueOf(account.getDob()));
            ps.setInt(8, account.getImage_id());
            ps.setInt(9, account.getId());

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        }
    }

    public Account selectByAccount(String email) {
        Account account = null;
        String sql = "SELECT * FROM account WHERE Email = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                account = new Account(
                        rs.getInt("id"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("status"),
                        rs.getString("role"),
                        rs.getString("full_name"),
                        rs.getInt("sex"),
                        rs.getDate("dob").toLocalDate(),
                        rs.getInt("image_id")
                );
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return account;
    }

    // Tìm account theo email
    public List<Account> findByEmail(String email) throws SQLException {
        String sql = "SELECT * FROM account WHERE email = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
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
                acc.setDob(sqlDate.toLocalDate());
                acc.setImage_id(rs.getInt("image_id"));
                accounts.add(acc);
            }
            return accounts;
        }
    }

    public boolean insert(Account account) throws SQLException {
        String sql = "INSERT INTO account (email, password, status, role, full_name, sex, dob, image_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, account.getEmail());
            stmt.setString(2, passwordEncode.hashPassword(account.getPassword()));
            stmt.setString(3, account.getStatus());
            stmt.setString(4, account.getRole());
            stmt.setString(5, account.getFull_name());
            stmt.setObject(6, account.getSex(), java.sql.Types.INTEGER);
            stmt.setObject(7, account.getDob());
            stmt.setObject(8, account.getImage_id(), java.sql.Types.INTEGER);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Account viewProfile(int accountId) throws SQLException {
        String sql = "SELECT * FROM account WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setInt(1, accountId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Account account = new Account();
                    account.setId(rs.getInt("id"));
                    account.setEmail(rs.getString("email"));
                    account.setPassword(rs.getString("password"));
                    account.setStatus(rs.getString("status"));
                    account.setRole(rs.getString("role"));
                    account.setFull_name(rs.getString("full_name"));
                    account.setSex(rs.getObject("sex") == null ? null : rs.getInt("sex"));
                    java.sql.Date sqlDate = rs.getDate("dob");
                    account.setDob(sqlDate.toLocalDate());
                    account.setImage_id(rs.getInt("image_id"));
                    return account;
                }
            }
        }
        return null;
    }

//    public Account findByEmailAndPassword(String email, String password) throws SQLException {
//        String sql = "SELECT * FROM account WHERE email = ? AND password = ?";
//        PreparedStatement ps = connection.prepareStatement(sql);
//        ps.setString(1, email);
//        ps.setString(2, password);
//        ResultSet rs = ps.executeQuery();
//        if (rs.next()) {
//            Account account = new Account();
//            account.setId(rs.getInt("id"));
//            account.setEmail(rs.getString("email"));
//            account.setPassword(rs.getString("password"));
//            account.setFull_name(rs.getString("full_name"));
//            account.setStatus(rs.getString("status"));
//            account.setRole(rs.getString("role"));
//            account.setSex(rs.getObject("sex") == null ? null : rs.getInt("sex"));
//            account.setDob(rs.getDate("dob").toLocalDate());
//            account.setImage_id(rs.getInt("image_id"));
//            return account;
//        }
//        return null;
//    }
    public List<Account> getAccountsByPage(int offset, int limit) throws SQLException {
        List<Account> list = new ArrayList<>();
        String sql = "SELECT * FROM account LIMIT ?, ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, offset);
            ps.setInt(2, limit);
            ResultSet rs = ps.executeQuery();
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
                list.add(acc);
            }
        }
        return list;
    }

    public int countAccounts() throws SQLException {
        String sql = "SELECT COUNT(*) FROM account";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    public Account checkLogin(String email, String password) {
        Account account = null;
        String sql = "SELECT * FROM account WHERE email = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int id = rs.getInt("id");
                    String Email = rs.getString("email");
                    String PasswordHash = rs.getString("password");
                    String status = rs.getString("status");
                    String role = rs.getString("role");
                    String fullName = rs.getString("full_name");
                    int sex = rs.getInt("Sex");
                    LocalDate dob = rs.getDate("dob").toLocalDate();
                    int imageId = rs.getInt("image_id");

                    if (passwordEncode.checkPassword(password, PasswordHash) && "ACTIVE".equals(status.toUpperCase())) {
                        account = new Account(id, Email, password, status, role, fullName, sex, dob, imageId);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return account;
    }

}
