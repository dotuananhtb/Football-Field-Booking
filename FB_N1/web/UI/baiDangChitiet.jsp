
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US" lang="en-US">

    <head>
        <meta charset="utf-8">
            <title>Diễn Đàn Tin Tức - FootBall Star</title>
            <base href="${pageContext.request.contextPath}/UI/">
                <meta name="author" content="themesflat.com">
                    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

                        <link rel="stylesheet" href="app/css/app.css">
                            <link rel="stylesheet" href="app/css/jquery.fancybox.min.css">

                                <!-- Favicon and Touch Icons  -->
                                <link rel="shortcut icon" href="assets/images/logoKoChu.png">
                                    <link rel="apple-touch-icon-precomposed" href="assets/images/logoKoChu.png">

                                        </head>

                                        <body class="body header-fixed ">

                                            <div class="preload preload-container">
                                                <svg class="pl" width="240" height="240" viewBox="0 0 240 240">
                                                    <circle class="pl__ring pl__ring--a" cx="120" cy="120" r="105" fill="none" stroke="#000" stroke-width="20" stroke-dasharray="0 660" stroke-dashoffset="-330" stroke-linecap="round"></circle>
                                                    <circle class="pl__ring pl__ring--b" cx="120" cy="120" r="35" fill="none" stroke="#000" stroke-width="20" stroke-dasharray="0 220" stroke-dashoffset="-110" stroke-linecap="round"></circle>
                                                    <circle class="pl__ring pl__ring--c" cx="85" cy="120" r="70" fill="none" stroke="#000" stroke-width="20" stroke-dasharray="0 440" stroke-linecap="round"></circle>
                                                    <circle class="pl__ring pl__ring--d" cx="155" cy="120" r="70" fill="none" stroke="#000" stroke-width="20" stroke-dasharray="0 440" stroke-linecap="round"></circle>
                                                </svg>
                                            </div>

                                            <!-- /preload -->

                                            <div id="wrapper">
                                                <div id="pagee" class="clearfix">

                                                    <!-- Main Header -->
                                                    <jsp:include page="header.jsp" />
                                                    <!-- End Main Header -->
                                                    <main id="main">

                                                     

                                                        <section class="our-blog pd-main">
                                                            <div class="tf-container">
                                                                <div class="row">
                                                                    <div class="col-lg-8 col-12">

                                                                        <article class="side-blog side-blog-single">

                                                                            <h2 class="entry-title">
                                                                                ${blog.title} Nguyễn văn Nguyên đẹp trai
                                                                            </h2>

                                                                            <div class="image">
                                                                                <img src="${blog.thumbnailUrl}" alt="">
                                                                            </div>
                                                                            <div class="top-detail-info">
                                                                                <ul class="flex-three">
                                                                                    <li>
                                                                                        <i class="icon-4"></i>
                                                                                        <span>${blog.timeAgo}</span>
                                                                                    </li>

                                                                                </ul>
                                                                            </div><br>

                                                                                <p class="des lh-32 mb-37">${blog.content}
                                                                                </p>
                                                                        </article>
                                                                                <div class="flex-two share-blog">
                                                                        

                                                                                </div>           

                                                                    </div>
                                                                    <div class="col-lg-4 col-12">
                                                                        <div class="side-bar-right">


                                                                            <div class="sidebar-widget">
                                                                                <h4 class="block-heading">Bài viết gần đây</h4>
                                                                                <div class="recent-post-list">
                                                                                    <c:forEach items="${listB1}" var="c">
                                                                                        <div class="list-recent flex-three">
                                                                                            <a href="${pageContext.request.contextPath}/bai-dang-chi-tiet?slug=${c.slug}" class="recentagt-image">
                                                                                                <img style="height: 122px; width: 171px" src="${c.thumbnailUrl}" alt="Image">
                                                                                            </a>
                                                                                            <div class="recent-info">
                                                                                                <div class="date">
                                                                                                    <i class="icon-4"></i>
                                                                                                    <span style="font-size: 12px;">${c.timeAgo}</span>
                                                                                                </div>
                                                                                                <h4 class="title">
                                                                                                    <a href="${pageContext.request.contextPath}/bai-dang-chi-tiet?slug=${c.slug}">${c.title}</a>
                                                                                                </h4>
                                                                                            </div>
                                                                                        </div>
                                                                                    </c:forEach>
                                                                                </div>
                                                                            </div>

                                                                            <div class="sidebar-widget">
                                                                                <h4 class="block-heading">Nhãn</h4>
                                                                                <ul class="tag">
                                                                                    <c:forEach items="${listTag}" var="listTag">
                                                                                        <li>
                                                                                            <a id ="listTag" href="${pageContext.request.contextPath}/bai-dang?tag=${listTag}">${listTag}</a>
                                                                                        </li>
                                                                                    </c:forEach>

                                                                                </ul>
                                                                                
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </section>



                                                    </main>

                                                    <jsp:include page="footer.jsp" />

                                                    <!-- Bottom -->
                                                </div>
                                                <!-- /#page -->
                                            </div>

                                            <!-- Modal Popup Bid -->

                                            <a id="scroll-top" class="button-go"></a>

                                            <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight">
                                                <div class="offcanvas-header">
                                                    <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                                                </div>
                                                <div class="offcanvas-body">
                                                    <div class="logo-canvas">
                                                        <img src="./assets/images/logo.png" alt="image">
                                                    </div>
                                                    <p class="des">The world’s first and largest digital market
                                                        for crypto collectibles and non-fungible
                                                    </p>
                                                    <ul class="canvas-info">
                                                        <li class="flex-three">
                                                            <i class="icon-noun-mail-5780740-1"></i>
                                                            <p>Info@webmail.com</p>
                                                        </li>
                                                        <li class="flex-three">
                                                            <i class="icon-Group-9"></i>
                                                            <p>684 555-0102 490</p>
                                                        </li>
                                                        <li class="flex-three">
                                                            <i class="icon-Layer-19"></i>
                                                            <p>6391 Elgin St. Celina, NYC 10299</p>
                                                        </li>
                                                    </ul>
                                                    <ul class="social flex-three">
                                                        <li>
                                                            <a href="#">
                                                                <i class="icon-icon-2"></i>
                                                            </a>
                                                        </li>
                                                        <li>
                                                            <a href="#">
                                                                <i class="icon-x"></i>
                                                            </a>
                                                        </li>
                                                        <li>
                                                            <a href="#">
                                                                <i class="icon-8"></i>
                                                            </a>
                                                        </li>
                                                        <li>
                                                            <a href="#">
                                                                <i class="icon-6"></i>
                                                            </a>
                                                        </li>
                                                    </ul>

                                                </div>
                                            </div>
                                            <script>

                                                function searchByTag(tag) {
                                                    fetch('/FB_N1/danh-sach-nhan?tag=' + encodeURIComponent(tag))
                                                            .then(res => {
                                                                if (!res.ok) {
                                                                    throw new Error("Không tìm thấy bài đăng với " + tag);
                                                                }
                                                                return res.json(); // chuyển response thành JSON
                                                            })
                                                            .then(data => {
                                                                console.log("Danh sách bài viết theo tag:", data);
                                                                // TODO: hiển thị danh sách data lên giao diện
                                                                renderBlogList(data); // ví dụ bạn có hàm này
                                                            })
                                                            .catch(err => {
                                                                console.error("Lỗi khi fetch:", err);
                                                                alert(err.message);
                                                            });
                                                }





                                                function searchByTitle(title) {
                                                    const title = document.getElementsByName("title");
                                                    fetch("${pageContext.request.contextPath}/bai-dang", {
                                                        method: "POST",
                                                        headers: {
                                                            "Content-Type": "application/x-www-form-urlencoded"
                                                        },
                                                        body: "title=" + encodeURIComponent(title)
                                                    }).then(res => {
                                                        if (res.ok) {
                                                            document.getElementById("listTag").src = "/FB_N1/bai-dang?tag=" + tag;
                                                        } else {
                                                            alert("Không tìm thấy " + title + "!");
                                                        }
                                                    });
                                                }


                                            </script>
                                            <!-- Javascript -->
                                            <script src="app/js/jquery.min.js"></script>
                                            <script src="app/js/jquery.nice-select.min.js"></script>
                                            <script src="app/js/bootstrap.min.js"></script>
                                            <script src="app/js/swiper-bundle.min.js"></script>
                                            <script src="app/js/swiper.js"></script>
                                            <script src="app/js/plugin.js"></script>
                                            <script src="app/js/jquery.fancybox.js"></script>
                                            <script src="app/js/shortcodes.js"></script>
                                            <script src="app/js/main.js"></script>

                                        </body>

                                        </html>