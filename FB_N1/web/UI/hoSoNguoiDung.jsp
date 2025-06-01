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

<%
    // Lấy ngày hiện tại
    String currentDate = LocalDate.now().toString();
    // Hoặc với format khác nếu cần
    String maxDate = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
%>
                                                        <form action="${pageContext.request.contextPath}/updateUser" method="post" class="edit-profile">
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
                                                                    <h4 class="title">Thông tin cá nhân</h4>
                                                                    <div class="widget-dash-board">
                                                                        <div class="grid-input-2">
                                                                            <input type="hidden" value="${u.getAccountId()}" name="id">
                                                                            <div class="input-wrap">
                                                                                <label>Tên Đăng Nhập </label>
                                                                                <input type="text" value="${a.getUsername()}" name="username" pattern="^[a-zA-Z0-9_.]{6,}$" minlength="6"
                                                                                       title="Tối thiểu 6 ký tự, chỉ gồm chữ, số, dấu gạch dưới và dấu chấm" required>
                                                                            </div>
                                                                            <div class="input-wrap">
                                                                                <label>Số điện thoại</label>
                                                                                <input type="tel" value="${u.getPhone()}" name="phone" pattern="^[0-9]{10}$" title="Số điện thoại phải gồm 10 chữ số" required>
                                                                            </div>
                                                                            <div class="input-wrap">
                                                                                <label>Họ</label>
                                                                                <input type="text" value="${u.getLastName()}" name="lname" pattern="^[A-Za-zÀ-ỹà-ỹ\s]+$" title="Chỉ chứa chữ cái và khoảng trắng" required>
                                                                            </div>
                                                                            <div class="input-wrap">
                                                                                <label>Tên</label>
                                                                                <input type="text" value="${u.getFirstName()}" name="fname"  pattern="^[A-Za-zÀ-ỹà-ỹ\s]+$" title="Chỉ chứa chữ cái và khoảng trắng" required>
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
                                                                                <input type="text" value="${u.getAddress()}" name="address" required>
                                                                            </div>
                                                                            <div class="input-wrap">
                                                                                <label>Ngày sinh</label>
                                                                                <input type="date" value="${u.getDob()}" name="dob" max="<?= date('Y-m-d') ?>" required>
                                                                            </div>
                                                                    </div>
                                                                </div>
                                                            </div>


                                                            <div class="otp-dashboard">

                                                                <div class="flex-three">
                                                                    <div class="button-wrap">
                                                                        <button type="submit" class="save"><i class="icon-Vector-221"></i>Lưu thay đổi</button>
                                                                        <button type="reset" class="reset"><i class="icon-reply-all"></i>Đặt lại
                                                                            </button>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </form><script>
// JavaScript để đảm bảo validation ngày sinh
document.addEventListener('DOMContentLoaded', function() {
    const dobInput = document.querySelector('input[name="dob"]');
    const today = new Date().toISOString().split('T')[0];
    
    // Set max date động
    dobInput.setAttribute('max', today);
    
    // Validation bổ sung
    dobInput.addEventListener('change', function() {
        const selectedDate = new Date(this.value);
        const currentDate = new Date();
        
        if (selectedDate > currentDate) {
            alert('Ngày sinh không được vượt quá ngày hiện tại!');
            this.value = '';
        }
    });
});
</script>
                                                                            <script src="app/js/validateRegister.js"></script>
                                                    </section>
                                                    
                                                </main>

<!--                                                <footer class="footer footer-dashboard">
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
                                                </footer>-->

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
