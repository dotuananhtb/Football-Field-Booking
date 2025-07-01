<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>FootballStar - Lỗi hệ thống</title>
        <link rel="shortcut icon" href="/FB_N1/UI/assets/images/logoKoChu.png">
        <link rel="apple-touch-icon-precomposed" href="/FB_N1/UI/assets/images/logoKoChu.png">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
        <style>
            * {
                box-sizing: border-box;
            }

            body {
                margin: 0;
                padding: 0;
                font-family: 'Inter', sans-serif;
                background: url('/FB_N1/UI/assets/images/grass-bg.jpg') no-repeat center center fixed;
                background-size: cover;
                height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
                overflow: hidden;
                color: #fff;
            }

            .error-container {
                background: rgba(0, 0, 0, 0.7);
                border-radius: 20px;
                padding: 50px 40px;
                max-width: 640px;
                width: 90%;
                text-align: center;
                backdrop-filter: blur(10px);
                box-shadow: 0 0 40px rgba(0, 255, 100, 0.2);
                position: relative;
                animation: floatIn 0.7s ease-out;
            }

            @keyframes floatIn {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .icon-wrapper {
                width: 90px;
                height: 90px;
                margin: 0 auto 25px;
                background: linear-gradient(135deg, #1abc9c, #2ecc71);
                border-radius: 50%;
                display: flex;
                justify-content: center;
                align-items: center;
                box-shadow: 0 0 20px rgba(46, 204, 113, 0.5);
            }

            .icon-wrapper svg {
                width: 45px;
                height: 45px;
                stroke: #fff;
            }

            h1 {
                font-size: 28px;
                margin-bottom: 15px;
                font-family: 'Orbitron', sans-serif;
                color: #f1c40f;
            }

            .brand {
                font-size: 16px;
                color: #bdc3c7;
                margin-top: -5px;
                margin-bottom: 25px;
            }

            p {
                font-size: 18px;
                margin-bottom: 30px;
                line-height: 1.6;
                color: #ecf0f1;
            }

            a {
                text-decoration: none;
                background: linear-gradient(to right, #27ae60, #2ecc71);
                color: white;
                padding: 14px 30px;
                border-radius: 10px;
                font-weight: 600;
                font-size: 16px;
                box-shadow: 0 4px 14px rgba(39, 174, 96, 0.3);
                transition: all 0.3s ease;
            }

            a:hover {
                transform: scale(1.03);
                box-shadow: 0 6px 18px rgba(39, 174, 96, 0.5);
            }

            @media (max-width: 480px) {
                .error-container {
                    padding: 30px 20px;
                }

                h1 {
                    font-size: 22px;
                }
            }
        </style>
    </head>
    <jsp:include page="toast.jsp" />
    <jsp:include page="sweetalert-include.jsp" />
    <body>
        <div class="error-container">
            <div class="icon-wrapper">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2">
                <path stroke-linecap="round" stroke-linejoin="round"
                      d="M12 9v3m0 4h.01M21 12c0 4.97-4.03 9-9 9s-9-4.03-9-9
                      4.03-9 9-9 9 4.03 9 9z" />
                </svg>
            </div>
            <h1>Lỗi hệ thống</h1>
            <div class="brand">FootballStar - Đặt sân bóng online</div>
            <p><strong><%= request.getAttribute("message") != null
                    ? request.getAttribute("message")
                    : "Có lỗi không xác định xảy ra. Vui lòng thử lại sau."%></strong></p>
            <a href="/FB_N1/home">⬅ Về Trang chủ</a>
        </div>
    </body>
</html>
