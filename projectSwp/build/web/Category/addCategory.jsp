<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><title>Add Category</title></head>
<body>
<h2>Add New Category</h2>

<form method="post" action="category">
    <input type="hidden" name="action" value="insert" />
    Name: <input type="text" name="name" required /><br/>
    Number of Questions: <input type="number" name="num_question" min="1" required /><br/>
    Duration (minutes): <input type="number" name="duration" min="1" required /><br/>
    <button type="submit">Add Category</button>
</form>

<br/>
<a href="category">Back to Category List</a>
</body>
</html>
