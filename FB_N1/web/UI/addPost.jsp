<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US" lang="en-US">

<head>
    <meta charset="utf-8">
        <base href="${pageContext.request.contextPath}/UI/">
    <title>FootballStar</title>

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
                            <h3 class="title">Tạo bài viết</h3>
                            <p class="des">Hãy điền thông tin bài viết của bạn</p>
                        </div>
                        <form action="${pageContext.request.contextPath}/createPost" method="post" class="form-add-tour">
                            <div class="widget-dash-board pr-256 mb-75">
                                <h4 class="title-add-tour mb-30">1. Thông tin bài viết</h4>
                                
                                <!-- Title field - luôn hiển thị -->
                                <div class="input-wrap mb-45">
                                    <label>Tiêu đề <span style="color:red">*</span></label>
                                    <input type="text" name="title" required placeholder="Nhập tiêu đề bài viết">
                                </div>
                                
                                <!-- Content field - luôn hiển thị -->
                                <div class="input-wrap mb-45">
                                    <label>Nội dung bài viết</label>
                                    <textarea name="userContent" rows="6" placeholder="Nhập nội dung bài viết..."></textarea>
                                </div>
                                
                                
                                <c:if test="${account.userProfile.roleId != 1 && account.userProfile.roleId != 2}">
                                    <div class="grid-input-2 mb-45">
                                        <div class="input-wrap">
                                            <label>Loại sân muốn chơi <span style="color:red">*</span></label>
                                            <select name="fieldTypeId" required>
                                                <c:forEach var="type" items="${fieldTypes}">
                                                    <option value="${type.fieldTypeId}">${type.fieldTypeName}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="grid-input-2 mb-45">
                                        <div class="input-wrap">
                                            <label>Giờ muốn đặt <span style="color:red">*</span></label>
                                            <input type="time" name="startTime" required />
                                        </div>
                                        <div class="input-wrap">
                                            <label>Ngày muốn đặt <span style="color:red">*</span></label>
                                            <input type="date" name="bookingDate" min="${currentDate}" required />
                                        </div>
                                    </div>
                                </c:if>
                                
                                <div style="text-align:center;">
                                    <button type="submit" class="button-add">Đăng bài</button>
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