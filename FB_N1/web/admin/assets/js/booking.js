/* global bootstrap */

let currentBookingCode = null;

$(document).ready(function () {
    const table = $('#booking-datatable').DataTable({
        scrollX: true,
        orderCellsTop: true,
        ajax: {
            url: '/FB_N1/admin/booking',
            dataSrc: ''
        },
        columns: [
            { data: null, title: 'STT', render: (data, type, row, meta) => meta.row + 1 },
            { data: 'booking_code', title: 'Mã đơn', render: data => safeText(data) },
            { data: 'booking_date', title: 'Ngày đặt', render: data => safeText(data) },
            {
                data: 'total_amount',
                title: 'Tổng tiền',
                render: data => formatPrice(data)
            },
            { data: 'customer_name', title: 'Khách hàng', render: data => safeText(data) },
            { data: 'customer_phone', title: 'SĐT', render: data => safeText(data) },
            {
                data: 'customer_type',
                title: 'Loại KH',
                render: data => data === 'online'
                    ? '<span class="badge bg-success">Online</span>'
                    : (data === 'offline'
                        ? '<span class="badge bg-secondary">Offline</span>'
                        : '<span class="badge bg-secondary">-</span>')
            },
            {
                data: 'status_pay',
                title: 'TT Thanh toán',
                render: data => {
                    switch (data) {
                        case -1:
                            return '<span class="badge bg-danger">Đã huỷ do quá hạn</span>';
                        case 0:
                            return '<span class="badge bg-warning text-dark">Chờ thanh toán online</span>';
                        case 1:
                            return '<span class="badge bg-success">Đã thanh toán</span>';
                        case 2:
                            return '<span class="badge bg-secondary">Thanh toán sau</span>';
                        default:
                            return '<span class="badge bg-secondary">Không xác định</span>';
                    }
                }
            },
            {
                data: null,
                title: 'Hành động',
                render: (data, type, row) => `
                    <button class="btn btn-sm btn-outline-primary btn-view-slots" 
                        data-booking-code="${safeText(row.booking_code)}">
                        <i class="bi bi-eye"></i> Xem ca
                    </button>
                `
            }
        ],
        pageLength: 10,
        language: {
            info: "Hiển thị _START_ đến _END_ trong tổng _TOTAL_ dòng",
            infoEmpty: "Không có dữ liệu để hiển thị",
            lengthMenu: "Hiển thị _MENU_ dòng mỗi trang",
            search: "Tìm kiếm:",
            zeroRecords: "Không tìm thấy kết quả phù hợp",
            emptyTable: "Không có dữ liệu trong bảng",
            paginate: {
                previous: "<i class='ri-arrow-left-s-line'></i>",
                next: "<i class='ri-arrow-right-s-line'></i>"
            }
        },
        drawCallback: () => {
            $(".dataTables_paginate > .pagination").addClass("pagination-rounded");
        }
    });

    $(document).on('click', '.btn-view-slots', function () {
        currentBookingCode = $(this).data('bookingCode');
        loadBookingDetails(currentBookingCode);
    });
});

function loadBookingDetails(bookingCode) {
    $.get('/FB_N1/admin/booking/details', { bookingCode: bookingCode }, function (data) {
        const container = $('#booking-slots-container');
        container.empty();

        if (!data || data.length === 0) {
            container.append(`<p class="text-center fst-italic">Không có ca nào trong đơn này</p>`);
        } else {
            data.forEach((slot, index) => {
                container.append(`
                    <div class="border rounded p-2 mb-2 bg-light">
                        <div class="fw-bold mb-1">
                            #${index + 1} | ${safeText(slot.slot_date)} ${safeText(slot.start_time)} - ${safeText(slot.end_time)}
                        </div>
                        <div class="mb-1">
                            <i class="bi bi-geo-alt-fill"></i> ${safeText(slot.field_name)} (${safeText(slot.field_type_name)})
                        </div>
                        <div class="mb-1">
                            <i class="bi bi-cash-stack"></i> 
                            Giá: <span class="text-success">${formatPrice(slot.price)}</span> | 
                            Extra: ${safeText(slot.extra_minutes, 0)} phút (+${formatPrice(slot.extra_fee)})
                        </div>
                        <div class="mb-1">
                            Trạng thái: ${renderStatus(safeText(slot.status_name))}
                        </div>
                        <div>
                            Ghi chú: <span class="fst-italic">${safeText(slot.note)}</span>
                        </div>
                    </div>
                `);
            });
        }

        const modal = new bootstrap.Modal(document.getElementById('bookingSlotModal'));
        modal.show();
    }).fail(function () {
        showToast("error", "❌ Lỗi tải chi tiết ca!");
    });
}

function formatPrice(price) {
    return price !== null && price !== undefined
        ? $.fn.dataTable.render.number(',', '.', 0, '', ' đ').display(price)
        : '-';
}

function safeText(value, fallback = '-') {
    return value !== null && value !== undefined && value !== '' ? value : fallback;
}

function renderStatus(statusName) {
    const mapColor = {
        'Đã đặt': 'bg-success',
        'Đang chờ huỷ': 'bg-warning text-dark',
        'Đã huỷ': 'bg-danger',
        'Chờ thanh toán': 'bg-info text-dark'
    };
    const color = mapColor[statusName] || 'bg-secondary';
    return `<span class="badge ${color}">${safeText(statusName)}</span>`;
}
