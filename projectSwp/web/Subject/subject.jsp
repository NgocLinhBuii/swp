<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Subject List</title>
    <style>
        table {
            border-collapse: collapse;
            width: 80%;
        }
        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: left;
        }
        a.update {
            color: purple;
            text-decoration: none;
        }
        a.delete {
            color: red;
            text-decoration: none;
        }
        a.add {
            color: purple;
            text-decoration: underline;
        }
    </style>
</head>
<body>

<h2>Subject List</h2>

<!-- Search Form -->
<form method="get" action="subjects">
    Search by name:
    <input type="text" name="name" value="${param.name != null ? param.name : ''}" />
    <input type="submit" value="Search" />
</form>

<!-- Error message -->
<c:if test="${not empty error}">
    <p style="color: red;">${error}</p>
</c:if>

<!-- Show message if no subjects found -->
<c:choose>
    <c:when test="${not empty subjectList and fn:length(subjectList) > 0}">
        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Description</th>
                <th>Grade ID</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="sub" items="${subjectList}">
                <tr>
                    <td><c:out value="${sub.id}"/></td>
                    <td><c:out value="${sub.name}"/></td>
                    <td><c:out value="${sub.description}"/></td>
                    <td><c:out value="${sub.grade_id}"/></td>
                    <td>
                        <a class="update" href="subjects?action=edit&id=${sub.id}">Update</a> |
                        <a class="delete" href="subjects?action=delete&id=${sub.id}" 
                           onclick="return confirm('Bạn có chắc muốn xóa?')">Delete</a>
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

<!-- Add / Update Form -->
<c:if test="${not empty subject}">
    <hr>
    <h2><c:out value="${subject.id != 0 ? 'Update Subject' : 'Add Subject'}"/></h2>

    <form method="post" action="subjects">
        <c:if test="${subject.id != 0}">
            <input type="hidden" name="id" value="<c:out value='${subject.id}'/>" />
        </c:if>
        <p>
            Name: <input type="text" name="name" value="<c:out value='${subject.name}'/>" required />
        </p>
        <p>
            Description:<br />
            <textarea name="description" rows="4" cols="50"><c:out value="${subject.description}"/></textarea>
        </p>
        <p>
            Grade ID: <input type="number" name="grade_id" value="${subject.grade_id != 0 ? subject.grade_id : ''}" required />
        </p>
        <input type="submit" value="${subject.id != 0 ? 'Update' : 'Add'} Subject" />
    </form>
</c:if>

</body>
</html>
