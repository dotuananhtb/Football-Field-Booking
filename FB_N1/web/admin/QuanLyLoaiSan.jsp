<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <title>FootballStar | Admin - Quản lý loại sân bóng</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
        <meta content="Coderthemes" name="author" />

        <!-- App favicon -->
        <link rel="shortcut icon" href="assets/images/favicon.ico">

        <!-- Theme Config Js -->
        <script src="assets/js/config.js"></script>

        <!-- App css -->
        <link href="assets/css/app.min.css" rel="stylesheet" type="text/css" id="app-style" />

        <!-- Icons css -->
        <link href="assets/css/icons.min.css" rel="stylesheet" type="text/css" />
        <%@include file="head_only.jsp" %>
    </head>
    <body>
        <!-- Begin page -->
        <div class="wrapper">


            <!-- ========== Topbar Start ========== -->
            <jsp:include page="topbar.jsp" />

            <!-- ========== Topbar End ========== -->

            <!-- ========== Left Sidebar Start ========== -->
            <jsp:include page="left_sidebar.jsp" />
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
                                        <ol class="breadcrumb m-0">
                                            <li class="breadcrumb-item"><a href="javascript: void(0);">Quản lý Sân</a>
                                            </li>
                                            <li class="breadcrumb-item active">Quản Lý loại Sân Bóng</li>
                                        </ol>
                                    </div>
                                    <h4 class="page-title">Quản Lý loại Sân Bóng</h4>
                                </div>
                            </div>
                        </div>
                        <div class="row g-4">

                            <form method="post" action="${pageContext.request.contextPath}/admin/quan-ly-loai-san"
                                  style="max-width: 600px; background: #f9f9f9; padding: 20px; border-radius: 10px;">
                                <input type="hidden" name="action" value="${type != null ? 'update' : 'add'}" />
                                <c:if test="${type != null}">
                                    <input type="hidden" name="field_type_id" value="${type.fieldTypeId}" />
                                </c:if>

                                <div class="mb-3">
                                    <label for="fieldTypeName" class="form-label">Tên loại sân</label>
                                    <input type="text" name="field_type_name" id="fieldTypeName"
                                           class="form-control" required placeholder="Nhập tên loại sân"
                                           value="${type != null ? type.fieldTypeName : ''}" />
                                </div>

                                <div class="mt-3">
                                    <button type="submit" class="btn btn-primary">
                                        ${type != null ? ' Cập nhật' : 'Thêm'}
                                    </button>
                                    <c:if test="${type != null}">
                                        <a href="${pageContext.request.contextPath}/admin/quan-ly-loai-san"
                                           class="btn btn-secondary ms-2"> Huỷ</a>
                                    </c:if>
                                </div>
                            </form>


                            <div class="col-8">
                                <div>
                                    <h2>Danh sách Loại Sân</h2>

                                    <!-- DANH SÁCH LOẠI SÂN -->
                                    <table class="table table-bordered table-striped table-custom">
                                        <colgroup>
                                            <col style="width: 80%">
                                            <col style="width: 20%">
                                        </colgroup>
                                        <thead class="table-light">
                                            <tr>
                                                <th class="text-start">Tên Loại Sân</th>
                                                <th class="text-center">Hành động</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="t" items="${types}">
                                                <tr>
                                                    <td>${t.fieldTypeName}</td>
                                                    <td class="text-center">
                                                        <a class="btn btn-sm btn-warning me-1"
                                                           href="${pageContext.request.contextPath}/admin/quan-ly-loai-san?editId=${t.fieldTypeId}">Sửa</a>
                                                        <form method="post" action="${pageContext.request.contextPath}/admin/quan-ly-loai-san" style="display:inline;">
                                                            <input type="hidden" name="action" value="delete" />
                                                            <input type="hidden" name="field_type_id" value="${t.fieldTypeId}" />
                                                            <button type="submit" class="btn btn-sm btn-danger" onclick="return confirm('Xác nhận xoá?')">Xoá</button>
                                                        </form>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>

                                </div> <!-- end card -->
                            </div><!-- end col-->

                        </div> <!-- container -->

                    </div> <!-- content -->


                </div>

                <!-- ============================================================== -->
                <!-- End Page content -->
                <!-- ============================================================== -->

            </div>
            <!-- END wrapper -->
            <%@include file="footer.jsp" %>

            <!-- Vendor js -->
            <script src="assets/js/vendor.min.js"></script>
            <!-- App js -->
            <script src="assets/js/app.min.js"></script>
    </body>

</html>
