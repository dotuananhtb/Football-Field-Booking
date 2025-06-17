<%-- 
    Document   : admin
    Created on : Jun 15, 2025, 1:31:26 PM
    Author     : VAN NGUYEN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <base href="${pageContext.request.contextPath}/admin/">
        <title>ADMIN - Quản lí FootballStar</title>

        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
        <meta content="Coderthemes" name="author" />

        <!-- Them_1 sau "App favicon" -->
        <!-- App favicon -->

        <%@include file="head_only.jsp" %>
        <!-- End_Them_1 sau "App favicon" -->

    </head>

    <body>
        <!-- Begin page -->
        <div class="wrapper">

            <!-- Them_2 sau "Topbar Start" -->
            <!-- ========== Topbar Start ========== -->
            <jsp:include page="topbar.jsp"/>
            <!-- ========== Topbar End ========== -->
            <!-- End_Them_2 sau "Topbar End" -->

            <!-- Them_3 sau "Topbar Left Sidebar Start" -->
            <!-- ========== Left Sidebar Start ========== -->
            <jsp:include page="left_sidebar.jsp"/>
            <!-- ========== Left Sidebar End ========== -->
            <!-- End_Them_3 sau "Topbar Left Sidebar Start" -->







            <!-- Noi Dung Chinh Start -->


            <!-- ============================================================== -->
            <!-- Start Page Content here -->
            <!-- ============================================================== -->

            <div class="content-page">
                <div class="content">

                    <!-- Start Content-->
                    <div class="container-fluid">

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
                                        <form class="d-flex">
                                            <div class="input-group">
                                                <input type="text" class="form-control" id="dash-daterange">
                                                <span class="input-group-text bg-primary border-primary text-white">
                                                    <i class="ri-calendar-todo-fill fs-13"></i>
                                                </span>
                                            </div>
                                            <a href="javascript: void(0);" class="btn btn-primary ms-2">
                                                <i class="ri-refresh-line"></i>
                                            </a>
                                        </form>
                                    </div>
                                    <h4 class="page-title">Doanh Thu</h4>
                                </div>
                            </div>
                        </div>

                        <div class="row">

                            <div class="col-sm-6 col-xxl-3">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="row align-items-center">
                                            <div class="col-6">
                                                <h5 class="text-muted fw-normal mt-0 text-truncate" title="Campaign Sent">Campaign Sent</h5>
                                                <h3 class="my-1 py-1">9,184</h3>
                                                <p class="mb-0 text-muted">
                                                    <span class="text-success me-2"><i class="ri-arrow-up-line"></i> 3.27%</span>
                                                </p>
                                            </div>
                                            <div class="col-6">
                                                <div class="text-end">
                                                    <div id="campaign-sent-chart" data-colors="#6da09c"></div>
                                                </div>
                                            </div>
                                        </div> <!-- end row-->
                                    </div> <!-- end card-body -->
                                </div> <!-- end card -->
                            </div> <!-- end col -->

                            <div class="col-sm-6 col-xxl-3">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="row align-items-center">
                                            <div class="col-6">
                                                <h5 class="text-muted fw-normal mt-0 text-truncate" title="New Leads">New Leads</h5>
                                                <h3 class="my-1 py-1">3,254</h3>
                                                <p class="mb-0 text-muted">
                                                    <span class="text-success me-2"><i class="ri-arrow-up-line"></i> 5.38%</span>
                                                </p>
                                            </div>
                                            <div class="col-6">
                                                <div class="text-end">
                                                    <div id="new-leads-chart" data-colors="#87bf8a"></div>
                                                </div>
                                            </div>
                                        </div> <!-- end row-->
                                    </div> <!-- end card-body -->
                                </div> <!-- end card -->
                            </div> <!-- end col -->

                            <div class="col-sm-6 col-xxl-3">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="row align-items-center">
                                            <div class="col-6">
                                                <h5 class="text-muted fw-normal mt-0 text-truncate" title="Deals">Deals</h5>
                                                <h3 class="my-1 py-1">861</h3>
                                                <p class="mb-0 text-muted">
                                                    <span class="text-success me-2"><i class="ri-arrow-up-line"></i> 4.87%</span>
                                                </p>
                                            </div>
                                            <div class="col-6">
                                                <div class="text-end">
                                                    <div id="deals-chart" data-colors="#e7607b"></div>
                                                </div>
                                            </div>
                                        </div> <!-- end row-->
                                    </div> <!-- end card-body -->
                                </div> <!-- end card -->
                            </div> <!-- end col -->

                            <div class="col-sm-6 col-xxl-3">
                                <div class="card text-bg-primary border-primary">
                                    <div class="card-body">
                                        <div class="row align-items-center">
                                            <div class="col-6">
                                                <h5 class="text-white text-opacity-75 fw-normal mt-0 text-truncate" title="Booked Revenue">Booked Revenue</h5>
                                                <h3 class="my-1 py-1">$253k</h3>
                                                <p class="mb-0 text-muted">
                                                    <span class="text-white text-opacity-75 me-2"><i class="ri-arrow-up-line"></i> 11.7%</span>
                                                </p>
                                            </div>
                                            <div class="col-6">
                                                <div class="text-end">
                                                    <div id="booked-revenue-chart" data-colors="#d89e70"></div>
                                                </div>
                                            </div>
                                        </div> <!-- end row-->
                                    </div> <!-- end card-body -->
                                </div> <!-- end card -->
                            </div> <!-- end col -->
                        </div>
                        <!-- end row -->

                        <div class="row">
                            <div class="col-lg-4">
                                <div class="card">
                                    <div class="d-flex card-header border-bottom-0 justify-content-between align-items-center">
                                        <h4 class="header-title">Revenue</h4>
                                        <div class="dropdown">
                                            <a href="#" class="dropdown-toggle arrow-none card-drop" data-bs-toggle="dropdown" aria-expanded="false">
                                                <i class="ri-more-2-fill"></i>
                                            </a>
                                            <div class="dropdown-menu dropdown-menu-end">
                                                <!-- item-->
                                                <a href="javascript:void(0);" class="dropdown-item">Sales Report</a>
                                                <!-- item-->
                                                <a href="javascript:void(0);" class="dropdown-item">Export Report</a>
                                                <!-- item-->
                                                <a href="javascript:void(0);" class="dropdown-item">Profit</a>
                                                <!-- item-->
                                                <a href="javascript:void(0);" class="dropdown-item">Action</a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-body pt-0">
                                        <div dir="ltr">
                                            <div id="revenue-chart" class="apex-charts mt-3" data-colors="#6da09c,#47ad77"></div>
                                        </div>
                                    </div> <!-- end card-body-->
                                </div> <!-- end card-->
                            </div> <!-- end col-->
                            <div class="col-lg-4">
                                <div class="card">
                                    <div class="d-flex card-header justify-content-between border-bottom-0 align-items-center">
                                        <h4 class="header-title">Total Sales</h4>
                                        <div class="dropdown">
                                            <a href="#" class="dropdown-toggle arrow-none card-drop" data-bs-toggle="dropdown" aria-expanded="false">
                                                <i class="ri-more-2-fill"></i>
                                            </a>
                                            <div class="dropdown-menu dropdown-menu-end">
                                                <!-- item-->
                                                <a href="javascript:void(0);" class="dropdown-item">Sales Report</a>
                                                <!-- item-->
                                                <a href="javascript:void(0);" class="dropdown-item">Export Report</a>
                                                <!-- item-->
                                                <a href="javascript:void(0);" class="dropdown-item">Profit</a>
                                                <!-- item-->
                                                <a href="javascript:void(0);" class="dropdown-item">Action</a>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="card-body pt-0">
                                        <div id="average-sales" class="apex-charts mb-3"
                                             data-colors="#6da09c"></div>

                                        <h5 class="mb-1 mt-0 fw-normal">Brooklyn, New York</h5>
                                        <div class="progress-w-percent">
                                            <span class="progress-value fw-bold">72k </span>
                                            <div class="progress progress-sm">
                                                <div class="progress-bar" role="progressbar" style="width: 72%;" aria-valuenow="72" aria-valuemin="0" aria-valuemax="100"></div>
                                            </div>
                                        </div>

                                        <h5 class="mb-1 mt-0 fw-normal">The Castro, San Francisco</h5>
                                        <div class="progress-w-percent mb-0">
                                            <span class="progress-value fw-bold">39k </span>
                                            <div class="progress progress-sm">
                                                <div class="progress-bar" role="progressbar" style="width: 39%;" aria-valuenow="39" aria-valuemin="0" aria-valuemax="100"></div>
                                            </div>
                                        </div>
                                    </div> <!-- end card-body-->
                                </div> <!-- end card-->
                            </div> <!-- end col-->

                            <div class="col-lg-4">
                                <div class="card">
                                    <div class="d-flex card-header justify-content-between border-bottom-0 align-items-center">
                                        <h4 class="header-title">Total Sales</h4>
                                        <div class="dropdown">
                                            <a href="#" class="dropdown-toggle arrow-none card-drop" data-bs-toggle="dropdown" aria-expanded="false">
                                                <i class="ri-more-2-fill"></i>
                                            </a>
                                            <div class="dropdown-menu dropdown-menu-end">
                                                <!-- item-->
                                                <a href="javascript:void(0);" class="dropdown-item">Sales Report</a>
                                                <!-- item-->
                                                <a href="javascript:void(0);" class="dropdown-item">Export Report</a>
                                                <!-- item-->
                                                <a href="javascript:void(0);" class="dropdown-item">Profit</a>
                                                <!-- item-->
                                                <a href="javascript:void(0);" class="dropdown-item">Action</a>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="card-body pt-0">
                                        <div id="country-chart" class="apex-charts" data-colors="#6da09c"></div>

                                        <div class="mt-2 text-center">
                                            <ul class="list-inline mb-0">
                                                <li class="list-inline-item"><img class="ms-3 pe-1" src="assets/images/browsers/chrome.png" height="18" alt="chrome"><span class="align-middle">45.87%</span></li>
                                                <li class="list-inline-item"><img class="ms-3 pe-1" src="assets/images/browsers/firefox.png" height="18" alt="chrome"><span class="align-middle">3.25%</span></li>
                                                <li class="list-inline-item"><img class="ms-3 pe-1" src="assets/images/browsers/safari.png" height="18" alt="chrome"><span class="align-middle">9.68%</span></li>
                                            </ul>
                                        </div>
                                    </div> <!-- end card-body-->
                                </div> <!-- end card-->
                            </div> <!-- end col-->

                        </div>
                        <!-- end row -->

                        <div class="row">
                            <div class="col-xl-6">
                                <div class="card">
                                    <div class="d-flex card-header justify-content-between align-items-center">
                                        <h4 class="header-title">Top Selling Products</h4>
                                        <a href="javascript:void(0);" class="btn btn-sm btn-info">Export <i class="ri-download-line ms-1"></i></a>
                                    </div>
                                    <div class="card-body p-0">
                                        <div class="table-responsive">
                                            <table class="table table-borderless table-hover table-nowrap table-centered m-0">
                                                <thead class="border-top border-bottom bg-light-subtle border-light">
                                                    <tr>
                                                        <th class="py-1">Product</th>
                                                        <th class="py-1">Price</th>
                                                        <th class="py-1">Orders</th>
                                                        <th class="py-1">Avl. Quantity</th>
                                                        <th class="py-1">Seller</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td>ASOS Ridley High Waist</td>
                                                        <td>$79.49</td>
                                                        <td>82</td>
                                                        <td>8,540</td>
                                                        <td>Adidas</td>
                                                    </tr>
                                                    <tr>
                                                        <td>Marco Lightweight Shirt</td>
                                                        <td>$12.5</td>
                                                        <td>58</td>
                                                        <td>6,320</td>
                                                        <td>Puma</td>
                                                    </tr>
                                                    <tr>
                                                        <td>Half Sleeve Shirt</td>
                                                        <td>$9.99</td>
                                                        <td>254</td>
                                                        <td>10,258</td>
                                                        <td>Nike</td>
                                                    </tr>
                                                    <tr>
                                                        <td>Lightweight Jacket</td>
                                                        <td>$69.99</td>
                                                        <td>560</td>
                                                        <td>1,020</td>
                                                        <td>Puma</td>
                                                    </tr>
                                                    <tr>
                                                        <td>Marco Sport Shoes</td>
                                                        <td>$119.99</td>
                                                        <td>75</td>
                                                        <td>357</td>
                                                        <td>Adidas</td>
                                                    </tr>
                                                    <tr>
                                                        <td>Custom Women's T-shirts</td>
                                                        <td>$45.00</td>
                                                        <td>85</td>
                                                        <td>135</td>
                                                        <td>Branded</td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                        <div class="text-center">
                                            <a href="#!" class="text-primary text-decoration-underline fw-bold btn mb-2">View All</a>
                                        </div>
                                    </div>
                                </div>
                            </div> <!-- end col -->

                            <div class="col-xl-6">
                                <div class="card">
                                    <div class="d-flex card-header justify-content-between align-items-center">
                                        <h4 class="header-title">Revenue By Locations</h4>
                                        <div class="dropdown">
                                            <a href="#" class="dropdown-toggle arrow-none card-drop" data-bs-toggle="dropdown" aria-expanded="false">
                                                <i class="ri-more-2-fill"></i>
                                            </a>
                                            <div class="dropdown-menu dropdown-menu-end">
                                                <!-- item-->
                                                <a href="javascript:void(0);" class="dropdown-item">Sales Report</a>
                                                <!-- item-->
                                                <a href="javascript:void(0);" class="dropdown-item">Export Report</a>
                                                <!-- item-->
                                                <a href="javascript:void(0);" class="dropdown-item">Profit</a>
                                                <!-- item-->
                                                <a href="javascript:void(0);" class="dropdown-item">Action</a>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-12">
                                                <div id="world-map-markers" class="mt-3 mb-3" style="height: 298px">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div> <!-- end card-->
                            </div> <!-- end col -->
                        </div>
                        <!-- end row -->

                    </div>
                    <!-- container -->

                </div>
                <!-- content -->
                <!-- Them_4 sau "Footer Start" -->
                <!-- Footer Start -->
                <%@include file="footer.jsp" %>
                <!-- end Footer -->
                <!-- End_Them_4 sau "Footer end" -->
            </div>

            <!-- ============================================================== -->
            <!-- End Page content -->
            <!-- ============================================================== -->
            <!-- Nho them include footer.jsp ở trên -->




            <!-- Noi Dung Chinh End -->

        </div>
        <!-- END wrapper -->

        <!-- Theme Settings -->
        <%@include file="themesetting.jsp" %>
    </body>
</html> 
