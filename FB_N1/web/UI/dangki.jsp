<%-- 
    Document   : dangki
    Created on : May 30, 2025, 1:40:06 AM
    Author     : Đỗ Tuấn Anh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US" lang="en-US">

    <head>
        <!-- đường dẫn tương đối được tính từ 1 gốc chung -->
        <!-- đường dẫn tương đối được tính từ 1 gốc chung -->
        <base href="${pageContext.request.contextPath}/UI/">
            <!-- đường dẫn tương đối được tính từ 1 gốc chung -->
            <!-- đường dẫn tương đối được tính từ 1 gốc chung -->
            <meta charset="utf-8">
                <title>FootballStar - Đăng kí tài khoản</title>

                <meta name="author" content="themesflat.com">
                    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">


                        <link rel="stylesheet" href="app/css/app.css">
                            <link rel="stylesheet" href="app/css/jquery.fancybox.min.css">

                                <!-- Favicon and Touch Icons  -->
                                <link rel="shortcut icon" href="assets/images/favico.png">
                                    <link rel="apple-touch-icon-precomposed" href="assets/images/favico.png">

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
                                                                        <h1 class="title">Đăng Kí Tài Khoản</h1>
                                                                        <ul class="breadcumb-list flex-five">
                                                                            <li><a href="/FB_N1/home">Trang chủ</a></li>
                                                                            <li><span>Đăng Kí</span></li>
                                                                        </ul>
                                                                        <img class="bcrumb-ab" src="./assets/images/page/mask-bcrumb.png" alt="">
                                                                    </div>
                                                                </div>

                                                            </div>
                                                        </section>

                                                        <section class="login">
                                                            <div class="tf-container">
                                                                <div class="row">
                                                                    <div class="col-lg-12">
                                                                        <div class="login-wrap flex">
                                                                            <div class="image">
                                                                                <img src="./assets/images/page/sign-up.jpg" alt="image">
                                                                            </div>
                                                                            <div class="content">
                                                                                <div class="inner-header-login">
                                                                                    <h3 class="title">Đăng kí tài khoản</h3>

                                                                                </div>
                                                                                <form action="${pageContext.request.contextPath}/dang-ki" method="POST" id="dkiform" class="login-user">
                                                                                    <div class="row">
                                                                                        <!-- Họ -->
                                                                                        <div class="col-md-6">
                                                                                            <div class="input-wrap">
                                                                                                <label>Họ</label>
                                                                                                <input type="text" name="lastname" placeholder="Nhập họ của bạn*" 
                                                                                                       pattern="^[A-Za-zÀ-ỹà-ỹ\s]+$" title="Chỉ chứa chữ cái và khoảng trắng" required>
                                                                                            </div>
                                                                                        </div>

                                                                                        <!-- Tên -->
                                                                                        <div class="col-md-6">
                                                                                            <div class="input-wrap">
                                                                                                <label>Tên</label>
                                                                                                <input type="text" name="firstname" placeholder="Nhập tên của bạn*" 
                                                                                                       pattern="^[A-Za-zÀ-ỹà-ỹ\s]+$" title="Chỉ chứa chữ cái và khoảng trắng" required>
                                                                                            </div>
                                                                                        </div>

                                                                                        <!-- Tên đăng nhập -->
                                                                                        <div class="col-md-6">
                                                                                            <div class="input-wrap">
                                                                                                <label>Tên đăng nhập</label>
                                                                                                <input type="text" name="username" placeholder="Nhập tên đăng nhập*" 
                                                                                                       pattern="^[a-zA-Z0-9_.]{6,}$" minlength="6"
                                                                                                       title="Tối thiểu 6 ký tự, chỉ gồm chữ, số, dấu gạch dưới và dấu chấm" required>
                                                                                            </div>
                                                                                        </div>

                                                                                        <!-- Email -->
                                                                                        <div class="col-md-6">
                                                                                            <div class="input-wrap">
                                                                                                <label>Email</label>
                                                                                                <input type="email" name="email" placeholder="Nhập email của bạn*" required>
                                                                                            </div>
                                                                                        </div>

                                                                                        <!-- Số điện thoại -->
                                                                                        <div class="col-md-6">
                                                                                            <div class="input-wrap">
                                                                                                <label>Số điện thoại</label>
                                                                                                <input type="tel" name="phone" placeholder="Nhập số điện thoại*" 
                                                                                                       pattern="^[0-9]{10}$" title="Số điện thoại phải gồm 10 chữ số" required>
                                                                                            </div>
                                                                                        </div>

                                                                                        <!-- Ngày sinh -->
                                                                                        <div class="col-md-6">
                                                                                            <div class="input-wrap">
                                                                                                <label>Ngày sinh</label>
                                                                                                <input type="date" name="dob" max="<?= date('Y-m-d') ?>" required>
                                                                                            </div>
                                                                                        </div>

                                                                                        <!-- Giới tính -->
                                                                                        <div class="col-md-6">
                                                                                            <div class="input-wrap">
                                                                                                <label>Giới tính</label>
                                                                                                <select name="gender" required>
                                                                                                    <option value="">-- Chọn giới tính --</option>
                                                                                                    <option value="Nam">Nam</option>
                                                                                                    <option value="Nữ">Nữ</option>
                                                                                                    <option value="Khác">Khác</option>
                                                                                                </select>
                                                                                            </div>
                                                                                        </div>

                                                                                        <!-- Địa chỉ -->
                                                                                        <div class="col-md-6">
                                                                                            <div class="input-wrap">
                                                                                                <label>Địa chỉ</label>
                                                                                                <input type="text" name="address" placeholder="Nhập địa chỉ*" required>
                                                                                            </div>
                                                                                        </div>

                                                                                        <!-- Mật khẩu -->
                                                                                        <div class="col-md-6">
                                                                                            <div class="input-wrap">
                                                                                                <label>Mật khẩu</label>
                                                                                                <input type="password" name="password" placeholder="Nhập mật khẩu*" 
                                                                                                       pattern="(?=.*[A-Za-z])(?=.*\d)(?=.*[^A-Za-z\d]).{8,}" 
                                                                                                       title="Ít nhất 8 ký tự gồm chữ, số và ký tự đặc biệt" required>
                                                                                            </div>
                                                                                        </div>

                                                                                        <!-- Nhập lại mật khẩu -->
                                                                                        <div class="col-md-6">
                                                                                            <div class="input-wrap">
                                                                                                <label>Nhập lại mật khẩu</label>
                                                                                                <input type="password" name="password_confirm" placeholder="Nhập lại mật khẩu*" required>
                                                                                            </div>
                                                                                        </div>

                                                                                        <!-- Xác nhận điều khoản -->
                                                                                        <div class="col-lg-12 mb-30">
                                                                                            <div class="checkbox">
                                                                                                <input id="check-policy" type="checkbox" name="check" value="check" >
                                                                                                    <label for="check-policy">Tôi đồng ý với Điều khoản dịch vụ và Chính sách bảo mật</label>
                                                                                            </div>
                                                                                        </div>

                                                                                        <!-- Nút Đăng ký -->
                                                                                        <div class="col-lg-12 mb-30">
                                                                                            <button type="submit" class="btn-submit">Đăng Ký</button>
                                                                                        </div>

                                                                                        <!-- Link Đăng nhập -->
                                                                                        <div class="col-md-12">
                                                                                            <div class="flex-three">
                                                                                                <span class="account">Bạn đã có tài khoản?</span>
                                                                                                <a href="login.html" class="link-login">Đăng nhập</a>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                </form>


                                                                                <div id="toast-container" style="position: fixed; top: 20px; right: 20px; z-index: 9999;"></div>
                                                                                <script src="app/js/validateRegister.js"></script>


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
