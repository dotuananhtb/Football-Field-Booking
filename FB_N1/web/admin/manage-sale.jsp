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
        <title>FootBallStar - Quản Lý Ưu Đãi</title>
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
                                    <h4 class="page-title">Quản Lý Ưu Đãi</h4>
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
                                                <th>Tên ưu đãi</th>
                                                <th>Phần Trăm Ưu Đãi</th>
                                                <th>Số Ca tối thiểu</th>
                                                <th>Mô tả</th>
                                                <th></th>
                                                <th></th>

                                            </tr>
                                        </thead>


                                        <tbody>
                                            <c:forEach var="listSale" items="${listSale}">
                                                <tr>
                                                    <td>${listSale.saleId} </td>
                                                    <td>${listSale.sale_name}</td>
                                                    <td>${listSale.salePercent}</td>
                                                    <td>${listSale.minSlot}</td>
                                                    
                                                    <td>${listSale.description}</td>
                                                    <td><a href="${pageContext.request.contextPath}/admin/quan-li-uu-dai?saleId=${listSale.saleId}"
                                                           type="button" class="btn btn-info"  data-bs-target="#bs-example-modal-lg-2">Sửa</a>
                                                        <input type="hidden" name="saleId" value="${listSale.saleId}" />
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${listSale.saleId == currentSaleId}">
                                                                <button class="btn btn-danger btn-unselect-sale" data-sale-id="${listSale.saleId}">
                                                                    Hủy chọn
                                                                </button>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <button class="btn btn-success btn-select-sale" data-sale-id="${listSale.saleId}">
                                                                    Chọn
                                                                </button>
                                                            </c:otherwise>
                                                        </c:choose>


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
                                        <h4 class="modal-title" id="myLargeModalLabel">Tạo Mới Ưu đãi</h4>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <div class="row g-4">
                                            <div class="col-12">
                                                <div class="mb-4">



                                                    <form action="${pageContext.request.contextPath}/admin/them-uu-dai" method="post">
                                                        <div class="row g-2">
                                                            <div class="mb-3 col-md-6">
                                                                <label for="inputEmai6" class="form-label">Tên ưu đãi</label>
                                                                <input type="text" name="name" class="form-control" id="inputEmail6" placeholder="Tên ưu đãi" required>
                                                            </div>
                                                            <div class="mb-3 col-md-6">
                                                                <label for="inputEmai6" class="form-label">Phần Trăm Ưu Đãi</label>
                                                                <input type="text" name="salePercent" class="form-control" id="inputEmail6" placeholder="Phần Trăm Ưu Đãi" required>
                                                            </div>
                                                            
                                                            <div class="mb-3 col-md-6">
                                                                <label for="inputPassword5" class="form-label">Số Ca tối thiểu</label>
                                                                <input type="text" name ="minSlot" class="form-control" id="inputPassword5" placeholder="Số Ca tối thiểu" required>
                                                            </div>
                                                            
                                                            <div class="mb-3 col-md-6">
                                                                <label for="inputEmai6" class="form-label">Mô tả</label>
                                                                <input type="text" name="description" class="form-control" id="inputEmail6" placeholder="Mô tả" required>
                                                            </div>

                                                        </div>
                                                        <button type="submit" class="btn btn-primary">Tạo mới</button>
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
                                        <h5 class="modal-title">Sửa Ưu Đãi</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                    </div>
                                    <div class="modal-body">
                                        <form action="${pageContext.request.contextPath}/admin/quan-li-uu-dai" method="post">
                                            <input type="hidden" name="saleId" id="modal-sale-id" />
                                            <div class="mb-3 col-md-6">
                                                <label >Tên ưu đãi</label>
                                                <input type="text" name="name" class="form-control" id="modal-sale-name" placeholder=" Tên ưu đãi" required>
                                            </div>
                                            <div class="mb-3 col-md-6">
                                                
                                                <label >Phần Trăm Ưu Đãi</label>
                                                <input type="text" name="salePercent" class="form-control" id="modal-sale-percent" placeholder="Phần Trăm Ưu Đãi" required>
                                            </div>
                                            <div class="mb-3 col-md-6">
                                                <label >Số Ca tối thiểu</label>
                                                <input type="text" name ="minSlot" class="form-control" id="modal-sale-minSlot" placeholder="Số Ca tối thiểu" required>
                                            </div>
                                            
                                            <div class="mb-3 col-md-6">
                                                <label >Mô tả</label>
                                                <input type="text" name="description" class="form-control" id="modal-sale-description" placeholder="Mô tả" required>
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
        <c:if test="${not empty sale}">
            <script>
                window.addEventListener("load", function () {
                    const myModal = new bootstrap.Modal(document.getElementById('bs-example-modal-lg-2'));
                    document.getElementById('modal-sale-id').value = "${sale.saleId}";
                    document.getElementById('modal-sale-percent').value = "${sale.salePercent}";
                    document.getElementById('modal-sale-minSlot').value = "${sale.minSlot}";
                    document.getElementById('modal-sale-name').value = "${sale.sale_name}";
                    document.getElementById('modal-sale-description').value = "${sale.description}";
                    myModal.show();
                });
            </script>
        </c:if>

        <script>
            document.addEventListener("DOMContentLoaded", function () {

                // Cập nhật toàn bộ giao diện nút dựa vào ưu đãi đang chọn
                function updateButtons(selectedId) {
                    document.querySelectorAll("button[data-sale-id]").forEach(btn => {
                        const saleId = btn.getAttribute("data-sale-id");

                        // Clone để gỡ mọi listener cũ
                        const newBtn = btn.cloneNode(true);

                        if (saleId === selectedId) {
                            newBtn.classList.remove("btn-success", "btn-select-sale");
                            newBtn.classList.add("btn-danger", "btn-unselect-sale");
                            newBtn.textContent = "Hủy chọn";
                            newBtn.addEventListener("click", () => handleUnselect(newBtn));
                        } else {
                            newBtn.classList.remove("btn-danger", "btn-unselect-sale");
                            newBtn.classList.add("btn-success", "btn-select-sale");
                            newBtn.textContent = "Chọn";
                            newBtn.addEventListener("click", () => handleSelect(newBtn));
                        }

                        btn.replaceWith(newBtn);
                    });
                }

                // Xử lý chọn ưu đãi
                function handleSelect(btn) {
                    const saleId = btn.getAttribute("data-sale-id");

                    fetch("${pageContext.request.contextPath}/admin/luu-uu-dai", {
                        method: "POST",
                        headers: {
                            "Content-Type": "application/x-www-form-urlencoded"
                        },
                        body: "saleId=" + encodeURIComponent(saleId)
                    }).then(res => {
                        if (res.ok) {
                            updateButtons(saleId);
                        } else {
                            alert("Không thể chọn ưu đãi!");
                        }
                    });
                }


                // Xử lý hủy chọn
                function handleUnselect(btn) {
                    fetch("${pageContext.request.contextPath}/admin/huy-uu-dai", {
                        method: "POST"
                    }).then(res => {
                        if (res.ok) {
                            updateButtons(null); // Reset về trạng thái chưa chọn
                        } else {
                            alert("Không thể hủy chọn ưu đãi!");
                        }
                    });
                }


                // Gán lần đầu cho tất cả các nút
                document.querySelectorAll(".btn-select-sale").forEach(btn => {
                    btn.addEventListener("click", () => handleSelect(btn));
                });

                document.querySelectorAll(".btn-unselect-sale").forEach(btn => {
                    btn.addEventListener("click", () => handleUnselect(btn));
                });
            });
        </script>




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
