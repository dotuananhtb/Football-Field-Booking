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
                                                            <!-- Header with search and filter -->
                                                            <div class="d-flex justify-content-between align-items-center mb-30" style="background: #f8f9fa; padding: 15px; border-radius: 8px;">
                                                                <div>
                                                                    <h5 style="margin: 0; color: #333;">Tổng cộng: ${totalPosts} bài viết</h5>
                                                                </div>
                                                                <form action="${pageContext.request.contextPath}/managerPostUser" method="get" class="d-flex gap-2">
                                                                    <input type="text" name="search" value="${search}" placeholder="Tìm theo tiêu đề..." class="form-control" style="width: 250px;">
                                                                    <button type="submit" class="btn btn-outline-primary">Tìm</button>
                                                                </form>
                                                            </div>
                                                            
                                                            <!-- Posts list -->
                                                            <c:forEach var="post" items="${userPosts}">
                                                                <div class="post-card mb-20" style="background: white; border: 1px solid #e5e5e5; border-radius: 12px; padding: 20px; box-shadow: 0 2px 8px rgba(0,0,0,0.1);">
                                                                    <div class="d-flex justify-content-between align-items-start mb-15">
                                                                        <div class="flex-grow-1">
                                                                            <h4 style="margin: 0 0 8px 0; color: #4DA528;">
                                                                                <a href="${pageContext.request.contextPath}/blogdetails?postId=${post.postId}" style="color: inherit; text-decoration: none;">
                                                                                    ${post.title}
                                                                                </a>
                                                                            </h4>
                                                                            <div class="post-meta" style="color: #666; font-size: 14px;">
                                                                                <span><i class="icon-4"></i> ${post.postDate}</span>
                                                                                
                                                                            </div>
                                                                        </div>
                                                                        <div class="post-actions d-flex gap-2">
                                                                            <a href="${pageContext.request.contextPath}/updatePost?postId=${post.postId}" 
                                                                               class="btn btn-outline-primary btn-sm" 
                                                                               style="padding: 6px 12px; border-radius: 6px;">
                                                                                <i class="icon-edit"></i> Sửa
                                                                            </a>
                                                                            <form action="${pageContext.request.contextPath}/deletePost" method="post" style="display:inline; margin:0;">
                                                                                <input type="hidden" name="postId" value="${post.postId}" />
                                                                                <button type="submit" 
                                                                                        class="btn btn-outline-danger btn-sm" 
                                                                                        style="padding: 6px 12px; border-radius: 6px;"
                                                                                        onclick="return confirm('Bạn chắc chắn muốn xóa bài viết này?')">
                                                                                    <i class="icon-delete"></i> Xóa
                                                                                </button>
                                                                            </form>
                                                                        </div>
                                                                    </div>
                                                                    
                                                                    <div class="post-content" style="color: #555; line-height: 1.6;">
                                                                        <c:choose>
                                                                            <c:when test="${fn:length(post.contentPost) > 100}">
                                                                                ${fn:substring(post.contentPost, 0, 100)}... 
                                                                                <a href="${pageContext.request.contextPath}/blogdetails?postId=${post.postId}" 
                                                                                   style="color: #4DA528; font-weight: 600; text-decoration: underline;">
                                                                                    Xem thêm
                                                                                </a>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                ${post.contentPost}
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </div>
                                                                    
                                                                    <div class="post-footer mt-15" style="border-top: 1px solid #eee; padding-top: 15px;">
                                                                        <a href="${pageContext.request.contextPath}/blogdetails?postId=${post.postId}" 
                                                                           class="btn btn-sm btn-outline-secondary" 
                                                                           style="padding: 4px 12px; border-radius: 4px;">
                                                                            <i class="icon-eye"></i> Xem chi tiết
                                                                        </a>
                                                                    </div>
                                                                </div>
                                                            </c:forEach>
                                                            
                                                            <c:if test="${empty userPosts}">
                                                                <div class="text-center py-50" style="background: #f8f9fa; border-radius: 12px; margin: 30px 0;">
                                                                    <i class="icon-document" style="font-size: 48px; color: #ccc; margin-bottom: 15px;"></i>
                                                                    <h5 style="color: #666; margin-bottom: 10px;">Bạn chưa có bài viết nào</h5>
                                                                    <p style="color: #999; margin-bottom: 20px;">Hãy tạo bài viết đầu tiên để tìm đối thủ đá bóng!</p>
                                                                    <a href="${pageContext.request.contextPath}/createPost" class="btn btn-primary">
                                                                        <i class="icon-plus"></i> Tạo bài viết đầu tiên
                                                                    </a>
                                                                </div>
                                                            </c:if>
                                                        </div>
                                                        
                                                        <!-- Pagination -->
                                                        <c:if test="${totalPages > 1}">
                                                            <div class="row mt-40">
                                                                <div class="col-md-12">
                                                                    <nav aria-label="Post pagination">
                                                                        <ul class="pagination justify-content-center" style="gap: 5px;">
                                                                            <c:if test="${currentPage > 1}">
                                                                                <li class="page-item">
                                                                                    <a class="page-link" href="${pageContext.request.contextPath}/managerPostUser?page=${currentPage - 1}&search=${search != null ? search : ''}" style="border-radius: 6px;">
                                                                                        <i class="icon-29"></i> Trước
                                                                                    </a>
                                                                                </li>
                                                                            </c:if>
                                                                            
                                                                            <c:forEach var="i" begin="1" end="${totalPages}">
                                                                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                                                    <a class="page-link" href="${pageContext.request.contextPath}/managerPostUser?page=${i}&search=${search != null ? search : ''}" 
                                                                                       style="border-radius: 6px; ${i == currentPage ? 'background-color: #4DA528; border-color: #4DA528;' : ''}">
                                                                                        ${i}
                                                                                    </a>
                                                                                </li>
                                                                            </c:forEach>
                                                                            
                                                                            <c:if test="${currentPage < totalPages}">
                                                                                <li class="page-item">
                                                                                    <a class="page-link" href="${pageContext.request.contextPath}/managerPostUser?page=${currentPage + 1}&search=${search != null ? search : ''}" style="border-radius: 6px;">
                                                                                        Sau <i class="icon--1"></i>
                                                                                    </a>
                                                                                </li>
                                                                            </c:if>
                                                                        </ul>
                                                                    </nav>
                                                                </div>
                                                            </div>
                                                        </c:if>
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
