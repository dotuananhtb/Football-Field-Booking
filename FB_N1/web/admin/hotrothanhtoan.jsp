<%-- 
    Document   : hotrothanhtoan
    Created on : Jul 3, 2025, 9:50:39 PM
    Author     : Đỗ Tuấn Anh
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Đối soát thanh toán</title>
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
                    <div class="container-fluid">

                        <!-- start page title -->
                        <div class="row mb-3">
                            <div class="col-12 position-relative">
                                <div class="bg-flower position-absolute top-0 start-0">
                                    <img src="assets/images/flowers/img-3.png" alt="Flower Left" class="img-fluid">
                                </div>

                                <div class="bg-flower-2 position-absolute top-0 end-0">
                                    <img src="assets/images/flowers/img-1.png" alt="Flower Right" class="img-fluid">
                                </div>

                                <div class="page-title-box text-center">
                                    <h2 class="fw-bold text-primary">Đối soát thanh toán thủ công</h2>

                                    <div class="alert alert-info mt-3 text-start">
                                        <h5 class="fw-bold text-dark mb-2">📌 QUY TẮC ĐỐI SOÁT</h5>

                                        <p class="text-dark mb-1 fw-bold">✅ Được phép đối soát khi:</p>
                                        <ul class="text-dark mb-2" style="list-style: none; padding-left: 0; font-size: 15px;">
                                            <li>- Thanh toán ở trạng thái <strong>Chờ người dùng thanh toán</strong> (trong 15 phút với khách đặt online hoặc thanh toán sau với khách offline).</li>
                                            <li>- Tất cả các ca đều ở trạng thái <strong>Chờ thanh toán</strong> (khách offline) hoặc <strong>Đã huỷ nhưng chưa có người khác đặt lại</strong> (khách online gặp vấn đề khi chuyển khoản).</li>
                                        </ul>

                                        <p class="text-dark mb-1 fw-bold">❌ Không được đối soát khi:</p>
                                        <ul class="text-dark mb-0" style="list-style: none; padding-left: 0; font-size: 15px;">
                                            <li>- Thanh toán đơn đặt đã <strong>hoàn tất</strong>.</li>
                                            <li>- Có ít nhất 1 ca ở trạng thái <strong>Đã đặt</strong> (có người khác đặt) sau 15 phút đơn đặt bị huỷ do thanh toán online không thành công.</li>
                                        </ul>
                                    </div>
                                </div>

                            </div>
                        </div>
                        <!-- end page title -->

                        <!-- table -->
                        <div class="row g-4">
                            <div class="col-12">
                                <div class="card shadow-sm">
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table id="paymentTable" class="table table-striped table-bordered align-middle">
                                                <thead class="table-light">
                                                    <tr class="text-center">
                                                        <th>Mã giao dịch</th>
                                                        <th>Số tiền (VNĐ)</th>
                                                        <th>Thời gian giao dịch</th>
                                                        <th>Nội dung</th>
                                                        <th>Cổng thanh toán</th>
                                                        <th>Trạng thái thanh toán</th>
                                                        <th>Ghi chú</th>
                                                        <th>Thao tác</th>
                                                    </tr>
                                                </thead>
                                                <tbody></tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Modal -->
                        <div class="modal fade" id="manualMatchModal" tabindex="-1" aria-labelledby="manualMatchModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-lg modal-dialog-centered">
                                <div class="modal-content">
                                    <div class="modal-header bg-primary text-white">
                                        <h5 class="modal-title">Đối soát thanh toán</h5>
                                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Đóng"></button>
                                    </div>
                                    <div class="modal-body">
                                        <input type="hidden" id="transactionCodeHidden">
                                        <p><strong>Mã giao dịch:</strong> <span id="transactionCodeDisplay" class="text-primary fw-bold"></span></p>

                                        <div class="row mb-3">
                                            <div class="col-md-8">
                                                <label class="form-label">Booking Code</label>
                                                <input type="text" id="bookingCode" class="form-control" placeholder="Nhập booking code">
                                            </div>
                                            <div class="col-md-4 d-flex align-items-end">
                                                <button class="btn btn-outline-primary w-100" id="btnCheckBooking">
                                                    <i class="bi bi-search"></i> Kiểm tra booking
                                                </button>
                                            </div>
                                        </div>

                                        <div id="bookingInfo" class="border rounded p-3 bg-light" style="display:none;">
                                            <div id="bookingDetails" class="mb-3"></div>

                                            <div class="mb-3">
                                                <label class="form-label">Ghi chú đối soát</label>
                                                <textarea id="matchNote" class="form-control" placeholder="VD: NV_XuLy đã đối soát..."></textarea>
                                            </div>

                                            <div class="text-end">
                                                <button class="btn btn-success" id="btnMatchPayment" disabled>
                                                    <i class="bi bi-check-circle"></i> Đối soát ngay
                                                </button>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>

                    </div> <!-- container-fluid -->
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
        <script src="assets/js/manual_match.js"></script>

        <!-- App js -->
        <script src="assets/js/app.min.js"></script>








    </body>

</html>