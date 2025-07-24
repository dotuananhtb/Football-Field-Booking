<%-- 
    Document   : header_dashboard
    Created on : Jun 14, 2025, 12:28:59 PM
    Author     : Đỗ Tuấn Anh
--%>

<%@page import="model.UserProfile"%>
<%@page import="model.Account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <base href="${pageContext.request.contextPath}/UI/">
        <!-- comment -->
        <link rel="shortcut icon" href="assets/images/logoKoChu.png">
        <link rel="apple-touch-icon-precomposed" href="assets/images/logoKoChu.png">
    </head>
    <div class="preload preload-container">
        <svg class="pl" width="240" height="240" viewBox="0 0 240 240">
        <circle class="pl__ring pl__ring--a" cx="120" cy="120" r="105" fill="none" stroke="#000" stroke-width="20" stroke-dasharray="0 660" stroke-dashoffset="-330" stroke-linecap="round"></circle>
        <circle class="pl__ring pl__ring--b" cx="120" cy="120" r="35" fill="none" stroke="#000" stroke-width="20" stroke-dasharray="0 220" stroke-dashoffset="-110" stroke-linecap="round"></circle>
        <circle class="pl__ring pl__ring--c" cx="85" cy="120" r="70" fill="none" stroke="#000" stroke-width="20" stroke-dasharray="0 440" stroke-linecap="round"></circle>
        <circle class="pl__ring pl__ring--d" cx="155" cy="120" r="70" fill="none" stroke="#000" stroke-width="20" stroke-dasharray="0 440" stroke-linecap="round"></circle>
        </svg>
    </div>
    <%
        Account account = (Account) session.getAttribute("account");
        UserProfile userProfile = (account != null) ? account.getUserProfile() : null;
    %>

    <script>
        window.accountId = <%= (account != null) ? account.getAccountId() : -1%>;
        window.roleId = <%= (userProfile != null) ? userProfile.getRoleId() : -1%>;
    </script>
    <!-- /preload -->
    <jsp:include page="toast.jsp" />
    <jsp:include page="sweetalert-include.jsp" />
    <script src="${pageContext.request.contextPath}/UI/app/js/userNoti-socket.js"></script>
    <script>
        connectUserNotiSocket(accountId, roleId);
    </script>
    <div id="wrapper">

        <div id="pagee" class="clearfix">

            <div class="sidebar-dashboard">
                <div class="db-logo">
                    <a href="/FB_N1/home"><span>⚽FootballStar</span></a>
                </div>
                <div class="db-menu">
                    <ul>
                        <li>
                            <a href="/FB_N1/userProfile">
                                <i class="icon-profile-user-1"></i>
                                <span>Hồ sơ</span>
                            </a>
                        </li>
                        <li>
                            <a href="/FB_N1/lich-su-dat-san">
                                <i class="icon-Layer-2"></i>
                                <span>Lịch sử đặt sân</span>
                            </a>
                        </li>
<!--                        <li>
                            <a href="dashboard.html">
                                <i class="icon-Vector-9"></i>
                                <span>Dashboard</span>
                            </a>
                        </li>-->

                        <c:if test="${account.userProfile.roleId==3}">
                            <li>
                                <a href="/FB_N1/managerPostUser">
                                    <i class="icon-Group-81"></i>
                                    <span>Bài viết</span>
                                </a>
                            </li>
                        </c:if>
<!--                        <li>
                            <a href="add-tour.html">
                                <i class="icon-Group-91"></i>
                                <span>Add Tour</span>
                            </a>
                        </li>-->
