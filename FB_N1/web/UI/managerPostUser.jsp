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

                                            <body class="body header-fixed">
                                                <jsp:include page="header_dashboard.jsp" />
                                                <!-- End Main Header -->
                                                <main id="main">
                                                    <h2>Quản lý bài viết của tôi</h2>
                                                    <div style="display: flex; justify-content: flex-end; margin-bottom: 20px;">
                                                        <a href="${pageContext.request.contextPath}/createPost" class="btn btn-success">Tạo bài viết</a>
                                                    </div>
                                                    <c:if test="${empty userPosts}">
                                                        <p>Bạn chưa có bài viết nào.</p>
                                                    </c:if>
                                                    <c:forEach var="post" items="${userPosts}">
                                                        <div class="post-item" style="border:1px solid #ccc; padding:16px; margin-bottom:12px; display:flex; justify-content:space-between; align-items:center;">
                                                            <div>
                                                                <h4><a href="${pageContext.request.contextPath}/blogdetails?postId=${post.postId}" style="color:#4DA528;text-decoration:underline;">${post.title}</a></h4>
                                                                <div>${post.postDate}</div>
                                                                <div>${post.contentPost}</div>
                                                            </div>
                                                            <div style="display: flex; gap: 10px; justify-content: flex-end; align-items: center;">
                                                                <a href="${pageContext.request.contextPath}/updatePost?postId=${post.postId}" class="btn btn-primary">Cập nhật</a>
                                                                <form action="${pageContext.request.contextPath}/deletePost" method="post" style="display:inline;">
                                                                    <input type="hidden" name="postId" value="${post.postId}" />
                                                                    <button type="submit" class="btn btn-danger" onclick="return confirm('Bạn chắc chắn muốn xóa bài viết này?')">Xoá</button>
                                                                </form>
                                                            </div>
                                                        </div>
                                                    </c:forEach>

                                                    <!-- Phân trang -->
                                                    <div style="margin-top: 24px;">
                                                        <ul class="tf-pagination flex-five mt-20">
                                                            <li>
                                                                <a class="pages-link" href="${pageContext.request.contextPath}/managerPostUser?page=1"><i class="icon-29"></i></a>
                                                            </li>
                                                            <c:forEach begin="1" end="${totalPages}" var="i">
                                                                <li class="pages-item${currentPage == i ? ' active' : ''}" aria-current="${currentPage == i ? 'page' : ''}">
                                                                    <a class="pages-link" href="${pageContext.request.contextPath}/managerPostUser?page=${i}">${i}</a>
                                                                </li>
                                                            </c:forEach>
                                                            <li>
                                                                <a class="pages-link" href="${pageContext.request.contextPath}/managerPostUser?page=${totalPages}"><i class="icon--1"></i></a>
                                                            </li>
                                                        </ul>
                                                    </div>
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
