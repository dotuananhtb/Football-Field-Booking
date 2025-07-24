<%-- 
    Document   : teamMember
    Created on : Jul 22, 2025, 4:15:37 AM
    Author     : VAN NGUYEN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US" lang="en-US">

    <head>
        <meta charset="utf-8">
            <title>Thành viên - FootBall Star</title>

            <meta name="author" content="themesflat.com">
                <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

                    <link rel="stylesheet" href="app/css/app.css">
                        <link rel="stylesheet" href="app/css/map.min.css">
                            <link rel="stylesheet" href="app/css/jquery.fancybox.min.css">

                                <!-- Favicon and Touch Icons  -->
                                <link rel="shortcut icon" href="assets/images/logoKoChu.png">
                                    <link rel="apple-touch-icon-precomposed" href="assets/images/logoKoChu.png">

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
                                                    <jsp:include page="header.jsp"></jsp:include>
                                                        <!-- End Main Header -->
                                                        <main id="main">

                                                            <section class="breadcumb-section">
                                                                <div class="tf-container">
                                                                    <div class="row">
                                                                        <div class="col-lg-12 center z-index1">
                                                                            <h1 class="title">Thành viên nhóm</h1>
                                                                            <ul class="breadcumb-list flex-five">
                                                                                <li><a href="/FB_N1/home">Trang Chủ</a></li>
                                                                                <li><span>Thành viên nhóm</span></li>
                                                                            </ul>
                                                                            <img class="bcrumb-ab" src="./assets/images/page/mask-bcrumb.png" alt="">
                                                                        </div>
                                                                    </div>

                                                                </div>
                                                            </section>

                                                            <section class="team-member-page pd-main">
                                                                <div class="tf-container">
                                                                    <div class="row mb-40">
                                                                        <div class="col-lg-12">
                                                                            <div class="center m0-auto w-text-heading">
                                                                                <span class="sub-title-heading text-main font-yes fs-28-46">FootballStar</span>
                                                                                <h2 class="title-heading ">gặp gỡ những thành viên của nhóm 
                                                                                </h2>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="team-member-grid">

                                                                        <div class="tf-widget-team">
                                                                            <div class="team-image mb-15">
                                                                                <img src=".\assets\images\member\nguyen.jpg" alt="">
                                                                                    <ul class="social-team">
                                                                                        <li>
                                                                                            <a href="#">
                                                                                                <i class="icon-9"></i>
                                                                                            </a>
                                                                                        </li>
                                                                                        <li>
                                                                                            <a href="#">
                                                                                                <i class="icon-5"></i>
                                                                                            </a>
                                                                                        </li>
                                                                                        <li>
                                                                                            <a href="#">
                                                                                                <i class="icon-linkedin"></i>
                                                                                            </a>
                                                                                        </li>
                                                                                        <li>
                                                                                            <a href="#">
                                                                                                <i class="icon-youtube"></i>
                                                                                            </a>
                                                                                        </li>
                                                                                    </ul>

                                                                            </div>
                                                                            <div class="team-content center">
                                                                                <p class="job">thành viên</p>
                                                                                <h4 class="name"><a href="#">Nguyễn Văn Nguyên</a></h4>
                                                                            </div>
                                                                        </div>
                                                                        <div class="tf-widget-team">
                                                                            <div class="team-image mb-15">
                                                                                <img src=".\assets\images\member\binh4.jpg" alt="">
                                                                                    <ul class="social-team">
                                                                                        <li>
                                                                                            <a href="#">
                                                                                                <i class="icon-9"></i>
                                                                                            </a>
                                                                                        </li>
                                                                                        <li>
                                                                                            <a href="#">
                                                                                                <i class="icon-5"></i>
                                                                                            </a>
                                                                                        </li>
                                                                                        <li>
                                                                                            <a href="#">
                                                                                                <i class="icon-linkedin"></i>
                                                                                            </a>
                                                                                        </li>
                                                                                        <li>
                                                                                            <a href="#">
                                                                                                <i class="icon-youtube"></i>
                                                                                            </a>
                                                                                        </li>
                                                                                    </ul>

                                                                            </div>
                                                                            <div class="team-content center">
                                                                                <p class="job">thành viên</p>
                                                                                <h4 class="name"><a href="#">Nguyễn Hữu Bình</a></h4>
                                                                            </div>
                                                                        </div>
                                                                        <div class="tf-widget-team">
                                                                            <div class="team-image mb-15">
                                                                                <img src=".\assets\images\member\tuananh.jpg" alt="">
                                                                                    <ul class="social-team">
                                                                                        <li>
                                                                                            <a href="#">
                                                                                                <i class="icon-9"></i>
                                                                                            </a>
                                                                                        </li>
                                                                                        <li>
                                                                                            <a href="#">
                                                                                                <i class="icon-5"></i>
                                                                                            </a>
                                                                                        </li>
                                                                                        <li>
                                                                                            <a href="#">
                                                                                                <i class="icon-linkedin"></i>
                                                                                            </a>
                                                                                        </li>
                                                                                        <li>
                                                                                            <a href="#">
                                                                                                <i class="icon-youtube"></i>
                                                                                            </a>
                                                                                        </li>
                                                                                    </ul>

                                                                            </div>
                                                                            <div class="team-content center">
                                                                                <p class="job">thành viên</p>
                                                                                <h4 class="name"><a href="#">Đỗ Tuấn Anh</a></h4>
                                                                            </div>
                                                                        </div>
                                                                        <div class="tf-widget-team">
                                                                            <div class="team-image mb-15">
                                                                                <img src=".\assets\images\member\thanh.jpg" alt="">
                                                                                    <ul class="social-team">
                                                                                        <li>
                                                                                            <a href="#">
                                                                                                <i class="icon-9"></i>
                                                                                            </a>
                                                                                        </li>
                                                                                        <li>
                                                                                            <a href="#">
                                                                                                <i class="icon-5"></i>
                                                                                            </a>
                                                                                        </li>
                                                                                        <li>
                                                                                            <a href="#">
                                                                                                <i class="icon-linkedin"></i>
                                                                                            </a>
                                                                                        </li>
                                                                                        <li>
                                                                                            <a href="#">
                                                                                                <i class="icon-youtube"></i>
                                                                                            </a>
                                                                                        </li>
                                                                                    </ul>

                                                                            </div>
                                                                            <div class="team-content center">
                                                                                <p class="job">thành viên</p>
                                                                                <h4 class="name"><a href="#">Trần Đức Thanh</a></h4>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </section>






                                                        </main>

                                                    <jsp:include page ="footer.jsp"></jsp:include>

                                                    <!-- Bottom -->
                                                </div>
                                                <!-- /#page -->
                                            </div>

                                            <!-- Modal Popup Bid -->





                                            <!-- Javascript -->
                                            <script src="app/js/jquery.min.js"></script>
                                            <script src="app/js/jquery.nice-select.min.js"></script>
                                            <script src="app/js/bootstrap.min.js"></script>
                                            <script src="app/js/swiper-bundle.min.js"></script>
                                            <script src="app/js/swiper.js"></script>
                                            <script src="app/js/plugin.js"></script>
                                            <script src="app/js/jquery.fancybox.js"></script>
                                            <script src="app/js/map.min.js"></script>
                                            <script src="app/js/map.js"></script>
                                            <script src="app/js/shortcodes.js"></script>
                                            <script src="app/js/main.js"></script>

                                        </body>

                                        </html>
