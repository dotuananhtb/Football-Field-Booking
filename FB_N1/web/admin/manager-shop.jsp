<%-- 
    Document   : ManagerProduct
    Created on : 15 thg 6, 2025, 20:29:41
    Author     : Asus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Quản lý Sản phẩm | Powerx - Bootstrap 5 Admin & Dashboard Template</title>
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
                                        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addProductModal">
                                            <i class="ri-add-line"></i> Thêm Sản phẩm Mới
                                        </button>
                                    </div>
                                    <h4 class="page-title">Quản lý Sản phẩm</h4>
                                </div>
                            </div>
                        </div>
                        <!-- end page title -->

                        <!-- Search and Filter Section -->
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <form action="${pageContext.request.contextPath}/admin/manager-product" method="GET" class="d-flex">
                                    <input type="hidden" name="action" value="search">
                                    <input type="text" name="search" class="form-control me-2" placeholder="Tìm kiếm sản phẩm..." value="${searchKeyword}">
                                    <button type="submit" class="btn btn-outline-primary">Tìm kiếm</button>
                                </form>
                            </div>
                            <div class="col-md-6">
                                <form action="${pageContext.request.contextPath}/admin/manager-product" method="GET" class="d-flex">
                                    <input type="hidden" name="action" value="filter">
                                    <select name="categoryId" class="form-select me-2">
                                        <option value="">Tất cả danh mục</option>
                                        <c:forEach var="category" items="${categories}">
                                            <option value="${category.productCateId}" ${selectedCategory eq category.productCateId ? 'selected' : ''}>
                                                ${category.cateName}
                                            </option>
                                        </c:forEach>
                                    </select>
                                    <input type="number" name="minPrice" class="form-control me-2" placeholder="Giá từ" value="${param.minPrice}">
                                    <input type="number" name="maxPrice" class="form-control me-2" placeholder="Đến" value="${param.maxPrice}">
                                    <button type="submit" class="btn btn-outline-secondary">Lọc</button>
                                </form>
                            </div>
                        </div>

                        <div class="row g-4">
                            <div class="col-12">
                                <div class="mb-4">
                                    <h4 class="fs-16">Danh sách Sản phẩm</h4>
                                    <p class="text-muted fs-14">Quản lý thông tin các sản phẩm trong hệ thống</p>

                                    <table id="scroll-horizontal-datatable" class="table table-striped w-100 nowrap">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Sản phẩm</th>
                                                <th>Danh mục</th>
                                                <th>Giá</th>
                                                <th>Mô tả</th>
                                                <th>Trạng thái</th>
                                                <th>Hành động</th>
                                            </tr>
                                        </thead>

                                        <tbody>
                                            <c:forEach var="product" items="${products}">
                                                <tr>
                                                    <td>${product.productId}</td>
                                                    <td>
                                                        <div class="d-flex align-items-center">
                                                            <c:if test="${not empty product.productImage}">
                                                                <img src="${product.productImage}" alt="${product.productName}" class="rounded me-2" width="40" height="40">
                                                            </c:if>
                                                            <span>${product.productName}</span>
                                                        </div>
                                                    </td>
                                                    <td>${product.cateProduct.cateName}</td>
                                                    <td>${product.productPrice}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${fn:length(product.productDescription) > 50}">
                                                                ${fn:substring(product.productDescription, 0, 50)}...
                                                            </c:when>
                                                            <c:otherwise>
                                                                ${product.productDescription}
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <span class="badge ${product.productStatus eq 'active' ? 'bg-success' : 'bg-danger'}">
                                                            ${product.productStatus eq 'active' ? 'Còn hàng' : 'Hết hàng'}
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <div class="btn-group" role="group">
                                                            <button type="button" class="btn btn-sm btn-outline-primary edit-product-btn"
                                                                    data-product-id="${product.productId}"
                                                                    data-product-name="${product.productName}"
                                                                    data-category-id="${product.productCateId}"
                                                                    data-product-price="${product.productPrice}"
                                                                    data-product-image="${product.productImage}"
                                                                    data-product-description="${product.productDescription}"
                                                                    data-product-status="${product.productStatus}">
                                                                <i class="ri-edit-line"></i>
                                                            </button>
                                                            <form action="${pageContext.request.contextPath}/admin/manager-product" method="POST" style="display:inline;">
                                                                <input type="hidden" name="action" value="toggleStatus">
                                                                <input type="hidden" name="productId" value="${product.productId}">
                                                                <input type="hidden" name="currentStatus" value="${product.productStatus}">
                                                                <button type="submit" class="btn btn-sm btn-outline-warning" onclick="return confirm('Xác nhận thay đổi trạng thái?')">
                                                                    <i class="ri-toggle-line"></i>
                                                                </button>
                                                            </form>
                                                            <form action="${pageContext.request.contextPath}/admin/manager-product" method="POST" style="display:inline;">
                                                                <input type="hidden" name="action" value="delete">
                                                                <input type="hidden" name="productId" value="${product.productId}">
                                                                <button type="submit" class="btn btn-sm btn-outline-danger" onclick="return confirm('Xác nhận xóa sản phẩm?')">
                                                                    <i class="ri-delete-bin-line"></i>
                                                                </button>
                                                            </form>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div> <!-- end card -->
                            </div><!-- end col-->
                        </div> <!-- end row-->

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

        <!-- Add Product Modal -->
        <div class="modal fade" id="addProductModal" tabindex="-1" aria-labelledby="addProductModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addProductModalLabel">Thêm Sản phẩm Mới</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/admin/manager-product" method="POST">
                        <input type="hidden" name="action" value="add">
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="productName" class="form-label">Tên Sản phẩm *</label>
                                        <input type="text" class="form-control" id="productName" name="productName" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="categoryId" class="form-label">Danh mục *</label>
                                        <select class="form-select" id="categoryId" name="categoryId" required>
                                            <option value="">Chọn danh mục</option>
                                            <c:forEach var="category" items="${categories}">
                                                <option value="${category.productCateId}">${category.cateName}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="productPrice" class="form-label">Giá *</label>
                                        <input type="number" step="0.01" class="form-control" id="productPrice" name="productPrice" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="productImage" class="form-label">URL Hình ảnh</label>
                                        <input type="url" class="form-control" id="productImage" name="productImage">
                                    </div>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="productDescription" class="form-label">Mô tả</label>
                                <textarea class="form-control" id="productDescription" name="productDescription" rows="3"></textarea>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                            <button type="submit" class="btn btn-primary">Thêm Sản phẩm</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Edit Product Modal -->
        <div class="modal fade" id="editProductModal" tabindex="-1" aria-labelledby="editProductModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editProductModalLabel">Chỉnh sửa Sản phẩm</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/admin/manager-product" method="POST">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="productId" id="editProductId">
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="editProductName" class="form-label">Tên Sản phẩm *</label>
                                        <input type="text" class="form-control" id="editProductName" name="productName" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="editCategoryId" class="form-label">Danh mục *</label>
                                        <select class="form-select" id="editCategoryId" name="categoryId" required>
                                            <option value="">Chọn danh mục</option>
                                            <c:forEach var="category" items="${categories}">
                                                <option value="${category.productCateId}">${category.cateName}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="mb-3">
                                        <label for="editProductPrice" class="form-label">Giá *</label>
                                        <input type="number" step="0.01" class="form-control" id="editProductPrice" name="productPrice" required>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="mb-3">
                                        <label for="editProductImage" class="form-label">URL Hình ảnh</label>
                                        <input type="url" class="form-control" id="editProductImage" name="productImage">
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="mb-3">
                                        <label for="editProductStatus" class="form-label">Trạng thái</label>
                                        <select class="form-select" id="editProductStatus" name="productStatus">
                                            <option value="active">Còn hàng</option>
                                            <option value="inactive">Hết hàng</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="editProductDescription" class="form-label">Mô tả</label>
                                <textarea class="form-control" id="editProductDescription" name="productDescription" rows="3"></textarea>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                            <button type="submit" class="btn btn-primary">Cập nhật</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Theme Settings -->
        <%@include file="themesetting.jsp" %>

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
        <script src="assets/js/jsBang.js"></script>

        <!-- App js -->
        <script src="assets/js/app.min.js"></script>

        <script>
            // Xử lý sự kiện click cho nút edit
            document.addEventListener('DOMContentLoaded', function() {
                document.querySelectorAll('.edit-product-btn').forEach(function(btn) {
                    btn.addEventListener('click', function() {
                        const productId = this.getAttribute('data-product-id');
                        const productName = this.getAttribute('data-product-name');
                        const categoryId = this.getAttribute('data-category-id');
                        const productPrice = this.getAttribute('data-product-price');
                        const productImage = this.getAttribute('data-product-image');
                        const productDescription = this.getAttribute('data-product-description');
                        const productStatus = this.getAttribute('data-product-status');
                        
                        editProduct(productId, productName, categoryId, productPrice, productImage, productDescription, productStatus);
                    });
                });
            });

            function editProduct(productId, productName, categoryId, productPrice, productImage, productDescription, productStatus) {
                document.getElementById('editProductId').value = productId;
                document.getElementById('editProductName').value = productName || '';
                document.getElementById('editCategoryId').value = categoryId || '';
                document.getElementById('editProductPrice').value = productPrice || '';
                document.getElementById('editProductImage').value = productImage || '';
                document.getElementById('editProductDescription').value = productDescription || '';
                document.getElementById('editProductStatus').value = productStatus || 'active';
                
                new bootstrap.Modal(document.getElementById('editProductModal')).show();
            }
        </script>
   
    </body>

</html>
