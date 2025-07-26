<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Quản Lí lịch các ca - FootBall Star</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
        <meta content="Coderthemes" name="author" />

        <!-- Theme Config Js -->
        <script src="assets/js/config.js"></script>

        <!-- App css -->
        <link href="assets/css/app.min.css" rel="stylesheet" type="text/css" id="app-style" />

        <!-- Icons css -->
        <link href="assets/css/icons.min.css" rel="stylesheet" type="text/css" />
        <%@include file="head_only.jsp" %>
    </head>
    <style>
        .grid-checkbox {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            /* 4 cột */
            gap: 10px;
        }

        .slot-item {
            display: flex;
            align-items: center;
            padding: 10px 14px;
            border: 1px solid #ccc;
            border-radius: 8px;
            background-color: #f8f9fa;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            user-select: none;
        }

        .slot-item:hover {
            background-color: #e2f0ff;
            box-shadow: 0 0 6px rgba(0, 123, 255, 0.3);
            transform: scale(1.01);
        }

        .slot-item input[type="checkbox"] {
            margin-right: 8px;
            transform: scale(1.2);
            cursor: pointer;
        }

        /* Khi checkbox được chọn thì label sáng màu lên */
        .slot-item input[type="checkbox"]:checked+span {
            color: #0d6efd;
            font-weight: bold;
        }

        /* Đổi màu nền label khi chọn */
        .slot-item input[type="checkbox"]:checked~* {
            background-color: #d0ebff;
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
                                            <li class="breadcrumb-item active">Quản Lý Các ca</li>
                                        </ol>
                                    </div>
                                    <h4 class="page-title">Quản Lý Các ca</h4>
                                </div>
                            </div>
                        </div>
                        <!-- end page title -->
                        <div class="row g-4">
                            <div class="d-flex flex-wrap gap-2">

                                <button type="button" class="btn btn-info" data-bs-toggle="modal"
                                        data-bs-target="#bs-example-modal-lg" onclick="resetSlotForm()">Tạo Slot Đơn</button>

                            </div>
                            <!-- Form Thêm nhiều Ca hiển thị trực tiếp ngoài giao diện -->
                            <div class="card p-4 mb-5">
                                <h4 class="mb-4">Tạo Nhiều Slot</h4>

                                <form method="post"
                                      action="${pageContext.request.contextPath}/admin/quan-ly-ca-theo-loai-san">
                                    <input type="hidden" name="action" value="checkbox_bulk_add" />

                                    <div class="row g-3">
                                        <!-- Chọn loại sân -->
                                        <div class="col-md-6">
                                            <label class="form-label">Chọn loại sân</label>
                                            <select name="field_type_id" class="form-select" required>
                                                <option value="">-- Chọn loại sân --</option>
                                                <c:forEach var="t" items="${types}">
                                                    <option value="${t.fieldTypeId}">${t.fieldTypeName}</option>
                                                </c:forEach>
                                            </select>
                                        </div>

                                        <!-- Chọn độ dài ca -->
                                        <div class="col-md-6">
                                            <label class="form-label">Chọn độ dài ca</label>
                                            <select id="durationSelector" class="form-select">
                                                <option value="60">1 tiếng</option>
                                                <option value="90">1 tiếng 30 phút</option>
                                                <option value="120">2 tiếng</option>
                                            </select>
                                        </div>

                                        <!-- Danh sách checkbox -->
                                        <div class="col-md-12">
                                            <label class="form-label"><strong>Chọn các khung giờ:</strong></label>
                                            <div id="slotContainer" class="grid-checkbox">
                                                <!-- Các checkbox slot sẽ render ở đây -->
                                            </div>
                                        </div>
                                    </div>

                                    <div class="mt-4">
                                        <button type="submit" class="btn btn-success">Thêm các ca đã chọn</button>
                                    </div>
                                </form>
                            </div>
                            <!-- Danh sách Slot theo loại sân -->
                            <h3 class="mb-4">Danh sách các ca</h3>
                            <c:forEach var="type" items="${types}">
                                <div class="col-xl-6">
                                    <div class="mb-4">
                                        <h3 class="text-muted fs-20 text-center mt-2">${type.fieldTypeName}</h3>

                                        <div class="table-responsive-sm mb-4">
                                            <table class="table table-bordered table-centered align-middle">
                                                <thead>
                                                    <tr>
                                                        <th>Bắt đầu</th>
                                                        <th>Kết thúc</th>
                                                        <th>Loại sân</th>
                                                        <th class="text-center">Hành động</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="s" items="${list}">
                                                        <c:if test="${s.fieldTypeId == type.fieldTypeId}">
                                                            <tr>
                                                                <td>${s.startTime}</td>
                                                                <td>${s.endTime}</td>
                                                                <td>${typeMap[s.fieldTypeId]}</td>
                                                                <td class="text-center">
                                                                    <!-- Nút sửa -->
                                                                    <a href="javascript:void(0);" class="editSlotBtn text-primary"
                                                                       data-id="${s.slotId}"
                                                                       data-start="${s.startTime}"
                                                                       data-end="${s.endTime}"
                                                                       data-type="${s.fieldTypeId}"
                                                                       title="Sửa">
                                                                        <i class="ri-edit-2-line"></i>
                                                                    </a>




                                                                    <!-- Nút xoá -->
                                                                    <form method="get"
                                                                          action="${pageContext.request.contextPath}/admin/quan-ly-ca-theo-loai-san"
                                                                          style="display:inline"
                                                                          onsubmit="return confirm('Bạn có chắc muốn xoá ca này?')">
                                                                        <input type="hidden" name="action"
                                                                               value="delete" />
                                                                        <input type="hidden" name="id"
                                                                               value="${s.slotId}" />
                                                                        <button type="submit"
                                                                                class="btn btn-link text-danger fs-16 px-1"
                                                                                title="Xoá"
                                                                                style="border: none; background: none; padding: 0;">
                                                                            <i class="ri-delete-bin-2-line"></i>
                                                                        </button>
                                                                    </form>
                                                                </td>
                                                            </tr>
                                                        </c:if>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>



                                    </div> <!-- end card -->
                                </div><!-- end col-->
                            </c:forEach>
                        </div>
                        <!-- end row-->

                        <div class="modal fade" id="bs-example-modal-lg" tabindex="-1" role="dialog"
                             aria-labelledby="myLargeModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-lg">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h4 class="modal-title" id="myLargeModalLabel">Tạo Mới Người Dùng</h4>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <div class="row g-4">
                                            <div class="col-12">
                                                <div class="mb-4">



                                                    <form id="slotForm" method="post" action="${pageContext.request.contextPath}/admin/quan-ly-ca-theo-loai-san">
                                                        <h3 id="modalTitle" class="mb-4">Thêm một Ca mới</h3>

                                                        <input type="hidden" name="action" id="formAction" value="add" />
                                                        <input type="hidden" name="id" id="slotId" />

                                                        <div class="row g-3">
                                                            <div class="col-md-6">
                                                                <label class="form-label">Giờ bắt đầu (HH:mm)</label>
                                                                <input type="text" name="start_time" id="startTime" class="form-control" required />
                                                            </div>
                                                            <div class="col-md-6">
                                                                <label class="form-label">Giờ kết thúc (HH:mm)</label>
                                                                <input type="text" name="end_time" id="endTime" class="form-control" required />
                                                            </div>
                                                            <div class="col-md-12">
                                                                <label class="form-label">Loại sân</label>
                                                                <select name="field_type_id" id="fieldTypeId" class="form-select" required>
                                                                    <option value="">-- Chọn loại sân --</option>
                                                                    <c:forEach var="t" items="${types}">
                                                                        <option value="${t.fieldTypeId}">${t.fieldTypeName}</option>
                                                                    </c:forEach>
                                                                </select>
                                                            </div>
                                                        </div>

                                                        <div class="mt-4">
                                                            <button type="submit" id="formSubmitBtn" class="btn btn-primary">Thêm</button>
                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Huỷ</button>
                                                        </div>
                                                    </form>




                                                </div> <!-- end card-->
                                            </div> <!-- end col -->
                                        </div>
                                    </div>
                                </div><!-- /.modal-content -->
                            </div><!-- /.modal-dialog -->
                        </div><!-- /.modal -->


                    </div> <!-- container -->

                </div> <!-- content -->
                <%@include file="footer.jsp" %>

            </div>

            <!-- ============================================================== -->
            <!-- End Page content -->
            <!-- ============================================================== -->

        </div>
        <!-- END wrapper -->

        <%@include file="themesetting.jsp" %>

        <!-- Vendor js -->
        <script src="assets/js/vendor.min.js"></script>
        <!-- App js -->
        <script src="assets/js/app.min.js"></script>
        <script>
                                                                              function resetSlotForm() {
                                                                                  document.getElementById("slotId").value = "";
                                                                                  document.getElementById("startTime").value = "";
                                                                                  document.getElementById("endTime").value = "";
                                                                                  document.getElementById("fieldTypeId").value = "";

                                                                                  document.getElementById("modalTitle").innerText = "Thêm một Ca mới";
                                                                                  document.getElementById("formAction").value = "add";
                                                                                  document.getElementById("formSubmitBtn").innerText = "Thêm";
                                                                              }
                                                                              document.getElementById("slotForm").addEventListener("submit", function (e) {
                                                                                  const startInput = this.querySelector("input[name='start_time']");
                                                                                  const endInput = this.querySelector("input[name='end_time']");

                                                                                  const formatTime = (timeStr) => {
                                                                                      let t = timeStr.trim();
                                                                                      if (!t.includes(":")) {
                                                                                          let h = parseInt(t);
                                                                                          return (h < 10 ? "0" + h : h) + ":00";
                                                                                      }
                                                                                      return t;
                                                                                  };

                                                                                  startInput.value = formatTime(startInput.value);
                                                                                  endInput.value = formatTime(endInput.value);
                                                                              });


        </script>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                // Lắng nghe tất cả các nút sửa
                document.querySelectorAll(".editSlotBtn").forEach(btn => {
                    btn.addEventListener("click", function () {
                        // Lấy dữ liệu từ data-*
                        const id = this.dataset.id;
                        const start = this.dataset.start;
                        const end = this.dataset.end;
                        const type = this.dataset.type;

                        // Gán vào form
                        document.getElementById("slotId").value = id;
                        document.getElementById("startTime").value = start;
                        document.getElementById("endTime").value = end;
                        document.getElementById("fieldTypeId").value = type;

                        // Đổi tiêu đề và action
                        document.getElementById("modalTitle").innerText = "Cập nhật Ca";
                        document.getElementById("formAction").value = "edit";
                        document.getElementById("formSubmitBtn").innerText = "Cập nhật";

                        // Hiển thị modal
                        const modal = new bootstrap.Modal(document.getElementById("bs-example-modal-lg"));
                        modal.show();
                    });
                });
            });
        </script>



        <script>
            // Các hàm tiện ích: khai báo ngoài để dùng được trong console
            function padTime(num) {
                return num < 10 ? "0" + num : num;
            }

            function toHM(minutes) {
                const h = Math.floor(minutes / 60);
                const m = minutes % 60;
                return padTime(h) + ":" + padTime(m);
            }

            function generateSlots(durationMinutes) {
                const slotContainer = document.getElementById("slotContainer");
                slotContainer.innerHTML = "";

                const startHour = 5;
                const endHour = 22;
                const toMinutes = (h, m = 0) => h * 60 + m;

                for (let start = toMinutes(startHour); start + durationMinutes <= toMinutes(endHour); start += 30) {
                    const end = start + durationMinutes;
                    const startStr = toHM(start);
                    const endStr = toHM(end);

                    const label = startStr + " - " + endStr;
                    const div = document.createElement("label");
                    div.className = "slot-item";
                    div.innerHTML = '<input type="checkbox" name="selected_slots" value="' + startStr + '-' + endStr + '" /> ' + label;
                    slotContainer.appendChild(div);
                }
            }

            // Đảm bảo chạy sau khi DOM đã load
            window.addEventListener("DOMContentLoaded", function () {
                const durationSelector = document.getElementById("durationSelector");

                durationSelector.addEventListener("change", function () {
                    generateSlots(parseInt(this.value));
                });

                // Gọi mặc định khi trang load
                generateSlots(parseInt(durationSelector.value));
            });
        </script>
    </body>

</html>