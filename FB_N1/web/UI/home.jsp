<%-- 
    Document   : home
    Created on : 26 thg 5, 2025, 23:20:54
    Author     : Asus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="vi">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>BookField - Hệ Thống Đặt Sân Bóng Đá</title>
    <!-- Favicon -->
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
</head>

<body>

    <!-- Preloader -->
    <div id="preloader">
        <div id="status"></div>
    </div>
    <!-- Preloader Ends -->

    <!-- header starts -->
    <jsp:include page="header.jsp"></jsp:include>
    <!-- header ends -->
    <div class="tet"></div>

    <!-- top Fields starts -->

    <!-- top Fields ends -->

    <!-- about-us starts -->
    <section class="about-us pt-0" style="background-image:url(images/bg/bg-trans.png);">
        <div class="container">
            <div class="about-image-box">
         
            </div>
        </div>
        <div class="white-overlay"></div>
    </section>
    <!-- about-us ends -->

    <!-- Hot Deals Starts -->
    <section class="trending pb-0 pt-6" style="background-image: url(images/shape2.png);">
        <div class="container">
            <div class="section-title mb-6 w-75 mx-auto text-center">
                <h4 class="mb-1 theme1">Ưu Đãi Hot</h4>
                <h2 class="mb-1">Sân Bóng <span class="theme">Giá Rẻ</span></h2>
                <p>Những sân bóng chất lượng cao với mức giá ưu đãi nhất. Đặt ngay để không bỏ lỡ cơ hội!
                </p>
            </div>
            <div class="trend-box">
                <div class="row">
                    <div class="col-lg-5 mb-4">
                        <div class="trend-item1 rounded box-shadow mb-4">
                            <div class="trend-image position-relative">
                                <img src="images/trending/trendingb-2.jpg" alt="Sân bóng Quận 1" class="">
                                <div class="trend-content1 p-4">
                                    <h5 class="theme1 mb-1"><i class="flaticon-location-pin"></i> Quận 1</h5>
                                    <h3 class="mb-1 white"><a href="field-grid.html" class="white">Sân Thể Thao Tân Định</a>
                                    </h3>
                                    <div class="rating-main d-flex align-items-center pb-2">
                                        <div class="rating">
                                            <span class="fa fa-star checked"></span>
                                            <span class="fa fa-star checked"></span>
                                            <span class="fa fa-star checked"></span>
                                            <span class="fa fa-star checked"></span>
                                            <span class="fa fa-star checked"></span>
                                        </div>
                                        <span class="ms-2 white">(16)</span>
                                    </div>
                                    <div class="entry-meta d-flex align-items-center justify-content-between">
                                        <div class="entry-author d-flex align-items-center">
                                            <p class="mb-0 white"><span class="theme1 fw-bold fs-5"> 180.000đ</span> |
                                                Mỗi giờ</p>
                                        </div>
                                        <div class="entry-author">
                                            <i class="icon-calendar white"></i>
                                            <span class="fw-bold white"> Sân 5 người</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="overlay"></div>
                            </div>
                        </div>
                        <div class="trend-item1 rounded box-shadow mb-4">
                            <div class="trend-image position-relative">
                                <img src="images/trending/trending-large.jpg" alt="Sân bóng Quận 7" class="">
                                <div class="trend-content1 p-4">
                                    <h5 class="theme1 mb-1"><i class="flaticon-location-pin"></i> Quận 7</h5>
                                    <h3 class="mb-1 white"><a href="field-grid.html" class="white">Sân Riverside</a>
                                    </h3>
                                    <div class="rating-main d-flex align-items-center pb-2">
                                        <div class="rating">
                                            <span class="fa fa-star checked"></span>
                                            <span class="fa fa-star checked"></span>
                                            <span class="fa fa-star checked"></span>
                                            <span class="fa fa-star checked"></span>
                                            <span class="fa fa-star checked"></span>
                                        </div>
                                        <span class="ms-2 white">(16)</span>
                                    </div>
                                    <div class="entry-meta d-flex align-items-center justify-content-between">
                                        <div class="entry-author d-flex align-items-center">
                                            <p class="mb-0 white"><span class="theme1 fw-bold fs-5"> 200.000đ</span> |
                                                Mỗi giờ</p>
                                        </div>
                                        <div class="entry-author">
                                            <i class="icon-calendar white"></i>
                                            <span class="fw-bold white"> Sân 7 người</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="overlay"></div>
                            </div>
                        </div>
                        <div class="trend-item1 rounded box-shadow">
                            <div class="trend-image position-relative">
                                <img src="images/trending/trendingb-1.jpg" alt="Sân bóng Tân Bình" class="">
                                <div class="trend-content1 p-4">
                                    <h5 class="theme1 mb-1"><i class="flaticon-location-pin"></i> Tân Bình</h5>
                                    <h3 class="mb-1 white"><a href="field-grid.html" class="white">Sân Green Park</a></h3>
                                    <div class="rating-main d-flex align-items-center pb-2">
                                        <div class="rating">
                                            <span class="fa fa-star checked"></span>
                                            <span class="fa fa-star checked"></span>
                                            <span class="fa fa-star checked"></span>
                                            <span class="fa fa-star checked"></span>
                                            <span class="fa fa-star checked"></span>
                                        </div>
                                        <span class="ms-2 white">(12)</span>
                                    </div>
                                    <div class="entry-meta d-flex align-items-center justify-content-between">
                                        <div class="entry-author d-flex align-items-center">
                                            <p class="mb-0 white"><span class="theme1 fw-bold fs-5"> 220.000đ</span> |
                                                Mỗi giờ</p>
                                        </div>
                                        <div class="entry-author">
                                            <i class="icon-calendar white"></i>
                                            <span class="fw-bold white"> Sân 11 người</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="overlay"></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-7">
                        <div class="row">
                            <div class="col-lg-6 col-md-6 mb-4">
                                <div class="trend-item rounded box-shadow">
                                    <div class="trend-image position-relative">
                                        <img src="images/trending/trending1.jpg" alt="Sân bóng Bình Thạnh" class="">
                                        <div class="color-overlay"></div>
                                    </div>
                                    <div class="trend-content p-4 pt-5 position-relative bg-white">
                                        <div class="trend-meta bg-theme white px-3 py-2 rounded">
                                            <div class="entry-author">
                                                <i class="icon-calendar"></i>
                                                <span class="fw-bold"> Sân 5 người</span>
                                            </div>
                                        </div>
                                        <h5 class="theme mb-1"><i class="flaticon-location-pin"></i> Bình Thạnh</h5>
                                        <h3 class="mb-1"><a href="field-grid.html">Sân Landmark 81</a></h3>
                                        <div class="rating-main d-flex align-items-center pb-2">
                                            <div class="rating">
                                                <span class="fa fa-star checked"></span>
                                                <span class="fa fa-star checked"></span>
                                                <span class="fa fa-star checked"></span>
                                                <span class="fa fa-star checked"></span>
                                                <span class="fa fa-star checked"></span>
                                            </div>
                                            <span class="ms-2">(21)</span>
                                        </div>
                                        <p class=" border-b pb-2 mb-2">Sân cỏ nhân tạo chất lượng cao, đèn chiếu sáng hiện đại</p>
                                        <div class="entry-meta">
                                            <div class="entry-author d-flex align-items-center">
                                                <p class="mb-0"><span class="theme fw-bold fs-5"> 160.000đ</span> | Mỗi giờ</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 mb-4">
                                <div class="trend-item rounded box-shadow">
                                    <div class="trend-image position-relative">
                                        <img src="images/trending/trending2.jpg" alt="Sân bóng Thủ Đức" class="">
                                        <div class="color-overlay"></div>
                                    </div>
                                    <div class="trend-content p-4 pt-5 position-relative bg-white">
                                        <div class="trend-meta bg-theme white px-3 py-2 rounded">
                                            <div class="entry-author">
                                                <i class="icon-calendar"></i>
                                                <span class="fw-bold"> Sân 7 người</span>
                                            </div>
                                        </div>
                                        <h5 class="theme mb-1"><i class="flaticon-location-pin"></i> Thủ Đức</h5>
                                        <h3 class="mb-1"><a href="field-grid.html">Sân Mega Sport</a></h3>
                                        <div class="rating-main d-flex align-items-center pb-2">
                                            <div class="rating">
                                                <span class="fa fa-star checked"></span>
                                                <span class="fa fa-star checked"></span>
                                                <span class="fa fa-star checked"></span>
                                                <span class="fa fa-star checked"></span>
                                                <span class="fa fa-star checked"></span>
                                            </div>
                                            <span class="ms-2">(11)</span>
                                        </div>
                                        <p class=" border-b pb-2 mb-2">Sân cỏ tự nhiên, phòng thay đồ rộng rãi, bãi đậu xe miễn phí</p>
                                        <div class="entry-meta">
                                            <div class="entry-author d-flex align-items-center">
                                                <p class="mb-0"><span class="theme fw-bold fs-5"> 190.000đ</span> | Mỗi giờ</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 mb-4">
                                <div class="trend-item rounded box-shadow">
                                    <div class="trend-image position-relative">
                                        <img src="images/trending/trending3.jpg" alt="Sân bóng Gò Vấp" class="">
                                        <div class="color-overlay"></div>
                                    </div>
                                    <div class="trend-content p-4 pt-5 position-relative bg-white">
                                        <div class="trend-meta bg-theme white px-3 py-2 rounded">
                                            <div class="entry-author">
                                                <i class="icon-calendar"></i>
                                                <span class="fw-bold"> Sân 5 người</span>
                                            </div>
                                        </div>
                                        <h5 class="theme mb-1"><i class="flaticon-location-pin"></i> Gò Vấp</h5>
                                        <h3 class="mb-1"><a href="field-grid.html">Sân Thể Thao Gò Vấp</a></h3>
                                        <div class="rating-main d-flex align-items-center pb-2">
                                            <div class="rating">
                                                <span class="fa fa-star checked"></span>
                                                <span class="fa fa-star checked"></span>
                                                <span class="fa fa-star checked"></span>
                                                <span class="fa fa-star checked"></span>
                                                <span class="fa fa-star checked"></span>
                                            </div>
                                            <span class="ms-2">(25)</span>
                                        </div>
                                        <p class=" border-b pb-2 mb-2">Sân cỏ nhân tạo mới, hệ thống âm thanh hiện đại</p>
                                        <div class="entry-meta">
                                            <div class="entry-author d-flex align-items-center">
                                                <p class="mb-0"><span class="theme fw-bold fs-5"> 140.000đ</span> | Mỗi giờ</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 mb-4">
                                <div class="trend-item rounded box-shadow">
                                    <div class="trend-image position-relative">
                                        <img src="images/trending/trending4.jpg" alt="Sân bóng Quận 12" class="">
                                        <div class="color-overlay"></div>
                                    </div>
                                    <div class="trend-content p-4 pt-5 position-relative bg-white">
                                        <div class="trend-meta bg-theme white px-3 py-2 rounded">
                                            <div class="entry-author">
                                                <i class="icon-calendar"></i>
                                                <span class="fw-bold"> Sân 11 người</span>
                                            </div>
                                        </div>
                                        <h5 class="theme mb-1"><i class="flaticon-location-pin"></i> Quận 12</h5>
                                        <h3 class="mb-1"><a href="field-grid.html">Sân Tân Chánh Hiệp</a></h3>
                                        <div class="rating-main d-flex align-items-center pb-2">
                                            <div class="rating">
                                                <span class="fa fa-star checked"></span>
                                                <span class="fa fa-star checked"></span>
                                                <span class="fa fa-star checked"></span>
                                                <span class="fa fa-star checked"></span>
                                                <span class="fa fa-star checked"></span>
                                            </div>
                                            <span class="ms-2">(32)</span>
                                        </div>
                                        <p class=" border-b pb-2 mb-2">Sân cỏ tự nhiên chuẩn FIFA, khán đài rộng rãi</p>
                                        <div class="entry-meta">
                                            <div class="entry-author d-flex align-items-center">
                                                <p class="mb-0"><span class="theme fw-bold fs-5"> 300.000đ</span> | Mỗi giờ</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </section>
    <!-- Hot Deals Ends -->

    <!-- Discount action starts -->
    <section class="discount-action pt-6"
        style="background-image:url(images/section-bg1.png); background-position:center;">
        <div class="section-shape section-shape1 top-inherit bottom-0"
            style="background-image: url(images/shape8.png);"></div>
        <div class="container">
            <div class="call-banner rounded pt-10 pb-14">
                <div class="call-banner-inner w-75 mx-auto text-center px-5">
                    <div class="trend-content-main">
                        <div class="trend-content mb-5 pb-2 px-5">
                            <h5 class="mb-1 theme">Đam Mê Bóng Đá</h5>
                            <h2><a href="detail-fullwidth.html">Khám Phá Niềm Đam Mê, <span class="theme1"> Chơi Bóng Mọi Lúc Mọi Nơi!</span></a></h2>
                            <p>Hệ thống đặt sân bóng đá hàng đầu Việt Nam. Hơn 1000+ sân bóng chất lượng cao trên toàn quốc, phục vụ 24/7.</p>
                        </div>
                        <div class="video-button text-center position-relative">
                            <div class="call-button text-center">
                                <button type="button" class="play-btn js-video-button" data-video-id="152879427"
                                    data-channel="vimeo">
                                    <i class="fa fa-play bg-blue"></i>
                                </button>
                            </div>
                            <div class="video-figure"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="white-overlay"></div>
    </section>
    <!-- Discount action Ends -->

    <!-- our teams starts -->
    <section class="our-team pb-6">
        <div class="container">

            <div class="section-title mb-6 w-75 mx-auto text-center">
                <h4 class="mb-1 theme1">Đội Ngũ Chuyên Nghiệp</h4>
                <h2 class="mb-1">Gặp Gỡ <span class="theme">Huấn Luyện Viên Xuất Sắc</span></h2>
                <p>Đội ngũ huấn luyện viên giàu kinh nghiệm, tận tâm hướng dẫn và phát triển kỹ năng bóng đá cho bạn.
                </p>
            </div>
            <div class="team-main">
                <div class="row shop-slider">
                    <div class="col-lg-3 col-md-6 col-sm-12 mb-4">
                        <div class="team-list rounded">
                            <div class="team-image">
                                <img src="images/team/img1.jpg" alt="Huấn luyện viên">
                            </div>
                            <div class="team-content text-center p-3 bg-theme">
                                <h4 class="mb-0 white">Nguyễn Văn Minh</h4>
                                <p class="mb-0 white">HLV Trưởng</p>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-3 col-md-6 col-sm-12 mb-4">
                        <div class="team-list rounded">
                            <div class="team-image">
                                <img src="images/team/img2.jpg" alt="Huấn luyện viên">
                            </div>
                            <div class="team-content text-center p-3 bg-theme">
                                <h4 class="mb-0 white">Trần Thành Đạt</h4>
                                <p class="mb-0 white">HLV Thể Lực</p>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-3 col-md-6 col-sm-12 mb-4">
                        <div class="team-list rounded">
                            <div class="team-image">
                                <img src="images/team/img4.jpg" alt="Huấn luyện viên">
                            </div>
                            <div class="team-content text-center p-3 bg-theme">
                                <h4 class="mb-0 white">Lê Hoàng Nam</h4>
                                <p class="mb-0 white">HLV Kỹ Thuật</p>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-3 col-md-6 col-sm-12 mb-4">
                        <div class="team-list rounded">
                            <div class="team-image">
                                <img src="images/team/img3.jpg" alt="Huấn luyện viên">
                            </div>
                            <div class="team-content text-center p-3 bg-theme">
                                <h4 class="mb-0 white">Phạm Quốc Tuấn</h4>
                                <p class="mb-0 white">HLV Thủ Môn</p>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-3 col-md-6 col-sm-12 mb-4">
                        <div class="team-list rounded">
                            <div class="team-image">
                                <img src="images/team/img4.jpg" alt="Huấn luyện viên">
                            </div>
                            <div class="team-content text-center bg-theme p-3">
                                <h4 class="mb-0 white">Võ Minh Tâm</h4>
                                <p class="mb-0 white">HLV Trẻ</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- our teams Ends -->

    <!-- partner starts -->
    
    <!-- partner ends -->

    <!-- recent-articles starts -->
    <section class="trending recent-articles pb-6">
        <div class="container">
            <div class="section-title mb-6 w-75 mx-auto text-center">
                <h4 class="mb-1 theme1">Tin Tức Bóng Đá</h4>
                <h2 class="mb-1">Bài Viết <span class="theme">Mới Nhất</span></h2>
                <p>Cập nhật những tin tức mới nhất về bóng đá, kỹ thuật chơi bóng và các giải đấu hấp dẫn.
                </p>
            </div>
            <div class="recent-articles-inner">
                <div class="row">
                    <div class="col-lg-4">
                        <div class="trend-item box-shadow bg-white mb-4 rounded overflow-hidden">
                            <div class="trend-image">
                                <img src="images/trending/trending10.jpg" alt="Tin tức bóng đá">
                            </div>
                            <div class="trend-content-main p-4 pb-2">
                                <div class="trend-content">
                                    <h5 class="theme mb-1">Kỹ Thuật</h5>
                                    <h4><a href="detail-1.html">5 Bài Tập Cơ Bản Giúp Cải Thiện Kỹ Năng Chuyền Bóng</a></h4>
                                    <p class="mb-3">
                                        Hướng dẫn chi tiết các bài tập giúp nâng cao kỹ năng chuyền bóng chính xác
                                    </p>
                                    <div class="entry-meta d-flex align-items-center justify-content-between">
                                        <div class="entry-author mb-2">
                                            <img src="images/reviewer/2.jpg" alt="" class="rounded-circle me-1">
                                            <span>HLV Minh Tuấn</span>
                                        </div>
                                        <div class="entry-button d-flex align-items-centermb-2">
                                            <a href="#" class="nir-btn">Đọc Thêm</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-4 col-md-6">
                        <div class="trend-item box-shadow bg-white mb-4 rounded overflow-hidden">
                            <div class="trend-image">
                                <img src="images/trending/trending12.jpg" alt="Tin tức bóng đá">
                            </div>
                            <div class="trend-content-main p-4 pb-2">
                                <div class="trend-content">
                                    <h5 class="theme mb-1">Giải Đấu</h5>
                                    <h4><a href="detail-1.html">Giải Bóng Đá Nghiệp Dư TP.HCM Mùa Giải 2024</a>
                                    </h4>
                                    <p class="mb-3">
                                        Thông tin chi tiết về giải đấu bóng đá nghiệp dư lớn nhất thành phố
                                    </p>
                                    <div class="entry-meta d-flex align-items-center justify-content-between">
                                        <div class="entry-author mb-2">
                                            <img src="images/reviewer/1.jpg" alt="" class="rounded-circle me-1">
                                            <span>Ban Tổ Chức</span>
                                        </div>
                                        <div class="entry-button d-flex align-items-center mb-2">
                                            <a href="#" class="nir-btn">Đọc Thêm</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-4 col-md-6">
                        <div class="trend-item box-shadow bg-white mb-4 rounded overflow-hidden">
                            <div class="trend-image">
                                <img src="images/trending/trending13.jpg" alt="Tin tức bóng đá">
                            </div>
                            <div class="trend-content-main p-4 pb-2">
                                <div class="trend-content">
                                    <h5 class="theme mb-1">Sức Khỏe</h5>
                                    <h4><a href="detail-1.html">Chế Độ Dinh Dưỡng Cho Cầu Thủ Bóng Đá Nghiệp Dư</a></h4>
                                    <p class="mb-3">
                                        Hướng dẫn chế độ ăn uống khoa học giúp nâng cao thể lực và sức bền
                                    </p>
                                    <div class="entry-meta d-flex align-items-center justify-content-between">
                                        <div class="entry-author mb-2">
                                            <img src="images/reviewer/3.jpg" alt="" class="rounded-circle me-1">
                                            <span>BS Thể Thao</span>
                                        </div>
                                        <div class="entry-button d-flex align-items-center mb-2">
                                            <a href="#" class="nir-btn">Đọc Thêm</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- recent-articles ends -->

    <!-- footer starts -->
    <jsp:include page="footer.jsp"></jsp:include>
    <!-- footer ends -->

    <!-- Back to top start -->
    <div id="back-to-top">
        <a href="#"></a>
    </div>
    <!-- Back to top ends -->

    <!-- search popup -->
    <div id="search1">
        <button type="button" class="close">×</button>
        <form>
            <input type="search" value="" placeholder="Tìm kiếm sân bóng..." />
            <button type="submit" class="btn btn-primary">Tìm Kiếm</button>
        </form>
    </div>

    <!-- login registration modal -->
   <!-- Modal -->
