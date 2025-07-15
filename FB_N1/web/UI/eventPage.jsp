<%-- 
    Document   : blog
    Created on : 11 thg 6, 2025, 20:30:39
    Author     : Asus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US" lang="en-US">

    <head>
        <meta charset="utf-8">
            <title>Blog của tôi - FootballStar</title>
            <base href="${pageContext.request.contextPath}/UI/">
                <meta name="author" content="themesflat.com">
                    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

                        <link rel="stylesheet" href="app/css/app.css">
                            <link rel="stylesheet" href="app/css/jquery.fancybox.min.css">

                                <!-- Favicon and Touch Icons  -->
                                <link rel="shortcut icon" href="assets/images/logoKoChu.png">
                                    <link rel="apple-touch-icon-precomposed" href="assets/images/logoKoChu.png">
                                        <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">

                                        <style>
                                            .blog-card {
                                                background: #fff;
                                                border-radius: 12px;
                                                box-shadow: 0 2px 16px rgba(0,0,0,0.08);
                                                padding: 28px 24px;
                                                margin-bottom: 32px;
                                                border: 1px solid #e5e5e5;
                                            }
                                            .blog-card-header {
                                                display: flex;
                                                gap: 18px;
                                                font-size: 15px;
                                                color: #888;
                                                margin-bottom: 10px;
                                            }
                                            .blog-card-title {
                                                font-size: 22px;
                                                font-weight: 700;
                                                margin: 10px 0 8px 0;
                                                color: #222;
                                            }
                                            .blog-card-desc {
                                                color: #444;
                                                margin-bottom: 18px;
                                            }
                                            .blog-card-actions {
                                                display: flex;
                                                gap: 12px;
                                                margin-bottom: 18px;
                                            }
                                            .blog-card-actions .button-link {
                                                border-radius: 6px;
                                                padding: 8px 18px;
                                                font-weight: 600;
                                                border: none;
                                                background: #4DA528;
                                                color: #fff;
                                                cursor: pointer;
                                                transition: none;
                                                display: flex;
                                                align-items: center;
                                            }
                                            .blog-card-actions .button-link.toggle {
                                                background: #fff;
                                                color: #222;
                                                border: 1px solid #4DA528;
                                                transition: none;
                                            }
                                            .blog-card-actions .button-link:hover,
                                            .blog-card-actions .button-link.toggle:hover {
                                                background: inherit;
                                                color: inherit;
                                            }
                                            .blog-card-comments {
                                                border-top: 1px solid #eee;
                                                margin-top: 18px;
                                                padding-top: 12px;
                                            }
                                            .blog-comment {
                                                background: #f6f8fa;
                                                border-radius: 8px;
                                                padding: 10px 14px;
                                                margin-bottom: 10px;
                                                color: #222;
                                            }
                                            .blog-comment-form {
                                                display: flex;
                                                gap: 8px;
                                                margin-top: 10px;
                                            }
                                            .blog-comment-form input[type='text'] {
                                                flex: 1;
                                                border-radius: 8px;
                                                border: 1px solid #ccc;
                                                padding: 10px 12px;
                                                font-size: 15px;
                                            }
                                            .send-btn {
                                                display: flex;
                                                align-items: center;
                                                background: #4DA528;
                                                color: #fff;
                                                border: none;
                                                border-radius: 8px;
                                                padding: 0 18px;
                                                font-size: 18px;
                                                font-weight: 600;
                                                cursor: pointer;
                                                transition: background 0.2s;
                                                height: 40px;
                                            }
                                            .send-btn:hover {
                                                background: #FF970D;
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

                                                    <!-- Main Header -->
                                                    <jsp:include page="header.jsp" />
                                                    <!-- End Main Header -->
                                                    <main id="main">

                                                        <section class="breadcumb-section">
                                                            <div class="tf-container">
                                                                <div class="row">
                                                                    <div class="col-lg-12 center z-index1">
                                                                        <h1 class="title">Thông báo sự kiện</h1>

                                                                        <img class="bcrumb-ab" src="./assets/images/page/mask-bcrumb.png" alt="">
                                                                    </div>
                                                                </div>

                                                            </div>
                                                        </section>

                                                        <section class="our-blog pd-main">
                                                            <div class="tf-container">
                                                                <div class="row">
                                                                    <div class="col-lg-1"></div>
                                                                    <div class="col-lg-10 col-12">
                                                                        <!-- Search and Filter Section -->
                                                                        <div class="ql-editor">
                                                                            ${event.title.title1}
                                                                        </div>
                                                                    </div>
                                                                        <div class="col-lg-1"></div>

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

                                            <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight">
                                                <div class="offcanvas-header">
                                                    <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                                                </div>
                                                <div class="offcanvas-body">
                                                    <div class="logo-canvas">
                                                        <img src="./assets/images/logo.png" alt="image">
                                                    </div>
                                                    <p class="des">The world's first and largest digital market
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

                                            <script>
                                                function toggleComment(postId) {
                                                    var el = document.getElementById('comment-section-' + postId);
                                                    var btn = document.getElementById('toggle-btn-' + postId);
                                                    if (el.style.display === 'none') {
                                                        el.style.display = 'block';
                                                        btn.innerText = 'Ẩn bình luận';
                                                    } else {
                                                        el.style.display = 'none';
                                                        btn.innerText = 'Hiện bình luận';
                                                    }
                                                }
                                            </script>

                                        </body>

                                        </html>