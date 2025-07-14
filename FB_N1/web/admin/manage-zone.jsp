<%-- 
    Document   : manage-user
    Created on : Jun 16, 2025, 10:44:10 AM
    Author     : VAN NGUYEN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Datatables | Powerx - Bootstrap 5 Admin & Dashboard Template</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
        <meta content="Coderthemes" name="author" />

        <!-- App favicon -->
        <link rel="shortcut icon" href="assets/images/favicon.ico">

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

        <!-- App favicon -->
        <%@include file="head_only.jsp" %>

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
                                    <h4 class="page-title">Quản lí Khu Vực</h4>
                                </div>
                            </div>
                        </div>
                        <!-- end page title -->

                        <div class="row g-4">
                            <div class="d-flex flex-wrap gap-2">

                                <button type="button" class="btn btn-info" data-bs-toggle="modal" data-bs-target="#bs-example-modal-lg">Tạo Mới</button>


                            </div>

                            <div class="col-12">
                                <div class="mb-4">



                                    <table id="scroll-horizontal-datatable" class="table table-striped w-100 nowrap">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Tên Khu Vực</th>
                                                <th>Địa Chỉ</th>
                                                <th></th>

                                            </tr>
                                        </thead>


                                        <tbody>
                                            <c:forEach var="listzone" items="${listZone}">
                                                <tr>
                                                    <td>${listzone.zoneId} </td>
                                                    <td>${listzone.zone_name}</td>
                                                    <td>${listzone.address}</td>
                                                    <td><a href="${pageContext.request.contextPath}/admin/quan-li-khu-vuc?zone_id=${listzone.zoneId}"
                                                           type="button" class="btn btn-info"  data-bs-target="#bs-example-modal-lg-2">Sửa</a>
                                                        <input type="hidden" name="zone_id" value="${listzone.zoneId}" />
                                                    </td>




                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>

                                </div> <!-- end card -->
                            </div><!-- end col-->
                        </div>





                        <div class="modal fade" id="bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-lg">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h4 class="modal-title" id="myLargeModalLabel">Tạo Mới Khu Vực</h4>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <div class="row g-4">
                                            <div class="col-12">
                                                <div class="mb-4">



                                                    <form action="${pageContext.request.contextPath}/admin/them-khu-vuc" method="post">
                                                        <div class="row g-2">
                                                            <div class="mb-3 col-md-6">
                                                                <label for="inputEmai6" class="form-label">Tên Khu Vực</label>
                                                                <input type="text" name="zone_name" class="form-control" id="inputEmail6" placeholder="Tên Khu Vực" required>
                                                            </div>
                                                            <div class="mb-3 col-md-6">
                                                                <label for="inputPassword5" class="form-label">Địa Chỉ</label>
                                                                <input type="text" name ="address" class="form-control" id="inputPassword5" placeholder="Địa Chỉ" required>
                                                            </div>
                                                        </div>
                                                        <button type="submit" class="btn btn-primary">Tạo Khu Vực</button>
                                                    </form>

                                                </div> <!-- end card-->
                                            </div> <!-- end col -->
                                        </div>
                                    </div>
                                </div><!-- /.modal-content -->
                            </div><!-- /.modal-dialog -->
                        </div><!-- /.modal -->


                        <div class="modal fade" id="bs-example-modal-lg-2" tabindex="-1" aria-hidden="true">
                            <div class="modal-dialog modal-lg">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Sửa Khu Vực</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                    </div>
                                    <div class="modal-body">
                                        <form action="${pageContext.request.contextPath}/admin/quan-li-khu-vuc" method="post">
                                            <input type="hidden" name="zone_id" id="modal-zone-id" />
                                            <div class="mb-3">
                                                <label>Tên Khu Vực</label>
                                                <input type="text" class="form-control" name="zone_name" id="modal-zone-name" required />
                                            </div>
                                            <div class="mb-3">
                                                <label>Địa Chỉ</label>
                                                <input type="text" class="form-control" name="address" id="modal-zone-address" required />
                                            </div>
                                            <button type="submit" class="btn btn-primary">Lưu</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>


































                    </div> <!-- container -->

                </div> <!-- content -->
                <%@include file="footer.jsp" %>
                <!-- Footer Start -->

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
        <c:if test="${not empty zone}">
            <script>
                window.addEventListener("load", function () {
                    const myModal = new bootstrap.Modal(document.getElementById('bs-example-modal-lg-2'));
                    document.getElementById('modal-zone-id').value = "${zone.zoneId}";
                    document.getElementById('modal-zone-name').value = "${zone.zone_name}";
                    document.getElementById('modal-zone-address').value = "${zone.address}";
                    myModal.show();
                });
            </script>
        </c:if>

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


        <script src="assets/js/pages/demo.datatable-init.js"></script>


        <script src="assets/js/app.min.js"></script>

    </body>

</html>