<!--                        <li>
                            <a href="my-favorite.html">
                                <i class="icon-Vector-10"></i>
                                <span>My Favorites</span>
                            </a>
                        </li>-->
                        
                         <li>
                            <a href="/FB_N1/changePassword">
                                <i class="icon-14"></i>
                                <span>Đổi mật khẩu</span>
                            </a>
                        </li>
                        
                        <li>
                            <a href="/FB_N1/logout">
                                <i class="icon-turn-off-1"></i>
                                <span>Đăng xuất</span>
                            </a>
                        </li>

                    </ul>


                </div>

            </div>

            <div class="has-dashboard">
                <!-- Main Header -->
                <header class="main-header flex">
                    <!-- Header Lower -->
                    <div id="header">                   
                        <div class="header-dashboard">
                            <div class="tf-container full">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="inner-container flex justify-space align-center">
                                            <!-- Logo Box -->
                                            <div class="header-search flex-three">
                                                <div class="icon-bars">
                                                    <i class="icon-Vector3"></i>
                                                </div>


                                            </div>
                                            <div class="nav-outer flex align-center">
                                                <!-- Main Menu -->
                                                <nav class="main-menu show navbar-expand-md">
                                                    <div class="navbar-collapse collapse clearfix"
                                                         id="navbarSupportedContent">
                                                        <ul class="navigation clearfix">
                                                            <li><a href="/FB_N1/home">Trang chủ</a></li>
<!--                                                            <li class="dropdown2">
                                                                <a href="#">Tour</a>
                                                                <ul>
                                                                    <li><a href="archieve-tour.html">Archieve tour</a>

                                                                    </li>
                                                                    <li><a href="tour-package-v2.html">Tour left
                                                                            sidebar</a>

                                                                    </li>
                                                                    <li><a href="tour-package-v4.html">Tour package </a>

                                                                    </li>
                                                                    <li><a href="tour-single.html">Tour Single </a>

                                                                    </li>
                                                                </ul>
                                                            </li>
                                                            <li><a href="contact-us.html">Contact</a></li>-->
                                                        </ul>
                                                    </div>
                                                </nav>
                                                <!-- Main Menu End-->
                                            </div>
                                            <div class="header-account flex align-center">                                              

<!--                                                <div class="dropdown notification">
                                                    <a class="icon-notification" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                        <i class="icon-notification-1"></i>
                                                    </a>
                                                    <ul class="dropdown-menu">
                                                        <li>
                                                            <div class="message-item  flex-three">
                                                                <div class="image">
                                                                    <i class="icon-26"></i>
                                                                </div>
                                                                <div>
                                                                    <div class="body-title">Discount available</div>
                                                                    <div class="text-tiny">Morbi sapien massa, ultricies at rhoncus at, ullamcorper nec diam</div>
                                                                </div>
                                                            </div>
                                                        </li>
                                                        <li>
                                                            <div class="message-item  flex-three">
                                                                <div class="image">
                                                                    <i class="icon-26"></i>
                                                                </div>
                                                                <div>
                                                                    <div class="body-title">Discount available</div>
                                                                    <div class="text-tiny">Morbi sapien massa, ultricies at rhoncus at, ullamcorper nec diam</div>
                                                                </div>
                                                            </div>
                                                        </li>
                                                        <li>
                                                            <div class="message-item  flex-three">
                                                                <div class="image">
                                                                    <i class="icon-26"></i>
                                                                </div>
                                                                <div>
                                                                    <div class="body-title">Discount available</div>
                                                                    <div class="text-tiny">Morbi sapien massa, ultricies at rhoncus at, ullamcorper nec diam</div>
                                                                </div>
                                                            </div>
                                                        </li>

                                                    </ul>
                                                </div> -->
                                                <div class="dropdown account">
                                                    <a type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                        <img src="${sessionScope.userProfile.avatar}" alt="image">
                                                    </a>
                                                    <ul class="dropdown-menu">
                                                        <li><a  href="/FB_N1/userProfile">Hồ sơ</a></li>
                                                        <li><a  href="/FB_N1/changePassword">Đổi mật khẩu</a></li>
                                                        <li><a  href="/FB_N1/logout">Đăng xuất</a></li>
                                                    </ul>
                                                </div>                                                                                         
                                                <div class="mobile-nav-toggler mobile-button">
                                                    <i class="icon-bar"></i>
                                                </div>

                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
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
                                </div>
                            </div>
                        </nav>
                    </div>
                    <!-- End Mobile Menu -->

                </header>
                <!-- End Main Header -->
                </html>
