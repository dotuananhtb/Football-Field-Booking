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
        <title>Datatables | Powerx - Bootstrap 5 Admin & Dashboard Template</title>
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
                                    <h2>Chi Tiết Đặt Sân</h2>
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
                                                <th>Mã chi tiết</th>
                                                <th>Mã đơn</th>
                                                <th>Ngày đặt</th>
                                                <th>Ngày diễn ra</th>
                                                <th>Giờ bắt đầu</th>      
                                                <th>Giờ kết thúc</th>     
                                                <th>Sân</th>
                                                <th>Loại sân</th>
                                                <th>Giá</th>
                                                <th>Trạng thái</th>
                                                <th>Người đặt</th>
                                                <th>SĐT</th>
                                                <th>Email</th>
                                                <th>Ghi chú</th>
                                            </tr>
                                        </thead>
                                        <tbody></tbody>
                                    </table>

                                </div> <!-- end card -->
                            </div><!-- end col-->
                        </div> <!-- end row-->




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

        <!-- App js -->
        <script src="assets/js/app.min.js"></script>
        <script>
            $(document).ready(function () {
                if (!$.fn.DataTable.isDataTable('#scroll-horizontal-datatable')) {
                    $("#scroll-horizontal-datatable").DataTable({
                        scrollX: true,
                        ajax: {
                            url: '/FB_N1/check-slot-info', // 🔁 endpoint trả về JSON array
                            dataSrc: '' // Nếu response là dạng mảng JSON, giữ nguyên ''
                        },
                        columns: [
                            {data: 'bookingDetailsId', title: 'Mã chi tiết'},
                            {data: 'bookingId', title: 'Mã đặt sân'},
                            {data: 'bookingDate', title: 'Ngày đặt'},
                            {data: 'slotDate', title: 'Ngày đá'},
                            {data: 'startTime', title: 'Giờ bắt đầu'},
                            {data: 'endTime', title: 'Giờ kết thúc'},
                            {data: 'fieldName', title: 'Sân'},
                            {data: 'fieldTypeName', title: 'Loại sân'},
                            {data: 'slotFieldPrice', title: 'Giá'},
                            {data: 'slotStatus', title: 'Trạng thái'},
                            {data: 'customerName', title: 'Khách hàng'},
                            {data: 'phone', title: 'SĐT'},
                            {data: 'email', title: 'Email'},
                            {data: 'note', title: 'Ghi chú'}
                        ],
                        pageLength: 10,
                        lengthMenu: [[10, 20, 30, -1], [10, 20, 30, "Tất cả"]],
                        language: {
                            info: "Hiển thị _START_ đến _END_ trong tổng _TOTAL_ dòng",
                            infoEmpty: "Không có dữ liệu để hiển thị",
                            lengthMenu: "Hiển thị _MENU_ dòng mỗi trang",
                            search: "Tìm kiếm:",
                            zeroRecords: "Không tìm thấy kết quả phù hợp",
                            emptyTable: "Không có dữ liệu trong bảng",
                            paginate: {
                                previous: "<i class='ri-arrow-left-s-line'></i>",
                                next: "<i class='ri-arrow-right-s-line'></i>"
                            },
                            loadingRecords: "Đang tải dữ liệu...",
                            processing: "Đang xử lý...",
                            infoFiltered: "(lọc từ tổng _MAX_ dòng)"
                        },
                        drawCallback: function () {
                            $(".dataTables_paginate > .pagination").addClass("pagination-rounded");
                        }
                    });
                } else {
                    $('#scroll-horizontal-datatable').DataTable().ajax.reload();
                }
            });

        </script>


    </body>

</html>