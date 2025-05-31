<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Subject</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 30px;
            background-color: #f9f9f9;
        }
        h2 { color: #333; }
        form {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            width: 500px;
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-top: 10px;
            margin-bottom: 5px;
        }
        input[type="text"], input[type="number"], textarea {
            width: 100%;
            padding: 8px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            padding: 10px 18px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
        a {
            color: #007BFF;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
        p.error {
            color: red;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <h2>Update Subject</h2>

    <c:if test="${empty subject}">
        <p class="error">Subject not found!</p>
        <a href="subjects">Back to Subject List</a>
    </c:if>

    <c:if test="${not empty subject}">
        <form method="post" action="subjects">
            <input type="hidden" name="action" value="update" />
            <input type="hidden" name="id" value="${subject.id}" />

            <label>Name:</label>
            <input type="text" name="name" value="${subject.name}" required />

            <label>Description:</label>
            <textarea name="description" rows="4">${subject.description}</textarea>

            <label>Grade ID:</label>
            <input type="number" name="grade_id" value="${subject.grade_id}" required />

            <input type="submit" value="Update Subject" />
        </form>
    </c:if>

    <a href="subjects">Back to Subject List</a>
</body>
</html>
