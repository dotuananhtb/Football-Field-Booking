<%-- 
    Document   : blog
    Created on : 11 thg 6, 2025, 20:30:39
    Author     : Asus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US" lang="en-US">

<head>
    <meta charset="utf-8">
    <title>Vitour - Travel & Tour Booking HTML Template</title>
<base href="${pageContext.request.contextPath}/UI/">
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
            <jsp:include page="header.jsp" />
            <!-- End Main Header -->
            <main id="main">

                <section class="breadcumb-section">
                    <div class="tf-container">
                        <div class="row">
                            <div class="col-lg-12 center z-index1">
                                <h1 class="title">Trang Blog</h1>
                                <ul class="breadcumb-list flex-five">
                                    <li><a href="/FB_N1/home">Trang chủ</a></li>
                                    <li><span>Tin tức</span></li>
                                </ul>
                                <img class="bcrumb-ab" src="./assets/images/page/mask-bcrumb.png" alt="">
                            </div>
                        </div>

                    </div>
                </section>

                <section class="our-blog pd-main">
                    <div class="tf-container">
                        <div class="row">
                            <div class="col-lg-8 col-12">
                                <!-- Search Form (trên danh sách bài viết) -->
                               
                                <div class="blog-posts">
                                    <c:forEach items="${posts}" var="post">
                                        <article class="side-blog mb-56px" style="border: 1px solid #e5e5e5; padding: 20px; margin-bottom: 30px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.05);">
                                            <div class="blog-image">
                                                
                                                <a class="post-thumbnail" href="${pageContext.request.contextPath}/blogdetails?postId=${post.postId}">
                                                    
                                                </a>
                                            </div>
                                            <div class="blog-content">
                                                <div class="top-detail-info">
                                                    <ul class="flex-three">
                                                        <li>
                                                            <i class="icon-user"></i>
                                                            <a href="#">${post.account.username}</a>
                                                        </li>
                                                        <li>
                                                            <i class="icon-25"></i>
                                                            <span class="date"> Bình luận:${post.commentCount}</span>
                                                        </li>
                                                        <li>
                                                            <i class="icon-24"></i>
                                                            <span class="date">${post.postDate}</span>
                                                        </li>
                                                    </ul>
                                                </div>
                                                <h3 class="entry-title">
                                                    <a href="${pageContext.request.contextPath}/blogdetails?postId=${post.postId}">${post.title}</a>
                                                </h3>
                                                <p class="description">${post.contentPost}</p>
                                                <div class="button-main ">
                                                    <a href="${pageContext.request.contextPath}/blogdetails?postId=${post.postId}" class="button-link">Xem thêm<i class="icon-Arrow-11"></i></a>
                                                </div>
                                            </div>
                                        </article>
                                    </c:forEach>
                                    <c:if test="${empty posts}">
                                        <p>Không có bài viết nào.</p>
                                    </c:if>
                                </div>
                                <!-- Pagination -->
                                <div class="row">
                                    <div class="col-md-12 ">
                                        <ul class="tf-pagination flex-five mt-20">
                                            <li>
                                                <a class="pages-link" href="${pageContext.request.contextPath}/blog?page=1${search != null ? '&search=' + search : ''}"><i class="icon-29"></i></a>
                                            </li>
                                            <c:forEach begin="1" end="${totalPages}" var="i">
                                                <li class="pages-item${currentPage == i ? ' active' : ''}" aria-current="${currentPage == i ? 'page' : ''}">
                                                    <a class="pages-link" href="${pageContext.request.contextPath}/blog?page=${i}${search != null ? '&search=' + search : ''}">${i}</a>
                                                </li>
                                            </c:forEach>
                                            <li>
                                                <a class="pages-link" href="${pageContext.request.contextPath}/blog?page=${totalPages}${search != null ? '&search=' + search : ''}"><i class="icon--1"></i></a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-12">
                                <div class="side-bar-right">
                                    
                                    </div>
                                    <div class="sidebar-widget">
                                        <h4 class="block-heading">Tìm kiếm</h4>
                                        <form action="${pageContext.request.contextPath}/blog" method="get" id="search-bar-widget">
                                            <input type="text" name="search" value="${search}" placeholder="Tìm kiếm bài viết...">
                                            <button type="submit"><i class="icon-search-2"></i></button>
                                        </form>

                                    </div>
                                    <div class="sidebar-widget">
                                        <h4 class="block-heading">Tin tức gần đây</h4>
                                        <div class="recent-post-list">
                                            <c:forEach var="post" items="${recentPosts}">
                                                <div class="list-recent flex-three">
                                                    <a href="${pageContext.request.contextPath}/blogdetails?postId=${post.postId}" class="recent-image">
                                                        
                                                    </a>
                                                    <div class="recent-info">
                                                        <div class="date">
                                                            <i class="icon-4"></i>
                                                            <span>${post.postDate}</span>
                                                        </div>
                                                        <h4 class="title">
                                                            <a href="${pageContext.request.contextPath}/blogdetails?postId=${post.postId}">${post.title}</a>
                                                        </h4>
                                                    </div>
                                                </div>
                                            </c:forEach>
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

</body>

</html>
