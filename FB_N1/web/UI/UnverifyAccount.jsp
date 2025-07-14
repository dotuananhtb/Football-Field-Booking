<%-- 
    Document   : UnverifyAccount
    Created on : Jun 2, 2025, 5:33:06 PM
    Author     : VAN NGUYEN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="vi">

    <head>
        <!-- đường dẫn tương đối được tính từ 1 gốc chung -->
        <!-- đường dẫn tương đối được tính từ 1 gốc chung -->
        <base href="${pageContext.request.contextPath}/UI/">
            <!-- đường dẫn tương đối được tính từ 1 gốc chung -->
            <!-- đường dẫn tương đối được tính từ 1 gốc chung -->
            <meta charset="utf-8">
                <title>Vitour - Travel & Tour Booking HTML Template</title>

                <meta name="author" content="themesflat.com">
                    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

                        <link rel="stylesheet" href="app/css/app.css">
                            <link rel="stylesheet" href="app/css/jquery.fancybox.min.css">

                                <!-- Favicon and Touch Icons  -->
                                <link rel="shortcut icon" href="assets/images/favico.png">
                                    <link rel="apple-touch-icon-precomposed" href="assets/images/favico.png">
                                        <link href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" rel="stylesheet">

                                            <link rel="stylesheet" href="fonts/line-icons.css" type="text/css">
                                                </head>
                                                <body>
                                                    <jsp:include page="header.jsp"></jsp:include>
                                                        <style>
                                                            body{
                                                                margin: 0;
                                                                padding: 0;
                                                                justify-content: center;
                                                                align-items: center;
                                                                background-color: #f8f9fa;
                                                                font-family: Arial, sans-serif;

                                                            }
                                                            .message-box{
                                                                height: 80vh;
                                                                text-align: center;
                                                            }
                                                            .message-box p{
                                                                margin: 60px;
                                                                font-size: 30px;
                                                                color: #555;
                                                            }
                                                            .message-box h1 {
                                                                margin-top:10px;
                                                                color: #333;
                                                                margin-bottom: 10px;
                                                            }
                                                            .message-box a {
                                                                display: inline-block;
                                                                padding: 12px 24px;
                                                                font-size: 16px;
                                                                color: white;
                                                                background-color: #4da528;
                                                                text-decoration: none;
                                                                border-radius: 8px;
                                                                transition: background-color 0.3s ease, transform 0.2s ease;
                                                                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                                                            }

                                                            .message-box a:hover {
                                                                background-color: #ff970d;
                                                                transform: scale(1.05);
                                                            }
                                                            

                                                        </style>
                                                        <div class="message-box">
                                                            <h1>Thông Báo</h1>
                                                            <p>Tài khoản của bạn đang trong thời gian chờ xác minh</p>
                                                            <a href="/FB_N1/home">Trang Chủ</a>
                                                        </div>

                                                    <jsp:include page="footer.jsp"></jsp:include>
                                                </body>
                                                </html>
