<%-- 
    Document   : error
    Created on : May 29, 2025, 5:51:46 AM
    Author     : Đỗ Tuấn Anh
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Lỗi xác minh tài khoản</title>
        <style>
            body {
                margin: 0;
                padding: 0;
                font-family: "Segoe UI", sans-serif;
                background: linear-gradient(to right, #006400, #228B22);
                color: #fff;
                height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .error-container {
                background-color: rgba(255, 255, 255, 0.95);
                color: #2c3e50;
                padding: 40px;
                border-radius: 15px;
                text-align: center;
                box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
                max-width: 600px;
                width: 90%;
            }

            .error-container h1 {
                font-size: 26px;
                color: #e74c3c;
                margin-bottom: 20px;
            }

            .error-container p {
                font-size: 18px;
                margin-bottom: 30px;
            }

            .error-container a {
                text-decoration: none;
                background-color: #27ae60;
                color: white;
                padding: 12px 24px;
                border-radius: 6px;
                font-size: 16px;
                transition: background-color 0.3s ease;
            }

            .error-container a:hover {
                background-color: #219150;
            }

            .stadium-icon {
                font-size: 50px;
                color: #2ecc71;
                margin-bottom: 15px;
            }
        </style>
    </head>
    <body>
        <div class="error-container">
            <div class="stadium-icon">⚽</div>
            <h1>Xác minh tài khoản thất bại!</h1>
            <p><%= request.getAttribute("message") %></p>
            <a href="/FB_N1/home">Quay lại Trang chủ</a>
        </div>
    </body>
</html>
