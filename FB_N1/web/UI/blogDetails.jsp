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
                                <div style="margin-top: 20px;">
                                    <a href="javascript:history.back()" class="btn btn-secondary" style="border-radius: 6px; padding: 8px 20px;">
                                        <i class="icon-arrow-left"></i> Quay lại
                                    </a>
                                </div>
                                <img class="bcrumb-ab" src="./assets/images/page/mask-bcrumb.png" alt="">
                            </div>
                        </div>

                    </div>
                </section>

                <section class="our-blog pd-main">
                    <div class="tf-container">
                        <div class="row justify-content-center">
                            <div class="col-lg-8 col-12">
                                <!-- Post Content -->
                                <article class="post-details-card" style="background: white; border: 1px solid #e5e5e5; border-radius: 12px; padding: 30px; box-shadow: 0 4px 12px rgba(0,0,0,0.08); margin-bottom: 40px;">
                                    <h1 class="post-title" style="font-size: 32px; font-weight: 700; color: #333; margin-bottom: 20px;">
                                        ${post.title}
                                    </h1>
                                    <div class="post-meta d-flex gap-4" style="color: #666; font-size: 14px; margin-bottom: 25px; padding-bottom: 15px; border-bottom: 1px solid #eee;">
                                        <span><i class="icon-user" style="color: #4DA528;"></i> <strong>Tác giả:</strong> ${post.account.username}</span>
                                        <span><i class="icon-4" style="color: #4DA528;"></i> <strong>Ngày đăng:</strong> ${post.postDate}</span>
                                    </div>
                                    <!-- Thông tin chi tiết trận đấu nếu có -->
                                    <c:if test="${not empty postDetails}">
                                        <div class="post-details-info" style="background: #f8f9fa; border-radius: 8px; padding: 15px 20px; margin-bottom: 20px; border: 1px solid #e5e5e5;">
                                            
                                            <ul style="list-style: none; padding: 0; margin: 0; color: #444; font-size: 15px;">
                                                <li><strong>Ngày muốn  đấu:</strong> ${postDetails.matchDate}</li>
                                                <li><strong>Giờ muốn đấu:</strong> ${postDetails.matchTime}</li>
                                                <li><strong>Loại sân:</strong> ${postDetails.fieldType}</li>
                                            </ul>
                                        </div>
                                    </c:if>
                                    <div class="post-content" style="font-size: 16px; line-height: 1.8; color: #444;">
                                        <p>
                                            <c:out value="${fn:replace(fn:replace(post.contentPost, ',', '<br/>'), 'Ghi chú:', '<br/><br/><strong>Ghi chú:</strong>')}" escapeXml="false"/>
                                        </p>
                                    </div>
                                </article>
                                
                                <!-- Comments Section -->
                                <div class="comments-section-card" style="background: white; border: 1px solid #e5e5e5; border-radius: 12px; padding: 30px; box-shadow: 0 4px 12px rgba(0,0,0,0.08); margin-bottom: 40px;">
                                    <h3 class="section-title" style="color: #333; margin-bottom: 25px; padding-bottom: 15px; border-bottom: 1px solid #eee;">
                                        <i class="icon-chat" style="color: #4DA528;"></i> Bình luận (${fn:length(comments)})
                                    </h3>
                                    
                                    <!-- List of comments -->
                                    <div class="comment-list">
                                        <c:forEach var="comment" items="${comments}">
                                            <div class="comment-item" style="display: flex; gap: 15px; margin-bottom: 25px;">
                                                <div class="comment-avatar" style="width: 48px; height: 48px; background: #4DA528; color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: 600; font-size: 20px;">
                                                    ${fn:substring(comment.account.username, 0, 1)}
                                                </div>
                                                <div class="comment-body" style="flex: 1;">
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <div class="comment-author" style="font-weight: 600; color: #333;">${comment.account.username}</div>
                                                        <div class="comment-date" style="color: #888; font-size: 13px;">${comment.cmtDate}</div>
                                                    </div>
                                                    <div id="comment-content-${comment.commentId}" style="color: #555; margin-top: 5px;">${comment.contentCmt}</div>
                                                    
                                                    <!-- Edit/Delete buttons -->
                                                    <c:if test="${sessionScope.account != null && (sessionScope.account.accountId == comment.accountId || sessionScope.account.userProfile.roleId <= 2)}">
                                                        <div class="comment-actions" style="margin-top: 10px; display: flex; gap: 15px; font-size: 13px;">
                                                            <button onclick="showEditForm(${comment.commentId})" class="btn btn-sm btn-outline-secondary" style="border: none; padding: 0; color: #4DA528;">
                                                                <i class="icon-edit"></i> Sửa
                                                            </button>
                                                            <form action="${pageContext.request.contextPath}/deleteComment" method="post" style="display:inline; margin: 0;">
                                                                <input type="hidden" name="commentId" value="${comment.commentId}" />
                                                                <button type="submit" onclick="return confirm('Bạn chắc chắn muốn xóa bình luận này?')" class="btn btn-sm btn-outline-danger" style="border: none; padding: 0; color: #dc3545;">
                                                                    <i class="icon-delete"></i> Xóa
                                                                </button>
                                                            </form>
                                                        </div>
                                                    </c:if>

                                                    <!-- Edit Form -->
                                                    <div id="edit-form-${comment.commentId}" style="display: none; margin-top: 10px;">
                                                        <form action="${pageContext.request.contextPath}/updateComment" method="post">
                                                            <input type="hidden" name="commentId" value="${comment.commentId}" />
                                                            <input type="hidden" name="postId" value="${post.postId}" />
                                                            <textarea name="content" class="form-control" style="border-radius: 6px;" rows="3">${comment.contentCmt}</textarea>
                                                            <div style="margin-top: 10px; display: flex; gap: 10px;">
                                                                <button type="submit" class="btn btn-primary btn-sm" style="border-radius: 6px;">Cập nhật</button>
                                                                <button type="button" onclick="hideEditForm(${comment.commentId})" class="btn btn-secondary btn-sm" style="border-radius: 6px;">Hủy</button>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                        <c:if test="${empty comments}">
                                            <p style="color: #888; text-align: center;">Chưa có bình luận nào. Hãy là người đầu tiên bình luận!</p>
                                        </c:if>
                                    </div>
                                </div>
                                
                                <!-- Add Comment Form -->
                                <div class="add-comment-card" style="background: white; border: 1px solid #e5e5e5; border-radius: 12px; padding: 30px; box-shadow: 0 4px 12px rgba(0,0,0,0.08);">
                                    <h3 class="section-title" style="color: #333; margin-bottom: 20px;">
                                        <i class="icon-add-comment" style="color: #4DA528;"></i> Viết bình luận
                                    </h3>
                                    <form action="${pageContext.request.contextPath}/comment" method="post">
                                        <input type="hidden" name="postId" value="${post.postId}" />
                                        <div class="mb-3">
                                            <textarea name="content" class="form-control" rows="4" placeholder="Nhập nội dung bình luận của bạn..." required style="border-radius: 6px;"></textarea>
                                        </div>
                                        <button type="submit" class="btn btn-primary" style="border-radius: 6px; padding: 10px 25px;">
                                            <i class="icon-send"></i> Gửi bình luận
                                        </button>
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
    function showEditForm(commentId) {
        // Hide all other open edit forms
        document.querySelectorAll('[id^="edit-form-"]').forEach(form => {
            if (form.id !== `edit-form-${commentId}`) {
                form.style.display = 'none';
            }
        });
        document.querySelectorAll('[id^="comment-content-"]').forEach(content => {
            content.style.display = 'block';
        });

        // Show the selected one
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