<%-- 
    Document   : debug
    Created on : Jun 2, 2025, 7:51:00 AM
    Author     : Đỗ Tuấn Anh
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Debug Callback</title>
</head>
<body>
    <h2>Callback Parameters</h2>
    <p><strong>Code:</strong> <%= request.getParameter("code") != null ? request.getParameter("code") : "Không có" %></p>
    <p><strong>State:</strong> <%= request.getParameter("state") != null ? request.getParameter("state") : "Không có" %></p>
    <p><strong>Scope:</strong> <%= request.getParameter("scope") != null ? request.getParameter("scope") : "Không có" %></p>
    <p><strong>Error:</strong> <%= request.getParameter("error") != null ? request.getParameter("error") : "Không có" %></p>
    <a href="login.jsp">Quay lại đăng nhập</a>
</body>
</html>
