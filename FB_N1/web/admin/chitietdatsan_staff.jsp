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
        <title>Bảng chi tiết các ca đã đặt </title>
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
                                    <h2>Bảng hiển thị chi tiết của tất cả các ca</h2>
                                </div>
                            </div>
                        </div>
                        <!-- end page title -->



                        <div class="row g-4">
                            <div class="col-12">
                                <div class="mb-4">
                                    <p class="text-muted fs-14">
                                        Bảng dữ liệu hiển thị danh sách các ca sân đã được khách hàng đặt, với thông tin đầy đủ như thời gian, sân, giá tiền và trạng thái.  
                                    </p>

                                    <table id="scroll-horizontal-datatable" class="table table-striped w-100 nowrap">

                                        <thead>
                                            <tr>
                                                <th>STT</th>
                                                <th>Mã đặt ca(BDC)</th>                                             
                                                <th>Ngày đá</th>
                                                <th>Khung giờ</th>
                                                <th>Sân</th>
                                                <th>Loại sân</th>
                                                <th>Trạng thái</th>
                                                <th>Người đặt</th>
                                                <th>SĐT</th>
                                                <th>Ngày đặt</th>
                                                <th>Giá</th>
                                                <th>Ghi chú</th>
                                            </tr>
                                            <tr id="filter-row">
                                                <th>
                                                    <button id="reset-filters" class="btn btn-secondary btn-sm mt-2">Đặt lại</button>
                                                </th>
                                                <th>
                                                    <input type="text" class="form-control form-control-sm"
                                                           placeholder="Tìm mã ca"
                                                           style="min-width: 120px; max-width: 200px;">
                                                </th>
                                                <th>
                                                    <input type="date" class="form-control form-control-sm mb-1"
                                                           id="slotDateFrom"
                                                           style="min-width: 90px; max-width: 120px;">
                                                    <input type="date" class="form-control form-control-sm"
                                                           id="slotDateTo"
                                                           style="min-width: 90px; max-width: 120px;">
                                                </th>
                                                <th>
                                                    <input type="text" class="form-control form-control-sm"
                                                           placeholder="Tìm giờ"
                                                           style="min-width: 85px; max-width: 90px;">
                                                </th>
                                                <th>
                                                    <input type="text" class="form-control form-control-sm"
                                                           placeholder="Sân"
                                                           style="min-width: 55px; max-width: 70px;">
                                                </th>
                                                <th>
                                                    <input type="text" class="form-control form-control-sm"
                                                           placeholder="Loại sân"
                                                           style="min-width: 80px; max-width: 100px;">
                                                </th>
                                                <th>
                                                    <input type="text" class="form-control form-control-sm"
                                                           placeholder="Trạng thái"
                                                           style="min-width: 90px; max-width: 120px;">
                                                </th>
                                                <th>
                                                    <input type="text" class="form-control form-control-sm"
                                                           placeholder="Tìm người đặt"
                                                           style="min-width: 115px; max-width: 140px;">
                                                </th>
                                                <th>
                                                    <input type="text" class="form-control form-control-sm"
                                                           placeholder="Tìm SĐT"
                                                           style="min-width: 100px; max-width: 140px;">
                                                </th>
                                                
                                                <th>
                                                    <input type="date" class="form-control form-control-sm mb-1"
                                                           id="bookingDateFrom"
                                                           style="min-width: 90px; max-width: 120px;">
                                                    <input type="date" class="form-control form-control-sm"
                                                           id="bookingDateTo"
                                                           style="min-width: 90px; max-width: 120px;">
                                                </th>
                                                <th>
                                                    <input type="text" class="form-control form-control-sm"
                                                           placeholder="Tìm giá"
                                                           style="min-width: 100px; max-width: 140px;">
                                                </th>
                                                <th>
                                                    <input type="text" class="form-control form-control-sm"
                                                           placeholder="Tìm ghi chú"
                                                           style="min-width: 130px; max-width: 200px;">
                                                </th>
                                            </tr>

                                        </thead>
                                        <tbody></tbody>
                                    </table>


                                </div> <!-- end card -->
                            </div><!-- end col-->
                        </div> <!-- end row-->

                        <div class="modal fade" id="updateStatusModal" tabindex="-1" aria-labelledby="updateStatusModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content shadow">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="updateStatusModalLabel">Cập nhật trạng thái ca</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                                    </div>
                                    <div class="modal-body">
                                        <p id="modal-slot-info" class="fw-bold text-primary"></p>
                                        <div class="d-grid gap-2">
                                            <button id="btn-status-1" class="btn btn-success">Xác nhận ca</button>
                                            <button id="btn-status-2" class="btn btn-warning">Chuyển chờ xử lý huỷ</button>
                                            <button id="btn-status-3" class="btn btn-danger">Huỷ ca</button>
                                        </div>
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
        <script src="assets/js/booking-details-table.js"></script>
        <!-- App js -->
        <script src="assets/js/app.min.js"></script>








    </body>

</html>