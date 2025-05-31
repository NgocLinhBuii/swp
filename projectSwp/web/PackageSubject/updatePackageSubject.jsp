<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Update PackageSubject</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 30px; }
        form { width: 400px; padding: 20px; border: 1px solid #ccc; border-radius: 8px; background-color: #f9f9f9; }
        label { display: block; margin-top: 10px; font-weight: bold; }
        input, select { width: 100%; padding: 8px; margin-top: 4px; }
        button { margin-top: 15px; padding: 10px 15px; }
        a { display: inline-block; margin-top: 20px; }
    </style>
</head>
<body>

<h2>Update PackageSubject</h2>

<c:if test="${not empty ps}">
    <form action="packageSubjectURL" method="post">
        <input type="hidden" name="service" value="update" />
        <input type="hidden" name="old_package_id" value="${ps.package_id}" />
        <input type="hidden" name="old_subject_name" value="${ps.subject_name}" />

        <label>Package ID:</label>
        <input type="number" name="package_id" value="${ps.package_id}" required />

        <label>Subject name:</label>
        <select name="subject_name" required>
            <c:forEach var="sub" items="${subject}">
                <option value="${sub.id}" ${sub.subject_id == ps.id ? 'selected' : ''}>
                    ${sub.name}
                </option>
            </c:forEach>
        </select>

        <button type="submit">Update</button>
        <a href="packageSubjectURL">Cancel</a>
    </form>
</c:if>

<c:if test="${empty ps}">
    <p style="color:red">PackageSubject not found!</p>
    <a href="packageSubjectURL">Back to List</a>
</c:if>

</body>
</html>
