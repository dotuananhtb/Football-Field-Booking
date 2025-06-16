<%-- 
    Document   : danhSachSan
    Created on : Jun 14, 2025, 12:19:19 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US" lang="en-US">

    <head>
        <base href="${pageContext.request.contextPath}/UI/">

            <meta charset="utf-8">
                <title>FootballStar - Danh sách sân</title>

                <meta name="author" content="themesflat.com">
                    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

                        <link rel="stylesheet" href="app/css/app.css">
                            <link rel="stylesheet" href="app/css/jquery.fancybox.min.css">
                                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.13/flatpickr.min.css">

                                    <!-- Favicon and Touch Icons  -->
                                    <link rel="shortcut icon" href="assets/images/favico.png">
                                        <link rel="apple-touch-icon-precomposed" href="assets/images/favico.png">
                                            <style>
                                                .date-input {
                                                    width: 100%;
                                                    padding: 10px 15px;
                                                    border: 2px solid #e0e0e0;
                                                    border-radius: 6px;
                                                    font-size: 14px;
                                                    background-color: white;
                                                    transition: border-color 0.3s ease;
                                                }

                                                .date-input:focus {
                                                    outline: none;
                                                    border-color: #4CAF50;
                                                    box-shadow: 0 0 0 3px rgba(76, 175, 80, 0.1);
                                                }

                                                .date-input:hover {
                                                    border-color: #4CAF50;
                                                }

                                                /* Styling cho date picker */
                                                .date-input::-webkit-calendar-picker-indicator {
                                                    background-color: #4CAF50;
                                                    border-radius: 3px;
                                                    padding: 2px;
                                                    cursor: pointer;
                                                }

                                                .date-input::-webkit-calendar-picker-indicator:hover {
                                                    background-color: #45a049;
                                                }

                                                /* Alternative styling với Flatpickr */
                                                .flatpickr-input {
                                                    width: 100%;
                                                    padding: 10px 15px;
                                                    border: 2px solid #e0e0e0;
                                                    border-radius: 6px;
                                                    font-size: 14px;
                                                    background-color: white;
                                                    cursor: pointer;
                                                }

                                                .flatpickr-input:focus {
                                                    outline: none;
                                                    border-color: #4CAF50;
                                                    box-shadow: 0 0 0 3px rgba(76, 175, 80, 0.1);
                                                }

                                                .book-btn button {
                                                    background: linear-gradient(135deg, #28a745, #20c997);
                                                    color: white;
                                                    border: none;
                                                    padding: 8px 16px;
                                                    border-radius: 6px;
                                                    font-size: 12px;
                                                    font-weight: 600;
                                                    cursor: pointer;
                                                    transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
                                                    white-space: nowrap;
                                                    min-width: auto;
                                                    position: relative;
                                                    overflow: hidden;
                                                    box-shadow: 0 4px 15px rgba(40, 167, 69, 0.2);
                                                }

                                                /* Hiệu ứng sóng khi hover */
                                                .book-btn button::before {
                                                    content: '';
                                                    position: absolute;
                                                    top: 50%;
                                                    left: 50%;
                                                    width: 0;
                                                    height: 0;
                                                    background: rgba(255, 255, 255, 0.3);
                                                    border-radius: 50%;
                                                    transform: translate(-50%, -50%);
                                                    transition: width 0.6s ease, height 0.6s ease;
                                                }

                                                .book-btn button:hover::before {
                                                    width: 300px;
                                                    height: 300px;
                                                }

                                                .book-btn button:hover {
                                                    background: linear-gradient(135deg, #218838, #1e7e34);
                                                    transform: translateY(-3px) scale(1.05);
                                                    box-shadow: 0 8px 25px rgba(40, 167, 69, 0.4);
                                                }

                                                .book-btn button:active {
                                                    transform: translateY(-1px) scale(1.02);
                                                    transition: all 0.1s ease;
                                                }
                                                .feature.maintenance {
                                                    background-color: #f59e0b !important;
                                                    color: white !important;
                                                    border-color: #d97706 !important;
                                                }

                                                .feature.broken {
                                                    background-color: #ef4444 !important;
                                                    color: white !important;
                                                    border-color: #dc2626 !important;
                                                }
                                            </style>
                                            </head>

                                            <body class="body header-fixed ">

                                                <div class="preload preload-container">
                                                    <svg class="pl" width="240" height="240" viewBox="0 0 240 240">
                                                        <circle class="pl__ring pl__ring--a" cx="120" cy="120" r="105" fill="none" stroke="#000" stroke-width="20"
                                                                stroke-dasharray="0 660" stroke-dashoffset="-330" stroke-linecap="round"></circle>
                                                        <circle class="pl__ring pl__ring--b" cx="120" cy="120" r="35" fill="none" stroke="#000" stroke-width="20"
                                                                stroke-dasharray="0 220" stroke-dashoffset="-110" stroke-linecap="round"></circle>
                                                        <circle class="pl__ring pl__ring--c" cx="85" cy="120" r="70" fill="none" stroke="#000" stroke-width="20"
                                                                stroke-dasharray="0 440" stroke-linecap="round"></circle>
                                                        <circle class="pl__ring pl__ring--d" cx="155" cy="120" r="70" fill="none" stroke="#000" stroke-width="20"
                                                                stroke-dasharray="0 440" stroke-linecap="round"></circle>
                                                    </svg>
                                                </div>

                                                <!-- /preload -->

                                                <div id="wrapper">
                                                    <div id="pagee" class="clearfix">

                                                        <jsp:include page="header.jsp" />

                                                        <!-- End Main Header -->
                                                        <main id="main">

                                                            <section class="breadcumb-section">
                                                                <div class="tf-container">
                                                                    <div class="row">
                                                                        <div class="col-lg-12 center z-index1">
                                                                            <h1 class="title">Tour Package v2</h1>
                                                                            <ul class="breadcumb-list flex-five">
                                                                                <li><a href="index.html">Home</a></li>
                                                                                <li><span>Tour Package</span></li>
                                                                            </ul>
                                                                            <img class="bcrumb-ab" src="./assets/images/page/mask-bcrumb.png" alt="">
                                                                        </div>
                                                                    </div>

                                                                </div>
                                                            </section>

                                                            <!-- Widget Select Form -->
                                                            <div class="mt--82 z-index3 relative">
                                                                <div class="tf-container">
                                                                    <div class="row">
                                                                        <div class="col-lg-12">
                                                                            <div class="search-form-widget-slider relative">
                                                                                <form action="/" id="search-form-slider">
                                                                                    <div class="flex wd-search">
                                                                                        <div class="form-group flex">
                                                                                            <i class="icon-18"></i>
                                                                                            <div class="search-bar-group">
                                                                                                <label>Destination</label>
                                                                                                <div class="nice-select" tabindex="0">
                                                                                                    <span class="current">
                                                                                                        <c:choose>
                                                                                                            <c:when test="${not empty param.zid}">
                                                                                                                <c:forEach items="${listZ}" var="z">
                                                                                                                    <c:if test="${z.zoneId == param.zid}">
                                                                                                                        ${z.address}
                                                                                                                    </c:if>
                                                                                                                </c:forEach>
                                                                                                            </c:when>
                                                                                                            <c:otherwise>Vị trí</c:otherwise>
                                                                                                        </c:choose>
                                                                                                    </span>
                                                                                                    <ul class="list">
                                                                                                        <c:forEach items="${listZ}" var="z">
                                                                                                            <li data-value="${z.zoneId}" class="option">
                                                                                                                <a href="${pageContext.request.contextPath}/KhuVuc?zid=${z.zoneId}">
                                                                                                                    ${z.address}
                                                                                                                </a>
                                                                                                            </li>
                                                                                                        </c:forEach>
                                                                                                    </ul>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>

                                                                                        <div class="form-group flex">
                                                                                            <i class="icon-15"></i>
                                                                                            <div class="search-bar-group">
                                                                                                <label>Loại Sân</label>
                                                                                                <div class="nice-select" tabindex="0">
                                                                                                    <span class="current">Sân 7 người</span>
                                                                                                    <ul class="list">
                                                                                                        <li data-value="san5" class="option">Sân 5 người</li>
                                                                                                        <li data-value="san7" class="option selected">Sân 7 người
                                                                                                        </li>
                                                                                                        <li data-value="san11" class="option">Sân 11 người</li>
                                                                                                        <li data-value="futsal" class="option">Sân Futsal</li>
                                                                                                    </ul>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>

                                                                                        <div class="form-group flex">
                                                                                            <i class="icon-time-left"></i>
                                                                                            <div class="search-bar-group">
                                                                                                <label>Giờ Đặt</label>
                                                                                                <div class="nice-select" tabindex="0">
                                                                                                    <span class="current">7:00 - 9:00</span>
                                                                                                    <ul class="list">
                                                                                                        <li data-value="7-9" class="option selected">7:00 - 9:00
                                                                                                        </li>
                                                                                                        <li data-value="9-11" class="option">9:00 - 11:00</li>
                                                                                                        <li data-value="14-16" class="option">14:00 - 16:00</li>
                                                                                                        <li data-value="16-18" class="option">16:00 - 18:00</li>
                                                                                                        <li data-value="18-20" class="option">18:00 - 20:00</li>
                                                                                                        <li data-value="20-22" class="option">20:00 - 22:00</li>
                                                                                                    </ul>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>

                                                                                        <div class="form-group flex">
                                                                                            <i class="icon-Group-111"></i>
                                                                                            <div class="search-bar-group">
                                                                                                <label>Ngày Đặt</label>
                                                                                                <input type="text" class="flatpickr-input" id="bookingDateAdvanced"
                                                                                                       placeholder="Chọn ngày đặt" readonly>
                                                                                            </div>
                                                                                        </div>

                                                                                        <div class="form-group flex-two">

                                                                                            <a href="#" class="btn-search"><i class="icon-Vector5"></i>Search</a>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="wd-search-form">
                                                                                        <div class="input-group-grid">
                                                                                            <fieldset class="group-select relative ">
                                                                                                <label>Filter By Price</label>
                                                                                                <div class="widget widget-price ">
                                                                                                    <div id="slider-range"></div>
                                                                                                    <div class="slider-labels">
                                                                                                        <div>
                                                                                                            <input type="hidden" name="min-value" value="">
                                                                                                                <input type="hidden" name="max-value" value="">
                                                                                                                    </div>
                                                                                                                    <div class="caption flex-three">
                                                                                                                        <p class="price-range">Price: </p>
                                                                                                                        <div class="number-range">
                                                                                                                            <span id="slider-range-value1"></span>
                                                                                                                            <span id="slider-range-value2"></span>
                                                                                                                        </div>
                                                                                                                    </div>

                                                                                                                    </div>
                                                                                                                    </div><!-- /.widget_price -->
                                                                                                                    </fieldset>
                                                                                                                    <fieldset class="group-select relative input-npd ">
                                                                                                                        <div class="search-bar-group relative">
                                                                                                                            <label>0</label>
                                                                                                                            <div class="nice-select" tabindex="0">
                                                                                                                                <span class="current">English</span>
                                                                                                                                <ul class="list">
                                                                                                                                    <li data-value="" class="option selected focus">Language
                                                                                                                                    </li>
                                                                                                                                    <li data-value="language1" class="option">Japan</li>
                                                                                                                                    <li data-value="language2" class="option">Vietnames</li>
                                                                                                                                    <li data-value="language3" class="option">Korea</li>
                                                                                                                                </ul>
                                                                                                                            </div>
                                                                                                                        </div>
                                                                                                                    </fieldset>
                                                                                                                    <fieldset class="group-select relative input-npd ">
                                                                                                                        <div class="search-bar-group relative">
                                                                                                                            <label>Any</label>
                                                                                                                            <div class="nice-select" tabindex="0">
                                                                                                                                <span class="current">Month</span>
                                                                                                                                <ul class="list">
                                                                                                                                    <li data-value="" class="option selected focus">Month
                                                                                                                                    </li>
                                                                                                                                    <li data-value="month1" class="option">1 Month</li>
                                                                                                                                    <li data-value="month2" class="option">2 Month</li>
                                                                                                                                    <li data-value="month3" class="option">3 Month</li>
                                                                                                                                </ul>
                                                                                                                            </div>
                                                                                                                        </div>
                                                                                                                    </fieldset>
                                                                                                                    <fieldset class="group-select relative input-npd">
                                                                                                                        <div class="search-bar-group relative">
                                                                                                                            <label>Any</label>
                                                                                                                            <div class="nice-select" tabindex="0">
                                                                                                                                <span class="current">Duration</span>
                                                                                                                                <ul class="list">
                                                                                                                                    <li data-value="" class="option selected focus">Duration
                                                                                                                                    </li>
                                                                                                                                    <li data-value="duration1" class="option">10-15 day</li>
                                                                                                                                    <li data-value="duration2" class="option">15-30 day</li>
                                                                                                                                    <li data-value="duration3" class="option">20-30 day</li>
                                                                                                                                </ul>
                                                                                                                            </div>
                                                                                                                        </div>
                                                                                                                    </fieldset>
                                                                                                                    <div class="group-check-box-wrap">
                                                                                                                        <div class="checkbox">
                                                                                                                            <input id="check4" type="checkbox" name="check" value="check">
                                                                                                                                <label for="check4">Accepts Credit Cards</label>
                                                                                                                        </div>
                                                                                                                        <div class="checkbox">
                                                                                                                            <input id="check5" type="checkbox" name="check" value="check">
                                                                                                                                <label for="check5">Car Parking</label>
                                                                                                                        </div>
                                                                                                                    </div>
                                                                                                                    <div class="group-check-box-wrap">
                                                                                                                        <div class="checkbox">
                                                                                                                            <input id="check6" type="checkbox" name="check" value="check">
                                                                                                                                <label for="check6">Free Coupons</label>
                                                                                                                        </div>
                                                                                                                        <div class="checkbox">
                                                                                                                            <input id="check7" type="checkbox" name="check" value="check">
                                                                                                                                <label for="check7">Laundry Service</label>
                                                                                                                        </div>
                                                                                                                    </div>
                                                                                                                    <div class="group-check-box-wrap">
                                                                                                                        <div class="checkbox">
                                                                                                                            <input id="check8" type="checkbox" name="check" value="check">
                                                                                                                                <label for="check8">Outdoor Seating</label>
                                                                                                                        </div>
                                                                                                                        <div class="checkbox">
                                                                                                                            <input id="check9" type="checkbox" name="check" value="check">
                                                                                                                                <label for="check9">Reservations</label>
                                                                                                                        </div>
                                                                                                                    </div>
                                                                                                                    <div class="group-check-box-wrap">
                                                                                                                        <div class="checkbox">
                                                                                                                            <input id="check10" type="checkbox" name="check" value="check">
                                                                                                                                <label for="check10">Restaurant</label>
                                                                                                                        </div>
                                                                                                                        <div class="checkbox">
                                                                                                                            <input id="check11" type="checkbox" name="check" value="check">
                                                                                                                                <label for="check11">Smoking Allowed</label>
                                                                                                                        </div>
                                                                                                                    </div>
                                                                                                                    </div>
                                                                                                                    </div>

                                                                                                                    </form>
                                                                                                                    </div>
                                                                                                                    </div>
                                                                                                                    </div>
                                                                                                                    </div>
                                                                                                                    </div>
                                                                                                                    <!-- Widget Select Form -->

                                                                                                                    <!-- Widget archieve tour -->
                                                                                                                    <section class="archieve-tour">
                                                                                                                        <div class="tf-container">

                                                                                                                            <div class="row">
                                                                                                                                <div class="col-lg-4">
                                                                                                                                    <form action="/" class="sider-bar-tour-package" >
                                                                                                                                        <div class="widget-filter mb-40">
                                                                                                                                            <h6 class="title-tour">Search by Filter</h6>
                                                                                                                                            <div class="group-select-wrap">
                                                                                                                                                <fieldset class="group-select relative mb-22">
                                                                                                                                                    <i class="icon-Vector-8"></i>
                                                                                                                                                    <div class="search-bar-group relative">
                                                                                                                                                        <label>Địa Điểm</label>
                                                                                                                                                        <div class="nice-select" tabindex="0">
                                                                                                                                                            <span class="current">
                                                                                                                                                                <c:choose>
                                                                                                                                                                    <c:when test="${not empty selectedZoneId}">
                                                                                                                                                                        <c:forEach items="${listZ}" var="z">
                                                                                                                                                                            <c:if test="${z.zoneId == selectedZoneId}">
                                                                                                                                                                                ${z.address}
                                                                                                                                                                            </c:if>
                                                                                                                                                                        </c:forEach>
                                                                                                                                                                    </c:when>
                                                                                                                                                                    <c:otherwise>Tất cả</c:otherwise>
                                                                                                                                                                </c:choose>
                                                                                                                                                            </span>
                                                                                                                                                            <ul class="list">
                                                                                                                                                                <!-- Lựa chọn 'Tất cả' -->
                                                                                                                                                                <li data-value="" class="option">
                                                                                                                                                                    <a href="${pageContext.request.contextPath}/KhuVuc">Tất cả</a>
                                                                                                                                                                </li>

                                                                                                                                                                <!-- Các khu vực -->
                                                                                                                                                                <c:forEach items="${listZ}" var="z">
                                                                                                                                                                    <li data-value="${z.zoneId}" class="option">
                                                                                                                                                                        <a href="${pageContext.request.contextPath}/KhuVuc?zid=${z.zoneId}">
                                                                                                                                                                            ${z.address}
                                                                                                                                                                        </a>
                                                                                                                                                                    </li>
                                                                                                                                                                </c:forEach>
                                                                                                                                                            </ul>
                                                                                                                                                        </div>


                                                                                                                                                    </div>
                                                                                                                                                </fieldset>
                                                                                                                                                <fieldset class="group-select relative mb-22">
                                                                                                                                                    <i class="icon-15"></i>
                                                                                                                                                    <div class="search-bar-group relative">
                                                                                                                                                        <label>Sân Bóng</label>
                                                                                                                                                        <div class="nice-select" tabindex="0">
                                                                                                                                                            <span class="current">Loại Sân</span>
                                                                                                                                                            <ul class="list">
                                                                                                                                                                <li data-value="" class="option selected focus">Lựa Chọn
                                                                                                                                                                </li>
                                                                                                                                                                <li data-value="4seat" class="option">Sân 5 người</li>
                                                                                                                                                                <li data-value="7seat" class="option">Quận 1</li>
                                                                                                                                                                <li data-value="12seat" class="option">Quận 1</li>
                                                                                                                                                                <li data-value="32seat" class="option">Quận 1</li>
                                                                                                                                                            </ul>
                                                                                                                                                        </div>
                                                                                                                                                    </div>
                                                                                                                                                </fieldset>
                                                                                                                                                <fieldset class="group-select relative mb-22">
                                                                                                                                                    <i class="icon-Group-111"></i>
                                                                                                                                                    <div class="search-bar-group relative">
                                                                                                                                                        <label>Date</label>
                                                                                                                                                        <div class="nice-select" tabindex="0">
                                                                                                                                                            <span class="current">Date From</span>

                                                                                                                                                        </div>
                                                                                                                                                    </div>
                                                                                                                                                </fieldset>
                                                                                                                                                <fieldset class="group-select relative mb-40">
                                                                                                                                                    <h6 class="title-tour">Filter By Price</h6>
                                                                                                                                                    <div class="widget widget-price ">
                                                                                                                                                        <div id="slider-range2"></div>
                                                                                                                                                        <div class="slider-labels">
                                                                                                                                                            <div>
                                                                                                                                                                <input type="hidden" name="min-value2" value="">
                                                                                                                                                                    <input type="hidden" name="max-value2" value="">
                                                                                                                                                                        </div>
                                                                                                                                                                        <div class="caption flex-three">
                                                                                                                                                                            <p class="price-range">Price: </p>
                                                                                                                                                                            <div class="number-range">
                                                                                                                                                                                <span id="slider-range-value01"></span>
                                                                                                                                                                                <span id="slider-range-value02"></span>
                                                                                                                                                                            </div>
                                                                                                                                                                        </div>
                                                                                                                                                                        </div>
                                                                                                                                                                        </div><!-- /.widget_price -->
                                                                                                                                                                        </fieldset>
                                                                                                                                                                        </div>
                                                                                                                                                                        </div>
                                                                                                                                                                        <div class="widget-filter mb-40">
                                                                                                                                                                            <h6 class="title-tour">Search by Filter</h6>
                                                                                                                                                                            <div class="group-check-box-wrap">
                                                                                                                                                                                <div class="checkbox">
                                                                                                                                                                                    <input id="check" type="checkbox" name="check" value="check">
                                                                                                                                                                                        <label for="check">10+</label>
                                                                                                                                                                                </div>
                                                                                                                                                                                <div class="checkbox">
                                                                                                                                                                                    <input id="check1" type="checkbox" name="check" value="check">
                                                                                                                                                                                        <label for="check1">12+</label>
                                                                                                                                                                                </div>
                                                                                                                                                                                <div class="checkbox">
                                                                                                                                                                                    <input id="check2" type="checkbox" name="check" value="check">
                                                                                                                                                                                        <label for="check2">15+</label>
                                                                                                                                                                                </div>
                                                                                                                                                                                <div class="checkbox">
                                                                                                                                                                                    <input id="check3" type="checkbox" name="check" value="check">
                                                                                                                                                                                        <label for="check3">Adults</label>
                                                                                                                                                                                </div>
                                                                                                                                                                            </div>
                                                                                                                                                                        </div>
                                                                                                                                                                        <div class="widget-filter mb-40">
                                                                                                                                                                            <h6 class="title-tour">Search by Filter</h6>
                                                                                                                                                                            <div class="group-check-box-wrap">
                                                                                                                                                                                <div class="checkbox">
                                                                                                                                                                                    <input id="check4-bar" type="checkbox" name="check" value="check">
                                                                                                                                                                                        <label for="check4-bar">Accepts Credit Cards</label>
                                                                                                                                                                                </div>
                                                                                                                                                                                <div class="checkbox">
                                                                                                                                                                                    <input id="check5-bar" type="checkbox" name="check" value="check">
                                                                                                                                                                                        <label for="check5-bar">Car Parking</label>
                                                                                                                                                                                </div>
                                                                                                                                                                                <div class="checkbox">
                                                                                                                                                                                    <input id="check6-bar" type="checkbox" name="check" value="check">
                                                                                                                                                                                        <label for="check6-bar">Free Coupons</label>
                                                                                                                                                                                </div>
                                                                                                                                                                                <div class="checkbox">
                                                                                                                                                                                    <input id="check7-bar" type="checkbox" name="check" value="check">
                                                                                                                                                                                        <label for="check7-bar">Laundry Service</label>
                                                                                                                                                                                </div>
                                                                                                                                                                                <div class="checkbox">
                                                                                                                                                                                    <input id="check8-bar" type="checkbox" name="check" value="check">
                                                                                                                                                                                        <label for="check8-bar">Outdoor Seating</label>
                                                                                                                                                                                </div>
                                                                                                                                                                                <div class="checkbox">
                                                                                                                                                                                    <input id="check9-bar" type="checkbox" name="check" value="check">
                                                                                                                                                                                        <label for="check9-bar">Reservations</label>
                                                                                                                                                                                </div>
                                                                                                                                                                                <div class="checkbox">
                                                                                                                                                                                    <input id="check10-bar" type="checkbox" name="check" value="check">
                                                                                                                                                                                        <label for="check10-bar">Restaurant</label>
                                                                                                                                                                                </div>
                                                                                                                                                                                <div class="checkbox">
                                                                                                                                                                                    <input id="check11-bar" type="checkbox" name="check" value="check">
                                                                                                                                                                                        <label for="check11-bar">Smoking Allowed</label>
                                                                                                                                                                                </div>
                                                                                                                                                                            </div>
                                                                                                                                                                        </div>
                                                                                                                                                                        </form>
                                                                                                                                                                        </div>
                                                                                                                                                                        <div class="col-lg-8 listing-list-car-wrap">
                                                                                                                                                                            <form  action="${pageContext.request.contextPath}/DanhSachSan" class="tf-my-listing mb-37">
                                                                                                                                                                                <input type="hidden" name="sortBy" id="sortByInput" value="${sortBy}">
                                                                                                                                                                                    <div class="row align-center">
                                                                                                                                                                                        <div class="col-sm-5">
                                                                                                                                                                                            <p class="showing">Showing <span class="text-main">${showing}</span> of ${total} Results
                                                                                                                                                                                            </p>
                                                                                                                                                                                        </div>
                                                                                                                                                                                        <div class="col-sm-7 group-bar-wrap flex-six">
                                                                                                                                                                                            <div class="listing-all-wrap">
                                                                                                                                                                                                <div class="flex-three">
                                                                                                                                                                                                    <div class="group-select-recently">
                                                                                                                                                                                                        <div class="nice-select" tabindex="0">
                                                                                                                                                                                                        <i class="icon-Vector6"></i>
                                                                                                                                                                                                        <span class="current">
                                                                                                                                                                                                        <c:choose>
                                                                                                                                                                                                        <c:when test="${sortBy == 'new'}">New</c:when>
                                                                                                                                                                                                        <c:when test="${sortBy == 'recent'}">Recently Added</c:when>
                                                                                                                                                                                                        <c:otherwise>Sort by</c:otherwise>
                                                                                                                                                                                                        </c:choose>
                                                                                                                                                                                                        </span>
                                                                                                                                                                                                        <ul class="list">
                                                                                                                                                                                                        <li class="option ${sortBy == 'new' ? 'selected focus' : ''}">
                                                                                                                                                                                                        <a href="${pageContext.request.contextPath}/DanhSachSan?sortBy=new">New</a>
                                                                                                                                                                                                        </li>
                                                                                                                                                                                                        <li class="option ${sortBy == 'recent' ? 'selected focus' : ''}">
                                                                                                                                                                                                        <a href="${pageContext.request.contextPath}/DanhSachSan?sortBy=recent">Recently Added</a>
                                                                                                                                                                                                        </li>
                                                                                                                                                                                                        </ul>
                                                                                                                                                                                                        </div>
                                                                                                                                                                                                    </div>
                                                                                                                                                                                                    <div class="toolbar-list">
                                                                                                                                                                                                        <div class="form-group">
                                                                                                                                                                                                        <a class="btn-display-listing-grid active">
                                                                                                                                                                                                        <i class="icon-list"></i>
                                                                                                                                                                                                        </a>
                                                                                                                                                                                                        </div>
                                                                                                                                                                                                        <div class="form-group">
                                                                                                                                                                                                        <a class="btn-display-listing-list">
                                                                                                                                                                                                        <i class="icon-Group-1000001297"></i>
                                                                                                                                                                                                        </a>
                                                                                                                                                                                                        </div>
                                                                                                                                                                                                    </div>
                                                                                                                                                                                                </div>
                                                                                                                                                                                            </div>
                                                                                                                                                                                        </div>
                                                                                                                                                                                    </div>
                                                                                                                                                                            </form>
                                                                                                                                                                            <div class="listing-list-car-grid mb-60">
                                                                                                                                                                                <c:forEach items="${listF}" var="o">
                                                                                                                                                                                    <div class="tour-listing box-sd">
                                                                                                                                                                                        <a href="tour-single.html" class="tour-listing-image">
                                                                                                                                                                                            <div class="badge-top flex-two">
                                                                                                                                                                                                <span class="feature
                                                                                                                                                                                                      <c:choose>
                                                                                                                                                                                                        <c:when test="${o.status == 'Bảo trì'}">maintenance</c:when>
                                                                                                                                                                                                        <c:when test="${o.status == 'Hỏng'}">broken</c:when>
                                                                                                                                                                                                        <c:otherwise></c:otherwise>
                                                                                                                                                                                                      </c:choose>">${o.status}</span>
                                                                                                                                                                                            </div>
                                                                                                                                                                                            <img src="${o.image}" alt="Image Listing">
                                                                                                                                                                                        </a>
                                                                                                                                                                                        <div class="tour-listing-content">
                                                                                                                                                                                            <span class="map"><i class="icon-Vector4"></i>${o.zone.address}</span>
                                                                                                                                                                                            <h3 class="title-tour-list"><a href="tour-single.html">${o.fieldName}</a>
                                                                                                                                                                                            </h3>
                                                                                                                                                                                            <div class="icon-box flex-three">
                                                                                                                                                                                                <div class="icons flex-three">
                                                                                                                                                                                                    <i class="icon-time-left"></i>
                                                                                                                                                                                                    <span>5 days</span>
                                                                                                                                                                                                </div>
                                                                                                                                                                                                <div class="icons flex-three">
                                                                                                                                                                                                    <i class="icon-user"></i>
                                                                                                                                                                                                    <span>${o.typeOfField.fieldTypeName}</span>
                                                                                                                                                                                                </div>
                                                                                                                                                                                            </div>
                                                                                                                                                                                            <div class="flex-two">
                                                                                                                                                                                                <div class="price-box flex-three">
                                                                                                                                                                                                    <p>From <span class="price-sale">$169.00</span></p>
                                                                                                                                                                                                    <span class="price">$199.00</span>
                                                                                                                                                                                                </div>
                                                                                                                                                                                                <div class="book-btn flex-three">
                                                                                                                                                                                                    <button type="submit">Đặt sân</button>
                                                                                                                                                                                                </div>
                                                                                                                                                                                            </div>
                                                                                                                                                                                        </div>
                                                                                                                                                                                    </div>
                                                                                                                                                                                </c:forEach>
                                                                                                                                                                            </div>
                                                                                                                                                                            <div class="row">
                                                                                                                                                                                <div class="col-md-12 ">
                                                                                                                                                                                    <ul class="tf-pagination flex-three">
                                                                                                                                                                                        <li>
                                                                                                                                                                                            <c:if test="${page > 1}">
                                                                                                                                                                                                <a class="pages-link" href="${pageContext.request.contextPath}/DanhSachSan?index=${page - 1}&sortBy=${sortBy}"><i class="icon-29"></i></a>
                                                                                                                                                                                                </c:if>
                                                                                                                                                                                        </li>
                                                                                                                                                                                        <c:forEach begin="1" end="${endP}" var="p">
                                                                                                                                                                                            <li>
                                                                                                                                                                                                <a class="pages-link ${p == page ? 'active' : ''}"  href="${pageContext.request.contextPath}/DanhSachSan?index=${p}&sortBy=${sortBy}">${p}</a>
                                                                                                                                                                                            </li>
                                                                                                                                                                                        </c:forEach>
                                                                                                                                                                                        <li>
                                                                                                                                                                                            <c:if test="${page * 6 < total}">
                                                                                                                                                                                                <a class="pages-link" href="${pageContext.request.contextPath}/DanhSachSan?index=${page + 1}&sortBy=${sortBy}"><i class=" icon--1"></i></a>
                                                                                                                                                                                                </c:if>
                                                                                                                                                                                        </li>
                                                                                                                                                                                    </ul>

                                                                                                                                                                                </div>
                                                                                                                                                                            </div>

                                                                                                                                                                        </div>
                                                                                                                                                                        </div>

                                                                                                                                                                        </div>
                                                                                                                                                                        </section>
                                                                                                                                                                        <!-- Widget archieve tour -->

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
                                                                                                                                                                        <!-- Flatpickr JS -->
                                                                                                                                                                        <script src="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.13/flatpickr.min.js"></script>
                                                                                                                                                                        <!-- Flatpickr Vietnamese locale -->
                                                                                                                                                                        <script src="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.13/l10n/vn.js"></script>
                                                                                                                                                                        <script>
                                                                                                                                                                            // Initialize Flatpickr for date picker
                                                                                                                                                                            const datePicker = flatpickr("#bookingDateAdvanced", {
                                                                                                                                                                                locale: "vn",
                                                                                                                                                                                dateFormat: "d/m/Y",
                                                                                                                                                                                minDate: "today",
                                                                                                                                                                                defaultDate: new Date(),
                                                                                                                                                                                enableTime: false,
                                                                                                                                                                                clickOpens: true,
                                                                                                                                                                                allowInput: false,
                                                                                                                                                                                onChange: function (selectedDates, dateStr, instance) {
                                                                                                                                                                                    console.log("Ngày được chọn:", dateStr);
                                                                                                                                                                                }
                                                                                                                                                                            });

                                                                                                                                                                            // Custom nice-select functionality
                                                                                                                                                                            document.querySelectorAll('.nice-select').forEach(select => {
                                                                                                                                                                                select.addEventListener('click', function (e) {
                                                                                                                                                                                    e.stopPropagation();

                                                                                                                                                                                    // Close all other selects
                                                                                                                                                                                    document.querySelectorAll('.nice-select').forEach(otherSelect => {
                                                                                                                                                                                        if (otherSelect !== this) {
                                                                                                                                                                                            otherSelect.classList.remove('open');
                                                                                                                                                                                        }
                                                                                                                                                                                    });

                                                                                                                                                                                    // Toggle current select
                                                                                                                                                                                    this.classList.toggle('open');
                                                                                                                                                                                });

                                                                                                                                                                                // Handle option selection
                                                                                                                                                                                select.querySelectorAll('.option').forEach(option => {
                                                                                                                                                                                    option.addEventListener('click', function (e) {
                                                                                                                                                                                        e.stopPropagation();

                                                                                                                                                                                        const selectElement = this.closest('.nice-select');
                                                                                                                                                                                        const currentSpan = selectElement.querySelector('.current');
                                                                                                                                                                                        const hiddenInput = selectElement.parentElement.querySelector('input[type="hidden"]');

                                                                                                                                                                                        // Remove selected class from all options
                                                                                                                                                                                        selectElement.querySelectorAll('.option').forEach(opt => {
                                                                                                                                                                                            opt.classList.remove('selected');
                                                                                                                                                                                        });

                                                                                                                                                                                        // Add selected class to clicked option
                                                                                                                                                                                        this.classList.add('selected');

                                                                                                                                                                                        // Update current text and hidden input value
                                                                                                                                                                                        currentSpan.textContent = this.textContent;
                                                                                                                                                                                        if (hiddenInput) {
                                                                                                                                                                                            hiddenInput.value = this.getAttribute('data-value');
                                                                                                                                                                                        }

                                                                                                                                                                                        // Close dropdown
                                                                                                                                                                                        selectElement.classList.remove('open');
                                                                                                                                                                                    });
                                                                                                                                                                                });
                                                                                                                                                                            });

                                                                                                                                                                            // Close dropdowns when clicking outside
                                                                                                                                                                            document.addEventListener('click', function () {
                                                                                                                                                                                document.querySelectorAll('.nice-select').forEach(select => {
                                                                                                                                                                                    select.classList.remove('open');
                                                                                                                                                                                });
                                                                                                                                                                            });

                                                                                                                                                                            // Handle search button click
                                                                                                                                                                            document.querySelector('.btn-search').addEventListener('click', function (e) {
                                                                                                                                                                                e.preventDefault();

                                                                                                                                                                                // Validate required fields
                                                                                                                                                                                const bookingDate = document.getElementById('bookingDateAdvanced').value;
                                                                                                                                                                                if (!bookingDate) {
                                                                                                                                                                                    alert('Vui lòng chọn ngày đặt sân!');
                                                                                                                                                                                    return;
                                                                                                                                                                                }

                                                                                                                                                                                // Submit form to servlet
                                                                                                                                                                                document.getElementById('search-form-slider').submit();
                                                                                                                                                                            });

                                                                                                                                                                            // Handle form submission
                                                                                                                                                                            document.getElementById('search-form-slider').addEventListener('submit', function (e) {
                                                                                                                                                                                const bookingDate = document.getElementById('bookingDateAdvanced').value;
                                                                                                                                                                                if (!bookingDate) {
                                                                                                                                                                                    e.preventDefault();
                                                                                                                                                                                    alert('Vui lòng chọn ngày đặt sân!');
                                                                                                                                                                                    return false;
                                                                                                                                                                                }
                                                                                                                                                                            });

                                                                                                                                                                            // Ensure date picker is clickable
                                                                                                                                                                            document.getElementById('bookingDateAdvanced').addEventListener('click', function () {
                                                                                                                                                                                if (this._flatpickr) {
                                                                                                                                                                                    this._flatpickr.open();
                                                                                                                                                                                }
                                                                                                                                                                            });
                                                                                                                                                                        </script>
                                                                                                                                                                        <!--sắp xếp-->

                                                                                                                                                                        <script src="app/js/jquery.min.js"></script>
                                                                                                                                                                        <script src="app/js/jquery.nice-select.min.js"></script>
                                                                                                                                                                        <script src="app/js/bootstrap.min.js"></script>
                                                                                                                                                                        <script src="app/js/swiper-bundle.min.js"></script>
                                                                                                                                                                        <script src="app/js/swiper.js"></script>
                                                                                                                                                                        <script src="app/js/plugin.js"></script>
                                                                                                                                                                        <script src="app/js/jquery.fancybox.js"></script>
                                                                                                                                                                        <script src="app/js/price-ranger.js"></script>
                                                                                                                                                                        <script src="app/js/shortcodes.js"></script>
                                                                                                                                                                        <script src="app/js/main.js"></script>

                                                                                                                                                                        </body>

                                                                                                                                                                        </html>
