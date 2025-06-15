<%-- 
    Document   : hoSoNguoiDung
    Created on : 31 thg 5, 2025, 15:21:16
    Author     : Asus
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US" lang="en-US">

    <head>
        <base href="${pageContext.request.contextPath}/UI/">
            <meta charset="utf-8">
                <title>Quản lý bài viết - FootballStar</title>

                <meta name="author" content="themesflat.com">
                    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

                        <link rel="stylesheet" href="app/css/app.css">
                            <link rel="stylesheet" href="app/css/bootstrap-select.min.css">
                                <link rel="stylesheet" href="app/css/map.min.css">

                                    <!-- Favicon and Touch Icons  -->
                                    <link rel="shortcut icon" href="assets/images/logoKoChu.png">
                                        <link rel="apple-touch-icon-precomposed" href="assets/images/logoKoChu.png">
                                            </head>

                                            <body class="body header-fixed">
                                                <jsp:include page="header_dashboard.jsp" />
                                                <!-- End Main Header -->
                                                <main id="main">
                                                   <section class="profile-dashboard">
                                                        <div class="inner-header mb-40">
                                                            <h3 class="title">Quản lý bài viết của bạn</h3>
                                                            <p class="des">Dưới đây là danh sách các bài viết bạn đã đăng</p>
                                                        </div>  
                                                        <div style="display: flex; justify-content: flex-end; margin-bottom: 20px;">
                                                            <a href="${pageContext.request.contextPath}/createPost" class="btn btn-primary">Tạo bài viết</a>
                                                        </div>
                                                        <div class="my-booking-wrap ">
                                                            <ul class="booking-table-title flex-three">
                                                                <li><p>Tiêu đề</p></li>
                                                                <li><p>Ghi chú/Nội dung</p></li>
                                                                <li><p>Ngày đăng</p></li>
                                                                <li><p>Trạng thái</p></li>
                                                                <li><p>Hành động</p></li>
                                                            </ul>
                                                            <c:forEach var="post" items="${userPosts}">
                                                                <ul class="booking-table-content mb-60">
                                                                    <li class="flex-three">
                                                                        <div class="booking-list flex-three">
                                                                            <p class="date-gues">
                                                                                <a href="${pageContext.request.contextPath}/blogdetails?postId=${post.postId}" style="color:#4DA528;text-decoration:underline;font-weight:600;">
                                                                                    ${post.title}
                                                                                </a>
                                                                            </p>
                                                                        </div>
                                                                        <div class="booking-list-table">
                                                                            <p class="date-gues">
                                                                                <c:choose>
                                                                                    <c:when test="${fn:length(post.contentPost) > 20}">
                                                                                        ${fn:substring(post.contentPost, 0, 20)}... 
                                                                                        <a href="${pageContext.request.contextPath}/blogdetails?postId=${post.postId}" style="color:#4DA528; font-weight:600; text-decoration:underline;">Xem thêm</a>
                                                                                    </c:when>
                                                                                    <c:otherwise>
                                                                                        ${post.contentPost}
                                                                                    </c:otherwise>
                                                                                </c:choose>
                                                                            </p>
                                                                        </div>
                                                                        <div class="booking-list-table">
                                                                            <p class="date-gues">${post.postDate}</p>
                                                                        </div>
                                                                        <div class="booking-list-table">
                                                                            <p class="status">
                                                                                <c:choose>
                                                                                    <c:when test="${post.statusPost eq 'active'}">Đang hiển thị</c:when>
                                                                                    <c:otherwise>Đã ẩn</c:otherwise>
                                                                                </c:choose>
                                                                            </p>
                                                                        </div>
                                                                        <div class="flex-five action-wrap" style="gap: 12px; align-items: center;">
                                                                            <a href="${pageContext.request.contextPath}/updatePost?postId=${post.postId}" title="Cập nhật" style="background: #f6f6f6; border-radius: 8px; padding: 6px 10px; display: inline-flex; align-items: center;"><i class="icon-Vector-21"></i></a>
                                                                            <form action="${pageContext.request.contextPath}/deletePost" method="post" style="display:inline; margin:0;">
                                                                                <input type="hidden" name="postId" value="${post.postId}" />
                                                                                <button type="submit" class="btn btn-danger" style="padding:6px 10px; border-radius:8px; margin-left:0; display:inline-flex; align-items:center;" onclick="return confirm('Bạn chắc chắn muốn xóa bài viết này?')"><i class="icon-Vector-18"></i></button>
                                                                            </form>
                                                                        </div>
                                                                    </li>
                                                                </ul>
                                                            </c:forEach>
                                                            <c:if test="${empty userPosts}">
                                                                <p>Bạn chưa có bài viết nào.</p>
                                                            </c:if>
                                                            <div class="row">
                                                                <div class="col-md-12">
                                                                    <ul class="tf-pagination flex-five">
                                                                        <c:if test="${currentPage > 1}">
                                                                            <li><a class="pages-link" href="${pageContext.request.contextPath}/managerPostUser?page=${currentPage - 1}"><i class="icon-29"></i></a></li>
                                                                        </c:if>
                                                                        <c:forEach var="i" begin="1" end="${totalPages}">
                                                                            <li class="pages-item ${i == currentPage ? 'active' : ''}" aria-current="${i == currentPage ? 'page' : ''}">
                                                                                <a class="pages-link" href="${pageContext.request.contextPath}/managerPostUser?page=${i}">${i}</a>
                                                                            </li>
                                                                        </c:forEach>
                                                                        <c:if test="${currentPage < totalPages}">
                                                                            <li><a class="pages-link" href="${pageContext.request.contextPath}/managerPostUser?page=${currentPage + 1}"><i class="icon--1"></i></a></li>
                                                                        </c:if>
                                                                    </ul>
                                                                </div>
                                                            </div>
                                                        </div>
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
                                                <div class="modal search-mobie fade" id="exampleModal" tabindex="-1" aria-hidden="true">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                            <div class="modal-body">
                                                                <form action="/" class="search-form-mobie">
                                                                    <div class="search">
                                                                        <i class="icon-circle2017"></i>
                                                                        <input type="search" placeholder="Search Travel" class="search-input" autocomplete="off">
                                                                            <button type="button">Search</button>
                                                                    </div>
                                                                </form>

                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight">
                                                    <div class="offcanvas-header">
                                                        <h5 class="offcanvas-title" id="offcanvasRightLabel">Offcanvas right</h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                                                    </div>
                                                    <div class="offcanvas-body">
                                                        ...
                                                    </div>
                                                </div>

                                                <!-- Javascript -->
                                                <script src="app/js/jquery.min.js"></script>
                                                <script src="app/js/jquery.nice-select.min.js"></script>
                                                <script src="app/js/bootstrap.min.js"></script>
                                                <script src="app/js/swiper-bundle.min.js"></script>
                                                <script src="app/js/swiper.js"></script>
                                                <script src="app/js/plugin.js"></script>
                                                <script src="app/js/shortcodes.js"></script>
                                                <script src="app/js/main.js"></script>

                                            </body>

                                            </html>
