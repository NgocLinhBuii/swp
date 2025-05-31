<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>PackageSubject List</title>
    <style>
        table { border-collapse: collapse; width: 50%; margin-top: 20px; }
        th, td { border: 1px solid black; padding: 8px; text-align: center; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>

<h2>PackageSubject List</h2>

<table>
    <tr>
        <th>Package ID</th>
        <th>Subject Name</th>
        <th>Actions</th>
    </tr>
    <c:choose>
        <c:when test="${not empty list}">
            <c:forEach var="item" items="${list}">
                <tr>
                    <td>${item.package_id}</td>
                    <td>
                        <c:forEach var="sub" items="${subject}">
                            <c:if test="${item.subject_id eq sub.id}">
                                "${sub.name}"
                            </c:if>
                        </c:forEach>
                    </td>
                    <td>
                        <a href="packageSubjectURL?action=updateForm&package_id=${item.package_id}&subject_id=${item.subject_id}">Edit</a> |
                        <a href="packageSubjectURL?action=delete&package_id=${item.package_id}&subject_id=${item.subject_id}"
                           onclick="return confirm('Are you sure you want to delete this item?')">Delete</a>
                    </td>
                </tr>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <tr><td colspan="3">No data available.</td></tr>
        </c:otherwise>
    </c:choose>
</table>

<p><a href="packageSubjectURL?action=addForm">Add New PackageSubject</a></p>

</body>
</html>
