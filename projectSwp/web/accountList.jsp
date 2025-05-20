<%-- 
    Document   : accountList
    Created on : May 19, 2025, 8:10:57 PM
    Author     : BuiNgocLinh
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
    <head><title>Account List</title></head>
    <body>
        <h2>Account List</h2>

        <form method="get" action="accounts">
            Search by email: <input type="text" name="email" />
            <button type="submit">Search</button>
        </form>

        <c:if test="${not empty error}">
            <p style="color:red">${error}</p>
        </c:if>

        <table border="1" cellpadding="5" cellspacing="0">
            <tr>
                <th>ID</th>
                <th>Email</th>
                <th>Full Name</th>
                <th>Status</th>
                <th>Role</th>
                <th>Sex</th>
                <th>DOB</th>
                <th>Image ID</th>
            </tr>
            <c:forEach var="acc" items="${requestScope.accountList}">
                <tr>
                    <td>${acc.id}</td>
                    <td>${acc.email}</td>
                    <td>${acc.full_name}</td>
                    <td>${acc.status}</td>
                    <td>${acc.role}</td>
                    <td>${acc.sex}</td>
                    <td>${acc.dob}</td>
                    <td>${acc.image_id}</td>
                </tr>
            </c:forEach>
        </table>

        <a href="register.jsp">Add New Account</a>
        <% if (session.getAttribute("account") != null) { %>
        <a href="logout">Logout</a>
        <% } %>


    </body>
</html>

