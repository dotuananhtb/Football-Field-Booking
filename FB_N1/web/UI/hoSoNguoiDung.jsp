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
                                                <jsp:include page="toast.jsp"/>
                                                <jsp:include page="header_dashboard.jsp" />
                                                <!-- End Main Header -->
                                                <main id="main">
                                                    <section class="profile-dashboard">

                                                        <!-- Mẫu cho nhóm upload ảnh_ ae thay đổi giá trị value để tạo ra folder lưu riêng ảnh cho Object mình làm -->                                                        
                                                        <form action="${pageContext.request.contextPath}/upload-cloud-image" method="post" enctype="multipart/form-data">
                                                            <div class="form-group mb-3">
                                                                <label for="avatar">Chọn ảnh đại diện Cloud(Dùng api cloudinary):</label>
                                                                <input type="file" name="image" id="avatar" accept="image/*" class="form-control" required>
                                                            </div>

                                                            <input type="hidden" name="type" value="avatars">

                                                                <button type="submit" class="btn btn-primary">Cập nhật avatar</button>
                                                        </form>

                                                        <form action="${pageContext.request.contextPath}/upload-image" method="post" enctype="multipart/form-data">
                                                            <div class="mb-3">
                                                                <label for="image" class="form-label">Chọn ảnh đại diện lưu vào assets/images/upload</label>
                                                                <input class="form-control" type="file" id="image" name="image" accept="image/*" required>
                                                            </div>

                                                            <input type="hidden" name="type" value="avatars"> <!-- value này là cho thư mục riêng cho mỗi  object -->

                                                                <button type="submit" class="btn btn-primary">Tải lên</button>
                                                        </form>
                                                        <!-- comment: Do Tuan Anh -->





                                                        <%
                                                            // Lấy ngày hiện tại
                                                            String currentDate = LocalDate.now().toString();
                                                            // Hoặc với format khác nếu cần
                                                            String maxDate = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                                                        %>
                                                        <form action="${pageContext.request.contextPath}/updateUser" method="post" class="edit-profile">
                                                            <c:set value="${sessionScope.userProfile}" var="u"></c:set>
                                                                <div class="inner-header mb-40">
                                                                    <h3 class="title">Hồ sơ cá nhân </h3>

                                                                </div>
                                                                <div class="upload-image-dashboard flex mb-80">
                                                                    <span class="title-avata">Avatar:</span>
                                                                    <div class="upload-image-wrap">
                                                                        <div class="avata relative">
                                                                            <img id="frame" src="${u.avatar}" alt="avatar">

                                                                    </div>

                                                                    <div class="upload-file">

                                                                    </div>

                                                                </div>
                                                            </div>

                                                            <c:set value="${sessionScope.account}" var="a"></c:set>
                                                                <div class="infomation-dashboard mb-70">
                                                                    <h4 class="title">Thông tin cá nhân</h4>
                                                                    <div class="widget-dash-board">
                                                                        <div class="grid-input-2">
                                                                            <input type="hidden" value="${u.getAccountId()}" name="id">
                                                                            <div class="input-wrap">
                                                                                <label>Tên Đăng Nhập</label>
                                                                                <input type="text" value="${a.getUsername()}" name="username" 
                                                                                       pattern="^[a-zA-Z0-9_.]{6,}$" minlength="6" maxlength="30"
                                                                                       title="Tối thiểu 6 ký tự, chỉ gồm chữ, số, dấu gạch dưới và dấu chấm" required>
                                                                                    <span class="error-message" style="color: red;">${mess}</span>
                                                                            </div>
                                                                            <div class="input-wrap">
                                                                                <label>Số điện thoại</label>
                                                                                <input type="tel" value="${u.getPhone()}" name="phone" pattern="^[0-9]{10}$" title="Số điện thoại phải gồm 10 chữ số"maxlength="10" required>
                                                                            </div>
                                                                            <div class="input-wrap">
                                                                                <label>Họ</label>
                                                                                <input type="text" value="${u.getLastName()}" name="lname" pattern="^[A-Za-zÀ-ỹà-ỹ\s]+$" title="Chỉ chứa chữ cái và khoảng trắng" minlength="1" maxlength="50" required>
                                                                            </div>
                                                                            <div class="input-wrap">
                                                                                <label>Tên</label>
                                                                                <input type="text" value="${u.getFirstName()}" name="fname"  pattern="^[A-Za-zÀ-ỹà-ỹ\s]+$" title="Chỉ chứa chữ cái và khoảng trắng" minlength="1" maxlength="30" required>
                                                                            </div>


                                                                            <div class="input-wrap">
                                                                                <label>Địa chỉ Email</label>
                                                                                <input type="email" value="${a.getEmail()}"minlength="5" maxlength="200" readonly>
                                                                            </div>
                                                                            <div class="input-wrap">

<!--                                                                                <input type="text" value="${u.getGender()}" name="gender"id="gender" readonly>-->
                                                                                <label for="gender">Giới tính </label>
                                                                                <select name="gender" id="gender"  required>
                                                                                    <option value="">${u.getGender()}</option>
                                                                                    <option value="Nam">Nam</option>
                                                                                    <option value="Nữ">Nữ</option>
                                                                                    <option value="Khác">Khác</option>
                                                                                </select>
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
                                                                    <br/>
                                                                    <div class="otp-dashboard">

                                                                        <div class="flex-three">
                                                                            <div class="button-wrap">
                                                                                <button type="submit" class="save"><i class="icon-Vector-221"></i>Lưu thay đổi</button>
                                                                                <button type="reset" class="reset"><i class="icon-reply-all"></i>Đặt lại
                                                                                </button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>



                                                        </form>

                                                        <script src="app/js/validateRegister.js"></script>
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
