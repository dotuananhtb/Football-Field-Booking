<%-- 
    Document   : blogDetails
    Created on : 11 thg 6, 2025, 21:31:39
    Author     : Asus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US" lang="en-US">

<head>
    <meta charset="utf-8">
    <title>BlogDetails-FootballStar</title>
<base href="${pageContext.request.contextPath}/UI/">
    <meta name="author" content="themesflat.com">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <link rel="stylesheet" href="app/css/app.css">
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
            <jsp:include page="header.jsp" />
            <!-- End Main Header -->
            <main id="main">

                <section class="breadcumb-section">
                    <div class="tf-container">
                        <div class="row">
                            <div class="col-lg-12 center z-index1">
                                <h1 class="title">Chi tiết bài viết</h1>
                                <ul class="breadcumb-list flex-five">
                                    <li><a href="/FB_N1/home">Trang chủ</a></li>
                                    <li><span>Xem bài viết</span></li>
                                </ul>
                                <img class="bcrumb-ab" src="./assets/images/page/mask-bcrumb.png" alt="">
                            </div>
                        </div>

                    </div>
                </section>

                <section class="our-blog pd-main">
                    <div class="tf-container">
                        <div class="row justify-content-center">
                            <div class="col-lg-8 col-12">
                                <article class="side-blog side-blog-single">
                                    
                                    <div class="top-detail-info">
                                        <ul class="flex-three">
                                            <li>
                                                <i class="icon-4"></i>
                                                <span>${post.postDate}</span>
                                            </li>
                                            <li>
                                                <i class="icon-user"></i>
                                                <span>${post.account.username}</span>
                                            </li>
                                        </ul>
                                    </div>
                                    <h2 class="entry-title">${post.title}</h2>
                                    <p class="des lh-32 mb-37">
                                        <c:out value="${fn:replace(post.contentPost, ',', '<br/>')}" escapeXml="false"/>
                                    </p>
                                </article>
                                
                                <div class="comment-single">
                                    <h3 class="title mb-32">Bình luận</h3>
                                    <c:forEach var="comment" items="${comments}">
                                        <div class="comment-item" style="margin-bottom: 24px; border: 1px solid #e5e5e5; padding: 15px; border-radius: 8px;">
                                            <strong style="font-size: 18px;">${comment.account.username}</strong>
                                            <div style="color: #888; font-size: 13px; text-transform: uppercase; margin-bottom: 4px;">
                                                ${comment.cmtDate}
                                            </div>
                                            <div style="font-size: 16px;" id="comment-content-${comment.commentId}">${comment.contentCmt}</div>
                                            <c:if test="${sessionScope.account != null && sessionScope.account.accountId == comment.accountId}">
                                                <div style="margin-top: 10px;">
                                                    <button onclick="showEditForm(${comment.commentId}, '${comment.contentCmt}')" style="color: #4DA528; background: none; border: none; cursor: pointer; margin-right: 10px;">Chỉnh sửa</button>
                                                    <form action="${pageContext.request.contextPath}/deleteComment" method="post" style="display:inline;">
                                                        <input type="hidden" name="commentId" value="${comment.commentId}" />
                                                        <button type="submit" onclick="return confirm('Bạn chắc chắn muốn xóa bình luận này?')" style="color:red;background:none;border:none;cursor:pointer;">Xóa</button>
                                                    </form>
                                                </div>
                                                <div id="edit-form-${comment.commentId}" style="display: none; margin-top: 10px;">
                                                    <form action="${pageContext.request.contextPath}/updateComment" method="post">
                                                        <input type="hidden" name="commentId" value="${comment.commentId}" />
                                                        <input type="hidden" name="postId" value="${post.postId}" />
                                                        <textarea name="content" style="width: 100%; padding: 8px; margin-bottom: 10px; border: 1px solid #ddd; border-radius: 4px;">${comment.contentCmt}</textarea>
                                                        <button type="submit" style="background: #4DA528; color: white; border: none; padding: 8px 15px; border-radius: 4px; cursor: pointer;">Cập nhật</button>
                                                        <button type="button" onclick="hideEditForm(${comment.commentId})" style="background: #666; color: white; border: none; padding: 8px 15px; border-radius: 4px; cursor: pointer; margin-left: 10px;">Hủy</button>
                                                    </form>
                                                </div>
                                            </c:if>
                                        </div>
                                    </c:forEach>
                                    <c:if test="${empty comments}">
                                        <p>Chưa có bình luận nào.</p>
                                    </c:if>
                                </div>
                                <div class="form-comment">
                                    <h3 class="title mb-32">Viết bình luận</h3>
                                    <form action="${pageContext.request.contextPath}/comment" method="post">
                                        <input type="hidden" name="postId" value="${post.postId}" />
                                        <textarea name="content" placeholder="Nhập bình luận..."></textarea>
                                        <button type="submit">Gửi bình luận</button>
                                    </form>
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
    function showEditForm(commentId, content) {
        document.getElementById('comment-content-' + commentId).style.display = 'none';
        document.getElementById('edit-form-' + commentId).style.display = 'block';
    }

    function hideEditForm(commentId) {
        document.getElementById('comment-content-' + commentId).style.display = 'block';
        document.getElementById('edit-form-' + commentId).style.display = 'none';
    }
    </script>

</body>

</html>