<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US" lang="en-US">

<head>
    <meta charset="utf-8">
        <base href="${pageContext.request.contextPath}/UI/">
    <c:set var="isNews" value="${sessionScope.account.userProfile.roleId == 1 || sessionScope.account.userProfile.roleId == 2}" />
    <title>${isNews ? 'Tạo tin tức' : 'Tạo bài viết'} - FootballStar</title>

    <meta name="author" content="themesflat.com">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <link rel="stylesheet" href="app/css/app.css">
    <link rel="stylesheet" href="app/css/map.min.css">

    <!-- Favicon and Touch Icons  -->
    <link rel="shortcut icon" href="assets/images/logoKoChu.png">
                                        <link rel="apple-touch-icon-precomposed" href="assets/images/logoKoChu.png">

</head>

<body class="body header-fixed ">

    
    <jsp:include page="header_dashboard.jsp" />
                <!-- Main Header -->
                
                <!-- End Main Header -->
                <main id="main">
                    <section class="profile-dashboard">
                        <div class="inner-header mb-40">
                            <h3 class="title">${isNews ? 'Tạo tin tức mới' : 'Tạo bài viết tìm đối thủ'}</h3>
                            <p class="des">${isNews ? 'Điền các thông tin bên dưới để đăng tải tin tức.' : 'Điền thông tin để tìm kiếm đối thủ phù hợp.'}</p>
                        </div>
                        <form action="${pageContext.request.contextPath}/tao-bai-viet" method="post" class="form-add-tour">
                            <div class="widget-dash-board pr-256 mb-75">
                                <h4 class="title-add-tour mb-30">${isNews ? 'Nội dung tin tức' : 'Thông tin bài viết'}</h4>
                                
                                <!-- Title field -->
                                <div class="input-wrap mb-45">
                                    <label class="form-label">Tiêu đề <span style="color:red">*</span></label>
                                    <input type="text" name="title" required placeholder="${isNews ? 'Nhập tiêu đề tin tức' : 'Ví dụ: Tìm đối thủ đá bóng tối nay'}" class="form-control">
                                    <small class="form-text text-muted">${isNews ? 'Tiêu đề cần hấp dẫn, phản ánh đúng nội dung tin tức.' : 'Tiêu đề ngắn gọn, dễ hiểu sẽ thu hút nhiều người tham gia.'}</small>
                                </div>
                                
                                <!-- Booking fields for regular users -->
                                <c:if test="${!isNews}">
                                    <div class="booking-info-section mb-45" style="background: #f8f9fa; padding: 20px; border-radius: 8px; border-left: 4px solid #4DA528;">
                                        <h5 style="color: #4DA528; margin-bottom: 15px;">📅 Thông tin tìm kèo</h5>
                                        <div class="grid-input-2 mb-30">
                                            <div class="input-wrap">
                                                <label class="form-label">Loại sân <span style="color:red">*</span></label>
                                                <select name="fieldTypeId" required class="form-control">
                                                    <option value="">-- Chọn loại sân --</option>
                                                    <c:forEach var="type" items="${fieldTypes}">
                                                        <option value="${type.fieldTypeId}">${type.fieldTypeName}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="grid-input-2 mb-30">
                                            <div class="input-wrap">
                                                <label class="form-label">Giờ đá <span style="color:red">*</span></label>
                                                <input type="time" name="startTime" required class="form-control" />
                                            </div>
                                            <div class="input-wrap">
                                                <label class="form-label">Ngày đá <span style="color:red">*</span></label>
                                                <input type="date" name="bookingDate" min="${currentDate}" required class="form-control" />
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                                
                                <!-- Content field -->
                                <div class="input-wrap mb-45">
                                    <label class="form-label">${isNews ? 'Nội dung đầy đủ' : 'Nội dung chi tiết'}</label>
                                    <textarea name="userContent" rows="6" placeholder="${isNews ? 'Nhập nội dung chi tiết của tin tức...' : 'Mô tả chi tiết về buổi đá bóng, yêu cầu đặc biệt, hoặc thông tin liên hệ...'}" class="form-control"></textarea>
                                    <small class="form-text text-muted">${isNews ? 'Sử dụng các đoạn văn ngắn để người đọc dễ theo dõi.' : 'Bạn có thể thêm thông tin về số người cần, trình độ, hoặc yêu cầu đặc biệt.'}</small>
                                </div>
                                
                                <!-- Action buttons -->
                                <div style="text-align:center; padding: 20px 0;">
                                    <button type="submit" class="button-add" style="background: #4DA528; color: white; padding: 12px 30px; border: none; border-radius: 6px; font-size: 16px; font-weight: 600;">
                                        <i class="icon-upload" style="margin-right: 8px;"></i>${isNews ? 'Đăng tin tức' : 'Đăng bài viết'}
                                    </button>
                                    <a href="javascript:history.back()" class="btn btn-secondary" style="margin-left: 15px; padding: 12px 30px; text-decoration: none;">
                                        Hủy bỏ
                                    </a>
                                </div>
                            </div>
                        </form>
                    </section>
                </main>
                
                <!-- Bottom -->
            </div>
        </div>
        <!-- /#page -->
    </div>

    <!-- Modal Popup Bid -->

    <a id="scroll-top" class="button-go"></a>

    <!-- Modal search-->
    <div class="modal search-mobie fade" id="exampleModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                <div class="modal-body">
                    <form action="/" class="search-form-mobie">
                        <div class="search">
                            <i class="icon-circle2017"></i>
                            <input type="search" placeholder="Search Travel" class="search-input" autocomplete="off">
                            <button type="button">Search</button>
                        </div>
                    </form>

                </div>
            </div>
        </div>
    </div>

    

    <!-- Javascript -->
    <script src="app/js/jquery.min.js"></script>
    <script src="app/js/jquery.nice-select.min.js"></script>
    <script src="app/js/bootstrap.min.js"></script>
    <script src="app/js/tinymce/tinymce.min.js"></script>
    <script src="app/js/tinymce/tinymce-custom.js"></script>
    <script src="app/js/swiper-bundle.min.js"></script>
    <script src="app/js/swiper.js"></script>
    <script src="app/js/plugin.js"></script>
    <script src="app/js/map.min.js"></script>
    <script src="app/js/map.js"></script>
    <script src="app/js/shortcodes.js"></script>
    <script src="app/js/main.js"></script>

</body>

</html>