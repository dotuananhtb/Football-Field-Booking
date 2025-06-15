<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US" lang="en-US">
<head>
    <base href="${pageContext.request.contextPath}/UI/">
    <meta charset="utf-8">
    <title>Cập nhật bài viết</title>
    <meta name="author" content="themesflat.com">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="app/css/app.css">
    <link rel="stylesheet" href="app/css/map.min.css">
    <!-- Favicon and Touch Icons  -->
    <link rel="shortcut icon" href="assets/images/favico.png">
    <link rel="apple-touch-icon-precomposed" href="assets/images/favico.png">
</head>
<body class="body header-fixed ">
    
    
            
                <jsp:include page="header_dashboard.jsp" />
                <!-- End Main Header -->
                <main id="main">
                    <section class="profile-dashboard">
                        <div class="inner-header mb-40">
                            <h3 class="title">Cập nhật bài viết</h3>
                            <p class="des">Bạn có thể chỉnh sửa thông tin bài viết tại đây</p>
                        </div>
                        <form action="${pageContext.request.contextPath}/updatePost" method="post" class="form-add-tour">
                            <input type="hidden" name="postId" value="${post.postId}" />
                            <div class="widget-dash-board pr-256 mb-75">
                                <h4 class="title-add-tour mb-30">1. Thông tin bài viết</h4>
                                <div class="input-wrap mb-45">
                                    <label>Tiêu đề <span style="color:red">*</span></label>
                                    <input type="text" name="title" required placeholder="Nhập tiêu đề bài viết" value="${post.title}">
                                </div>
                                <div class="input-wrap mb-45">
                                    <label>Ghi chú/Nội dung thêm</label>
                                    <textarea name="userContent" rows="4" placeholder="Nhập ghi chú hoặc yêu cầu đặc biệt...">${post.contentPost}</textarea>
                                </div>
                                <div style="text-align:center;">
                                    <button type="submit" class="button-add">Cập nhật</button>
                                </div>
                            </div>
                        </form>
                    </section>
                </main>
                <footer class="footer footer-dashboard">
                    <div class="tf-container full">
                        <div class="row">
                            <div class="col-lg-6">
                                <p class="text-white">Made with ❤️ by Themesflat. - Powered by Theme</p>
                            </div>
                            <div class="col-lg-6">
                                <ul class="menu-footer flex-six">
                                    <li><a href="#">Privacy & Policy</a></li>
                                    <li><a href="#">Licensing</a></li>
                                    <li><a href="#">Instruction</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </footer>
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
    <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight">
        <div class="offcanvas-header">
            <h5 class="offcanvas-title" id="offcanvasRightLabel">Offcanvas right</h5>
            <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
        </div>
        <div class="offcanvas-body">...</div>
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