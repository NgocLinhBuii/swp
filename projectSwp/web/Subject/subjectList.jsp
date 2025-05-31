<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Subject List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 30px;
            background-color: #f9f9f9;
        }
        h2 { color: #333; }
        form {
            margin-bottom: 20px;
        }
        input[type="text"] {
            padding: 6px;
            border-radius: 4px;
            border: 1px solid #ccc;
        }
        input[type="submit"] {
            padding: 6px 12px;
            background-color: #4CAF50;
            border: none;
            border-radius: 4px;
            color: white;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
        p.error {
            color: red;
            font-weight: bold;
        }
        table {
            border-collapse: collapse;
            width: 100%;
            background-color: #fff;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        a {
            color: #007BFF;
            text-decoration: none;
        }
        a.update {
            color: #6f42c1;
        }
        a.delete {
            color: red;
        }
        a.add {
            color: #6f42c1;
            font-weight: bold;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <h2>Subject List</h2>

    <form method="get" action="subjects">
        <label>Search by name:</label>
        <input type="text" name="name" value="${param.name != null ? param.name : ''}" />
        <input type="submit" value="Search" />
    </form>

    <c:if test="${not empty error}">
        <p class="error">${error}</p>
    </c:if>

    <c:choose>
        <c:when test="${not empty subjectList and fn:length(subjectList) > 0}">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Description</th>
                        <th>Grade</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="sub" items="${subjectList}">
                        <tr>
                            <td><c:out value="${sub.id}"/></td>
                            <td><c:out value="${sub.name}"/></td>
                            <td><c:out value="${sub.description}"/></td>
                            <td><c:out value="${gradeMap[sub.grade_id]}" default="Unknown"/></td>
                            <td>
                                <a class="update" href="subjects?action=edit&id=${sub.id}">Update</a> |
                                <a class="delete" href="subjects?action=delete&id=${sub.id}" onclick="return confirm('Bạn có chắc muốn xóa?')">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:when>
        <c:otherwise>
            <p>No subjects found.</p>
        </c:otherwise>
    </c:choose>

    <br>
    <a class="add" href="subjects?action=create">Add new Subject</a>
</body>
</html>
