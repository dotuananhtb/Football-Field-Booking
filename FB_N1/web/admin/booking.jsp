<%-- 
    Document   : booking
    Created on : Jul 4, 2025, 8:01:24 AM
    Author     : Đỗ Tuấn Anh
--%>

<%-- 
    Document   : chitietdatsan_staff
    Created on : Jun 18, 2025, 4:56:35 AM
    Author     : Đỗ Tuấn Anh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Các đơn đặt sân</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
        <meta content="Coderthemes" name="author" />

        <!-- App favicon -->
        <jsp:include page="head_only.jsp" />

        <!-- Datatables css -->
        <link href="assets/vendor/datatables.net-bs5/css/dataTables.bootstrap5.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/vendor/datatables.net-responsive-bs5/css/responsive.bootstrap5.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/vendor/datatables.net-fixedcolumns-bs5/css/fixedColumns.bootstrap5.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/vendor/datatables.net-fixedheader-bs5/css/fixedHeader.bootstrap5.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/vendor/datatables.net-buttons-bs5/css/buttons.bootstrap5.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/vendor/datatables.net-select-bs5/css/select.bootstrap5.min.css" rel="stylesheet" type="text/css" />

        <!-- Theme Config Js -->
        <script src="assets/js/config.js"></script>

        <!-- App css -->
        <link href="assets/css/app.min.css" rel="stylesheet" type="text/css" id="app-style" />

        <!-- Icons css -->
        <link href="assets/css/icons.min.css" rel="stylesheet" type="text/css" />
    </head>
    <style>.dataTables_filter {
            display: none;
        }
    </style>
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

                                    </div>
                                    <h2>Bảng hiển thị các đơn đặt sân của khánh hàng</h2>
                                </div>
                            </div>
                        </div>
                        <!-- end page title -->



                        <div class="row g-4">
                            <div class="col-12">
                                <div class="mb-4">
                                    <p class="text-muted fs-14">
                                        Danh sách đơn đặt sân
                                    </p>

                                    <table id="booking-datatable" class="table table-striped w-100 nowrap">
                                        <thead>
                                            <tr>
                                                <th>STT</th>
                                                <th>Mã đơn</th>
                                                <th>Ngày đặt</th>
                                                <th>Tổng tiền</th>
                                                <th>Khách hàng</th>
                                                <th>SĐT</th>
                                                <th>Loại KH</th>
                                                <th>Trạng thái ca</th>
                                                <th>Hành động</th>
                                            </tr>
                                            <tr id="filter-row">
                                                <th>
                                                    <button id="reset-filters" class="btn btn-secondary btn-sm mt-2">Đặt lại</button>
                                                </th>
                                                <th>
                                                    <input type="text" class="form-control form-control-sm" placeholder="Mã đơn" style="min-width: 80px;">
                                                </th>
                                                <th>
                                                    <input type="date" class="form-control form-control-sm mb-1" id="bookingDateFrom" style="min-width: 90px; max-width: 120px;">
                                                    <input type="date" class="form-control form-control-sm" id="bookingDateTo" style="min-width: 90px; max-width: 120px;">
                                                </th>
                                                <th>
                                                    <input type="text" class="form-control form-control-sm" placeholder="Tổng tiền" style="min-width: 80px;">
                                                </th>
                                                <th>
                                                    <input type="text" class="form-control form-control-sm" placeholder="Tên KH" style="min-width: 100px;">
                                                </th>
                                                <th>
                                                    <input type="text" class="form-control form-control-sm" placeholder="SĐT" style="min-width: 90px;">
                                                </th>
                                                <th>
                                                    <input type="text" class="form-control form-control-sm" placeholder="Loại KH" style="min-width: 80px;">
                                                </th>
                                                <th>
                                                    <input type="text" class="form-control form-control-sm" placeholder="Trạng thái " style="min-width: 90px;">
                                                </th>


                                                <th></th> <!-- Hành động không cần filter input -->
                                            </tr>

                                        </thead>
                                        <tbody></tbody>
                                    </table>
                                </div> <!-- end card -->
                            </div><!-- end col-->
                        </div> <!-- end row-->

                        <div class="modal fade" id="bookingSlotModal" tabindex="-1" aria-labelledby="bookingSlotModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-lg modal-dialog-scrollable">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="bookingSlotModalLabel">Chi tiết các ca trong đơn</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                                    </div>
                                    <div class="modal-body">
                                        <div id="booking-slots-container"></div>
                                    </div>
                                </div>
                            </div>
                        </div>



                    </div> <!-- container -->

                </div> <!-- content -->

                <!-- Footer Start -->
                <jsp:include page="footer.jsp" />

                <!-- end Footer -->

            </div>

            <!-- ============================================================== -->
            <!-- End Page content -->
            <!-- ============================================================== -->

        </div>
        <!-- END wrapper -->

        <!-- Theme Settings -->
        <jsp:include page="themesetting.jsp" />

        <!-- Vendor js -->
        <script src="assets/js/vendor.min.js"></script>

        <!-- Datatables js -->
        <script src="assets/vendor/datatables.net/js/jquery.dataTables.min.js"></script>
        <script src="assets/vendor/datatables.net-bs5/js/dataTables.bootstrap5.min.js"></script>
        <script src="assets/vendor/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
        <script src="assets/vendor/datatables.net-responsive-bs5/js/responsive.bootstrap5.min.js"></script>
        <script src="assets/vendor/datatables.net-fixedcolumns-bs5/js/fixedColumns.bootstrap5.min.js"></script>
        <script src="assets/vendor/datatables.net-fixedheader/js/dataTables.fixedHeader.min.js"></script>
        <script src="assets/vendor/datatables.net-buttons/js/dataTables.buttons.min.js"></script>
        <script src="assets/vendor/datatables.net-buttons-bs5/js/buttons.bootstrap5.min.js"></script>
        <script src="assets/vendor/datatables.net-buttons/js/buttons.html5.min.js"></script>
        <script src="assets/vendor/datatables.net-buttons/js/buttons.flash.min.js"></script>
        <script src="assets/vendor/datatables.net-buttons/js/buttons.print.min.js"></script>
        <script src="assets/vendor/datatables.net-keytable/js/dataTables.keyTable.min.js"></script>
        <script src="assets/vendor/datatables.net-select/js/dataTables.select.min.js"></script>

        <!-- Datatable Demo Aapp js -->
        <script src="assets/js/booking.js"></script>
        <!-- App js -->
        <script src="assets/js/app.min.js"></script>








    </body>

</html>