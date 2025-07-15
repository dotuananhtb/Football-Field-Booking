<%-- 
    Document   : hoSoNguoiDung
    Created on : 31 thg 5, 2025, 15:21:16
    Author     : Asus
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US" lang="en-US">

    <head>
        <base href="${pageContext.request.contextPath}/UI/">
            <meta charset="utf-8">
                <title>Hồ sơ người dùng - FootballStar</title>

                <meta name="author" content="themesflat.com">
                    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

                        <link rel="stylesheet" href="app/css/app.css">
                            <link rel="stylesheet" href="app/css/bootstrap-select.min.css">
                                <link rel="stylesheet" href="app/css/map.min.css">

                                    <!-- Favicon and Touch Icons  -->
                                    <link rel="shortcut icon" href="assets/images/logoKoChu.png">
                                        <link rel="apple-touch-icon-precomposed" href="assets/images/logoKoChu.png">
                                            </head>
                                            <style>
                                                .avatar-upload-wrapper {
                                                    max-width: 400px;
                                                    margin: 0 auto;
                                                    background-color: #fff;
                                                    border-radius: 12px;
                                                    padding: 20px;
                                                    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                                                }

                                                .avatar-preview {
                                                    display: flex;
                                                    justify-content: center;
                                                    margin-bottom: 20px;
                                                }

                                                .avatar-preview img {
                                                    max-width: 150px;
                                                    max-height: 150px;
                                                    border-radius: 50%;
                                                    object-fit: cover;
                                                    border: 3px solid #0d6efd;
                                                    box-shadow: 0 2px 6px rgba(0,0,0,0.2);
                                                }

                                                .form-label {
                                                    font-weight: 600;
                                                }
                                            </style>
                                            <body class="body header-fixed">
                                                <jsp:include page="toast.jsp"/>
                                                <jsp:include page="header_dashboard.jsp" />
                                                <!-- End Main Header -->
                                                <main id="main">
                                                    <section class="profile-dashboard">


                                                        <form action="${pageContext.request.contextPath}/changePassword" method="post" class="edit-profile">
                                                            <c:set value="${sessionScope.userProfile}" var="u"></c:set>
                                                            <c:set value="${sessionScope.account}" var="a"></c:set>
                                                            <div class="infomation-dashboard mb-70">
                                                                <h4 class="title">Đổi Mật Khẩu </h4>
                                                                <div class="widget-dash-board">

                                                                    <div class="grid-input-2">
                                                                        <div class="input-wrap">
                                                                            <label>Mật Khẩu Mới</label>
                                                                            <input type="password" name="pass" placeholder="Nhập mật khẩu" 
                                                                                    pattern="(?=.*[A-Za-z])(?=.*\d)(?=.*[^A-Za-z\d]).{8,}" 
                                                                                    title="Ít nhất 8 ký tự gồm chữ, số và ký tự đặc biệt" 
                                                                                    minlength="8" maxlength="100" required>
                                                                        </div>
                                                                        <div class="input-wrap">
                                                                            <label>Nhập Lại Mật Khẩu Mới</label>
                                                                            <input type="password" name="re-pass" placeholder="Nhập lại mật khẩu" 
                                                                                    pattern="(?=.*[A-Za-z])(?=.*\d)(?=.*[^A-Za-z\d]).{8,}" 
                                                                                    title="Ít nhất 8 ký tự gồm chữ, số và ký tự đặc biệt" 
                                                                                    minlength="8" maxlength="100" required>
                                                                        </div>
                                                                    </div>
                                                                    <p class="mt-20 text-danger" >*Chú ý: Mật khẩu phải từ 8 ký tự trở lên, có số, chữ cái viết thường, hoa và ký tự đặc biệt</p>
                                                                    <br>

                                                                        <div class="otp-dashboard">

                                                                            <div class="flex-three">
                                                                                <div class="button-wrap">
                                                                                    <button type="submit" class="save"><i class="icon-Vector-221"></i>Lưu thay đổi</button>
                                                                                    <button type="reset" class="reset"><i class="icon-reply-all"></i>Đặt lại
                                                                                    </button>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                </div>

                                                            </div>



                                                        </form>

                                                        <script src="app/js/validateRegister.js"></script>
                                                    </section>

                                                </main>


                                                <!-- Bottom -->
                                                </div>

                                                </div>
                                                <!-- /#page -->
                                                </div>

                                                <!-- Modal Popup Bid -->

                                                <a id="scroll-top" class="button-go"></a>
                                                <!-- Modal search-->



                                                <!-- Javascript -->
                                                <script src="app/js/jquery.min.js"></script>
                                                <script src="app/js/jquery.nice-select.min.js"></script>
                                                <script src="app/js/bootstrap.min.js"></script>
                                                <script src="app/js/swiper-bundle.min.js"></script>
                                                <script src="app/js/swiper.js"></script>
                                                <script src="app/js/plugin.js"></script>
                                                <script src="app/js/shortcodes.js"></script>
                                                <script src="app/js/main.js"></script>
                                                <script>
                                                    function previewAvatar(event) {
                                                        const input = event.target;
                                                        const preview = document.getElementById('avatar-preview');

                                                        if (input.files && input.files[0]) {
                                                            const reader = new FileReader();

                                                            reader.onload = function (e) {
                                                                preview.src = e.target.result;
                                                            };

                                                            reader.readAsDataURL(input.files[0]);
                                                        }
                                                    }
                                                </script>

                                            </body>

                                            </html>
