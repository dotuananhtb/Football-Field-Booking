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
                                                <th>STT</th>
                                                <th>Mã đặt ca(BDC)</th>                                             
                                                <th>Ngày đá</th>
                                                <th>Khung giờ</th>
                                                <th>Sân</th>
                                                <th>Loại sân</th>
                                                <th>Trạng thái</th>
                                                <th>Người đặt</th>
                                                <th>SĐT</th>
                                                <th>Email</th>
                                                <th>Ngày đặt</th>
                                                <th>Giá</th>
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
                const tableId = '#scroll-horizontal-datatable';

                if (!$.fn.DataTable.isDataTable(tableId)) {
                    $(tableId).DataTable({
                        scrollX: true,
                        ajax: {
                            url: '/FB_N1/checking-slots2',
                            dataSrc: ''
                        },
                        columns: [
                            {
                                data: null,
                                title: 'STT',
                                render: function (data, type, row, meta) {
                                    return meta.row + 1;
                                }
                            },
                            {
                                data: 'extendedProps.booking_details_code',
                                title: 'Mã đặt ca(BDC)',
                                defaultContent: '-'
                            },

                            {
                                data: 'extendedProps.slot_date',
                                title: 'Ngày đá',
                                defaultContent: '-'
                            },
                            {
                                data: null,
                                title: 'Khung giờ',
                                render: function (data, type, row) {
                                    const ep = row.extendedProps || {};
                                    return (ep.start_time || '-') + ' - ' + (ep.end_time || '-');
                                }
                            },
                            {
                                data: 'extendedProps.field_name',
                                title: 'Sân',
                                defaultContent: '-'
                            },
                            {
                                data: 'extendedProps.field_type_name',
                                title: 'Loại sân',
                                defaultContent: '-'
                            },
                            {
                                data: 'extendedProps.status',
                                title: 'Trạng thái',
                                render: function (data) {
                                    if (data === 1)
                                        return '<span class="badge bg-success">Đã đặt</span>';
                                    if (data === 2)
                                        return '<span class="badge bg-warning text-dark">Chờ xử lý</span>';
                                    if (data === 3)
                                        return '<span class="badge bg-danger">Đã huỷ</span>';
                                    return '<span class="badge bg-secondary">Không xác định</span>';
                                }
                            },
                            {
                                data: 'extendedProps.userInfo.name',
                                title: 'Người đặt',
                                defaultContent: '-'
                            },
                            {
                                data: 'extendedProps.userInfo.phone',
                                title: 'SĐT',
                                defaultContent: '-'
                            },
                            {
                                data: 'extendedProps.userInfo.email',
                                title: 'Email',
                                defaultContent: '-'
                            },
                            {
                                data: 'extendedProps.booking_date',
                                title: 'Ngày đặt',
                                defaultContent: '-'
                            },
                            {
                                data: 'extendedProps.price',
                                title: 'Giá',
                                render: function (data) {
                                    return data != null ? $.fn.dataTable.render.number(',', '.', 0, '', ' đ').display(data) : '-';
                                }
                            },
                            {
                                data: 'extendedProps.note',
                                title: 'Ghi chú',
                                defaultContent: '-'
                            }
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
                    $(tableId).DataTable().ajax.reload();
                }
            });
        </script>







    </body>

</html>