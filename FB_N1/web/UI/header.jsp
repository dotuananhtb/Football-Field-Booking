<%-- 
    Document   : header
    Created on : May 28, 2025, 10:05:25 AM
    Author     : VAN NGUYEN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <header>
        <!-- Navigation Bar -->
        <div class="header_menu" id="header_menu">
            <nav class="navbar navbar-default">
                <div class="container">
                    <div class="navbar-flex d-flex align-items-center justify-content-between w-100 pb-3 pt-3">
                        <!-- Brand and toggle get grouped for better mobile display -->
                        <div class="navbar-header">
                            <a class="navbar-brand" href="home.jsp">
                                <img src="images/logo.png" alt="BookField Logo">
                            </a>
                        </div>
                        <!-- Collect the nav links, forms, and other content for toggling -->
                        <div class="navbar-collapse1 d-flex align-items-center" id="bs-example-navbar-collapse-1">
                            <ul class="nav navbar-nav" id="responsive-menu">
                                <li class="dropdown submenu active">
                                    <a href="home.jsp" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Trang Chủ</a>
                                </li>

                                <li><a href="about.html">Giới Thiệu</a></li>

                                <li class="submenu dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Sân Bóng <i class="icon-arrow-down" aria-hidden="true"></i></a> 
                                    <ul class="dropdown-menu">
                                        <li><a href="field-list.html">Danh Sách Sân</a></li>
                                        <li><a href="field-detail.html">Chi Tiết Sân</a></li>
                                    </ul> 
                                </li>
                                <li class="submenu dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Đặt Sân <i class="icon-arrow-down" aria-hidden="true"></i></a> 
                                    <ul class="dropdown-menu">
                                        <li class="submenu dropdown">
                                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Sân 5 Người<i class="fa fa-angle-right" aria-hidden="true"></i></a>
                                            <ul class="dropdown-menu">
                                                <li><a href="field-5-list.html">Sân 5 Quận 1</a></li>
                                                <li><a href="field-5-list1.html">Sân 5 Quận 7</a></li>
                                                <li><a href="field-5-list2.html">Sân 5 Tân Bình</a></li>
                                            </ul>
                                        </li>
                                        <li class="submenu dropdown">
                                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Sân 7 Người<i class="fa fa-angle-right" aria-hidden="true"></i></a>
                                            <ul class="dropdown-menu">
                                                <li><a href="field-7-list.html">Sân 7 Quận 1</a></li>
                                                <li><a href="field-7-list1.html">Sân 7 Quận 7</a></li>
                                                <li><a href="field-7-list2.html">Sân 7 Tân Bình</a></li>
                                            </ul>
                                        </li>
                                        <li class="submenu dropdown">
                                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Sân 11 Người<i class="fa fa-angle-right" aria-hidden="true"></i></a>
                                            <ul class="dropdown-menu">
                                                <li><a href="field-11-list.html">Sân 11 Quận 1</a></li>
                                                <li><a href="field-11-list1.html">Sân 11 Quận 7</a></li>
                                                <li><a href="field-11-list2.html">Sân 11 Tân Bình</a></li>
                                            </ul>
                                        </li>
                                    </ul> 
                                </li>
                                <li class="submenu dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Dịch Vụ <i class="icon-arrow-down" aria-hidden="true"></i></a> 
                                    <ul class="dropdown-menu">
                                        <li><a href="team.html">Huấn Luyện Viên</a></li>
                                        <li><a href="booking.html">Đặt Sân</a></li>
                                        <li><a href="confirmation.html">Xác Nhận</a></li>
                                        <li class="submenu dropdown">
                                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Dịch Vụ Khác<i class="fa fa-angle-right" aria-hidden="true"></i></a>
                                            <ul class="dropdown-menu">
                                                <li><a href="services.html">Thuê Thiết Bị</a></li>
                                                <li><a href="services-detail.html">Chi Tiết Dịch Vụ</a></li>
                                            </ul>
                                        </li>
                                        <li class="submenu dropdown">
                                            <a href="gallery.html" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Thư Viện<i class="fa fa-angle-right" aria-hidden="true"></i></a>
                                            <ul class="dropdown-menu">
                                                <li><a href="gallery.html">Hình Ảnh Sân</a></li>
                                                <li><a href="gallery1.html">Video Sân</a></li>
                                            </ul>
                                        </li>
                                        <li><a href="login.html">Đăng Nhập|Đăng Ký</a></li>
                                        <li><a href="contact.html">Liên Hệ</a></li>
                                        <li><a href="dashboard/dashboard.html">Quản Lý</a></li>
                                    </ul> 
                                </li>
                                <li class="submenu dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Tin Tức <i class="icon-arrow-down" aria-hidden="true"></i></a> 
                                    <ul class="dropdown-menu">
                                        <li class="submenu dropdown">
                                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Tin Bóng Đá<i class="fa fa-angle-right" aria-hidden="true"></i></a>
                                            <ul class="dropdown-menu">
                                                <li><a href="post-grid-1.html">Tin Trong Nước</a></li>
                                                <li><a href="post-grid-2.html">Tin Quốc Tế</a></li>
                                                <li><a href="post-grid-3.html">Tin Địa Phương</a></li>
                                            </ul>
                                        </li>
                                        <li class="submenu dropdown">
                                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Giải Đấu<i class="fa fa-angle-right" aria-hidden="true"></i></a>
                                            <ul class="dropdown-menu">
                                                <li><a href="post-list-1.html">Giải Nghiệp Dư</a></li>
                                                <li><a href="post-list-2.html">Giải Chuyên Nghiệp</a></li>
                                                <li><a href="post-list-3.html">Giải Thiếu Nhi</a></li>
                                            </ul>
                                        </li>
                                    </ul>
                                </li>
                                <li class="search-main"><a href="#search1" class="mt_search"><i class="fa fa-search"></i></a></li>
                            </ul>
                        </div><!-- /.navbar-collapse -->  
                        <div class="register-login d-flex align-items-center">
                            <c:if test="${sessionScope.username != null}">
                            <a href="${pageContext.request.contextPath}/logout"  class="me-3">
                                <i class="icon-user"></i> Đăng Xuất
                            </a>
                            </c:if>
                            <c:if test="${sessionScope.username == null}">
                            <a href="#" data-bs-toggle="modal" data-bs-target="#exampleModal" class="me-3">
                                <i class="icon-user"></i> Đăng Nhập/Đăng Ký
                            </a>
                            </c:if>
                            
                            
                            <a href="#" class="nir-btn white">Đặt Sân Ngay</a>
                        </div>

                        <div id="slicknav-mobile"></div>
                    </div>
                </div><!-- /.container-fluid -->
            </nav>
        </div>
        <!-- Navigation Bar Ends -->
    </header>
    </body>
</html>
