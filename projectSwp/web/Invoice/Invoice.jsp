<%-- 
    Document   : Invoice
    Created on : May 21, 2025, 8:56:58 PM
    Author     : ledai
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Invoice" %>
<html>
<head>
    <title>Quản lý Hóa đơn</title>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
            margin-bottom: 20px;
        }

        th, td {
            border: 1px solid #ccc;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        form {
            margin-top: 20px;
        }

        input, select {
            margin: 5px 0;
            padding: 8px;
            width: 100%;
        }

        .form-group {
            margin-bottom: 10px;
        }
    </style>
</head>
<body>

<h2>Danh sách Hóa đơn</h2>
<table>
    <tr>
        <th>ID</th>
        <th>Tổng tiền</th>
        <th>Parent ID</th>
        <th>Ngày tạo</th>
        <th>Trạng thái</th>
        <th>Ngày thanh toán</th>
        <th>Hành động</th>
    </tr>
    <%
        List<Invoice> invoices = (List<Invoice>) request.getAttribute("invoices");
        if (invoices != null) {
            for (Invoice invoice : invoices) {
    %>
    <tr>
        <td><%= invoice.getId() %></td>
        <td><%= invoice.getTotal_amount() %></td>
        <td><%= invoice.getParent_id() %></td>
        <td><%= invoice.getCreated_at() %></td>
        <td><%= invoice.getStatus() %></td>
        <td><%= invoice.getPay_at() != null ? invoice.getPay_at() : "" %></td>
        <td>
            <a href="invoice?action=delete&id=<%= invoice.getId() %>" onclick="return confirm('Xác nhận xoá?');">Xoá</a>
            |
            <a href="invoice?action=edit&id=<%= invoice.getId() %>">Sửa</a>
        </td>
    </tr>
    <%
            }
        }
    %>
</table>

<h2>Thêm / Cập nhật Hóa đơn</h2>
<form action="invoice" method="post">
    <input type="hidden" name="action" value="insert" />
    <input type="hidden" name="id" value="" /> <!-- Dùng cho cập nhật nếu cần -->

    <div class="form-group">
        <label>Tổng tiền:</label>
        <input type="text" name="total_amount" required />
    </div>

    <div class="form-group">
        <label>Parent ID:</label>
        <input type="number" name="parent_id" required />
    </div>

    <div class="form-group">
        <label>Ngày tạo:</label>
        <input type="date" name="created_at" required />
    </div>

    <div class="form-group">
        <label>Trạng thái:</label>
        <select name="status" required>
            <option value="Chưa thanh toán">Chưa thanh toán</option>
            <option value="Đã thanh toán">Đã thanh toán</option>
        </select>
    </div>

    <div class="form-group">
        <label>Ngày thanh toán (nếu có):</label>
        <input type="date" name="pay_at" />
    </div>
    <input type="submit" value="Lưu hóa đơn" />
</form>

</body>
</html>
