<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Lesson" %>
<%
    // Lấy danh sách từ controller truyền qua
    List<Lesson> list = (List<Lesson>) request.getAttribute("listLesson");

    // Kiểm tra nếu đang chỉnh sửa
    String editId = request.getParameter("id");
    String editName = request.getParameter("name");
    String editContent = request.getParameter("content");
    String editChapterId = request.getParameter("chapter_id");

    boolean isEditing = (editId != null);
%>
<!DOCTYPE html>
<html>
<head>
    <title>Lesson Management</title>
</head>
<body>

<h2><%= isEditing ? "Edit Lesson" : "Add New Lesson" %></h2>
<form action="LessonURL?service=<%= isEditing ? "edit" : "add" %>" method="post"> 
    <% if (isEditing) { %>
        <input type="hidden" name="id" value="<%= editId %>">
    <% } %>
    <p>Name: <input type="text" name="name" value="<%= isEditing ? editName : "" %>" required></p>
    <p>Content: <input type="text" name="content" value="<%= isEditing ? editContent : "" %>" required></p>
    <p>Chapter ID: <input type="number" name="chapter_id" value="<%= isEditing ? editChapterId : "" %>" required></p>
    <p><input type="submit" value="<%= isEditing ? "Update" : "Add" %> Lesson"></p>
</form>

<hr>

<h2>Lesson List</h2>
<table border="1" cellpadding="5" cellspacing="0">
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Content</th>
        <th>Chapter ID</th>
        <th>Actions</th>
    </tr>
    <%
        if (list != null && !list.isEmpty()) {
            for (Lesson l : list) {
    %>
    <tr>
        <td><%= l.getId() %></td>
        <td><%= l.getName() %></td>
        <td><%= l.getContent() %></td>
        <td><%= l.getChapter_id() %></td>
        <td>
            <a href="LessonURL?id=<%= l.getId() %>&name=<%= l.getName() %>&content=<%= l.getContent() %>&chapter_id=<%= l.getChapter_id() %>">Edit</a> |
            <a href="LessonURL?service=delete&id=<%= l.getId() %>" onclick="return confirm('Delete this lesson?')">Delete</a>
        </td>
    </tr>
    <%
            }
        } else {
    %>
    <tr><td colspan="5">No lessons found.</td></tr>
    <%
        }
    %>
</table>

</body>
</html>
