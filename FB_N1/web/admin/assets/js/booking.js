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
            { data: null, render: (data, type, row, meta) => meta.row + 1 },
            { data: 'booking_code', render: data => safeText(data) },
            { data: 'booking_date', render: data => safeText(data) },
            {
                data: 'total_amount',
                render: (data, type) => type === 'sort' ? data || 0 : formatPrice(data)
            },
            { data: 'customer_name', render: data => safeText(data) },
            { data: 'customer_phone', render: data => safeText(data) },
            {
                data: 'customer_type',
                render: data => {
                    if (data === 'online') return '<span class="badge bg-success">Online</span>';
                    if (data === 'offline') return '<span class="badge bg-secondary">Offline</span>';
                    return '<span class="badge bg-secondary">-</span>';
                }
            },
            {
                data: 'status_pay',
                render: data => renderPayStatus(data)
            },
            {
                data: null,
                orderable: false,
                render: (data, type, row) => {
                    const qrButton = (row.status_pay === 0 || row.status_pay === 2) ? `
                        <li>
                            <a class="dropdown-item d-flex align-items-center gap-2"
                               target="_blank"
                               href="http://localhost:9999/FB_N1/thanh-toan?code=${safeText(row.booking_code)}">
                                <i class="bi bi-qr-code"></i> Mã QR thanh toán
                            </a>
                        </li>
                    ` : '';

                    const cancelButton = (row.status_pay !== -1 && row.status_pay !== -2) ? `
                        <li>
                            <a class="dropdown-item d-flex align-items-center gap-2 btn-cancel-booking"
                               href="#" data-booking-code="${safeText(row.booking_code)}">
                                <i class="bi bi-x-circle"></i> Huỷ booking
                            </a>
                        </li>
                    ` : '';

                    return `
                        <div class="dropdown">
                            <button class="btn btn-sm btn-outline-primary dropdown-toggle" type="button"
                                    data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="bi bi-list"></i> Hành động
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end shadow-sm" style="min-width: 180px;">
                                <li>
                                    <a class="dropdown-item d-flex align-items-center gap-2 btn-view-slots"
                                       href="#" data-booking-code="${safeText(row.booking_code)}">
                                        <i class="bi bi-eye"></i> Xem ca
                                    </a>
                                </li>
                                ${qrButton}
                                ${cancelButton}
                            </ul>
                        </div>
                    `;
                }
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

    $('#filter-row th').each(function (colIdx) {
        const input = $(this).find('input[type="text"]');
        if (input.length) {
            input.on('keyup change', function () {
                table.column(colIdx).search(this.value || '').draw();
            });
        }
    });

    $.fn.dataTable.ext.search.push(function (settings, data) {
        const bookingDateStr = data[2];
        const fromStr = $('#bookingDateFrom').val();
        const toStr = $('#bookingDateTo').val();

        if (!fromStr && !toStr) return true;
        if (!bookingDateStr) return false;

        const datePart = bookingDateStr.split(' ')[0];
        const bookingDate = new Date(datePart).getTime();
        const from = fromStr ? new Date(fromStr).getTime() : null;
        const to = toStr ? new Date(toStr).getTime() : null;

        if (from !== null && bookingDate < from) return false;
        if (to !== null && bookingDate > to) return false;

        return true;
    });

    $('#bookingDateFrom, #bookingDateTo').on('change', function () {
        table.draw();
    });

    $('#reset-filters').on('click', function () {
        $('#filter-row input').val('');
        $('#bookingDateFrom').val('');
        $('#bookingDateTo').val('');
        table.columns().search('');
        table.draw();
    });

    $(document).on('click', '.btn-view-slots', function () {
        currentBookingCode = $(this).data('bookingCode');
        loadBookingDetails(currentBookingCode);
    });

    $(document).on('click', '.btn-cancel-booking', function (e) {
        e.preventDefault();
        const bookingCode = $(this).data('bookingCode');
        if (!bookingCode) {
            showToast("error", "❌ Không xác định được mã booking.");
            return;
        }

        showConfirmDialog(`Bạn có chắc chắn muốn huỷ booking [${bookingCode}]?`, () => {
            $.ajax({
                url: '/FB_N1/admin/cancel-booking',
                type: 'POST',
                data: { bookingCode },
                success: function (res) {
                    if (res && res.success) {
                        showToast("success", `✅ ${res.message}`);
                        $('#booking-datatable').DataTable().ajax.reload(null, false);
                    } else {
                        showToast("error", `❌ ${res.message || 'Huỷ booking thất bại'}`);
                    }
                },
                error: function () {
                    showToast("error", `❌ Lỗi khi huỷ booking [${bookingCode}]`);
                }
            });
        });
    });
});

function loadBookingDetails(bookingCode) {
    $.get('/FB_N1/admin/booking/details', { bookingCode }, function (data) {
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
                            Giá: <span class="text-success">${formatPrice(slot.price)}</span>
                        </div>
                        <div class="mb-1">
                            <i class="bi bi-info-circle"></i> Trạng thái:
                            ${renderSlotStatusBadge(slot.status_id, safeText(slot.status_name))}
                        </div>
                        <div>
                            <i class="bi bi-card-text"></i> Ghi chú: <span class="fst-italic">${safeText(slot.note)}</span>
                        </div>
                    </div>
                `);
            });
        }

        const modal = new bootstrap.Modal(document.getElementById('bookingSlotModal'));
        modal.show();
    }).fail(() => {
        showToast("error", "❌ Lỗi tải chi tiết ca!");
    });
}

function renderSlotStatusBadge(statusId, statusName) {
    let color = 'secondary';
    switch (parseInt(statusId, 10)) {
        case 1: color = 'success'; break; // Đã đặt
        case 2: color = 'warning'; break; // Chờ xử lý
        case 3: color = 'danger'; break;  // Đã huỷ
        default: color = 'secondary';
    }
    return `<span class="badge bg-${color}">${statusName}</span>`;
}

function renderPayStatus(data) {
    const status = parseInt(data, 10);
    const map = {
        [-2]: '<span class="badge bg-danger">Đã huỷ bởi admin</span>',
        [-1]: '<span class="badge bg-danger">Đã huỷ do quá hạn</span>',
        [0]: '<span class="badge bg-warning text-dark">Chờ thanh toán online</span>',
        [1]: '<span class="badge bg-success">Đã thanh toán</span>',
        [2]: '<span class="badge bg-secondary">Thanh toán sau</span>'
    };
    return map.hasOwnProperty(status) ? map[status] : '<span class="badge bg-secondary">Không xác định</span>';
}

function formatPrice(price) {
    return price !== null && price !== undefined
        ? $.fn.dataTable.render.number(',', '.', 0, '', ' đ').display(price)
        : '-';
}

function safeText(value, fallback = '-') {
    return value !== null && value !== undefined && value !== '' ? value : fallback;
}
