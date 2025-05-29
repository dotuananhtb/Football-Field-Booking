<%-- 
    Document   : dangki
    Created on : May 30, 2025, 1:40:06 AM
    Author     : Đỗ Tuấn Anh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US" lang="en-US">

    <head>
        <base href="${pageContext.request.contextPath}/UI/">

            <meta charset="utf-8">
                <title>Vitour - Travel & Tour Booking HTML Template</title>

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

                                                    <!-- Main Header -->
                                                    <header class="main-header flex">
                                                        <!-- Header Lower -->
                                                        <div id="header">
                                                            <div class="header-top">
                                                                <div class="header-top-wrap flex-two">
                                                                    <div class="header-top-right">
                                                                        <ul class=" flex-three">
                                                                            <li class="flex-three">
                                                                                <i class="icon-day"></i>
                                                                                <span>Thursday, Mar 26, 2021</span>
                                                                            </li>
                                                                            <li class="flex-three">
                                                                                <i class="icon-mail"></i>
                                                                                <span>support@example.com</span>
                                                                            </li>
                                                                            <li class="flex-three">
                                                                                <i class="icon-phone"></i>
                                                                                <span>684 555-0102 490</span>
                                                                            </li>


                                                                        </ul>
                                                                    </div>
                                                                    <div class="header-top-left flex-two">
                                                                        <a href="contact-us.html" class="booking">
                                                                            <i class="icon-19"></i>
                                                                            <span>Booking Now</span>
                                                                        </a>
                                                                        <div class="follow-social flex-two">
                                                                            <span>Follow Us :</span>
                                                                            <ul class="flex-two">
                                                                                <li><a href="#"><i class="icon-icon-2"></i></a></li>
                                                                                <li><a href="#"><i class="icon-icon_03"></i></a></li>
                                                                                <li><a href="#"><i class="icon-x"></i></a></li>
                                                                                <li><a href="#"><i class="icon-icon"></i></a></li>
                                                                            </ul>
                                                                        </div>

                                                                    </div>
                                                                </div>

                                                            </div>
                                                            <div class="header-lower">
                                                                <div class="tf-container full">
                                                                    <div class="row">
                                                                        <div class="col-lg-12">
                                                                            <div class="inner-container flex justify-space align-center">
                                                                                <!-- Logo Box -->
                                                                                <div class="mobile-nav-toggler mobie-mt mobile-button">
                                                                                    <i class="icon-Vector3"></i>
                                                                                </div>
                                                                                <div class="logo-box">
                                                                                    <div class="logo">
                                                                                        <a href="index.html">
                                                                                            <img src="assets/images/logo.png" alt="Logo">
                                                                                        </a>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="nav-outer flex align-center">
                                                                                    <!-- Main Menu -->
                                                                                    <nav class="main-menu show navbar-expand-md">
                                                                                        <div class="navbar-collapse collapse clearfix"
                                                                                             id="navbarSupportedContent">
                                                                                            <ul class="navigation clearfix">
                                                                                                <li class="dropdown2">
                                                                                                    <a href="#">Home</a>
                                                                                                    <ul>
                                                                                                        <li><a href="index.html">Home Page 01</a></li>
                                                                                                        <li><a href="home2.html">Home Page 02</a></li>
                                                                                                        <li><a href="home3.html">Home Page 03</a></li>
                                                                                                        <li><a href="home4.html">Home Page 04</a></li>
                                                                                                        <li><a href="home5.html">Home Page 05</a></li>
                                                                                                    </ul>
                                                                                                </li>
                                                                                                <li class="dropdown2">
                                                                                                    <a href="#">Tour</a>
                                                                                                    <ul>
                                                                                                        <li><a href="archieve-tour.html">Archieve tour</a>

                                                                                                        </li>
                                                                                                        <li><a href="tour-package-v2.html">Tour left sidebar</a>

                                                                                                        </li>
                                                                                                        <li><a href="tour-package-v4.html">Tour package </a>

                                                                                                        </li>
                                                                                                        <li><a href="tour-single.html">Tour Single </a>

                                                                                                        </li>
                                                                                                    </ul>
                                                                                                </li>
                                                                                                <li class="dropdown2"><a href="#">Destination</a>
                                                                                                    <ul>
                                                                                                        <li><a href="tour-destination-v1.html">Destination
                                                                                                                V1</a></li>
                                                                                                        <li><a href="tour-destination-v2.html">Destination
                                                                                                                V2</a></li>
                                                                                                        <li><a href="tour-destination-v3.html">Destination
                                                                                                                V3</a></li>
                                                                                                        <li><a href="single-destination.html">Destination V3</a>
                                                                                                        </li>
                                                                                                    </ul>
                                                                                                </li>
                                                                                                <li class="dropdown2 "><a href="#">Blog</a>
                                                                                                    <ul>
                                                                                                        <li><a href="blog.html">Blog</a></li>
                                                                                                        <li><a href="blog-details.html">Blog Detail</a></li>
                                                                                                    </ul>
                                                                                                </li>

                                                                                                <li class="dropdown2"><a href="#">Pages</a>
                                                                                                    <ul>
                                                                                                        <li><a href="about-us.html">About Us</a></li>
                                                                                                        <li><a href="team.html">Team member</a></li>
                                                                                                        <li><a href="gallery.html">Gallery</a></li>
                                                                                                        <li><a href="terms-condition.html">Terms & Condition</a>
                                                                                                        </li>
                                                                                                        <li><a href="help-center.html">Help center</a></li>
                                                                                                    </ul>
                                                                                                </li>
                                                                                                <li class="dropdown2"><a href="#">Dashboard</a>
                                                                                                    <ul>
                                                                                                        <li><a href="dashboard.html">Dashboard</a></li>
                                                                                                        <li><a href="my-booking.html">My booking</a></li>
                                                                                                        <li><a href="my-listing.html">My Listing</a></li>
                                                                                                        <li><a href="add-tour.html">Add Tour</a></li>
                                                                                                        <li><a href="my-favorite.html">My Favorites</a></li>
                                                                                                        <li><a href="my-profile.html">My profile</a></li>
                                                                                                    </ul>
                                                                                                </li>
                                                                                                <li><a href="contact-us.html">Contact</a></li>
                                                                                            </ul>
                                                                                        </div>
                                                                                    </nav>
                                                                                    <!-- Main Menu End-->
                                                                                </div>
                                                                                <div class="header-account flex align-center">
                                                                                    <div class="language">
                                                                                        <div class="nice-select" tabindex="0">
                                                                                            <img src="./assets/images/page/language.svg" alt=""><span
                                                                                                    class="current">English</span>
                                                                                                <ul class="list">
                                                                                                    <li data-value class="option selected"><img
                                                                                                            src="./assets/images/page/language.svg" alt="">English
                                                                                                    </li>
                                                                                                    <li data-value="Vietnam" class="option"><img
                                                                                                            src="./assets/images/page/language.svg" alt="">Vietnam
                                                                                                    </li>
                                                                                                    <li data-value="German" class="option"><img
                                                                                                            src="./assets/images/page/language.svg" alt="">German
                                                                                                    </li>
                                                                                                    <li data-value="Russian" class="option"><img
                                                                                                            src="./assets/images/page/language.svg" alt="">Russian
                                                                                                    </li>
                                                                                                    <li data-value="Canada" class="option"><img
                                                                                                            src="./assets/images/page/language.svg" alt="">Canada
                                                                                                    </li>
                                                                                                </ul>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="currency">
                                                                                        <div class="nice-select" tabindex="0">
                                                                                            <span class="current">USD</span>
                                                                                            <ul class="list">
                                                                                                <li data-value class="option selected">USD</li>
                                                                                                <li data-value="vnd" class="option">VND</li>
                                                                                                <li data-value="ero" class="option">ERO</li>
                                                                                            </ul>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="search-mobie relative">
                                                                                        <div class="dropdown">
                                                                                            <a  type="button" class="show-search" data-bs-toggle="dropdown" aria-expanded="false">
                                                                                                <i class="icon-Vector5"></i>
                                                                                            </a>
                                                                                            <ul class="dropdown-menu top-search">
                                                                                                <form action="/" id="search-bar-widget">
                                                                                                    <input type="text" placeholder="Search here...">
                                                                                                        <button type="button"><i class="icon-search-2"></i></button>
                                                                                                </form>
                                                                                            </ul>
                                                                                        </div> 
                                                                                    </div>
                                                                                    <div class="register">
                                                                                        <ul class="flex align-center">
                                                                                            <li class="">
                                                                                                <a href="login.html"><i class="icon-user-1-1"></i>
                                                                                                    <span>Sign in</span>
                                                                                                </a>
                                                                                            </li>
                                                                                        </ul>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <img src="./assets/images/page/fl1.png" alt="" class="fly-ab">
                                                            </div>
                                                        </div>

                                                        <!-- End Header Lower -->
                                                        <a href="#" class="header-sidebar flex-three" data-bs-toggle="offcanvas"
                                                           data-bs-target="#offcanvasRight" aria-controls="offcanvasRight">
                                                            <i class="icon-Bars"></i>
                                                        </a>

                                                        <!-- Mobile Menu  -->
                                                        <div class="close-btn"><span class="icon flaticon-cancel-1"></span></div>
                                                        <div class="mobile-menu">
                                                            <div class="menu-backdrop"></div>
                                                            <nav class="menu-box">
                                                                <div class="nav-logo"><a href="index.html">
                                                                        <img src="assets/images/logo2.png" alt=""></a></div>
                                                                <div class="bottom-canvas">
                                                                    <div class="menu-outer">
                                                                    </div>
                                                                </div>
                                                            </nav>
                                                        </div>
                                                        <!-- End Mobile Menu -->

                                                    </header>
                                                    <!-- End Main Header -->
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

                                                        <section class="brand-logo-widget bg-1">
                                                            <div class="tf-container">
                                                                <div class="row">
                                                                    <div class="col-lg-12">
                                                                        <div class="swiper brand-logo overflow-hidden">
                                                                            <div class="swiper-wrapper">
                                                                                <div class="swiper-slide">
                                                                                    <img src="./assets/images/page/brand-logo.png" alt="">
                                                                                </div>
                                                                                <div class="swiper-slide">
                                                                                    <img src="./assets/images/page/brand-logo.png" alt="">
                                                                                </div>
                                                                                <div class="swiper-slide">
                                                                                    <img src="./assets/images/page/brand-logo.png" alt="">
                                                                                </div>
                                                                                <div class="swiper-slide">
                                                                                    <img src="./assets/images/page/brand-logo.png" alt="">
                                                                                </div>
                                                                                <div class="swiper-slide">
                                                                                    <img src="./assets/images/page/brand-logo.png" alt="">
                                                                                </div>
                                                                                <div class="swiper-slide">
                                                                                    <img src="./assets/images/page/brand-logo.png" alt="">
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                        </section>


                                                        <section class="mb--93 bg-1">
                                                            <div class="tf-container">
                                                                <div class="callt-to-action flex-two z-index3 relative">
                                                                    <div class="callt-to-action-content flex-three">
                                                                        <div class="image">
                                                                            <img src="./assets/images/page/ready.png" alt="Image">
                                                                        </div>
                                                                        <div class="content">
                                                                            <h2 class="title-call">Ready to adventure and enjoy natural</h2>
                                                                            <p class="des">Lorem ipsum dolor sit amet, consectetur notted adipisicin</p>
                                                                        </div>
                                                                    </div>
                                                                    <img src="./assets/images/page/vector4.png" alt="" class="shape-ab">
                                                                        <div class="callt-to-action-button">
                                                                            <a href="#" class="get-call">Let,s get started</a>
                                                                        </div>
                                                                </div>
                                                            </div>

                                                        </section>

                                                    </main>

                                                    <footer class="footer footer-style1">
                                                        <div class="tf-container">
                                                            <div class="footer-main">
                                                                <div class="footer-logo">
                                                                    <div class="logo-footer">
                                                                        <img src="./assets/images/logo2.png" alt="">
                                                                    </div>
                                                                    <p class="des-footer">The world’s first and largest digital market
                                                                        for crypto collectibles and non-fungible
                                                                    </p>
                                                                    <ul class="footer-info">
                                                                        <li class="flex-three">
                                                                            <i class="icon-noun-mail-5780740-1"></i>
                                                                            <p>Info@webmail.com</p>
                                                                        </li>
                                                                        <li class="flex-three">
                                                                            <i class="icon-Group-9"></i>
                                                                            <p>684 555-0102 490</p>
                                                                        </li>
                                                                        <li class="flex-three">
                                                                            <i class="icon-Layer-19"></i>
                                                                            <p>6391 Elgin St. Celina, NYC 10299</p>
                                                                        </li>
                                                                    </ul>

                                                                </div>
                                                                <div class="footer-service">
                                                                    <h5 class="title">Services Req</h5>

                                                                    <ul class="footer-menu">
                                                                        <li>
                                                                            <a href="about-us.html">About Us</a>
                                                                        </li>
                                                                        <li>
                                                                            <a href="gallery.html">Gallery</a>
                                                                        </li>
                                                                        <li>
                                                                            <a href="team.html">Our Team</a>
                                                                        </li>
                                                                        <li>
                                                                            <a href="blog.html">Blog Insights</a>
                                                                        </li>
                                                                        <li>
                                                                            <a href="contact-us.html">Contact</a>
                                                                        </li>
                                                                    </ul>

                                                                </div>
                                                                <div class="footer-gallery">
                                                                    <h5 class="title">Gallery</h5>

                                                                    <div class="gallery-img">
                                                                        <a href="./assets/images/gallery/gl1.jpg" data-fancybox="gallery">
                                                                            <img src="./assets/images/gallery/gl1.jpg" alt="image gallery">
                                                                        </a>
                                                                        <a href="./assets/images/gallery/gl2.jpg" data-fancybox="gallery">
                                                                            <img src="./assets/images/gallery/gl2.jpg" alt="image gallery">
                                                                        </a>
                                                                        <a href="./assets/images/gallery/gl3.jpg" data-fancybox="gallery">
                                                                            <img src="./assets/images/gallery/gl3.jpg" alt="image gallery">
                                                                        </a>
                                                                        <a href="./assets/images/gallery/gl4.jpg" data-fancybox="gallery">
                                                                            <img src="./assets/images/gallery/gl4.jpg" alt="image gallery">
                                                                        </a>
                                                                        <a href="./assets/images/gallery/gl5.jpg" data-fancybox="gallery">
                                                                            <img src="./assets/images/gallery/gl5.jpg" alt="image gallery">
                                                                        </a>
                                                                        <a href="./assets/images/gallery/gl6.jpg" data-fancybox="gallery">
                                                                            <img src="./assets/images/gallery/gl6.jpg" alt="image gallery">
                                                                        </a>
                                                                    </div>

                                                                </div>
                                                                <div class="footer-newsletter">
                                                                    <h5 class="title">Newsletter</h5>
                                                                    <form action="/" id="footer-form">
                                                                        <div class="input-wrap flex-three">
                                                                            <input type="email" placeholder="Enter Email Adress">
                                                                                <button type="submit"><i class="icon-paper-plane"></i></button>
                                                                        </div>
                                                                        <div class="check-form flex-three">
                                                                            <i class="icon-Vector-121"></i>
                                                                            <p>I agree to all your terms and policies</p>
                                                                        </div>

                                                                    </form>
                                                                    <ul class="social-ft flex-three">
                                                                        <li>
                                                                            <a href="#">
                                                                                <i class="icon-icon-2"></i>
                                                                            </a>
                                                                        </li>
                                                                        <li>
                                                                            <a href="#">
                                                                                <i class="icon-x"></i>
                                                                            </a>
                                                                        </li>
                                                                        <li>
                                                                            <a href="#">
                                                                                <i class="icon-8"></i>
                                                                            </a>
                                                                        </li>
                                                                        <li>
                                                                            <a href="#">
                                                                                <i class="icon-2"></i>
                                                                            </a>
                                                                        </li>
                                                                    </ul>

                                                                </div>
                                                            </div>

                                                            <div class="row footer-bottom">
                                                                <div class="col-md-6">
                                                                    <p class="copy-right">Copyright © 2024 by Themesflat. All Rights Reserved</p>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <ul class="social flex-six">
                                                                        <li>
                                                                            <a href="#">
                                                                                <i class="icon-icon-2"></i>
                                                                            </a>
                                                                        </li>
                                                                        <li>
                                                                            <a href="#">
                                                                                <i class="icon-x"></i>
                                                                            </a>
                                                                        </li>
                                                                        <li>
                                                                            <a href="#">
                                                                                <i class="icon-icon_03"></i>
                                                                            </a>
                                                                        </li>
                                                                        <li>
                                                                            <a href="#">
                                                                                <i class="icon-2"></i>
                                                                            </a>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </footer>

                                                    <!-- Bottom -->
                                                </div>
                                                <!-- /#page -->
                                            </div>

                                            <!-- Modal Popup Bid -->

                                            <a id="scroll-top" class="button-go"></a>


                                            <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight" aria-labelledby="offcanvasRightLabel">
                                                <div class="offcanvas-header">
                                                    <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                                                </div>
                                                <div class="offcanvas-body">
                                                    <div class="logo-canvas">
                                                        <img src="./assets/images/logo.png" alt="image">
                                                    </div>
                                                    <p class="des">The world’s first and largest digital market
                                                        for crypto collectibles and non-fungible
                                                    </p>
                                                    <ul class="canvas-info">
                                                        <li class="flex-three">
                                                            <i class="icon-noun-mail-5780740-1"></i>
                                                            <p>Info@webmail.com</p>
                                                        </li>
                                                        <li class="flex-three">
                                                            <i class="icon-Group-9"></i>
                                                            <p>684 555-0102 490</p>
                                                        </li>
                                                        <li class="flex-three">
                                                            <i class="icon-Layer-19"></i>
                                                            <p>6391 Elgin St. Celina, NYC 10299</p>
                                                        </li>
                                                    </ul>
                                                    <ul class="social flex-three">
                                                        <li>
                                                            <a href="#">
                                                                <i class="icon-icon-2"></i>
                                                            </a>
                                                        </li>
                                                        <li>
                                                            <a href="#">
                                                                <i class="icon-x"></i>
                                                            </a>
                                                        </li>
                                                        <li>
                                                            <a href="#">
                                                                <i class="icon-8"></i>
                                                            </a>
                                                        </li>
                                                        <li>
                                                            <a href="#">
                                                                <i class="icon-6"></i>
                                                            </a>
                                                        </li>
                                                    </ul>

                                                </div>
                                            </div>

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
