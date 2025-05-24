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

        <form method="get" action="admin">
            <input type="hidden" name="action" value="searchAccount" />
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
                <th>Image</th>
                <th></th>
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
                    <td>
                        <c:forEach items="${imageList}" var="i">
                            <c:if test="${i.id == acc.image_id}">
                                <img src="${pageContext.request.contextPath}/${not empty i.image_data ? i.image_data : 'assets/img/avatar/macdinh.jpg'}"
                                     alt="Ảnh cá nhân" width="200" height="200"/>
                            </c:if>
                        </c:forEach>
                    </td>
                    <td>
                        <a href="admin?action=deleteAccount&id=${acc.id}" 
                           class="btn btn-danger btn-sm" 
                           onclick="return confirm('Are you sure you want to delete this account?');">
                            Delete
                        </a>
                        <a href="admin?action=editAccount&id=${acc.id}" class="btn btn-danger btn-sm" ">Update</a>
                    </td>


                </tr>
            </c:forEach>
        </table>

        <a href="register.jsp">Add New Account</a>
        <% if (session.getAttribute("account") != null) { %>
        <a href="logout">Logout</a>
        <% } %>


    </body>
</html>

