<%-- 
    Document   : addInvoice
    Created on : May 25, 2025, 7:19:47 PM
    Author     : ledai
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Thêm mới Hóa đơn</title>
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

<h2>Thêm mới Hóa đơn</h2>
<form action="invoice" method="post">
    <input type="hidden" name="action" value="insert" />

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

<a href="invoice">Quay lại danh sách</a>

</body>
</html>

