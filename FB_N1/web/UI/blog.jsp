<%-- 
    Document   : blog
    Created on : 11 thg 6, 2025, 20:30:39
    Author     : Asus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US" lang="en-US">

<head>
    <meta charset="utf-8">
    <title>Vitour - Travel & Tour Booking HTML Template</title>
<base href="${pageContext.request.contextPath}/UI/">
    <meta name="author" content="themesflat.com">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <link rel="stylesheet" href="app/css/app.css">
    <link rel="stylesheet" href="app/css/jquery.fancybox.min.css">

    <!-- Favicon and Touch Icons  -->
    <link rel="shortcut icon" href="assets/images/favico.png">
    <link rel="apple-touch-icon-precomposed" href="assets/images/favico.png">

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

                <section class="breadcumb-section">
                    <div class="tf-container">
                        <div class="row">
                            <div class="col-lg-12 center z-index1">
                                <h1 class="title">Blog Page</h1>
                                <ul class="breadcumb-list flex-five">
                                    <li><a href="/FB_N1/home">Home</a></li>
                                    <li><span>Blog Page</span></li>
                                </ul>
                                <img class="bcrumb-ab" src="./assets/images/page/mask-bcrumb.png" alt="">
                            </div>
                        </div>

                    </div>
                </section>

                <section class="our-blog pd-main">
                    <div class="tf-container">
                        <div class="row">
                            <div class="col-lg-8 col-12">
                                <article class="side-blog mb-56px">
                                    <div class="blog-image">
                                        <div class="list-categories">
                                            <a href="#" class="new">24 Feb</a>
                                        </div>
                                        <a class="post-thumbnail" href="blog-details.html">
                                            <img src="./assets/images/blog/blog.jpg" alt="Image blog">
                                        </a>

                                    </div>
                                    <div class="blog-content">
                                        <div class="top-detail-info">
                                            <ul class="flex-three">
                                                <li>
                                                    <i class="icon-user"></i>
                                                    <a href="#">Mehedii .Ha</a>
                                                </li>
                                                <li>
                                                    <i class="icon-25"></i>
                                                    <span class="date">Coments (03)</span>
                                                </li>
                                                <li>
                                                    <i class="icon-24"></i>
                                                    <span class="date">3 min Read</span>
                                                </li>
                                            </ul>
                                        </div>
                                        <h3 class="entry-title">
                                            <a href="blog-details.html">The whimsically named Egg Canvas brainch </a>
                                        </h3>
                                        <p class="description">There are many variations of passages of Lorem Ipsum
                                            available, but majority have suffered
                                            teration in some form, by injected humour, or randomised words which don't
                                            look even slight
                                            believable. If you are going to use a passage of Lorem Ipsum.
                                        </p>
                                        <div class="button-main ">
                                            <a href="blog-details.html" class="button-link">Read More <i
                                                    class="icon-Arrow-11"></i></a>
                                        </div>
                                    </div>
                                </article>
                                <article class="side-blog mb-56px">
                                    <div class="blog-image">
                                        <div class="list-categories">
                                            <a href="#" class="new">24 Feb</a>
                                        </div>
                                        <a class="post-thumbnail" href="blog-details.html">
                                            <img src="./assets/images/blog/blog1.jpg" alt="Image blog">
                                        </a>

                                    </div>
                                    <div class="blog-content">
                                        <div class="top-detail-info">
                                            <ul class="flex-three">
                                                <li>
                                                    <i class="icon-user"></i>
                                                    <a href="#">Mehedii .Ha</a>
                                                </li>
                                                <li>
                                                    <i class="icon-25"></i>
                                                    <span class="date">Coments (03)</span>
                                                </li>
                                                <li>
                                                    <i class="icon-24"></i>
                                                    <span class="date">3 min Read</span>
                                                </li>
                                            </ul>
                                        </div>
                                        <h3 class="entry-title">
                                            <a href="blog-details.html">The whimsically named Egg Canvas brainch </a>
                                        </h3>
                                        <p class="description">There are many variations of passages of Lorem Ipsum
                                            available, but majority have suffered
                                            teration in some form, by injected humour, or randomised words which don't
                                            look even slight
                                            believable. If you are going to use a passage of Lorem Ipsum.
                                        </p>
                                        <div class="button-main">
                                            <a href="blog-details.html" class="button-link">Read More<i
                                                    class="icon-Arrow-11"></i></a>
                                        </div>
                                    </div>
                                </article>
                                <article class="side-blog mb-56px">
                                    <div class="blog-image">
                                        <div class="list-categories">
                                            <a href="#" class="new">24 Feb</a>
                                        </div>
                                        <a class="post-thumbnail" href="blog-details.html">
                                            <img src="./assets/images/blog/blog2.jpg" alt="Image blog">
                                        </a>

                                    </div>
                                    <div class="blog-content">
                                        <div class="top-detail-info">
                                            <ul class="flex-three">
                                                <li>
                                                    <i class="icon-user"></i>
                                                    <a href="#">Mehedii .Ha</a>
                                                </li>
                                                <li>
                                                    <i class="icon-25"></i>
                                                    <span class="date">Coments (03)</span>
                                                </li>
                                                <li>
                                                    <i class="icon-24"></i>
                                                    <span class="date">3 min Read</span>
                                                </li>
                                            </ul>
                                        </div>
                                        <h3 class="entry-title">
                                            <a href="blog-details.html">The whimsically named Egg Canvas brainch </a>
                                        </h3>
                                        <p class="description">There are many variations of passages of Lorem Ipsum
                                            available, but majority have suffered
                                            teration in some form, by injected humour, or randomised words which don't
                                            look even slight
                                            believable. If you are going to use a passage of Lorem Ipsum.
                                        </p>
                                        <div class="button-main">
                                            <a href="blog-details.html" class="button-link">Read More<i
                                                    class="icon-Arrow-11"></i></a>
                                        </div>
                                    </div>
                                </article>

                                <div class="row">
                                    <div class="col-md-12 ">
                                        <ul class="tf-pagination flex-five mt-20">
                                            <li>
                                                <a class="pages-link" href="#"> <i class="icon-29"></i></a>
                                            </li>
                                            <li>
                                                <a class="pages-link" href="#">1</a>
                                            </li>
                                            <li class="pages-item active" aria-current="page">
                                                <a class="pages-link" href="#">2</a>
                                            </li>
                                            <li><a class="pages-link" href="#">3</a></li>
                                            <li>
                                                <a class="pages-link" href="#"><i class=" icon--1"></i></a>
                                            </li>
                                        </ul>

                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-12">
                                <div class="side-bar-right">
                                    <div class="sidebar-widget">
                                        <div class="profile-widget center">
                                            <img src="./assets/images/avata/avt-blog.jpg" alt="Image Blog"
                                                class="avata">
                                            <div class="name">Rosalina D. Willaim</div>
                                            <span class="job">Blogger/Photographer</span>
                                            <p class="des">he whimsically named Egg Canvas is the
                                                design director and photographer
                                                in New York. Why the nam
                                            </p>
                                            <ul class="social">
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
                                                        <i class="icon-icon_03"></i>
                                                    </a>
                                                </li>
                                                <li>
                                                    <a href="#">
                                                        <i class="icon-2"></i>
                                                    </a>
                                                </li>
                                            </ul>

                                        </div>
                                    </div>
                                    <div class="sidebar-widget">
                                        <h4 class="block-heading">search here</h4>
                                        <form action="/" id="search-bar-widget">
                                            <input type="text" placeholder="Search here...">
                                            <button type="button"><i class="icon-search-2"></i></button>
                                        </form>

                                    </div>
                                    <div class="sidebar-widget">
                                        <h4 class="block-heading">Recent News</h4>
                                        <div class="recent-post-list">
                                            <div class="list-recent flex-three">
                                                <a href="blog-details.html" class="recent-image">
                                                    <img src="./assets/images/blog/re-blog1.jpg" alt="Image">
                                                </a>
                                                <div class="recent-info">
                                                    <div class="date">
                                                        <i class="icon-4"></i>
                                                        <span>Jan 23,2022</span>
                                                    </div>
                                                    <h4 class="title">
                                                        <a href="blog-details.html">Budget Issues Force The Our To
                                                            Become</a>
                                                    </h4>
                                                </div>
                                            </div>
                                            <div class="list-recent flex-three">
                                                <a href="blog-details.html" class="recent-image">
                                                    <img src="./assets/images/blog/re-blog2.jpg" alt="Image">
                                                </a>
                                                <div class="recent-info">
                                                    <div class="date">
                                                        <i class="icon-4"></i>
                                                        <span>Jan 23,2022</span>
                                                    </div>
                                                    <h4 class="title">
                                                        <a href="blog-details.html">The Best Products That Shape
                                                            Fashion</a>
                                                    </h4>
                                                </div>
                                            </div>
                                            <div class="list-recent flex-three">
                                                <a href="blog-details.html" class="recent-image">
                                                    <img src="./assets/images/blog/re-blog3.jpg" alt="Image">
                                                </a>
                                                <div class="recent-info">
                                                    <div class="date">
                                                        <i class="icon-4"></i>
                                                        <span>Jan 23,2022</span>
                                                    </div>
                                                    <h4 class="title">
                                                        <a href="blog-details.html">The Best Products That Shape
                                                            Fashion</a>
                                                    </h4>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="sidebar-widget">
                                        <h4 class="block-heading">Categories</h4>
                                        <ul class="category-blog">
                                            <li>
                                                <a href="#" class="flex-two">
                                                    <span>Mobile Set</span>
                                                    <span>03</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="#" class="flex-two">
                                                    <span>Mobile Set</span>
                                                    <span>03</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="#" class="flex-two">
                                                    <span>Mobile Set</span>
                                                    <span>03</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="#" class="flex-two">
                                                    <span>Mobile Set</span>
                                                    <span>03</span>
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="sidebar-widget">
                                        <h4 class="block-heading">Tags</h4>
                                        <ul class="tag">
                                            <li>
                                                <a href="#">Tourist</a>
                                            </li>
                                            <li>
                                                <a href="#">Traveling</a>
                                            </li>
                                            <li>
                                                <a href="#">Cave</a>
                                            </li>
                                            <li>
                                                <a href="#">Sky Dive</a>
                                            </li>
                                            <li>
                                                <a href="#">Hill Climb</a>
                                            </li>
                                            <li>
                                                <a href="#">Oppos</a>
                                            </li>
                                            <li>
                                                <a href="#" class="active">Landing</a>
                                            </li>
                                            <li>
                                                <a href="#">Oppos</a>
                                            </li>
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