<div class="modal fade log-reg" id="exampleModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div class="post-tabs">
                    <!-- Tab navs -->
                    <ul class="nav nav-tabs nav-pills nav-fill" id="postsTab" role="tablist">
                        <li class="nav-item" role="presentation">
                            <button aria-controls="login" aria-selected="false" class="nav-link active"
                                data-bs-target="#login" data-bs-toggle="tab" id="login-tab" role="tab"
                                 >Đăng Nhập</button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button aria-controls="register" aria-selected="true" class="nav-link"
                                data-bs-target="#register" data-bs-toggle="tab" id="register-tab" role="tab"
                                type="button">Đăng Ký</button>
                        </li>
                    </ul>

                    <!-- Tab contents -->
                    <div class="tab-content blog-full" id="postsTabContent">
                        <!-- Đăng Nhập -->
                        <div aria-labelledby="login-tab" class="tab-pane fade active show" id="login" role="tabpanel">
                            <div class="row">
                                <div class="col-lg-6">
                                    <div class="blog-image rounded" style="background-image: url(images/trending/trending5.jpg); height: 250px;"></div>
                                </div>
                                <div class="col-lg-6">
                                    <h4 class="text-center border-b pb-2">Đăng Nhập</h4>
                                    <hr class="log-reg-hr position-relative my-4 overflow-visible">
                                    <form method="post" action="${pageContext.request.contextPath}/login" name="contactform" id="contactform" onsubmit=" return checkLogin()">
                                        <div  class="form-group mb-2">
                                            <input type="text" name="username" class="form-control" id="username"
                                                   placeholder="Tên đăng nhập hoặc địa chỉ Email" autocomplete="off"  />
                                        </div>
                                        <div class="form-group mb-2">
                                            <input type="password" name="password" class="form-control"
                                                id="password" placeholder="Mật khẩu"  >
                                                
                                        </div>
                                        <a class="fas fa-eye " href ="#" onclick="daoTT()" > Hiện thị mật khẩu</a>
                                        <div id="loginError" class="text-danger mb-2" style="font-size: 14px;"></div>
                                        <div class="form-group mb-2">
                                            <input type="checkbox" name="remember" class="custom-control-input" id="rememberCheck">
                                            <label class="custom-control-label mb-0" for="rememberCheck">Nhớ Mật Khẩu</label>
                                            <a class="float-end" href="#">Quên mật khẩu?</a>
                                        </div>
                                        <div class="comment-btn mb-2 pb-2 text-center border-b">
                                            <input type="submit" class="nir-btn w-100" onclick="submitForm()" value="Đăng Nhập">

                                    
                                        </div>
                                        <p class="text-center">Bạn chưa có tài khoản? <a href="#" class="theme" onclick="event.preventDefault(); document.getElementById('register-tab').click();">Đăng Ký</a></p>
                                    </form>
                                </div>
                            </div>
                        </div>

                        <!-- Đăng Ký -->
                        <div aria-labelledby="register-tab" class="tab-pane fade" id="register" role="tabpanel">
                            <div class="row">
                                <div class="col-lg-6">
                                    <div class="blog-image rounded" style="background-image: url(images/trending/trending5.jpg); height: 250px;"></div>
                                </div>
                                <div class="col-lg-6">
                                    <h4 class="text-center border-b pb-2">Đăng Ký</h4>
                                    <hr class="log-reg-hr position-relative my-4 overflow-visible">
                                    <form method="post" action="#" name="contactform1" id="contactform1">
                                        <div class="form-group mb-2">
                                            <input type="text" name="user_name" class="form-control" id="fname1"
                                                placeholder="Tên đăng nhập" required>
                                        </div>
                                        <div class="form-group mb-2">
                                            <input type="email" name="user_email" class="form-control" id="femail"
                                                placeholder="Địa chỉ Email" required>
                                        </div>
                                        <div class="form-group mb-2">
                                            <input type="text" name="user_phone" class="form-control" id="fphone"
                                                placeholder="Số điện thoại" required>
                                        </div>
                                        <div class="form-group mb-2">
                                            <input type="password" name="password_name" class="form-control"
                                                id="lpass1" placeholder="Mật khẩu" required>
                                        </div>
                                        <div class="form-group mb-2">
                                            <input type="password" name="password_confirm" class="form-control"
                                                id="lrepass" placeholder="Xác nhận mật khẩu" required>
                                        </div>
                                        <div class="form-group mb-2 d-flex">
                                            <input type="checkbox" class="custom-control-input" id="registerCheck">
                                            <label class="custom-control-label mb-0 ms-1 lh-1" for="registerCheck">Tôi đã đọc và chấp nhận Điều khoản và Chính sách Bảo mật</label>
                                        </div>
                                        <div class="comment-btn mb-2 pb-2 text-center border-b">
                                            <input type="submit" class="nir-btn w-100" id="submit1" value="Đăng Ký">
                                        </div>
                                        <p class="text-center">Bạn đã có tài khoản? <a href="#" class="theme" onclick="event.preventDefault(); document.getElementById('login-tab').click();">Đăng Nhập</a></p>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div> <!-- tab-content -->
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Script -->

