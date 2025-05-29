<%-- 
    Document   : userProfile
    Created on : 27 thg 5, 2025, 08:28:49
    Author     : Asus
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="vi">

    <head>
        <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1">
                <title>Hồ Sơ Cá Nhân - BookField</title>

                <!-- Favicon -->
                <link rel="shortcut icon" type="image/x-icon" href="images/favicon.png">
                    <!-- Bootstrap core CSS -->
                    <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
                        <!--Custom CSS-->
                        <link href="css/style.css" rel="stylesheet" type="text/css">
                            <!--Plugin CSS-->
                            <link href="css/plugin.css" rel="stylesheet" type="text/css">
                                <!--Font Awesome-->
                                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
                                    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.min.css">
                                        <link rel="stylesheet" href="fonts/line-icons.css" type="text/css">

                                            <style>
                                                .profile-sidebar {
                                                    background: #fff;
                                                    border-radius: 10px;
                                                    box-shadow: 0 0 20px rgba(0,0,0,0.1);
                                                    padding: 0;
                                                    overflow: hidden;
                                                }

                                                .profile-header {
                                                    background: linear-gradient(135deg, #28a745, #20c997);
                                                    padding: 30px 20px;
                                                    text-align: center;
                                                    color: white;
                                                }

                                                .profile-avatar {
                                                    width: 100px;
                                                    height: 100px;
                                                    border-radius: 50%;
                                                    border: 4px solid white;
                                                    margin-bottom: 15px;
                                                }

                                                .profile-nav {
                                                    list-style: none;
                                                    padding: 0;
                                                    margin: 0;
                                                }

                                                .profile-nav li {
                                                    border-bottom: 1px solid #f0f0f0;
                                                }

                                                .profile-nav li:last-child {
                                                    border-bottom: none;
                                                }

                                                .profile-nav a {
                                                    display: block;
                                                    padding: 15px 20px;
                                                    color: #333;
                                                    text-decoration: none;
                                                    transition: all 0.3s;
                                                }

                                                .profile-nav a:hover,
                                                .profile-nav a.active {
                                                    background: #f8f9fa;
                                                    color: #28a745;
                                                    padding-left: 30px;
                                                }

                                                .profile-nav i {
                                                    width: 20px;
                                                    margin-right: 10px;
                                                }

                                                .profile-content {
                                                    background: #fff;
                                                    border-radius: 10px;
                                                    box-shadow: 0 0 20px rgba(0,0,0,0.1);
                                                    padding: 30px;
                                                }

                                                .stats-card {
                                                    background: linear-gradient(135deg, #007bff, #0056b3);
                                                    color: white;
                                                    border-radius: 10px;
                                                    padding: 20px;
                                                    text-align: center;
                                                    margin-bottom: 20px;
                                                }

                                                .stats-card.success {
                                                    background: linear-gradient(135deg, #28a745, #20c997);
                                                }

                                                .stats-card.warning {
                                                    background: linear-gradient(135deg, #ffc107, #e0a800);
                                                }

                                                .stats-card.info {
                                                    background: linear-gradient(135deg, #17a2b8, #138496);
                                                }

                                                .booking-card {
                                                    border: 1px solid #e9ecef;
                                                    border-radius: 10px;
                                                    padding: 20px;
                                                    margin-bottom: 20px;
                                                    transition: all 0.3s;
                                                }

                                                .booking-card:hover {
                                                    box-shadow: 0 5px 15px rgba(0,0,0,0.1);
                                                    transform: translateY(-2px);
                                                }

                                                .status-badge {
                                                    padding: 5px 12px;
                                                    border-radius: 20px;
                                                    font-size: 12px;
                                                    font-weight: bold;
                                                }

                                                .status-confirmed {
                                                    background: #d4edda;
                                                    color: #155724;
                                                }

                                                .status-pending {
                                                    background: #fff3cd;
                                                    color: #856404;
                                                }

                                                .status-cancelled {
                                                    background: #f8d7da;
                                                    color: #721c24;
                                                }

                                                .favorite-field {
                                                    border: 1px solid #e9ecef;
                                                    border-radius: 10px;
                                                    overflow: hidden;
                                                    margin-bottom: 20px;
                                                    transition: all 0.3s;
                                                }

                                                .favorite-field:hover {
                                                    box-shadow: 0 5px 15px rgba(0,0,0,0.1);
                                                }

                                                .field-image {
                                                    height: 150px;
                                                    background-size: cover;
                                                    background-position: center;
                                                    position: relative;
                                                }

                                                .field-content {
                                                    padding: 15px;
                                                }

                                                .breadcrumb-main {
                                                    background: #f8f9fa;
                                                    padding: 20px 0;
                                                    margin-bottom: 30px;
                                                }
                                            </style>
                                            </head>

                                            <body>
                                                <!-- Preloader -->
                                                <div id="preloader">
                                                    <div id="status"></div>
                                                </div>

                                                <!-- Header -->
                                                <header>
                                                    <div class="header_menu" id="header_menu">
                                                        <nav class="navbar navbar-default">
                                                            <div class="container">
                                                                <div class="navbar-flex d-flex align-items-center justify-content-between w-100 pb-3 pt-3">
                                                                    <div class="navbar-header">

                                                                    </div>

                                                                    <div class="navbar-collapse1 d-flex align-items-center">
                                                                        <ul class="nav navbar-nav">
                                                                            <li><a href="home.jsp">Trang Chủ</a></li>
                                                                            <li><a href="fields.html">Sân Bóng</a></li>
                                                                            <li><a href="booking.html">Đặt Sân</a></li>
                                                                            <li><a href="contact.html">Liên Hệ</a></li>
                                                                        </ul>
                                                                    </div>

                                                                    <div class="register-login d-flex align-items-center">
                                                                        <div class="dropdown">
                                                                            <a href="#" class="dropdown-toggle" data-bs-toggle="dropdown">
                                                                                <img src="images/reviewer/1.jpg" alt="Avatar" class="rounded-circle me-2" width="30" height="30">
                                                                                    <c:set value="${sessionScope.userProfile}" var="u"></c:set>
                                                                                    ${u.getFirstName()}
                                                                            </a>
                                                                            <ul class="dropdown-menu">
                                                                                <li><a href="user-profile.html">Hồ Sơ</a></li>
                                                                                <li><a href="my-bookings.html">Đặt Sân Của Tôi</a></li>

                                                                                <li><hr class="dropdown-divider"></li>
                                                                                <li><a href="logout.html">Đăng Xuất</a></li>
                                                                            </ul>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </nav>
                                                    </div>
                                                </header>

                                                <!-- Breadcrumb -->
                                                <section class="breadcrumb-main">
                                                    <div class="container">
                                                        <div class="row">
                                                            <div class="col-lg-12">
                                                                <div class="breadcrumb-content">
                                                                    <h2>Hồ Sơ Cá Nhân</h2>
                                                                    <nav aria-label="breadcrumb">
                                                                        <ol class="breadcrumb">


                                                                        </ol>
                                                                    </nav>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </section>

                                                <!-- Profile Content -->
                                                <section class="py-5">
                                                    <div class="container">
                                                        <div class="row">
                                                            <!-- Profile Sidebar -->
                                                            <div class="col-lg-3 mb-4">
                                                                <div class="profile-sidebar">
                                                                    <div class="profile-header">
                                                                        <img src="images/reviewer/1.jpg" alt="Avatar" class="profile-avatar">
                                                                            <h4 class="mb-1">${u.getFirstName()}</h4>


                                                                    </div>

                                                                    <ul class="profile-nav">





                                                                    </ul>
                                                                </div>
                                                            </div>

                                                            <!-- Profile Content -->
                                                            <div class="col-lg-9">
                                                                <!-- Overview Tab -->
                                                                <div class="tab-content active" id="overview">
                                                                    <div class="profile-content">
                                                                        <h3 class="mb-4">Tổng Quan Tài Khoản</h3>

                                                                        <!-- Stats Cards -->
                                                                        <div class="row mb-4">
                                                                            <div class="col-md-3 col-sm-6 mb-3">
                                                                                <div class="stats-card">
                                                                                    <h3 class="mb-1">24</h3>
                                                                                    <p class="mb-0">Lần Đặt Sân</p>
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-4 col-sm-6 mb-3">
                                                                                <div class="stats-card success">
                                                                                    <h3 class="mb-1">18</h3>
                                                                                    <p class="mb-0">Đặt Thành Công</p>
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-4 col-sm-6 mb-3">
                                                                                <div class="stats-card warning">
                                                                                    <h3 class="mb-1">4.8M</h3>
                                                                                    <p class="mb-0">Tổng Chi Tiêu</p>
                                                                                </div>
                                                                            </div>

                                                                        </div>

                                                                        <!-- Recent Bookings -->
                                                                        <h4 class="mb-3">Đặt Sân Gần Đây</h4>
                                                                        <div class="booking-card">
                                                                            <div class="row align-items-center">
                                                                                <div class="col-md-8">
                                                                                    <h5 class="mb-1">Sân Thể Thao Tân Định</h5>
                                                                                    <p class="text-muted mb-1">Sân 5 người - 28/12/2024, 19:00 - 21:00</p>
                                                                                    <small class="text-muted">Quận 1, TP.HCM</small>
                                                                                </div>
                                                                                <div class="col-md-2 text-center">
                                                                                    <span class="status-badge status-confirmed">Đã Xác Nhận</span>
                                                                                </div>
                                                                                <div class="col-md-2 text-end">
                                                                                    <h5 class="text-success mb-0">360.000đ</h5>
                                                                                </div>
                                                                            </div>
                                                                        </div>

                                                                        <div class="booking-card">
                                                                            <div class="row align-items-center">
                                                                                <div class="col-md-8">
                                                                                    <h5 class="mb-1">Sân Riverside</h5>
                                                                                    <p class="text-muted mb-1">Sân 7 người - 25/12/2024, 16:00 - 18:00</p>
                                                                                    <small class="text-muted">Quận 7, TP.HCM</small>
                                                                                </div>
                                                                                <div class="col-md-2 text-center">
                                                                                    <span class="status-badge status-pending">Chờ Xác Nhận</span>
                                                                                </div>
                                                                                <div class="col-md-2 text-end">
                                                                                    <h5 class="text-warning mb-0">400.000đ</h5>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                                <!-- Personal Info Tab -->
                                                                <div class="tab-content" id="personal-info">
                                                                    <div class="profile-content">
                                                                        <h3 class="mb-4">Thông Tin Cá Nhân</h3>
                                                                        <c:set value="${sessionScope.userProfile}" var="u"></c:set>
                                                                        <c:set value="${sessionScope.acc}" var="a"></c:set>
                                                                        <%--<c:out value="${sessionScope.acc}" default="Chưa có userProfile trong session" />--%>
                                                                        <form action="${pageContext.request.contextPath}/updateUser" id="contactform3">

                                                                            <div class="row">
                                                                                <div class="col-md-6 mb-3">
                                                                                    <input type="hidden" value="${a.getAccountId()}" name="id">
                                                                                        <label class="form-label">Họ và Tên</label>
                                                                                        <input type="text" class="form-control" value="${u.getFirstName()}" name="name">
                                                                                            </div>
                                                                                            <div class="col-md-6 mb-3">
                                                                                                <label class="form-label">User Name</label>
                                                                                                <input type="text" class="form-control" value="${a.getUsername()}" name="username" readonly>
                                                                                            </div>
                                                                                            <div class="col-md-6 mb-3">
                                                                                                <label class="form-label">Email</label>
                                                                                                <input type="email" class="form-control" value="${a.getEmail()}" readonly >
                                                                                            </div>
                                                                                            </div>

                                                                                            <div class="row">
                                                                                                <div class="col-md-6 mb-3">
                                                                                                    <label class="form-label">Số Điện Thoại</label>
                                                                                                    <input type="tel" class="form-control" value="${u.getPhone()}" name="phone">
                                                                                                </div>
                                                                                                <div class="col-md-6 mb-3">
                                                                                                    <label class="form-label">Ngày Sinh</label>
                                                                                                    <input type="date" class="form-control" value="${u.getDob()}" name="dob">
                                                                                                </div>
                                                                                            </div>

                                                                                            <div class="row">
                                                                                                <div class="col-md-6 mb-3">
                                                                                                    <label class="form-label">Giới Tính</label>
                                                                                                    <input type="text" class="form-control" value="${u.getGender()}" readonly>
                                                                                                </div>

                                                                                            </div>

                                                                                            <div class="mb-3">
                                                                                                <label class="form-label">Địa Chỉ</label>
                                                                                                <input type="text" class="form-control" value="${u.getAddress()}" name="address">
                                                                                            </div>

                                                                                            <button type="submit" class="btn btn-success" onclick="submitUpdate()">Cập Nhật</button>

                                                                                            <h6>${mess}</h6>
                                                                                            </form>
                                                                                            </div>
                                                                                            </div>

                                                                                            <!-- Booking History Tab -->
                                                                                            <div class="tab-content" id="booking-history">
                                                                                                <div class="profile-content">
                                                                                                    <div class="d-flex justify-content-between align-items-center mb-4">
                                                                                                        <h3>Lịch Sử Đặt Sân</h3>
                                                                                                        <div class="d-flex gap-2">
                                                                                                            <select class="form-select form-select-sm">
                                                                                                                <option>Tất cả trạng thái</option>
                                                                                                                <option>Đã xác nhận</option>
                                                                                                                <option>Chờ xác nhận</option>
                                                                                                                <option>Đã hủy</option>
                                                                                                            </select>
                                                                                                            <input type="month" class="form-control form-control-sm" value="2024-12">
                                                                                                        </div>
                                                                                                    </div>

                                                                                                    <!-- Booking Items -->
                                                                                                    <div class="booking-card">
                                                                                                        <div class="row">
                                                                                                            <div class="col-md-3">
                                                                                                                <img src="images/trending/trending1.jpg" alt="Sân bóng" class="img-fluid rounded">
                                                                                                            </div>
                                                                                                            <div class="col-md-6">
                                                                                                                <h5 class="mb-2">Sân Thể Thao Tân Định</h5>
                                                                                                                <p class="text-muted mb-1"><i class="fas fa-map-marker-alt"></i> Quận 1, TP.HCM</p>
                                                                                                                <p class="text-muted mb-1"><i class="fas fa-calendar"></i> 28/12/2024, 19:00 - 21:00</p>
                                                                                                                <p class="text-muted mb-1"><i class="fas fa-users"></i> Sân 5 người</p>
                                                                                                                <span class="status-badge status-confirmed">Đã Xác Nhận</span>
                                                                                                            </div>
                                                                                                            <div class="col-md-3 text-end">
                                                                                                                <h4 class="text-success mb-2">360.000đ</h4>
                                                                                                                <p class="text-muted mb-1">Mã đặt: #BF001234</p>
                                                                                                                <div class="btn-group-vertical btn-group-sm">
                                                                                                                    <button class="btn btn-outline-primary btn-sm">Xem Chi Tiết</button>
                                                                                                                    <button class="btn btn-outline-success btn-sm">Đặt Lại</button>
                                                                                                                </div>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                    </div>

                                                                                                    <div class="booking-card">
                                                                                                        <div class="row">
                                                                                                            <div class="col-md-3">
                                                                                                                <img src="images/trending/trending2.jpg" alt="Sân bóng" class="img-fluid rounded">
                                                                                                            </div>
                                                                                                            <div class="col-md-6">
                                                                                                                <h5 class="mb-2">Sân Riverside</h5>
                                                                                                                <p class="text-muted mb-1"><i class="fas fa-map-marker-alt"></i> Quận 7, TP.HCM</p>
                                                                                                                <p class="text-muted mb-1"><i class="fas fa-calendar"></i> 25/12/2024, 16:00 - 18:00</p>
                                                                                                                <p class="text-muted mb-1"><i class="fas fa-users"></i> Sân 7 người</p>
                                                                                                                <span class="status-badge status-pending">Chờ Xác Nhận</span>
                                                                                                            </div>
                                                                                                            <div class="col-md-3 text-end">
                                                                                                                <h4 class="text-warning mb-2">400.000đ</h4>
                                                                                                                <p class="text-muted mb-1">Mã đặt: #BF001235</p>
                                                                                                                <div class="btn-group-vertical btn-group-sm">
                                                                                                                    <button class="btn btn-outline-primary btn-sm">Xem Chi Tiết</button>
                                                                                                                    <button class="btn btn-outline-success btn-sm">Đặt Lại</button>
                                                                                                                </div>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                    </div>

                                                                                                    <div class="booking-card">
                                                                                                        <div class="row">
                                                                                                            <div class="col-md-3">
                                                                                                                <img src="images/trending/trending3.jpg" alt="Sân bóng" class="img-fluid rounded">
                                                                                                            </div>
                                                                                                            <div class="col-md-6">
                                                                                                                <h5 class="mb-2">Sân Green Park</h5>
                                                                                                                <p class="text-muted mb-1"><i class="fas fa-map-marker-alt"></i> Tân Bình, TP.HCM</p>
                                                                                                                <p class="text-muted mb-1"><i class="fas fa-calendar"></i> 20/12/2024, 20:00 - 22:00</p>
                                                                                                                <p class="text-muted mb-1"><i class="fas fa-users"></i> Sân 11 người</p>
                                                                                                                <span class="status-badge status-cancelled">Đã Hủy</span>
                                                                                                            </div>
                                                                                                            <div class="col-md-3 text-end">
                                                                                                                <h4 class="text-danger mb-2">600.000đ</h4>
                                                                                                                <p class="text-muted mb-1">Mã đặt: #BF001236</p>
                                                                                                                <div class="btn-group-vertical btn-group-sm">
                                                                                                                    <button class="btn btn-outline-primary btn-sm">Xem Chi Tiết</button>
                                                                                                                    <button class="btn btn-outline-success btn-sm">Đặt Lại</button>
                                                                                                                </div>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                    </div>

                                                                                                    <!-- Pagination -->
                                                                                                    <nav aria-label="Page navigation" class="mt-4">
                                                                                                        <ul class="pagination justify-content-center">
                                                                                                            <li class="page-item disabled">
                                                                                                                <a class="page-link" href="#" tabindex="-1">Trước</a>
                                                                                                            </li>
                                                                                                            <li class="page-item active"><a class="page-link" href="#">1</a></li>
                                                                                                            <li class="page-item"><a class="page-link" href="#">2</a></li>
                                                                                                            <li class="page-item"><a class="page-link" href="#">3</a></li>
                                                                                                            <li class="page-item">
                                                                                                                <a class="page-link" href="#">Sau</a>
                                                                                                            </li>
                                                                                                        </ul>
                                                                                                    </nav>
                                                                                                </div>
                                                                                            </div>





                                                                                            </div>
                                                                                            </div>
                                                                                            </div>
                                                                                            </section>

                                                                                            <!-- Footer -->
                                                                                            <footer class="pt-20 pb-4" style="background-image: url(images/background_pattern.png);">
                                                                                                <div class="container">
                                                                                                    <div class="footer-copyright">
                                                                                                        <div class="copyright-inner rounded p-3 d-md-flex align-items-center justify-content-between">
                                                                                                            <div class="copyright-text">
                                                                                                                <p class="m-0 white">2025 BookField. Tất cả quyền được bảo lưu.</p>
                                                                                                            </div>
                                                                                                            <div class="social-links">
                                                                                                                <ul>
                                                                                                                    <li><a href="#"><i class="fab fa-facebook" aria-hidden="true"></i></a></li>
                                                                                                                    <li><a href="#"><i class="fab fa-twitter" aria-hidden="true"></i></a></li>
                                                                                                                    <li><a href="#"><i class="fab fa-instagram" aria-hidden="true"></i></a></li>
                                                                                                                    <li><a href="#"><i class="fab fa-linkedin" aria-hidden="true"></i></a></li>
                                                                                                                </ul>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </footer>

                                                                                            <!-- Scripts -->
                                                                                            <script src="js/jquery-3.5.1.min.js"></script>
                                                                                            <script src="js/bootstrap.min.js"></script>
                                                                                            <script src="js/plugin.js"></script>
                                                                                            <script src="js/main.js"></script>

                                                                                            <script>
                                                                                               
                                                                                                function submitUpdate() {
                                                                                                        const form = document.getElementById('contactform3');
                                                                                                        form.submit();
                    }
                                                                                                
                                                                                            

                                                                                            // Tab switching functionality
                                                                                            document.addEventListener('DOMContentLoaded', function () {
                                                                                            const navLinks = document.querySelectorAll('.nav-link');
                                                                                            const tabContents = document.querySelectorAll('.tab-content');

                                                                                            navLinks.forEach(link => {
                                                                                            link.addEventListener('click', function (e) {
                                                                                            e.preventDefault();

                                                                                            // Remove active class from all nav links
                                                                                            navLinks.forEach(nav => nav.classList.remove('active'));

                                                                                            // Add active class to clicked nav link
                                                                                            this.classList.add('active');

                                                                                            // Hide all tab contents
                                                                                            tabContents.forEach(content => content.classList.remove('active'));

                                                                                            // Show target tab content
                                                                                            const targetTab = this.getAttribute('data-tab');
                                                                                            document.getElementById(targetTab).classList.add('active');
                                                                                            });
                                                                                            });
                                                                                            });

                                                                                            function submitUpdate() {
                                                                                            const form = document.getElementById('contactform3');
                                                                                            form.submit();
                                                                                            }
                                                                                            </script>
                                                                                            </body>

                                                                                            </html>
