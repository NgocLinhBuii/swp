<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
    <head><title>Grade List</title></head>
    <body>
        <h2>Grade List</h2>

        <form method="get" action="../Grade">
            Search by name: <input type="text" name="name" />
            <button type="submit">Search</button>
        </form>

        <c:if test="${not empty error}">
            <p style="color:red">${error}</p>
        </c:if>

        <table border="1" cellpadding="5" cellspacing="0">
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Description</th>
                <th>Teacher_id</th>  
                <th>Actions</th>              
            </tr>
            <c:forEach var="gra" items="${requestScope.gradeList}">
                <tr>
                    <td>${gra.id}</td>
                    <td>${gra.name}</td>
                    <td>${gra.description}</td>
                    <td>${gra.teacher_id}</td>  
                    <td>
                        <a href="../Grade?action=updateForm&id=${gra.id}">Update</a> | 
                        <a href="../Grade?action=delete&id=${gra.id}" onclick="return confirm('Are you sure to delete grade ID ${gra.id}?');" style="color:red">Delete</a>
                    </td>               
                </tr>
            </c:forEach>
        </table>

        <br/>
        <a href="../Grade?action=addForm">Add new Grade</a>

        <c:if test="${not empty message}">
            <p style="color:green">${message}</p>
        </c:if>

    </body>
</html>