<script>
//document.addEventListener("DOMContentLoaded", function () {
//    const exampleModal = document.getElementById("exampleModal");
//    const usernameInput = document.getElementById("username");
//    const passwordInput = document.getElementById("password");
//    const errorDiv = document.getElementById("loginError");
//

//
//    // Hàm checkLogin gắn vào window
//    window.checkLogin = function () {
//        const username = usernameInput?.value.trim() || "";
//        const password = passwordInput?.value.trim() || "";
//
//        console.log("CheckLogin Called:", username, password);
//
//        if (!username || !password) {
//            if (errorDiv) errorDiv.textContent = "Vui lòng nhập tên đăng nhập và mật khẩu.";
//            return false;
//        }
//
//        if (errorDiv) errorDiv.textContent = "";
//        return true;
//    };
//
//    // Toggle hiển thị mật khẩu
//  

//document.addEventListener("DOMContentLoaded", function () {
//    const exampleModal = document.getElementById("exampleModal");
//    // Khi modal mở, focus vào input
//    if (exampleModal) {
//        exampleModal.addEventListener('shown.bs.modal', function () {
//            if (usernameInput) usernameInput.focus();
//        });
//
//        exampleModal.addEventListener('hidden.bs.modal', function () {
//            if (errorDiv) errorDiv.textContent = "";
//            if (usernameInput) usernameInput.value = "";
//            if (passwordInput) passwordInput.value = "";
//       });
//    }
//  window.daoTT = function () {
//        let mk = document.getElementById("password");
//        if (mk) {
//            mk.type = (mk.type === "password") ? "text" : "password";
//        }
//   };
//   window.checkLogin = function () {
//    const username = document.getElementById("username").value.trim();
//    const password = document.getElementById("password").value.trim();
//
//    console.log("CheckLogin Called:", username, password); // Debug
//
//    if (!username || !password) {
//        document.getElementById("loginError").textContent = "Vui lòng nhập tên đăng nhập và mật khẩu.";
//        return false;
//    }
//    return true;
//};
//});


