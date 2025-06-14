<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Tạo bài viết mới</title>
    <link rel="stylesheet" href="app/css/app.css">
    <style>
        .form-create-post {
            max-width: 600px;
            margin: 40px auto;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 2px 16px rgba(0,0,0,0.08);
            padding: 32px 28px;
        }
        .form-create-post h2 {
            text-align: center;
            margin-bottom: 28px;
            color: #4DA528;
        }
        .form-create-post label {
            font-weight: 600;
            margin-bottom: 6px;
            display: block;
        }
        .form-create-post input, .form-create-post select, .form-create-post textarea {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #ddd;
            border-radius: 6px;
            margin-bottom: 18px;
            font-size: 16px;
        }
        .form-create-post textarea {
            resize: vertical;
            min-height: 80px;
        }
        .form-create-post button {
            background: #4DA528;
            color: #fff;
            border: none;
            padding: 12px 32px;
            border-radius: 6px;
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.2s;
        }
        .form-create-post button:hover {
            background: #FF970D;
        }
    </style>
</head>
<body style="background: #f6f8fa;">
    <form class="form-create-post" action="${pageContext.request.contextPath}/createPost" method="post">
        <div style="margin-bottom: 18px;">
            <a href="${pageContext.request.contextPath}/managerPostUser" style="color:#fff;background:#4DA528;padding:8px 18px;border-radius:6px;text-decoration:none;font-weight:600;">← Trở lại</a>
        </div>
        <h2>Tạo bài viết mới</h2>
        <div>
            <label>Tiêu đề <span style="color:red">*</span></label>
            <input type="text" name="title" required placeholder="Nhập tiêu đề bài viết" />
        </div>
        <div>
            <label>Giờ muốn đặt <span style="color:red">*</span></label>
            <input type="time" name="startTime" required />
        </div>
        <div>
            <label>Ngày muốn đặt <span style="color:red">*</span></label>
            <input type="date" name="bookingDate" min="${currentDate}" required />
        </div>
        <div>
            <label>Loại sân muốn chơi <span style="color:red">*</span></label>
            <select name="fieldTypeId" required>
                <c:forEach var="type" items="${fieldTypes}">
                    <option value="${type.fieldTypeId}">${type.fieldTypeName}</option>
                </c:forEach>
            </select>
        </div>
        <div>
            <label>Ghi chú/Nội dung thêm</label>
            <textarea name="userContent" rows="4" placeholder="Nhập ghi chú hoặc yêu cầu đặc biệt..."></textarea>
        </div>
        <div style="text-align:center;">
            <button type="submit">Đăng bài</button>
        </div>
    </form>
</body>
</html> 