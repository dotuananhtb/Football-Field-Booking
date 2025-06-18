$(document).ready(function () {
    "use strict";

    const viLanguage = {
        processing: "Đang xử lý...",
        search: "Tìm kiếm:",
        lengthMenu: "Hiển thị _MENU_ dòng mỗi trang",
        info: "Hiển thị _START_ đến _END_ trong tổng _TOTAL_ dòng",
        infoEmpty: "Không có dữ liệu để hiển thị",
        infoFiltered: "(lọc từ tổng _MAX_ dòng)",
        loadingRecords: "Đang tải dữ liệu...",
        zeroRecords: "Không tìm thấy kết quả phù hợp",
        emptyTable: "Không có dữ liệu trong bảng",
        paginate: {
            first: "Đầu",
            previous: "<i class='ri-arrow-left-s-line'></i>",
            next: "<i class='ri-arrow-right-s-line'></i>",
            last: "Cuối"
        }
    };

    function addRounded() {
        $(".dataTables_paginate > .pagination").addClass("pagination-rounded");
    }

    // Basic table
    $("#basic-datatable").DataTable({
        keys: true,
        language: viLanguage,
        drawCallback: addRounded
    });

    // Table with buttons
    const dtBtn = $("#datatable-buttons").DataTable({
        lengthChange: false,
        buttons: ["copy", "print"],
        language: viLanguage,
        drawCallback: addRounded
    });
    dtBtn.buttons().container().appendTo("#datatable-buttons_wrapper .col-md-6:eq(0)");

    // Multi-select table
    $("#selection-datatable").DataTable({
        select: { style: "multi" },
        language: viLanguage,
        drawCallback: addRounded
    });

    // Pagination style table
    $("#alternative-page-datatable").DataTable({
        pagingType: "full_numbers",
        language: viLanguage,
        drawCallback: addRounded
    });

    // Vertical scroll
    $("#scroll-vertical-datatable").DataTable({
        scrollY: "350px",
        scrollCollapse: true,
        paging: false,
        language: viLanguage,
        drawCallback: addRounded
    });

    // Horizontal scroll
    $("#scroll-horizontal-datatable").DataTable({
        scrollX: true,
        language: viLanguage,
        drawCallback: addRounded
    });

    // Complex header
    $("#complex-header-datatable").DataTable({
        columnDefs: [{ visible: false, targets: -1 }],
        language: viLanguage,
        drawCallback: addRounded
    });

    // Row callback
    $("#row-callback-datatable").DataTable({
        language: viLanguage,
        drawCallback: addRounded,
        createdRow: function (row, data, index) {
            if (+data[5].replace(/[\$,]/g, "") > 150000) {
                $("td", row).eq(5).addClass("text-danger");
            }
        }
    });

    // State saving
    $("#state-saving-datatable").DataTable({
        stateSave: true,
        language: viLanguage,
        drawCallback: addRounded
    });

    // Fixed columns
    $("#fixed-columns-datatable").DataTable({
        scrollY: 300,
        scrollX: true,
        scrollCollapse: true,
        paging: false,
        fixedColumns: true
    });

    // Giao diện form
    $(".dataTables_length select").addClass("form-select form-select-sm");
    $(".dataTables_length label").addClass("form-label");

    // Fixed header
    const dtFixedHeader = $("#fixed-header-datatable").DataTable({
        responsive: true,
        language: viLanguage,
        drawCallback: addRounded
    });
    new $.fn.dataTable.FixedHeader(dtFixedHeader);
});
