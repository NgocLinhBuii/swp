<%-- 
    Document   : editInvoice
    Created on : May 25, 2025, 7:20:24 PM
    Author     : ledai
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Invoice" %>
<html>
<head>
    <title>Sửa Hóa đơn</title>
    <style>
        form {
            max-width: 400px;
        }
        .form-group {
            margin-bottom: 10px;
        }
        label, input, select {
            display: block;
            width: 100%;
        }
        input, select {
            padding: 8px;
        }
    </style>
</head>
<body>

<%
    Invoice invoice = (Invoice) request.getAttribute("invoice");
    if (invoice == null) {
%>
    <p style="color:red;">Hóa đơn không tồn tại hoặc lỗi tải dữ liệu.</p>
    <a href="invoice">Quay lại danh sách</a>
<%
    } else {
%>

<h2>Sửa Hóa đơn</h2>
<form action="invoice" method="post">
    <input type="hidden" name="action" value="update" />
    <input type="hidden" name="id" value="<%= invoice.getId() %>" />

    <div class="form-group">
        <label>Tổng tiền:</label>
        <input type="text" name="total_amount" value="<%= invoice.getTotal_amount() %>" required />
    </div>

    <div class="form-group">
        <label>Parent ID:</label>
        <input type="number" name="parent_id" value="<%= invoice.getParent_id() %>" required />
    </div>

    <div class="form-group">
        <label>Ngày tạo:</label>
        <input type="date" name="created_at" value="<%= invoice.getCreated_at() %>" required />
    </div>

    <div class="form-group">
        <label>Trạng thái:</label>
        <select name="status" required>
            <option value="Chưa thanh toán" <%= "Chưa thanh toán".equals(invoice.getStatus()) ? "selected" : "" %>>Chưa thanh toán</option>
            <option value="Đã thanh toán" <%= "Đã thanh toán".equals(invoice.getStatus()) ? "selected" : "" %>>Đã thanh toán</option>
        </select>
    </div>

    <div class="form-group">
        <label>Ngày thanh toán (nếu có):</label>
        <input type="date" name="pay_at" value="<%= invoice.getPay_at() != null ? invoice.getPay_at() : "" %>" />
    </div>

    <input type="submit" value="Cập nhật hóa đơn" />
</form>

<a href="invoice">Quay lại danh sách</a>

<% } %>

</body>
</html>
