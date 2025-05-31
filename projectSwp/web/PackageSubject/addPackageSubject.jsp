<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thêm PackageSubject</title>
</head>
<body>

    <h2>Thêm PackageSubject mới</h2>

    <form id="packageForm" action="packageSubjectURL" method="post" onsubmit="return validatePackageForm()">
    <input type="hidden" name="action" value="insert">

    <p>Package ID: 
        <input type="number" id="package_id" name="package_id">
        <div id="packageError" style="color: red;"></div>
    </p>

    <p>Subject name: 
        <select id="subject_id" name="subject_id">
            <option value="">-- Chọn Subject --</option>
            <c:forEach items="${subjectName}" var="sub">
                <option value="${sub.id}">${sub.name}</option>
            </c:forEach>
        </select>
        <div id="subjectError" style="color: red;"></div>
    </p>

    <button type="submit">Thêm</button>
</form>


    <p><a href="packageSubjectURL">Quay lại danh sách</a></p>
<script>
function validatePackageForm() {
    let isValid = true;

    // Xóa lỗi cũ
    document.getElementById("packageError").innerText = "";
    document.getElementById("subjectError").innerText = "";

    const packageId = document.getElementById("package_id").value.trim();
    const subjectId = document.getElementById("subject_id").value;

    if (packageId === "") {
        document.getElementById("packageError").innerText = "Vui lòng nhập Package ID.";
        isValid = false;
    }

    if (subjectId === "") {
        document.getElementById("subjectError").innerText = "Vui lòng chọn một Subject.";
        isValid = false;
    }

    return isValid;
}
</script>

</body>
</html>
