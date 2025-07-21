<%-- 
    Document   : shop
    Created on : Jun 21, 2025, 2:58:22 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US" lang="en-US">

    <head>
        <base href="${pageContext.request.contextPath}/UI/">
            <meta charset="utf-8">
                <title>FootballStar - Cửa hàng</title>

                <meta name="author" content="themesflat.com">
                    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

                        <link rel="stylesheet" href="app/css/app.css">
                            <link rel="stylesheet" href="app/css/jquery.fancybox.min.css">

                                <!-- Favicon and Touch Icons  -->
                                <link rel="shortcut icon" href="assets/images/favico.png">
                                    <link rel="apple-touch-icon-precomposed" href="assets/images/favico.png">
                                        <style>
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
                                            .form-group.flex-five {
                                                flex: 5;
                                            }
                                            .search-bar-group {
                                                flex: 1;
                                            }
                                            .search-bar-group input {
                                                width: 100%;
                                                border: none;
                                                outline: none;
                                                font-size: 14px;
                                                color: #212529;
                                                font-weight: 500;
                                                background: transparent;
                                                padding: 0;
                                            }

                                            .search-bar-group input::placeholder {
                                                color: #6c757d;
                                                font-weight: 400;
                                            }

                                            .form-group-btn {
                                                display: flex;
                                                align-items: center;
                                                gap: 10px;
                                            }
                                            /* Responsive design */
                                            @media (max-width: 768px) {
                                                .wd-search {
                                                    flex-direction: column;
                                                    gap: 0;
                                                }

                                                .form-group {
                                                    border-right: none;
                                                    border-bottom: 1px solid #e8ecef;
                                                    padding: 20px;
                                                    min-height: auto;
                                                }

                                                .form-group:last-of-type {
                                                    border-bottom: none;
                                                }

                                                .form-group-btn {
                                                    padding: 20px;
                                                    justify-content: center;
                                                    width: 100%;
                                                }

                                                .search-form-widget-slider {
                                                    margin-top: 20px;
                                                    padding: 0;
                                                    border-radius: 12px;
                                                }

                                                .btn-search {
                                                    width: 100%;
                                                    max-width: 200px;
                                                }
                                            }

                                            /* Animation */
                                            @keyframes fadeIn {
                                                from {
                                                    opacity: 0;
                                                    transform: translateY(20px);
                                                }
                                                to {
                                                    opacity: 1;
                                                    transform: translateY(0);
                                                }
                                            }

                                            .search-form-widget-slider {
                                                animation: fadeIn 0.5s ease-out;
                                            }
                                            .tf-pagination .pages-link {
                                                display: inline-block;
                                                width: 40px;
                                                height: 40px;
                                                line-height: 40px;
                                                text-align: center;
                                                border-radius: 50%;
                                                background-color: white;
                                                color: #0c1e35;
                                                font-weight: 500;
                                                border: 1px solid #ddd;
                                                transition: all 0.3s ease;
                                                margin: 0 4px;
                                                cursor: pointer;
                                                font-size: 16px;
                                                padding: 0;
                                            }

                                            .tf-pagination .pages-link:hover,
                                            .tf-pagination .pages-link.active {
                                                background-color: #4CAF50; /* màu xanh lá */
                                                color: white;
                                                border-color: #4CAF50;
                                            }
                                        </style>

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
                                                                        <h1 class="title">Cửa hàng</h1>
                                                                        <ul class="breadcumb-list flex-five">
                                                                            <li><a href="/FB_N1/home">Trang chủ</a></li>
                                                                            <li><span>Danh sách sản phẩm</span></li>
                                                                        </ul>
                                                                        <img class="bcrumb-ab" src="./assets/images/page/mask-bcrumb.png" alt="">
                                                                    </div>
                                                                </div>

                                                            </div>
                                                        </section>

                                                        <!-- Widget Select Form -->
                                                        <form mehtod="get" action="${pageContext.request.contextPath}/Shop">
                                                            <!-- Widget Select Form -->
                                                            <div class="mt--82 z-index3 relative">
                                                                <div class="tf-container">
                                                                    <div class="row">
                                                                        <div class="col-lg-12">
                                                                            <div class="search-form-widget-slider relative">
                                                                                <div class="flex wd-search">
                                                                                    <!-- Ô nhập tên sân -->
                                                                                    <div class="form-group flex-five">
                                                                                        <i class="icon-18"></i>
                                                                                        <div class="search-bar-group">
                                                                                            <label for="keyword">Tên sân</label>
                                                                                            <input type="text"
                                                                                                   id="keyword"
                                                                                                   name="keyword"
                                                                                                   placeholder="Nhập tên sân bạn muốn tìm..."
                                                                                                   value="${fn:escapeXml(param.keyword)}"
                                                                                                   required />
                                                                                        </div>
                                                                                    </div>
                                                                                    <!-- Nút tìm kiếm -->
                                                                                    <div class="form-group flex-two">
                                                                                        <button type="submit" class="btn-search">
                                                                                            <i class="icon-Vector5"></i>
                                                                                            Tìm kiếm
                                                                                        </button>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <!-- Widget Select Form -->

                                                            <!-- Widget archieve tour -->
                                                            <section class="archieve-tour">
                                                                <div class="tf-container">

                                                                    <div class="tf-my-listing1 mb-37">
                                                                        <div class="row align-center">
                                                                            <div class="col-md-8">
                                                                                <p class="showing">Hiện thị <span class="text-main">${showing}</span> / ${total} Tổng số sản phẩm</p>
                                                                                <div class="flex-three filter-tour-package">
                                                                                    <div class="nice-select" tabindex="0">
                                                                                        <i class="icon-Vector-41"></i>
                                                                                        <span class="current">
                                                                                            <c:choose>
                                                                                                <c:when test="${not empty param.productCateId}">
                                                                                                    <c:forEach var="c" items="${listC}">
                                                                                                        <c:if test="${c.productCateId == param.productCateId}">
                                                                                                            ${c.cateName}
                                                                                                        </c:if>
                                                                                                    </c:forEach>
                                                                                                </c:when>
                                                                                                <c:otherwise>Tất cả sản phẩm</c:otherwise>
                                                                                            </c:choose>
                                                                                        </span>
                                                                                        <ul class="list">
                                                                                            <li data-value="" class="option ${empty param.productCateId ? 'selected focus' : ''}" 
                                                                                                onclick="filterByCategory('')">Tất cả sản phẩm</li>
                                                                                                <c:forEach items="${listC}" var="c">
                                                                                                <li data-value="${c.productCateId}"
                                                                                                    class="option ${param.productCateId == c.productCateId ? 'selected focus' : ''}"
                                                                                                    onclick="filterByCategory('${c.productCateId}')">
                                                                                                    ${c.cateName}
                                                                                                </li>
                                                                                            </c:forEach>
                                                                                        </ul>
                                                                                    </div>
                                                                                    <div class="nice-select" tabindex="0" id="pageSizeSelector">
                                                                                        <span class="current">${pageSize} sản phẩm</span>
                                                                                        <ul class="list">
                                                                                            <li data-value="8" class="option ${pageSize == 6 ? 'selected focus' : ''}">8 sản phẩm</li>
                                                                                            <li data-value="12" class="option ${pageSize == 12 ? 'selected focus' : ''}">12 sản phẩm</li>
                                                                                        </ul>
                                                                                    </div>
                                                                                    <div class="nice-select price-filter" tabindex="0">
                                                                                        <span class="current">
                                                                                            <c:choose>
                                                                                                <c:when test="${not empty param.minPrice or not empty param.maxPrice}">
                                                                                                    Giá: 
                                                                                                    <c:if test="${not empty param.minPrice}">${param.minPrice}</c:if>
                                                                                                    <c:if test="${not empty param.minPrice and not empty param.maxPrice}"> - </c:if>
                                                                                                    <c:if test="${not empty param.maxPrice}">${param.maxPrice}</c:if>
                                                                                                </c:when>
                                                                                                <c:otherwise>Khoảng giá</c:otherwise>
                                                                                            </c:choose>
                                                                                        </span>
                                                                                        <ul class="list">
                                                                                            <li data-value="" class="option ${empty param.minPrice and empty param.maxPrice ? 'selected focus' : ''}"
                                                                                                onclick="filterByPrice('', '')">Tất cả</li>
                                                                                            <li class="option" onclick="filterByPrice('0', '100000')">Dưới 100,000₫</li>
                                                                                            <li class="option" onclick="filterByPrice('100000', '500000')">100,000₫ - 500,000₫</li>
                                                                                            <li class="option" onclick="filterByPrice('500000', '1000000')">500,000₫ - 1,000,000₫</li>
                                                                                            <li class="option" onclick="filterByPrice('1000000', '')">Trên 1,000,000₫</li>
                                                                                        </ul>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-4  flex-six">
                                                                                <div class="listing-all-wrap">
                                                                                    <div class="group-select-recently">
                                                                                        <div class="nice-select" tabindex="0">
                                                                                            <span class="current">
                                                                                                <c:choose>
                                                                                                    <c:when test="${param.sortBy == 'new'}">Mới nhất</c:when>
                                                                                                    <c:when test="${param.sortBy == 'price_low'}">Giá thấp đến cao</c:when>
                                                                                                    <c:when test="${param.sortBy == 'price_high'}">Giá cao đến thấp</c:when>
                                                                                                    <c:when test="${param.sortBy == 'name_asc'}">Tên A-Z</c:when>
                                                                                                    <c:when test="${param.sortBy == 'name_desc'}">Tên Z-A</c:when>
                                                                                                    <c:otherwise>Sắp xếp</c:otherwise>
                                                                                                </c:choose>
                                                                                            </span>
                                                                                            <ul class="list">
                                                                                                <li data-value="new" class="option ${param.sortBy == 'new' ? 'selected focus' : ''}"
                                                                                                    onclick="sortProducts('new')">Mới nhất</li>
                                                                                                <li data-value="price_low" class="option ${param.sortBy == 'price_low' ? 'selected focus' : ''}"
                                                                                                    onclick="sortProducts('price_low')">Giá thấp đến cao</li>
                                                                                                <li data-value="price_high" class="option ${param.sortBy == 'price_high' ? 'selected focus' : ''}"
                                                                                                    onclick="sortProducts('price_high')">Giá cao đến thấp</li>
                                                                                                <li data-value="name_asc" class="option ${param.sortBy == 'name_asc' ? 'selected focus' : ''}"
                                                                                                    onclick="sortProducts('name_asc')">Tên A-Z</li>
                                                                                                <li data-value="name_desc" class="option ${param.sortBy == 'name_desc' ? 'selected focus' : ''}"
                                                                                                    onclick="sortProducts('name_desc')">Tên Z-A</li>
                                                                                            </ul>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="row">
                                                                        <c:forEach items="${ListP}" var="p">
                                                                            <div class="col-sm-6 col-xl-3 mb-32">
                                                                                <div class="tour-listing box-sd">
                                                                                    <a href="/FB_N1/product-details?productId=${p.productId}" class="tour-listing-image">
                                                                                        <div class="badge-top flex-two">
                                                                                            <c:choose>
                                                                                                <c:when test="${p.productStatus == 'Sản phẩm mới'}">
                                                                                                    <span class="feature maintenance">${p.productStatus}</span>
                                                                                                </c:when>
                                                                                                <c:when test="${p.productStatus == 'Hết hàng'}">
                                                                                                    <span class="feature broken">${p.productStatus}</span>
                                                                                                </c:when>
                                                                                                <c:otherwise>
                                                                                                    <span class="feature">${p.productStatus}</span>
                                                                                                </c:otherwise>
                                                                                            </c:choose>
                                                                                        </div>
                                                                                        <img src="${p.productImage}" alt="Image Listing">
                                                                                    </a>

                                                                                    <div class="tour-listing-content">

                                                                                        <h3 class="title-tour-list"><a href="/FB_N1/product-details?productId=${p.productId}">${p.productName}</a></h3>
                                                                                        <div class="icon-box flex-three">
                                                                                            <div class="icons flex-three">
                                                                                                <i class="icon-time-left"></i>
                                                                                                <span>${p.cateProduct.cateName}</span>
                                                                                            </div>

                                                                                        </div>
                                                                                        <div class="icon-box flex-three">
                                                                                            <div class="icons flex-three">
                                                                                                <span>${p.productDescription}</span>
                                                                                            </div>

                                                                                        </div>
                                                                                        <div class="flex-two">
                                                                                            <div class="price-box flex-three">
                                                                                                <p>Giá:  <span class="price-sale"><fmt:formatNumber value="${p.productPrice}" type="number" groupingUsed="true"/> ₫</span></p>

                                                                                            </div>

                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </c:forEach>
                                                                    </div>
                                                                    <div class="row mt-20">
                                                                        <div class="col-md-12 ">
                                                                            <ul class="tf-pagination flex-three">
                                                                                <!-- Previous Button -->
                                                                                <li>
                                                                                    <c:if test="${page > 1}">
                                                                                        <button type="button" class="pages-link" onclick="goToPage(${page - 1})">
                                                                                            <i class="icon-29"></i>
                                                                                        </button>
                                                                                    </c:if>
                                                                                </li>

                                                                                <!-- Page Numbers -->
                                                                                <c:forEach begin="1" end="${endP}" var="p">
                                                                                    <li>
                                                                                        <button type="button" class="pages-link ${p == page ? 'active' : ''}" onclick="goToPage(${p})">
                                                                                            ${p}
                                                                                        </button>
                                                                                    </li>
                                                                                </c:forEach>

                                                                                <!-- Next Button -->
                                                                                <li>
                                                                                    <c:if test="${page < endP}">
                                                                                        <button type="button" class="pages-link" onclick="goToPage(${page + 1})">
                                                                                            <i class="icon--1"></i>
                                                                                        </button>
                                                                                    </c:if>
                                                                                </li>
                                                                            </ul>

                                                                        </div>
                                                                    </div>

                                                                </div>
                                                            </section>
                                                        </form>




                                                    </main>

                                                    <jsp:include page="footer.jsp" />

                                                    <!-- Bottom -->
                                                </div>
                                                <!-- /#page -->
                                            </div>

                                            <!-- Modal Popup Bid -->

                                            <a id="scroll-top" class="button-go"></a>



                                            <!-- Javascript -->
                                            <script>
                                                function formatPrice(price) {
                                                    return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".");
                                                }
                                            </script>
                                            <script>
                                                function getUrlParams() {
                                                    const params = new URLSearchParams(window.location.search);
                                                    return {
                                                        index: params.get('index') || '1',
                                                        productCateId: params.get('productCateId') || '',
                                                        productName: params.get('productName') || '',
                                                        minPrice: params.get('minPrice') || '',
                                                        maxPrice: params.get('maxPrice') || '',
                                                        sortBy: params.get('sortBy') || ''
                                                    };
                                                }

                                                function updateUrl(newParams) {
                                                    const currentParams = getUrlParams();
                                                    const params = {...currentParams, ...newParams};

                                                    // Remove empty parameters
                                                    Object.keys(params).forEach(key => {
                                                        if (params[key] === '' || params[key] === null) {
                                                            delete params[key];
                                                        }
                                                    });

                                                    // Always reset to page 1 when filtering
                                                    if (newParams.productCateId !== undefined || newParams.productName !== undefined ||
                                                            newParams.minPrice !== undefined || newParams.maxPrice !== undefined ||
                                                            newParams.sortBy !== undefined) {
                                                        params.index = '1';
                                                    }

                                                    const urlParams = new URLSearchParams(params);
                                                    window.location.href = '${pageContext.request.contextPath}/Shop?' + urlParams.toString();
                                                }

                                                function filterByCategory(categoryId) {
                                                    updateUrl({productCateId: categoryId});
                                                }

                                                function searchProducts() {
                                                    const productName = document.getElementById('productNameSearch').value.trim();
                                                    updateUrl({productName: productName});
                                                }

                                                function filterByPrice(minPrice = null, maxPrice = null) {
                                                    if (minPrice === null && maxPrice === null) {
                                                        minPrice = document.getElementById('minPrice').value;
                                                        maxPrice = document.getElementById('maxPrice').value;
                                                    }
                                                    updateUrl({minPrice: minPrice, maxPrice: maxPrice});
                                                }

                                                function sortProducts(sortBy) {
                                                    updateUrl({sortBy: sortBy});
                                                }

                                                // Clear all filters
                                                function clearFilters() {
                                                    window.location.href = '${pageContext.request.contextPath}/products';
                                                }
                                                function goToPage(pageNumber) {
                                                    // Lấy URL hiện tại và các parameter
                                                    const urlParams = new URLSearchParams(window.location.search);

                                                    // Set page number
                                                    urlParams.set('index', pageNumber);

                                                    // Redirect với tất cả parameter
                                                    window.location.href = window.location.pathname + '?' + urlParams.toString();
                                                }
                                                document.addEventListener('DOMContentLoaded', function () {
                                                    const selector = document.getElementById('pageSizeSelector');
                                                    const options = selector.querySelectorAll('.option');

                                                    // Xử lý click vào option
                                                    options.forEach(option => {
                                                        option.addEventListener('click', function () {
                                                            const selectedValue = this.getAttribute('data-value');
                                                            changePageSize(selectedValue);
                                                        });
                                                    });
                                                });
                                                function changePageSize(newPageSize) {
                                                    // Lấy URL hiện tại và các parameter
                                                    const urlParams = new URLSearchParams(window.location.search);

                                                    // Set page size mới
                                                    urlParams.set('pageSize', newPageSize);

                                                    // Reset về trang 1 khi thay đổi page size
                                                    urlParams.set('index', '1');

                                                    // Redirect với tất cả parameter
                                                    window.location.href = window.location.pathname + '?' + urlParams.toString();
                                                }
                                            </script>
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
