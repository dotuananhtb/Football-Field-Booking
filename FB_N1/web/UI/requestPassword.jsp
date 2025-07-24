<%-- 
    Document   : requestPassword
    Created on : May 26, 2025, 11:55:12 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>


<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US" lang="en-US">

    <head>
        <base href="${pageContext.request.contextPath}/UI/">
            <meta charset="utf-8">
                <title>Quên Mật Khẩu - FootBall Star</title>

                <meta name="author" content="themesflat.com">
                    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">


                        <link rel="stylesheet" href="app/css/app.css">
                            <link rel="stylesheet" href="app/css/jquery.fancybox.min.css">

                                <!-- Favicon and Touch Icons  -->
                                <link rel="shortcut icon" href="assets/images/favico.png">
                                    <link rel="apple-touch-icon-precomposed" href="assets/images/favico.png">
                                        <style>
                                            .login {
                                                display: flex;
                                                justify-content: center;
                                                align-items: center;
                                                min-height: 100vh; /* Chiều cao full màn hình */
                                            }

                                            .login-wrap {
                                                display: flex;
                                                flex-direction: row;
                                                justify-content: center;
                                                align-items: center;
                                                width: 100%;
                                            }

                                        </style>
                                        </head>

                                        <body class="body header-fixed ">

                                            <div class="preload preload-container">
                                                <svg class="pl" width="240" height="240" viewBox="0 0 240 240">
                                                    <circle class="pl__ring pl__ring--a" cx="120" cy="120" r="105" fill="none" stroke="#000" stroke-width="20" stroke-dasharray="0 660" stroke-dashoffset="-330" stroke-linecap="round"></circle>
                                                    <circle class="pl__ring pl__ring--b" cx="120" cy="120" r="35" fill="none" stroke="#000" stroke-width="20" stroke-dasharray="0 220" stroke-dashoffset="-110" stroke-linecap="round"></circle>
                                                    <circle class="pl__ring pl__ring--c" cx="85" cy="120" r="70" fill="none" stroke="#000" stroke-width="20" stroke-dasharray="0 440" stroke-linecap="round"></circle>
                                                    <circle class="pl__ring pl__ring--d" cx="155" cy="120" r="70" fill="none" stroke="#000" stroke-width="20" stroke-dasharray="0 440" stroke-linecap="round"></circle>
                                                </svg>
                                            </div>

                                            <!-- /preload -->

                                            <div id="wrapper">
                                                <div id="pagee" class="clearfix">

                                                    <jsp:include page="header.jsp" />
                                                    <main id="main">

                                                        <section class="breadcumb-section">
                                                            <div class="tf-container">
                                                                <div class="row">
                                                                    <div class="col-lg-12 center z-index1">
                                                                        <h1 class="title">Quên Mật khẩu</h1>
                                                                        <ul class="breadcumb-list flex-five">
                                                                            <li><a href="/FB_N1/home">Trang chủ</a></li>
                                                                            <li><span>Xác minh tài khoản</span></li>
                                                                        </ul>
                                                                        <img class="bcrumb-ab" src="./assets/images/page/mask-bcrumb.png" alt="">
                                                                    </div>
                                                                </div>

                                                            </div>
                                                        </section>
                                                        <section class="login">
                                                            <div class="tf-container">
                                                                <div class="row">
                                                                    <div class="col-lg-12 ">
                                                                        <div class="login-wrap flex">
                                                                            <div class="image">
                                                                                <img src="./assets/images/page/sign-up.jpg" alt="image">
                                                                            </div>
                                                                            <div class="content">
                                                                                <div class="inner-header-login">
                                                                                    <h2 class="title">Quên Mật Khẩu?</h2>

                                                                                </div>
                                                                                <form action="${pageContext.request.contextPath}/requestPassword" method="POST" id="rPassword" class="login-user">
                                                                                    <!-- Email -->
                                                                                    <div class="col-cd-12">
                                                                                        <div class="input-wrap">
                                                                                            <label>Email</label>
                                                                                            <input type="email" name="email" placeholder="name@example.com" required>
                                                                                        </div>
                                                                                    </div>
                                                                                    <!-- Nút gửi -->
                                                                                    <div class="col-lg-12 mb-30">
                                                                                        <button type="submit" class="btn-submit">Gửi</button>
                                                                                    </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </section>
                                                    </main>

                                                    <jsp:include page="footer.jsp" />

                                                    <!-- Bottom -->
                                                </div>
                                                <!-- /#page -->
                                            </div>

                                            <!-- Modal Popup Bid -->

                                            <a id="scroll-top" class="button-go"></a>

                                            <!-- Javascript -->
                                            <script src="app/js/jquery.min.js"></script>
                                            <script src="app/js/jquery.nice-select.min.js"></script>
                                            <script src="app/js/bootstrap.min.js"></script>
                                            <script src="app/js/swiper-bundle.min.js"></script>
                                            <script src="app/js/swiper.js"></script>
                                            <script src="app/js/plugin.js"></script>
                                            <script src="app/js/jquery.fancybox.js"></script>
                                            <script src="app/js/shortcodes.js"></script>
                                            <script src="app/js/main.js"></script>

                                        </body>

                                        </html>

