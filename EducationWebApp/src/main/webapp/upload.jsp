<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Upload Video to GCS</title>
</head>
<body>
    <h2>Upload video (.mp4) lên Google Cloud Storage</h2>

    <form action="upload-video" method="post" enctype="multipart/form-data">
        <label>Chọn video:</label>
        <input type="file" name="video" accept="video/mp4" required /><br/><br/>

        <button type="submit">Upload</button>
    </form>
</body>
</html>
