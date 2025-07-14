
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>FootballStar | Admin - Quản lý sân bóng</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc."
              name="description" />
        <meta content="Coderthemes" name="author" />

        <!-- App favicon -->
        <link rel="shortcut icon" href="assets/images/favicon.ico">

        <!-- Datatables css -->
        <link href="assets/vendor/datatables.net-bs5/css/dataTables.bootstrap5.min.css" rel="stylesheet"
              type="text/css" />
        <link href="assets/vendor/datatables.net-responsive-bs5/css/responsive.bootstrap5.min.css"
              rel="stylesheet" type="text/css" />
        <link href="assets/vendor/datatables.net-fixedcolumns-bs5/css/fixedColumns.bootstrap5.min.css"
              rel="stylesheet" type="text/css" />
        <link href="assets/vendor/datatables.net-fixedheader-bs5/css/fixedHeader.bootstrap5.min.css"
              rel="stylesheet" type="text/css" />
        <link href="assets/vendor/datatables.net-buttons-bs5/css/buttons.bootstrap5.min.css"
              rel="stylesheet" type="text/css" />
        <link href="assets/vendor/datatables.net-select-bs5/css/select.bootstrap5.min.css" rel="stylesheet"
              type="text/css" />

        <!-- Theme Config Js -->
        <script src="assets/js/config.js"></script>

        <!-- App css -->
        <link href="assets/css/app.min.css" rel="stylesheet" type="text/css" id="app-style" />

        <!-- Icons css -->
        <link href="assets/css/icons.min.css" rel="stylesheet" type="text/css" />

        <!-- App favicon -->
        <%@include file="head_only.jsp" %>

    </head>
    <style>
        select#status {
            display: block !important;
        }
    </style>

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
                                            <li class="breadcrumb-item active">Quản lý Sân Bóng</li>
                                        </ol>
                                    </div>
                                    <h4 class="page-title">Quản Lý Sân Bóng</h4>
                                </div>
                            </div>
                        </div>
                        <!-- end page title -->

                        <div class="row g-4">
                            <div class="d-flex flex-wrap gap-2">

                                <button type="button" class="btn btn-info" data-bs-toggle="modal"
                                        data-bs-target="#bs-example-modal-lg" onclick="resetFieldForm()">Tạo Mới</button>


                            </div>

                            <div class="col-12">
                                <div class="mb-4">



                                    <h2>Danh sách sân bóng</h2>

                                    <table id="field-table" class="table table-striped w-100 nowrap">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Tên sân</th>
                                                <th>Ảnh</th>
                                                <th>Khu vực</th>
                                                <th>Địa điểm</th>
                                                <th>Loại sân</th>
                                                <th>Trạng thái</th>
                                                <th>Mô tả</th>
                                                <th>Hành động</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="f" items="${fields}">
                                                <tr>
                                                    <td>${f.fieldId}</td>
                                                    <td>${f.fieldName}</td>
                                                    <td><img src="${f.image}" alt="Ảnh sân" width="80"
                                                             height="60" /></td>
                                                    <td>${f.zone.zone_name}</td>
                                                    <td>${f.zone.address}</td>
                                                    <td>${f.typeOfField.fieldTypeName}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${f.status == 'Hoạt động'}">
                                                                <span class="badge bg-success">Hoạt
                                                                    động</span>
                                                                </c:when>
                                                                <c:when test="${f.status == 'Hỏng'}">
                                                                <span class="badge bg-danger">Ngừng hoạt
                                                                    động</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                <span class="badge bg-secondary">Không
                                                                    rõ</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                    </td>
                                                    <td>${f.description}</td>
                                                    <td>
                                                        <button class="btn btn-sm btn-outline-primary editFieldBtn"
                                                                data-id="${f.fieldId}"
                                                                data-name="${f.fieldName}"
                                                                data-image="${f.image}"
                                                                data-type="${f.typeOfField.fieldTypeId}"
                                                                data-zone="${f.zone.zoneId}"
                                                                data-status="${f.status}"
                                                                data-description="${f.description}">
                                                            <i class="ri-edit-2-line"></i> Sửa
                                                        </button>

                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>


                                </div> <!-- end card -->
                            </div><!-- end col-->
                        </div>





                        <div class="modal fade" id="bs-example-modal-lg" tabindex="-1" role="dialog"
                             aria-labelledby="myLargeModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-lg">
                                <div class="modal-content">
                                    <form method="post"
                                          action="${pageContext.request.contextPath}/admin/Admin_San">
                                        <div class="modal-header">
                                            <h4 class="modal-title" id="sanModalLabel"> Thêm / Cập nhật sân
                                                bóng</h4>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                    aria-label="Đóng"></button>
                                        </div>

                                        <div class="modal-body">
                                            <input type="hidden" name="action" value="add"
                                                   id="formAction" />
                                            <input type="hidden" name="field_id" id="fieldId" />

                                            <div class="row g-3">
                                                <!-- Tên sân -->
                                                <div class="col-md-6">
                                                    <label for="fieldName" class="form-label">Tên
                                                        sân:</label>
                                                    <input type="text" name="field_name" id="fieldName"
                                                           class="form-control" required />
                                                </div>

                                                <!-- Ảnh -->
                                                <div class="col-md-6">
                                                    <label for="fieldImage" class="form-label">Ảnh (link
                                                        hoặc tên file):</label>
                                                    <input type="text" name="image" id="fieldImage"
                                                           class="form-control" />
                                                </div>

                                                <!-- Loại sân -->
                                                <div class="col-md-6">
                                                    <label for="typeId" class="form-label">Loại sân:</label>
                                                    <select name="type_id" id="typeId" class="form-select"
                                                            required>
                                                        <option value="">-- Chọn loại sân --</option>
                                                        <c:forEach var="type" items="${types}">
                                                            <option value="${type.fieldTypeId}">
                                                                ${type.fieldTypeName}</option>
                                                            </c:forEach>
                                                    </select>
                                                </div>

                                                <!-- Khu vực -->
                                                <div class="col-md-6">
                                                    <label for="zoneId" class="form-label">Khu vực:</label>
                                                    <select name="zone_id" id="zoneId" class="form-select"
                                                            required>
                                                        <option value="">-- Chọn khu vực --</option>
                                                        <c:forEach var="z" items="${zones}">
                                                            <option value="${z.zoneId}">${z.zone_name}
                                                            </option>
                                                        </c:forEach>
                                                    </select>
                                                </div>

                                                <!-- Trạng thái -->
                                                <div class="col-md-6">
                                                    <label for="status" class="form-label">Trạng
                                                        thái:</label>
                                                    <select name="status" id="fieldstatus" class="form-select">
                                                        <option value="Hoạt động">Hoạt động</option>
                                                        <option value="Bảo trì">Bảo trì</option>
                                                        <option value="Hỏng">Hỏng</option>
                                                    </select>
                                                </div>

                                                <!-- Mô tả -->
                                                <div class="col-md-12">
                                                    <label for="description" class="form-label">Mô
                                                        tả:</label>
                                                    <textarea name="description" id="description" rows="3"
                                                              class="form-control"></textarea>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="modal-footer">
                                            <button type="button" id="btnCancel" class="btn btn-secondary" data-bs-dismiss="modal">Huỷ</button>
                                            <button type="submit" id="btnAdd" class="btn btn-primary">Thêm
                                                sân</button>
                                            <button type="submit" id="btnUpdate" class="btn btn-warning"
                                                    style="display:none;">Cập nhật sân</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div><!-- /.modal -->
































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

        <!-- Datatables js -->
        <script src="assets/vendor/datatables.net/js/jquery.dataTables.min.js"></script>
        <script src="assets/vendor/datatables.net-bs5/js/dataTables.bootstrap5.min.js"></script>
        <script src="assets/vendor/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
        <script
        src="assets/vendor/datatables.net-responsive-bs5/js/responsive.bootstrap5.min.js"></script>
        <script
        src="assets/vendor/datatables.net-fixedcolumns-bs5/js/fixedColumns.bootstrap5.min.js"></script>
        <script
        src="assets/vendor/datatables.net-fixedheader/js/dataTables.fixedHeader.min.js"></script>
        <script src="assets/vendor/datatables.net-buttons/js/dataTables.buttons.min.js"></script>
        <script src="assets/vendor/datatables.net-buttons-bs5/js/buttons.bootstrap5.min.js"></script>
        <script src="assets/vendor/datatables.net-buttons/js/buttons.html5.min.js"></script>
        <script src="assets/vendor/datatables.net-buttons/js/buttons.flash.min.js"></script>
        <script src="assets/vendor/datatables.net-buttons/js/buttons.print.min.js"></script>
        <script src="assets/vendor/datatables.net-keytable/js/dataTables.keyTable.min.js"></script>
        <script src="assets/vendor/datatables.net-select/js/dataTables.select.min.js"></script>


        <script src="assets/js/pages/demo.datatable-init.js"></script>


        <script src="assets/js/app.min.js"></script>
        <script>
                                            function editField(id, name, image, typeId, zoneId, status, description) {
                                                document.getElementById("formAction").value = "update";
                                                document.getElementById("fieldId").value = id;
                                                document.getElementById("fieldName").value = name;
                                                document.getElementById("fieldImage").value = image;
                                                document.getElementById("typeId").value = typeId;
                                                document.getElementById("zoneId").value = zoneId;

                                                // Đảm bảo status khớp với option trong <select>
                                                document.getElementById("fieldstatus").value = status.trim();

                                                document.getElementById("description").value = description;

                                                // Chuyển sang chế độ cập nhật
                                                document.getElementById("btnAdd").style.display = "none";
                                                document.getElementById("btnUpdate").style.display = "inline-block";
                                                document.getElementById("btnCancel").style.display = "inline-block";
                                                window.scrollTo({top: 0, behavior: 'smooth'});
                                                
                                                const modal = new bootstrap.Modal(document.getElementById("bs-example-modal-lg"));
                                                modal.show();
                                            }

                                            function cancelEdit() {
                                                document.getElementById("formAction").value = "add";
                                                document.getElementById("fieldId").value = "";
                                                document.getElementById("fieldName").value = "";
                                                document.getElementById("fieldImage").value = "";
                                                document.getElementById("typeId").selectedIndex = 0;
                                                document.getElementById("zoneId").selectedIndex = 0;
                                                document.getElementById("fieldstatus").selectedIndex = 0;
                                                document.getElementById("description").value = "";

                                                // Chuyển về chế độ thêm mới
                                                document.getElementById("btnAdd").style.display = "inline-block";
                                                document.getElementById("btnUpdate").style.display = "none";
                                                document.getElementById("btnCancel").style.display = "none";

                                            }
        </script>
        <script>
            function resetFieldForm() {
                document.getElementById("formAction").value = "add";
                document.getElementById("fieldId").value = "";
                document.getElementById("fieldName").value = "";
                document.getElementById("fieldImage").value = "";
                document.getElementById("typeId").selectedIndex = 0;
                document.getElementById("zoneId").selectedIndex = 0;
                document.getElementById("fieldstatus").selectedIndex = 0;
                document.getElementById("description").value = "";

                document.getElementById("btnAdd").style.display = "inline-block";
                document.getElementById("btnUpdate").style.display = "none";
                document.getElementById("btnCancel").style.display = "none";
            }

            document.addEventListener("DOMContentLoaded", function () {
                document.querySelectorAll(".editFieldBtn").forEach(function (btn) {
                    btn.addEventListener("click", function () {
                        const id = this.dataset.id;
                        const name = this.dataset.name;
                        const image = this.dataset.image;
                        const typeId = this.dataset.type;
                        const zoneId = this.dataset.zone;
                        const status = this.dataset.status;
                        const description = this.dataset.description;

                        editField(id, name, image, typeId, zoneId, status, description);
                    });
                });
            });
        </script>



    </body>

</html>