package dal;

import model.Invoice;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class InvoiceDAO extends DBContext {

    public void insertInvoice(Invoice invoice) {
        String sql = "INSERT INTO invoice (total_amount, parent_id, created_at, status, pay_at) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, invoice.getTotal_amount());
            stmt.setInt(2, invoice.getParent_id());
            stmt.setDate(3, Date.valueOf(invoice.getCreated_at()));
            stmt.setString(4, invoice.getStatus());
            if (invoice.getPay_at() != null) {
                stmt.setDate(5, Date.valueOf(invoice.getPay_at()));
            } else {
                stmt.setNull(5, Types.DATE);
            }

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateInvoice(Invoice invoice) {
        String sql = "UPDATE invoice SET total_amount = ?, parent_id = ?, created_at = ?, status = ?, pay_at = ? WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, invoice.getTotal_amount());
            stmt.setInt(2, invoice.getParent_id());
            stmt.setDate(3, Date.valueOf(invoice.getCreated_at()));
            stmt.setString(4, invoice.getStatus());
            if (invoice.getPay_at() != null) {
                stmt.setDate(5, Date.valueOf(invoice.getPay_at()));
            } else {
                stmt.setNull(5, Types.DATE);
            }
            stmt.setInt(6, invoice.getId());

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteInvoice(int id) {
        String sql = "DELETE FROM invoice WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Invoice> getAllInvoices() {
        List<Invoice> list = new ArrayList<>();
        String sql = "SELECT * FROM invoice";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Invoice invoice = new Invoice(
                        rs.getInt("id"),
                        rs.getString("total_amount"),
                        rs.getInt("parent_id"),
                        rs.getDate("created_at").toLocalDate(),
                        rs.getString("status"),
                        rs.getDate("pay_at") != null ? rs.getDate("pay_at").toLocalDate() : null
                );
                  list.add(invoice);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

  public Invoice getInvoiceById(int id) {
    Invoice invoice = null;
    String sql = "SELECT * FROM invoices WHERE id = ?";
    
    try (
         PreparedStatement stmt = connection.prepareStatement(sql)) {
        
        stmt.setInt(1, id);
        ResultSet rs = stmt.executeQuery();
        
        if (rs.next()) {
            invoice = new Invoice();
            invoice.setId(rs.getInt("id"));
            invoice.setTotal_amount(rs.getString("total_amount"));
            invoice.setParent_id(rs.getInt("parent_id"));
                       invoice.setCreated_at(rs.getDate("created_at").toLocalDate());
                       invoice.setStatus(rs.getString("status"));
                        invoice.setPay_at(rs.getDate("pay_at") != null ? rs.getDate("pay_at").toLocalDate() : null);
            // set các thuộc tính khác nếu cần
        }
    } catch (SQLException e) {
        e.printStackTrace(); // hoặc log lỗi
    }
    
    return invoice;
}

}