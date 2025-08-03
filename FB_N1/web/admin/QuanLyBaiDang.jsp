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
        <title>Quản Lý Tin Tức - FootBall Star</title>
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
                                    <h4 class="page-title">Quản Lý Tin Tức</h4>
                                </div>
                            </div>
                        </div>
                        <!-- end page title -->

                        <div class="row g-4">
                            <div class="d-flex flex-wrap gap-2">

                                <a type="button" href="/FB_N1/admin/tao-moi-bai-dang" class="btn btn-info" >Tạo Mới</a>


                            </div>

                            <div class="col-12">
                                <div class="mb-4">



                                    <table id="scroll-horizontal-datatable" class="table table-striped w-100 nowrap">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Tiêu đề</th>
                                                <th>Ngày tạo</th>
                                                <th>Ngày cập nhật</th>
                                                <th>Trạng Thái</th>
                                                <th></th>
                                            </tr>
                                        </thead>


                                        <tbody>
                                            <c:forEach var="c" items="${listB}">
                                                <tr>
                                                    <td>${c.blogId} </td>
                                                    <td>${c.title}</td>
                                                    <td>${c.createdAt}</td>
                                                    <td>${c.updatedAt}</td>
                                                    <td>
                                                        <div class="btn-group mb-2">
                                                            <c:if test="${c.statusBlogId  == 1}">
                                                                <button type="button" class="btn btn-success dropdown-toggle" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                                    Hoạt Động</button></c:if>
                                                                <c:if test="${c.statusBlogId   == 2}">
                                                                <button type="button" class="btn btn-danger dropdown-toggle" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                                    Ẩn</button></c:if>
                                                                
                                                                <div class="dropdown-menu">
                                                                <c:forEach items="${listS}" var="status">
                                                                    <form action="${pageContext.request.contextPath}/admin/quan-li-bai-dang" method="post" style="margin: 0;">
                                                                        <input type="hidden" name="sId" value="${status.status_id}" />
                                                                        <input type="hidden" name="bId" value="${c.blogId}" />
                                                                        <button type="submit" class="dropdown-item" style="border: none; background: none; padding: 8px 16px; width: 100%; text-align: left;">
                                                                            ${status.status_des}
                                                                        </button>
                                                                    </form>
                                                                </c:forEach>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td><a href="${pageContext.request.contextPath}/admin/sua-bai-dang?blogId=${c.blogId}"
                                                           type="button" class="btn btn-info"  >Sửa</a>
                                                        <input type="hidden" name="saleId" value="${c.blogId}" />
                                                    </td>




                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>

                                </div> <!-- end card -->
                            </div><!-- end col-->
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


        <script src="assets/js/jsBang.js"></script>


        <script src="assets/js/app.min.js"></script>

    </body>

</html>
