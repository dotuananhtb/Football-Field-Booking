<%-- 
    Document   : hoSoNguoiDung
    Created on : 31 thg 5, 2025, 15:21:16
    Author     : Asus
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US" lang="en-US">

<head>
    <meta charset="utf-8">
    <title>Vitour - Travel & Tour Booking HTML Template</title>

    <meta name="author" content="themesflat.com">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <link rel="stylesheet" href="app/css/app.css">

     <!--Favicon and Touch Icons-->  
    <link rel="shortcut icon" href="assets/images/favico.png">
    <link rel="apple-touch-icon-precomposed" href="assets/images/favico.png">

</head>

<body class="body header-fixed">

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


<jsp:include page="dashboard_menu.jsp" />

            <div class="has-dashboard">
                
<jsp:include page="header_bashboard.jsp" />
                </header>-->
                <!-- End Main Header -->
                <main id="main">
                    <section class="profile-dashboard">

                        <form action="${pageContext.request.contextPath}/updateUser" method="post"" class="edit-profile">
                            <div class="inner-header mb-40">
                                <h3 class="title">My Profile</h3>
                                <p class="des">There are many variations of passages of Lorem Ipsum</p>
                            </div>
                            <div class="upload-image-dashboard flex mb-80">
                                <span class="title-avata">Avatar:</span>
                                <div class="upload-image-wrap">
                                    <div class="avata relative">
                                        <img id="frame" src="./assets/images/page/update-profile.jpg" alt="image">
                                        <div class="icon-delete">
                                            <i class="icon-delete-1"></i>
                                        </div>
                                    </div>
                                    <span class="upload">Upload a new Avatar</span>
                                    <div class="upload-file">
                                        <input type="file">
                                    </div>
                                    <p>Png, Jpg, Svg dimenson (300* 350) max file not more then size 4 mb</p>
                                </div>
                            </div>
                            <c:set value="${sessionScope.userProfile}" var="u"></c:set>
                            <c:set value="${sessionScope.account}" var="a"></c:set>
                            <div class="infomation-dashboard mb-70">
                                <h4 class="title">User Information</h4>
                                <div class="widget-dash-board">
                                    <div class="grid-input-2">
                                        <div class="input-wrap">
                                            <label>Tên Đăng Nhập </label>
                                            <input type="text" value="${u.getFirstName()}" name="fname" >
                                        </div>
                                        <div class="input-wrap">
                                            <label>Số điện thoại</label>
                                            <input type="tel" value="${u.getPhone()}" name="phone">
                                        </div>
                                        <div class="input-wrap">
                                            <label>Họ</label>
                                            <input type="text" value="${u.getLastName()}" name="lname" readonly>
                                        </div>
                                        <div class="input-wrap">
                                            <label>Tên</label>
                                            <input type="text" value="${u.getFirstName()}" name="fname" >
                                        </div>
                                        
                                        
                                        <div class="input-wrap">
                                            <label>Địa chỉ Email</label>
                                            <input type="email" value="${a.getEmail()}" readonly>
                                        </div>
                                        <div class="input-wrap">
                                            <label>Giới tính</label>
                                            <input type="text" value="${u.getGender()}" readonly>
                                        </div>
                                        <div class="input-wrap">
                                            <label>Địa chỉ</label>
                                            <input type="text" value="${u.getAddress()}" name="address">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            
                            <div class="otp-dashboard">
                                
                                                                <div class="flex-three">
                                    <div class="button-wrap">
                                        <button type="submit" class="save"><i class="icon-Vector-221"></i>Save
                                            changes</button>
                                        <button type="reset" class="reset"><i class="icon-reply-all"></i>Reset
                                            All</button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </section>

                </main>

                <footer class="footer footer-dashboard">
                    <div class="tf-container full">
                        <div class="row">
                            <div class="col-lg-6">
                                <p class="text-white">Made with ❤️ by Themesflat. - Powered by Theme</p>
                            </div>
                            <div class="col-lg-6">
                                <ul class="menu-footer flex-six">
                                    <li>
                                        <a href="#">Privacy & Policy</a>
                                    </li>
                                    <li>
                                        <a href="#">Licensing</a>
                                    </li>
                                    <li>
                                        <a href="#">Instruction</a>
                                    </li>
                                </ul>

                            </div>
                        </div>

                    </div>
                </footer>

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
