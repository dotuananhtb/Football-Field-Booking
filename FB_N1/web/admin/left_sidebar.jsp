<%-- 
    Document   : left_sidebar
    Created on : Jun 15, 2025, 1:34:07 PM
    Author     : VAN NGUYEN
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="leftside-menu">

    <!-- Brand Logo Light -->
    <a href="/FB_N1/home" class="logo logo-light">
        <span class="logo-lg">
            <img src="assets/images/logo.png" alt="logo">
        </span>
        <span class="logo-sm">
            <img src="assets/images/logo-sm.png" alt="small logo">
        </span>
    </a>

    <!-- Brand Logo Dark -->
    <a href="/FB_N1/home" class="logo logo-dark">
        <span class="logo-lg">
            <img src="assets/images/logo-dark.png" alt="dark logo">
        </span>
        <span class="logo-sm">
            <img src="assets/images/logo-sm.png" alt="small logo">
        </span>
    </a>
    <!-- Full Sidebar Menu Close Button -->
    <div class="button-close-fullsidebar">
        <i class="ri-close-fill align-middle"></i>
    </div>

    <!-- Sidebar -left -->
    <div class="h-100" id="leftside-menu-container" data-simplebar>
        <!-- Leftbar User -->

        <div class="leftbar-user">
            <a href="/FB_N1/userProfile">
                <img src="${sessionScope.userProfile.avatar}" alt="user-image" height="42" class="rounded-circle shadow-sm">
                <span class="leftbar-user-name mt-2">${sessionScope.account.userProfile.firstName}</span>
            </a>
        </div>


        <!--- Sidemenu -->
        <ul class="side-nav">

            <li class="side-nav-title">Main</li>

            <li class="side-nav-item">
                <a href="index.html" class="side-nav-link">
                    <i class="ri-dashboard-2-fill"></i>
                    <span> Dashboard </span>
                </a>
            </li>



            <li class="side-nav-item">
                <a href="apps-chat.html" class="side-nav-link">
                    <i class="ri-message-3-fill"></i>
                    <span> Chat </span>
                </a>
            </li>

            <li class="side-nav-item">
                <a data-bs-toggle="collapse" href="#sidebarEmail" aria-expanded="false" aria-controls="sidebarEmail" class="side-nav-link">
                    <i class="ri-mail-fill"></i>
                    <span> Email </span>
                    <span class="menu-arrow"></span>
                </a>
                <div class="collapse" id="sidebarEmail">
                    <ul class="side-nav-second-level">
                        <li>
                            <a href="apps-email-inbox.html">Inbox</a>
                        </li>
                        <li>
                            <a href="apps-email-read.html">Read Email</a>
                        </li>
                    </ul>
                </div>
            </li>

            <li class="side-nav-title">Quản lí đặt sân</li>

            <li class="side-nav-item">
                <a href="/FB_N1/admin/dat-san" class="side-nav-link">
                    <i class="ri-calendar-event-fill"></i>
                    <span> Lịch đặt của các sân </span>
                </a>
            </li>


            <li class="side-nav-item">
                <a href="/FB_N1/admin/chi-tiet-dat-san" class="side-nav-link">
                    <i class="ri-survey-fill"></i>
                    <span> Bảng chi tiết đặt sân </span>
                </a>
            </li>


            <li class="side-nav-item">
                <a data-bs-toggle="collapse" href="#sidebarIcons" aria-expanded="false" aria-controls="sidebarIcons" class="side-nav-link">
                    <i class="ri-service-fill"></i>
                    <span> Quản lý sân </span>
                    <span class="menu-arrow"></span>
                </a>
                <div class="collapse" id="sidebarIcons">
                    <ul class="side-nav-second-level">
                        <li>
                            <a href="icons-remixicons.html">Remix Icons</a>
                        </li>
                        <li>
                            <a href="icons-bootstrap.html">Bootstrap Icons</a>
                        </li>
                    </ul>
                </div>
            </li>



            <li class="side-nav-title">Chung</li>

            <li class="side-nav-item">
                <a href="/FB_N1/admin/managerPost"" class="side-nav-link">
                    <i class="ri-pages-fill"></i>
                    <span> Quản lí bài viết và tin tức</span>


                </a>
            </li>


            <li class="side-nav-item">
                <a data-bs-toggle="collapse" href="#sidebarBaseUI" aria-expanded="false" aria-controls="sidebarBaseUI" class="side-nav-link">
                    <i class="ri-briefcase-fill"></i>
                    <span> Quản Lý Trang Chủ</span>
                    <span class="menu-arrow"></span>

                </a>
                <div class="collapse" id="sidebarBaseUI">
                    <ul class="side-nav-second-level">
                        <li>
                            <a href="/FB_N1/admin/xu-li-chieu-thu-trang-chu">Chọn chủ đề</a>
                        </li>
                        <li>
                            <a href="/FB_N1/admin/tao-moi-chu-de">Tạo mới chủ đề</a>
                        </li>
                        <li>
                            <a href="/FB_N1/admin/tao-moi-slider">Tạo mới slider</a>
                        </li>
                        <li>
                            <a href="/FB_N1/admin/sua-chu-de">Sửa chủ đề</a>
                        </li>
                        <li>
                            <a href="/FB_N1/admin/sua-slider">Sửa slider</a>
                        </li>

                    </ul>
                </div>
            </li>

            <li class="side-nav-item">
                <a data-bs-toggle="collapse" href="#sidebarExtendedUI" aria-expanded="false" aria-controls="sidebarExtendedUI" class="side-nav-link">
                    <i class="ri-stack-fill"></i>
                    <span> Quản lý người dùng </span>
                    <span class="menu-arrow"></span>
                </a>
                <div class="collapse" id="sidebarExtendedUI">
                    <ul class="side-nav-second-level">
                        <li>
                            <a href="/FB_N1/admin/quan-li-tai-khoan">Danh sách người dùng</a>
                        </li>
                        <li>
                            <a href="/FB_N1/admin/quan-li-nhan-vien">Danh sách nhân viên</a>
                        </li>

                    </ul>
                </div>
            </li>


            <li class="side-nav-item">
                <a data-bs-toggle="collapse" href="#sidebarPagesAuth" aria-expanded="false" aria-controls="sidebarPagesAuth" class="side-nav-link">
                    <i class="ri-shield-user-fill"></i>
                    <span> Quản lý cửa hàng </span>
                    <span class="menu-arrow"></span>
                </a>
                <div class="collapse" id="sidebarPagesAuth">
                    <ul class="side-nav-second-level">
                        <li>
                            <a href="auth-login.html">Login</a>
                        </li>
                        <li>
                            <a href="auth-register.html">Register</a>
                        </li>
                        <li>
                            <a href="auth-logout.html">Logout</a>
                        </li>
                        <li>
                            <a href="auth-recoverpw.html">Recover Password</a>
                        </li>
                        <li>
                            <a href="auth-lock-screen.html">Lock Screen</a>
                        </li>
                        <li>
                            <a href="auth-confirm-mail.html">Confirm Mail</a>
                        </li>
                    </ul>
                </div>
            </li>

            <li class="side-nav-item">
                <a data-bs-toggle="collapse" href="#sidebarPagesError" aria-expanded="false" aria-controls="sidebarPagesError" class="side-nav-link">
                    <i class="ri-error-warning-fill"></i>
                    <span> Error Pages </span>
                    <span class="menu-arrow"></span>
                </a>
                <div class="collapse" id="sidebarPagesError">
                    <ul class="side-nav-second-level">
                        <li>
                            <a href="error-404.html">Error 404</a>
                        </li>
                        <li>
                            <a href="error-404-alt.html">Error 404-alt</a>
                        </li>
                        <li>
                            <a href="error-500.html">Error 500</a>
                        </li>
                    </ul>
                </div>
            </li>

            <li class="side-nav-item">
                <a data-bs-toggle="collapse" href="#sidebarLayouts" aria-expanded="false" aria-controls="sidebarLayouts" class="side-nav-link">
                    <i class="ri-layout-fill"></i>
                    <span> Layouts </span>
                    <span class="menu-arrow"></span>
                </a>
                <div class="collapse" id="sidebarLayouts">
                    <ul class="side-nav-second-level">
                        <li>
                            <a href="layouts-compact.html" target="_blank">Compact</a>
                        </li>
                        <li>
                            <a href="layouts-icon-view.html" target="_blank">Icon View</a>
                        </li>
                        <li>
                            <a href="layouts-full.html" target="_blank">Full View</a>
                        </li>
                        <li>
                            <a href="layouts-fullscreen.html" target="_blank">Fullscreen View</a>
                        </li>
                    </ul>
                </div>
            </li>

            <li class="side-nav-item">
                <a data-bs-toggle="collapse" href="#sidebarMultiLevel" aria-expanded="false" aria-controls="sidebarMultiLevel" class="side-nav-link">
                    <i class="ri-share-fill"></i>
                    <span> Multi Level </span>
                    <span class="menu-arrow"></span>
                </a>
                <div class="collapse" id="sidebarMultiLevel">
                    <ul class="side-nav-second-level">
                        <li class="side-nav-item">
                            <a data-bs-toggle="collapse" href="#sidebarSecondLevel" aria-expanded="false" aria-controls="sidebarSecondLevel">
                                <span> Second Level </span>
                                <span class="menu-arrow"></span>
                            </a>
                            <div class="collapse" id="sidebarSecondLevel">
                                <ul class="side-nav-third-level">
                                    <li>
                                        <a href="javascript: void(0);">Item 1</a>
                                    </li>
                                    <li>
                                        <a href="javascript: void(0);">Item 2</a>
                                    </li>
                                </ul>
                            </div>
                        </li>
                        <li class="side-nav-item">
                            <a data-bs-toggle="collapse" href="#sidebarThirdLevel" aria-expanded="false" aria-controls="sidebarThirdLevel">
                                <span> Third Level </span>
                                <span class="menu-arrow"></span>
                            </a>
                            <div class="collapse" id="sidebarThirdLevel">
                                <ul class="side-nav-third-level">
                                    <li>
                                        <a href="javascript: void(0);">Item 1</a>
                                    </li>
                                    <li class="side-nav-item">
                                        <a data-bs-toggle="collapse" href="#sidebarFourthLevel" aria-expanded="false" aria-controls="sidebarFourthLevel">
                                            <span> Item 2 </span>
                                            <span class="menu-arrow"></span>
                                        </a>
                                        <div class="collapse" id="sidebarFourthLevel">
                                            <ul class="side-nav-forth-level">
                                                <li>
                                                    <a href="javascript: void(0);">Item 2.1</a>
                                                </li>
                                                <li>
                                                    <a href="javascript: void(0);">Item 2.2</a>
                                                </li>
                                            </ul>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </li>
                    </ul>
                </div>
            </li>


        </ul>
        <!--- End Sidemenu -->

        <div class="clearfix"></div>
    </div>
</div>