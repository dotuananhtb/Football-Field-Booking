<%-- 
    Document   : login
    Created on : May 28, 2025, 8:58:40 PM
    Author     : VAN NGUYEN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
<form method="post" action="${pageContext.request.contextPath}/login" name="contactform" id="contactform">
    <input type="text" name="username" placeholder="Tên đăng nhập">
    <input type="password" name="password" placeholder="Mật khẩu">
    <input type="checkbox" name="remember"> Nhớ mật khẩu
    <input type="submit" name="login-submit" value="Đăng Nhập">
</form>

    </body>
</html>
