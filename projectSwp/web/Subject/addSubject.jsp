<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Subject</title>
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
        input[type="text"], textarea, select {
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
    </style>
</head>
<body>
    <h2>Add New Subject</h2>

    <form method="post" action="subjects">
        <input type="hidden" name="action" value="create" />

        <label>Name:</label>
        <input type="text" name="name" required />

        <label>Description:</label>
        <textarea name="description" rows="4"></textarea>

        <label>Grade:</label>
        <select name="grade_id" required>
            <option value="" disabled selected>-- Select Grade --</option>
            <c:forEach var="grade" items="${gradeList}">
                <option value="${grade.id}"><c:out value="${grade.name}"/></option>
            </c:forEach>
        </select>

        <input type="submit" value="Add Subject" />
    </form>

    <a href="subjects">Back to Subject List</a>
</body>
</html>
