<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage PackageSubject</title>
    <style>
        table { border-collapse: collapse; width: 50%; margin-top: 20px; }
        th, td { border: 1px solid black; padding: 8px; text-align: center; }
        th { background-color: #f2f2f2; }
        form { margin-top: 20px; }
    </style>
</head>
<body>

<h2>PackageSubject List</h2>

<table>
    <tr>
        <th>Package ID</th>
        <th>Subject name</th>
        <th>Actions</th>
    </tr>
    <c:choose>
        <c:when test="${not empty data}">
            <c:forEach var="item" items="${data}">
                <tr>
                    <td>${item.package_id}</td>
                    <td>
                        <c:forEach var="sub" items="${sub}">
                            <c:if test="${item.id eq sub.id}">
                                "${sub.name}"
                            </c:if>
                        </c:forEach>
                    </td>
                    <td>
                        <a href="packageSubjectURL?service=edit&package_id=${item.package_id}&subject_id=${item.subject_id}">Edit</a> |
                        <a href="packageSubjectURL?service=delete&package_id=${item.package_id}&subject_id=${item.subject_id}"
                           onclick="return confirm('Are you sure you want to delete this item?')">Delete</a>
                    </td>
                </tr>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <tr>
                <td colspan="3">No data available.</td>
            </tr>
        </c:otherwise>
    </c:choose>
</table>

<hr>

<c:set var="isEdit" value="${not empty ps}" />

<h3>${isEdit ? "Edit PackageSubject" : "Add New PackageSubject"}</h3>

<form action="packageSubjectURL" method="post">
    <input type="hidden" name="service" value="${isEdit ? 'update' : 'insert'}" />

    <c:if test="${isEdit}">
        <input type="hidden" name="old_package_id" value="${ps.package_id}" />
        <input type="hidden" name="old_subject_name" value="${ps.subject_name}" />
    </c:if>

    <label>Package ID:</label>
    <input type="number" name="package_id" value="${isEdit ? ps.package_id : ''}" required /><br><br>

    <label>Subject name:</label>
    <input type="number" name="subject_name" value="${isEdit ? ps.subject_name : ''}" required /><br><br>

    <input type="submit" value="${isEdit ? 'Update' : 'Add'}" />
    <c:if test="${isEdit}">
        <a href="packageSubjectURL" style="margin-left: 20px;">Cancel</a>
    </c:if>
</form>

</body>
</html>
