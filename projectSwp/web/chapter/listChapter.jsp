<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <title>Danh sách Chapter</title>
</head>
<body>

<h1>Danh sách Chapter</h1>

<table border="1" cellpadding="8" cellspacing="0">
    <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Description</th>
            <th>Subject ID</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="ch" items="${listChapter}">
            <tr>
                <td>${ch.id}</td>
                <td>${ch.name}</td>
                <td>${ch.description}</td>
                <td>${ch.subject_id}</td>
                <td>
                    <!-- Form sửa -->
                    <form action="chapter" method="post" style="display:inline;">
                        <input type="hidden" name="service" value="edit"/>
                        <input type="hidden" name="id" value="${ch.id}"/>
                        <input type="text" name="name" value="${ch.name}" required/>
                        <input type="text" name="description" value="${ch.description}" required/>
                        <input type="number" name="subject_id" value="${ch.subject_id}" required min="1"/>
                        <button type="submit">Sửa</button>
                    </form>

                    <!-- Form xóa -->
                    <form action="chapter" method="post" style="display:inline;" onsubmit="return confirm('Bạn có chắc muốn xóa không?');">
                        <input type="hidden" name="service" value="delete"/>
                        <input type="hidden" name="id" value="${ch.id}"/>
                        <button type="submit">Xóa</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<h2>Thêm Chapter mới</h2>
<form action="chapter" method="post">
    <input type="hidden" name="service" value="add"/>
    
    <label for="id">ID:</label><br/>
    <input type="number" id="id" name="id" required min="1" placeholder="Nhập ID chapter"/><br/><br/>
    
    <label for="name">Name:</label><br/>
    <input type="text" id="name" name="name" required placeholder="Nhập tên chapter"/><br/><br/>
    
    <label for="description">Description:</label><br/>
    <input type="text" id="description" name="description" required placeholder="Mô tả chapter"/><br/><br/>
    
    <label for="subject_id">Subject ID:</label><br/>
    <input type="number" id="subject_id" name="subject_id" required min="1" placeholder="Mã môn học"/><br/><br/>
    
    <button type="submit">Thêm mới</button>
</form>


</body>
</html>
