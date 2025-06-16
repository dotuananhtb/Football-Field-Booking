<%--
    Created on : May 30, 2025, 8:15:12 AM
    Author     : Đỗ Tuấn Anh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<head>
    <!-- comment -->
    <base href="${pageContext.request.contextPath}/UI/">
    <!-- comment -->
    <link rel="shortcut icon" href="assets/images/logoKoChu.png">
    <link rel="apple-touch-icon-precomposed" href="assets/images/logoKoChu.png">
</head>

<!-- Main Header -->
<header class="main-header flex">
    <!-- Header Lower -->
    <div id="header">
        <jsp:include page="toast.jsp" />
        <jsp:include page="sweetalert-include.jsp" />
        <div class="header-lower">
            <div class="tf-container full">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="inner-container flex justify-space align-center">
                            <!-- Logo Box -->
                            <div class="mobile-nav-toggler mobie-mt mobile-button">
                                <i class="icon-Vector3"></i>
                            </div>
                            <div class="logo-box">
                                <div class="logo">
                                    <a href="/FB_N1/home">
                                        <img src="assets/images/logo22.png" alt="Logo">
                                    </a>
                                </div>
                            </div>
                            <div class="nav-outer flex align-center">
                                <!-- Main Menu -->
                                <nav class="main-menu show navbar-expand-md">
                                    <div class="navbar-collapse collapse clearfix" id="navbarSupportedContent">
                                        <ul class="navigation clearfix">
                                            <li class="dropdown2">
                                                <a href="#">Cửa Hàng</a>
                                                <ul>
                                                    <li><a href="index.html">Giày </a></li>
                                                    <li><a href="home2.html">Quần Áo Thể Thao</a></li>
                                                    <li><a href="home3.html">Dụng Cụ Thể Thao</a></li>
                                                </ul>
                                                <div class="dropdown2-btn"></div></li>
                                            <li class="dropdown2">
                                                <a href="#">Danh Sách Sân</a>
                                                <ul>
                                                    <li><a href="archieve-tour.html">Hà Nội</a>

                                                    </li>
                                                    <li><a href="tour-package-v2.html">TP.Hồ Chí Minh</a>

                                                    </li>
                                                    <li><a href="tour-package-v4.html">Đà Nẵng</a>

                                                    </li>
                                                    <li><a href="tour-single.html">Hải Phòng</a>

                                                    </li>
                                                </ul>
                                                <div class="dropdown2-btn"></div></li>

                                            <li class="dropdown2 "><a href="/FB_N1/blog">Diễn Đàn</a>
                                                <ul>
                                                    <li><a href="/FB_N1/blog">Diễn Đàn Tìm Đối Thủ</a></li>
                                                    <li><a href="/FB_N1/UI/blogDetails.jsp">Diễn Đàn Thông Tin Cầu Thủ</a></li>
                                                </ul>
                                                <div class="dropdown2-btn"></div></li>



                                            <li><a href="contact-us.html">Liên Hệ</a></li>




                                            <c:if test="${sessionScope.account.userProfile.roleId == 1}">
                                                <li><a href="/FB_N1/admin/dat-san"
                                                       style="position: fixed; top: 70px; right: 20px;
                                                   background-color: #4da528; color: white;
                                                   padding: 10px 16px; border-radius: 8px;
                                                   text-decoration: none; font-weight: 500;
                                                   box-shadow: 0 2px 5px rgba(0,0,0,0.2);">
                                                        ️ Bảng điều khiển của Quản trị viên
                                                    </a></li>
                                                
                                            </c:if>
                                            <c:if test="${sessionScope.account != null}">

                                                <li class="dropdown2"
                                                    style="position: fixed; top: 20px; right: 20px; z-index: 1000;">

                                                    <a href="#" style="display: flex; align-items: center; gap: 8px; padding: 6px 12px;
                                                       background-color: #4da528; border-radius: 20px; text-decoration: none;
                                                       color: white; font-weight: 500;">
                                                        <img src="${sessionScope.userProfile.avatar}"
                                                             style="width: 30px; height: 30px; border-radius: 50%; object-fit: cover;">
                                                        ${sessionScope.account.userProfile.firstName}
                                                    </a>

                                                    <ul>
                                                        <li><a href="/FB_N1/userProfile"><i class="icon-user"></i> Trang cá nhân</a></li>
                                                        <li><a href="/FB_N1/managerPostUser"><i class="icon-user"></i> Bài Viết</a></li>

                                                        <li><a href="/FB_N1/lich-su-dat-san"><i class="icon-day"></i> Lịch sử đặt sân của tôi</a></li>

                                                        <li>
                                                            <a href="${pageContext.request.contextPath}/logout" class="me-3">
                                                                <i class="icon-turn-off-1"></i> Đăng Xuất
                                                            </a>
                                                        </li>
                                                    </ul>
                                                </li>


                                            </c:if>

                                        </ul>

                                    </div>
                                </nav>
                                <!-- Main Menu End-->
                            </div>



                            <div class="dropdown2-btn"></div></li>





                            <a   style="margin: 20px">

                            </a>


                            <c:if test="${sessionScope.account == null}">
                                <div class="header-account flex align-center">
                                    <div class="register">
                                        <ul class="flex align-center">
                                            <li class="">
                                                <a href="${pageContext.request.contextPath}/login"><i class="icon-user-1-1"></i>
                                                    <span>Đăng nhập</span>
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="register">
                                        <ul class="flex align-center">
                                            <li class="">
                                                <a href="/FB_N1/dang-ki"><i class="icon-user-1-1"></i>
                                                    <span>Đăng kí</span>
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>

        </div><div style="height: 184px; display: none;"></div>
    </div>

    <!-- End Header Lower -->


    <!-- Mobile Menu  -->
    <div class="close-btn"><span class="icon flaticon-cancel-1"></span></div>
    <div class="mobile-menu">
        <div class="menu-backdrop"></div>
        <nav class="menu-box">
            <div class="nav-logo"><a href="index.html">
                    <img src="assets/images/logo2.png" alt=""></a></div>
            <div class="bottom-canvas">
                <div class="menu-outer">

                    <div class="navbar-collapse collapse clearfix" id="navbarSupportedContent">
                        <ul class="navigation clearfix">
                            <li class="dropdown2">
                                <a href="#">Home</a>
                                <ul>
                                    <li><a href="index.html">Home Page 01</a></li>
                                    <li><a href="home2.html">Home Page 02</a></li>
                                    <li><a href="home3.html">Home Page 03</a></li>
                                    <li><a href="home4.html">Home Page 04</a></li>
                                    <li><a href="home5.html">Home Page 05</a></li>
                                </ul>
                                <div class="dropdown2-btn"></div></li>
                            <li class="dropdown2">
                                <a href="#">Tour</a>
                                <ul>
                                    <li><a href="archieve-tour.html">Archieve tour</a>

                                    </li>
                                    <li><a href="tour-package-v2.html">Tour left sidebar</a>

                                    </li>
                                    <li><a href="tour-package-v4.html">Tour package </a>

                                    </li>
                                    <li><a href="tour-single.html">Tour Single </a>

                                    </li>
                                </ul>
                                <div class="dropdown2-btn"></div></li>
                            <li class="dropdown2"><a href="#">Destination</a>
                                <ul>
                                    <li><a href="tour-destination-v1.html">Destination
                                            V1</a></li>
                                    <li><a href="tour-destination-v2.html">Destination
                                            V2</a></li>
                                    <li><a href="tour-destination-v3.html">Destination
                                            V3</a></li>
                                    <li><a href="single-destination.html">Destination
                                            Single</a></li>
                                </ul>
                                <div class="dropdown2-btn"></div></li>
                            <li class="dropdown2 "><a href="#">Blog</a>
                                <ul>
                                    <li><a href="blog.html">Blog</a></li>
                                    <li><a href="blog-details.html">Blog Detail</a></li>
                                </ul>
                                <div class="dropdown2-btn"></div></li>

                            <li class="dropdown2"><a href="#">Pages</a>
                                <ul>
                                    <li><a href="about-us.html">About Us</a></li>
                                    <li><a href="team.html">Team member</a></li>
                                    <li><a href="gallery.html">Gallery</a></li>
                                    <li><a href="terms-condition.html">Terms &amp; Condition</a>
                                    </li>
                                    <li><a href="help-center.html">Help center</a></li>
                                </ul>
                                <div class="dropdown2-btn"></div></li>
                            <li class="dropdown2"><a href="#">Dashboard</a>
                                <ul>
                                    <li><a href="dashboard.html">Dashboard </a></li>
                                    <li><a href="my-booking.html">My booking</a></li>
                                    <li><a href="my-listing.html">My Listing</a></li>
                                    <li><a href="add-tour.html">Add Tour</a></li>
                                    <li><a href="my-favorite.html">My Favorites</a></li>
                                    <li><a href="my-profile.html">My profile</a></li>
                                </ul>
                                <div class="dropdown2-btn"></div></li>
                            <li><a href="contact-us.html">Contact</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </nav>
    </div>
    <!-- End Mobile Menu -->

</header>
<!-- End Main Header -->
