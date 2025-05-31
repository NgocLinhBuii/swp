<%-- 
    Document   : listInvoices
    Created on : May 25, 2025, 7:19:15 PM
    Author     : ledai
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Invoice" %>
<html>
<head>
    <title>Danh sách Hóa đơn</title>
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
        a {
            margin-right: 5px;
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
            <a href="invoice?action=edit&id=<%= invoice.getId() %>">Sửa</a>
            <a href="invoice?action=delete&id=<%= invoice.getId() %>" onclick="return confirm('Xác nhận xoá?');">Xoá</a>
        </td>
    </tr>
    <%
            }
        }
    %>
</table>

<a href="invoice?action=create">Thêm mới Hóa đơn</a>

</body>
</html>
