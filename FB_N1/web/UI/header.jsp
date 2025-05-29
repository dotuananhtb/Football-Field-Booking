<%-- 
    Document   : header
    Created on : 29 thg 5, 2025, 08:58:42
    Author     : Asus
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="shortcut icon" type="image/x-icon" href="images/favicon.png">
                    <!-- Bootstrap core CSS -->
                    <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
                        <!--Custom CSS-->
                        <link href="css/style.css" rel="stylesheet" type="text/css">
                            <!--Plugin CSS-->
                            <link href="css/plugin.css" rel="stylesheet" type="text/css">

                                <!--Font Awesome-->
                                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
                                    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.min.css">

                                        <link rel="stylesheet" href="fonts/line-icons.css" type="text/css">
<div class="header_menu" id="header_menu">
    <nav class="navbar navbar-default">
        <div class="container">
            <div class="navbar-flex d-flex align-items-center justify-content-between w-100 pb-3 pt-3">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <a class="navbar-brand" href="home.jsp">
                        <img src="images/logo.png123    " alt="BookField Logo">
                    </a>
                </div>
                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="navbar-collapse1 d-flex align-items-center" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav" id="responsive-menu">
                        <li class="dropdown submenu active">
                            <a href="home.jsp" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Trang Ch?</a>
                        </li>

                        <li><a href="about.html">Gi?i Thi?u</a></li>


                        <li class="submenu dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">??t Sân <i class="icon-arrow-down" aria-hidden="true"></i></a> 
                            <ul class="dropdown-menu">
                                <li class="submenu dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Sân 5 Ng??i<i class="fa fa-angle-right" aria-hidden="true"></i></a>
                                    <ul class="dropdown-menu">
                                        <li><a href="field-5-list.html">Sân 5 Qu?n 1</a></li>
                                        <li><a href="field-5-list1.html">Sân 5 Qu?n 7</a></li>
                                        <li><a href="field-5-list2.html">Sân 5 Tân Bình</a></li>
                                    </ul>
                                </li>
                                <li class="submenu dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Sân 7 Ng??i<i class="fa fa-angle-right" aria-hidden="true"></i></a>
                                    <ul class="dropdown-menu">
                                        <li><a href="field-7-list.html">Sân 7 Qu?n 1</a></li>
                                        <li><a href="field-7-list1.html">Sân 7 Qu?n 7</a></li>
                                        <li><a href="field-7-list2.html">Sân 7 Tân Bình</a></li>
                                    </ul>
                                </li>
                                <li class="submenu dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Sân 11 Ng??i<i class="fa fa-angle-right" aria-hidden="true"></i></a>
                                    <ul class="dropdown-menu">
                                        <li><a href="field-11-list.html">Sân 11 Qu?n 1</a></li>
                                        <li><a href="field-11-list1.html">Sân 11 Qu?n 7</a></li>
                                        <li><a href="field-11-list2.html">Sân 11 Tân Bình</a></li>
                                    </ul>
                                </li>
                            </ul> 
                        </li>
                        <li class="submenu dropdown">
                            <ul class="dropdown-menu">
                                <li><a href="team.html">Hu?n Luy?n Viên</a></li>
                                <li><a href="booking.html">??t Sân</a></li>
                                <li><a href="confirmation.html">Xác Nh?n</a></li>
                                <li class="submenu dropdown">
                                    <ul class="dropdown-menu">
                                        <li><a href="services.html">Thuê Thi?t B?</a></li>
                                        <li><a href="services-detail.html">Chi Ti?t D?ch V?</a></li>
                                    </ul>
                                </li>
                                <li class="submenu dropdown">
                                    <a href="gallery.html" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Th? Vi?n<i class="fa fa-angle-right" aria-hidden="true"></i></a>
                                    <ul class="dropdown-menu">
                                        <li><a href="gallery.html">Hình ?nh Sân</a></li>
                                        <li><a href="gallery1.html">Video Sân</a></li>
                                    </ul>
                                </li>
                                <li><a href="login.html">??ng Nh?p|??ng Ký</a></li>
                                <li><a href="contact.html">Liên H?</a></li>
                                <li><a href="dashboard/dashboard.html">Qu?n Lý</a></li>
                            </ul> 
                        </li>
                        <li class="submenu dropdown">
                            <ul class="dropdown-menu">
                                <li class="submenu dropdown">
                                    <ul class="dropdown-menu">
                                        <li><a href="post-grid-1.html">Tin Trong N??c</a></li>
                                        <li><a href="post-grid-2.html">Tin Qu?c T?</a></li>
                                        <li><a href="post-grid-3.html">Tin ??a Ph??ng</a></li>
                                    </ul>
                                </li>
                                <li class="submenu dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Gi?i ??u<i class="fa fa-angle-right" aria-hidden="true"></i></a>
                                    <ul class="dropdown-menu">
                                        <li><a href="post-list-1.html">Gi?i Nghi?p D?</a></li>
                                        <li><a href="post-list-2.html">Gi?i Chuyên Nghi?p</a></li>
                                        <li><a href="post-list-3.html">Gi?i Thi?u Nhi</a></li>
                                    </ul>
                                </li>
                            </ul>
                        </li>
                        <li class="search-main"><a href="#search1" class="mt_search"><i class="fa fa-search"></i></a></li>
                    </ul>
                </div><!-- /.navbar-collapse -->  
                <div class="register-login d-flex align-items-center">
                    <c:if test="${empty sessionScope.acc}">
                        <a href="#" data-bs-toggle="modal" data-bs-target="#exampleModal" class="me-3">
                            <i class="icon-user"></i> ??ng Nh?p/??ng Ký
                        </a>
                    </c:if>
                    <a href="#" class="nir-btn white">??t Sân Ngay</a>
                    <a href="/FB_N1/userProfile" class="nir-btn white" style="margin: 20px">?</a>
                </div>

                <div id="slicknav-mobile"></div>
            </div>
        </div><!-- /.container-fluid -->
    </nav>
</div>
