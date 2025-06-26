<%-- 
    Document   : thanh-toan
    Created on : Jun 27, 2025, 12:47:52 AM
    Author     : Đỗ Tuấn Anh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Pricing | Powerx - Bootstrap 5 Admin & Dashboard Template</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
        <meta content="Coderthemes" name="author" />

        <!-- App favicon -->
        <%@include file="head_only.jsp" %>


        <!-- Theme Config Js -->
        <script src="assets/js/config.js"></script>

        <!-- App css -->
        <link href="assets/css/app.min.css" rel="stylesheet" type="text/css" id="app-style" />

        <!-- Icons css -->
        <link href="assets/css/icons.min.css" rel="stylesheet" type="text/css" />
    </head>

    <body>
        <!-- Begin page -->
        <div class="wrapper">


            <!-- ========== Topbar Start ========== -->
            <jsp:include page="topbar.jsp"/>

            <!-- ========== Topbar End ========== -->

            <!-- ========== Left Sidebar Start ========== -->
            <jsp:include page="left_sidebar.jsp"/>
            <!-- ========== Left Sidebar End ========== -->

            <!-- ============================================================== -->
            <!-- Start Page Content here -->
            <!-- ============================================================== -->

            <div class="content-page">
                <div class="content">

                    <!-- Start Content-->
                    <div class="container-fluid">

                        <!-- start page title -->
                        <div class="row">
                            <div class="col-12">
                                <div class="bg-flower">
                                    <img src="assets/images/flowers/img-3.png">
                                </div>

                                <div class="bg-flower-2">
                                    <img src="assets/images/flowers/img-1.png">
                                </div>

                                <div class="page-title-box">
                                    <div class="page-title-right">
                                        <!--                                        <ol class="breadcrumb m-0">
                                                                                    <li class="breadcrumb-item"><a href="javascript: void(0);">Powerx</a></li>
                                                                                    <li class="breadcrumb-item"><a href="javascript: void(0);">Pages</a></li>
                                                                                    <li class="breadcrumb-item active">Pricing</li>
                                                                                </ol>-->
                                    </div>
                                    <h4 class="page-title"></h4>
                                </div>
                            </div>
                        </div>
                        <!-- end page title -->


                        <div class="row justify-content-center">
                            <div class="col-xxl-10">

                                <!-- Pricing Title-->
                                <div class="text-center">
                                    <h1 class="mb-2">Thanh <b>Toán</b></h1>
                                    <p class="text-muted">
                                        Quét QR để thanh toán cho đơn hàng của bạn<br> Trạng thái được cập nhật tự động vui lòng chờ xử lí!
                                    </p>
                                </div>

                                <!-- Plans -->
                                <div class="row my-3">
                                    <div class="col-md-4">

                                    </div> <!-- end col -->

                                    <div class="col-md-4">
                                        <div class="card">
                                            <div class="card-body ">  <!-- QR đặt trong card body -->
                                                <div class="avatar-md mb-3">
                                                    <span class="avatar-title bg-danger-subtle border-danger border border-opacity-25 text-danger fw-normal fs-24 rounded-3">
                                                        <i class="ri-briefcase-2-line"></i>
                                                    </span>
                                                </div>
                                                <h2 class="my-3">$29 <span class="text-uppercase fs-14 text-muted">/ Month</span></h2>
                                                <p class="fw-bold text-uppercase mb-3">Business Pack</p>
                                                <ul class="list-unstyled d-grid gap-2">
                                                    <li><i class="ri-check-double-line text-danger fs-18 me-1"></i>50 GB Storage</li>
                                                    <li><i class="ri-check-double-line text-danger fs-18 me-1"></i>900 GB Bandwidth</li>
                                                    <li><i class="ri-check-double-line text-danger fs-18 me-1"></i>2 Domain</li>
                                                    <li><i class="ri-check-double-line text-danger fs-18 me-1"></i>10 User</li>
                                                    <li><i class="ri-check-double-line text-danger fs-18 me-1"></i>Email Support</li>
                                                    <li><i class="ri-check-double-line text-danger fs-18 me-1"></i>24x7 Support</li>
                                                </ul>
                                                <button class="btn btn-danger mt-2 w-100">Change Plan</button>
                                            </div>
                                        </div> <!-- end Pricing_card -->
                                    </div> <!-- end col -->

                                    <div class="col-md-4">

                                    </div> <!-- end col -->
                                </div>
                                <!-- end row -->

                            </div> <!-- end col-->
                        </div>
                        <!-- end row -->

                    </div> <!-- container -->

                </div> <!-- content -->

                <!-- Footer Start -->
                <footer class="footer">
                    <%@include file="footer.jsp" %>

                </footer>
                <!-- end Footer -->

            </div>

            <!-- ============================================================== -->
            <!-- End Page content -->
            <!-- ============================================================== -->

        </div>
        <!-- END wrapper -->

        <!-- Theme Settings -->
        <%@include file="themesetting.jsp" %>


        <!-- Vendor js -->
        <script src="assets/js/vendor.min.js"></script>

        <!-- App js -->
        <script src="assets/js/app.min.js"></script>

    </body>
</html>