document.addEventListener("DOMContentLoaded", function () {
    const exampleModal = document.getElementById("exampleModal");
    const errorDiv = document.getElementById("loginError");
    const usernameInput = document.getElementById("username");
    const passwordInput = document.getElementById("password");
    const  form = document.getElementById('contactform');

    // Tự động focus khi mở modal
    exampleModal.addEventListener('shown.bs.modal', function () {
        if (usernameInput) usernameInput.focus();
    });

    // Khi đóng modal: xóa lỗi + xóa nội dung các input
    exampleModal.addEventListener('hidden.bs.modal', function () {
        if (errorDiv) errorDiv.textContent = "";
        if (usernameInput) usernameInput.value = "";
        if (passwordInput) passwordInput.value = "";
    });

    // Hàm kiểm tra login
    window.checkLogin = function () {
        const username = usernameInput.value.trim();
        const password = passwordInput.value.trim();

        if (!username || !password) {
            errorDiv.textContent = "Vui lòng nhập tên đăng nhập và mật khẩu.";
            return false;
        } else {
            errorDiv.textContent = "";
            return true;
        }
    };

    // Hàm ẩn/hiện mật khẩu
    window.daoTT = function () {
        let mk = document.getElementById("password");
        mk.type = (mk.type === "password") ? "text" : "password";
    };
    
window.submitForm = function(){
    const contactform = form.value.trim();
        contactform.submit();
};
});


</script>



<link href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" rel="stylesheet">


    <!-- *Scripts* -->
    <script src="js/jquery-3.5.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/particles.js"></script>
    <script src="js/particlerun.js"></script>
    <script src="js/plugin.js"></script>
    <script src="js/main.js"></script>
    <script src="js/custom-swiper.js"></script>
    <script src="js/custom-nav.js"></script>
</body>

</html>