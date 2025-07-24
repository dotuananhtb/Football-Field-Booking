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
    <title>Bài viết của tôi - FootballStar</title>
<base href="${pageContext.request.contextPath}/UI/">
    <meta name="author" content="themesflat.com">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <link rel="stylesheet" href="app/css/app.css">
    <link rel="stylesheet" href="app/css/jquery.fancybox.min.css">

    <!-- Favicon and Touch Icons  -->
    <link rel="shortcut icon" href="assets/images/logoKoChu.png">
                                        <link rel="apple-touch-icon-precomposed" href="assets/images/logoKoChu.png">

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
                                <h1 class="title">Bài viết tìm đối</h1>
                                <ul class="breadcumb-list flex-five">
                                    <li><a href="/FB_N1/home">Trang chủ</a></li>
                                    <li><span>Bài viết</span></li>
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
                                <!-- Search and Filter Section -->
                                <div class="search-filter-section mb-40" style="background: #f8f9fa; padding: 20px; border-radius: 12px; border: 1px solid #e5e5e5;">
                                    <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
                                        <div>
                                            <h4 style="margin: 0; color: #333;">Diễn đàn tìm đối thủ</h4>
                                            <p style="margin: 5px 0 0 0; color: #666;">Tìm kiếm và tham gia các buổi đá bóng</p>
                                        </div>
                                        <div class="d-flex align-items-center gap-2">
                                            <c:if test="${sessionScope.account != null && account.userProfile.roleId ==3}">
                                                <a href="${pageContext.request.contextPath}/createPost" class="btn btn-primary" style="border-radius: 6px; white-space: nowrap;">
                                                    <i class="icon-plus"></i> Tạo bài viết
                                                </a>
                                            </c:if>
                                            <form action="${pageContext.request.contextPath}/blog" method="get" class="d-flex gap-2">
                                                <input type="text" name="search" value="${search}" placeholder="Tìm kiếm bài viết..." 
                                                       class="form-control" style="width: 250px; border-radius: 6px;">
                                                <button type="submit" class="btn btn-outline-primary" style="border-radius: 6px; white-space: nowrap;">
                                                    <i class="icon-search-2"></i> Tìm
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                               
                                <div class="blog-posts">
                                    <c:forEach items="${posts}" var="post">
                                        <article class="blog-card" style="margin-bottom: 30px;">
                                            <div class="blog-card-header" style="margin-bottom: 15px;">
                                                <div class="d-flex justify-content-between align-items-center">
                                                    <div class="d-flex gap-3" style="color: #666; font-size: 14px;">
                                                        <c:if test="${not empty post.account}">
                                                            <span><i class="icon-user"></i> ${post.account.username}</span>
                                                        </c:if>
                                                        <span><i class="icon-25"></i> ${commentCounts[post.postId]} bình luận</span>
                                                        <span><i class="icon-24"></i> ${post.postDate}</span>
                                                    </div>
                                                    <div>
                                                        <a href="${pageContext.request.contextPath}/blogdetails?postId=${post.postId}" 
                                                           class="btn btn-outline-primary btn-sm" style="border-radius: 6px;">
                                                            <i class="icon-eye"></i> Xem chi tiết
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                            <h3 class="blog-card-title" style="margin-bottom: 15px;">
                                                <a href="${pageContext.request.contextPath}/blogdetails?postId=${post.postId}" 
                                                   style="color: #4DA528; text-decoration: none; font-weight: 600;">
                                                    ${post.title}
                                                </a>
                                            </h3>
                                            <!-- Thông tin PostDetails nếu có -->
                                            <c:if test="${not empty post.postDetails}">
                                                <div style="margin-bottom: 10px; color: #333;">
                                                    <b>Ngày đá:</b> ${post.postDetails.matchDate} &nbsp;|
                                                    <b>Giờ đá:</b> ${post.postDetails.matchTime} &nbsp;|
                                                    <b>Loại sân:</b> ${post.postDetails.fieldType}
                                                </div>
                                            </c:if>
                                            <p class="blog-card-desc" style="color: #555; line-height: 1.6; margin-bottom: 20px;">
                                                <c:out value="${fn:replace(fn:replace(post.contentPost, ',', '<br/>'), 'Ghi chú:', '<br/><strong>Ghi chú:</strong>')}" escapeXml="false"/>
                                            </p>
                                            
                                            <!-- Comments Section -->
                                            <div class="comments-section">
                                                <button type="button" class="btn btn-outline-secondary btn-sm mb-15" 
                                                        onclick="toggleComment('${post.postId}')" 
                                                        id="toggle-btn-${post.postId}" 
                                                        style="border-radius: 6px;">
                                                    <i class="icon-chat"></i> Hiện bình luận (${commentCounts[post.postId]})
                                                </button>
                                                
                                                <div id="comment-section-${post.postId}" class="blog-card-comments" style="display:none; background: #f8f9fa; border-radius: 8px; padding: 15px;">
                                                    <h6 style="margin-bottom: 15px; color: #333;">Bình luận</h6>
                                                    <c:forEach var="cmt" items="${commentsMap[post.postId]}">
                                                        <div class="blog-comment" style="background: white; border-radius: 6px; padding: 10px; margin-bottom: 10px; border-left: 3px solid #4DA528;">
                                                            <c:if test="${not empty cmt.account}">
                                                                <div style="font-weight: 600; color: #4DA528; margin-bottom: 5px;">${cmt.account.username}</div>
                                                            </c:if>
                                                            <div style="color: #555;">${cmt.contentCmt}</div>
                                                        </div>
                                                    </c:forEach>
                                                    <form action="${pageContext.request.contextPath}/comment" method="post" class="blog-comment-form" style="margin-top: 15px;">
                                                        <input type="hidden" name="postId" value="${post.postId}" />
                                                        <div class="d-flex gap-2">
                                                            <input type="text" name="content" placeholder="Nhập bình luận của bạn..." 
                                                                   class="form-control" style="border-radius: 6px;" required />
                                                            <button type="submit" class="btn btn-primary" style="border-radius: 6px; white-space: nowrap;">
                                                                <i class="icon-send"></i> Gửi
                                                            </button>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </article>
                                    </c:forEach>
                                    <c:if test="${empty posts}">
                                        <div class="text-center py-50" style="background: #f8f9fa; border-radius: 12px;">
                                            <i class="icon-search" style="font-size: 48px; color: #ccc; margin-bottom: 15px;"></i>
                                            <h5 style="color: #666; margin-bottom: 10px;">Không tìm thấy bài viết nào</h5>
                                            <p style="color: #999;">Hãy thử tìm kiếm với từ khóa khác hoặc tạo bài viết mới</p>
                                        </div>
                                    </c:if>
                                </div>
                                <!-- Pagination -->
                                <c:if test="${totalPages > 1}">
                                    <div class="row mt-40">
                                        <div class="col-md-12">
                                            <nav aria-label="Blog pagination">
                                                <ul class="pagination justify-content-center" style="gap: 5px;">
                                                    <c:if test="${currentPage > 1}">
                                                        <li class="page-item">
                                                            <a class="page-link" href="${pageContext.request.contextPath}/blog?page=${currentPage - 1}&search=${search != null ? search : ''}" style="border-radius: 6px;">
                                                                <i class="icon-29"></i> Trước
                                                            </a>
                                                        </li>
                                                    </c:if>
                                                    
                                                    <c:forEach var="i" begin="1" end="${totalPages}">
                                                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                            <a class="page-link" href="${pageContext.request.contextPath}/blog?page=${i}&search=${search != null ? search : ''}" 
                                                               style="border-radius: 6px; ${i == currentPage ? 'background-color: #4DA528; border-color: #4DA528;' : ''}">
                                                                ${i}
                                                            </a>
                                                        </li>
                                                    </c:forEach>
                                                    
                                                    <c:if test="${currentPage < totalPages}">
                                                        <li class="page-item">
                                                            <a class="page-link" href="${pageContext.request.contextPath}/blog?page=${currentPage + 1}&search=${search != null ? search : ''}" style="border-radius: 6px;">
                                                                Sau <i class="icon--1"></i>
                                                            </a>
                                                        </li>
                                                    </c:if>
                                                </ul>
                                            </nav>
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                            <div class="col-lg-4 col-12">
                                <div class="side-bar-right">
                                    
                                    </div>
                                    <div class="sidebar-widget">
                                        <h4 class="block-heading">Bài viết gần đây</h4>
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