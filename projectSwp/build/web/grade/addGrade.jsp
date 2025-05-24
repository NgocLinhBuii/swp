<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><title>Add Grade</title></head>
<body>
    <h2>Add New Grade</h2>
    <form method="post" action="Grade">
        <input type="hidden" name="action" value="insert" />
        ID: <input type="number" name="id" required /><br/>
        Name: <input type="text" name="name" required /><br/>
        Description: <input type="text" name="description" /><br/>
        Teacher ID: <input type="number" name="teacher_id" required /><br/>
        <button type="submit">Add Grade</button>
    </form>
    <br/>
    <a href="Grade">Back to Grade List</a>
</body>
</html>
