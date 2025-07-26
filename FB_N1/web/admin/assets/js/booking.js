/* global bootstrap */
//booking.js
let currentBookingCode = null;

$(document).ready(function () {
    const table = $('#booking-datatable').DataTable({
        scrollX: true,
        orderCellsTop: true,
        fixedHeader: true,
        ajax: {
            url: '/FB_N1/admin/booking',
            dataSrc: ''
        },
        columns: [
            {data: null, render: (data, type, row, meta) => meta.row + 1},
            {data: 'booking_code', render: data => safeText(data)},
            {data: 'booking_date', render: data => safeText(data)},
            {
                data: 'total_amount',
                render: (data, type) => type === 'sort' ? data || 0 : formatPrice(data)
            },
            {data: 'customer_name', render: data => safeText(data)},
            {data: 'customer_phone', render: data => safeText(data)},
            {
                data: 'customer_type',
                render: data => {
                    if (data === 'online')
                        return '<span class="badge bg-success">Online</span>';
                    if (data === 'offline')
                        return '<span class="badge bg-secondary">Offline</span>';
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
                        </li>` : '';

                    const cancelButton = (row.status_pay !== -1 && row.status_pay !== -2) ? `
                        <li>
                            <a class="dropdown-item d-flex align-items-center gap-2 btn-cancel-booking"
                               href="#" data-booking-code="${safeText(row.booking_code)}">
                                <i class="bi bi-x-circle"></i> Huỷ booking
                            </a>
                        </li>` : '';

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
                        </div>`;
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

    // ✅ Filter theo text input
    $('#filter-row input[type="text"]').on('keyup change', function () {
        const colIndex = $(this).closest('th').index();
        table.column(colIndex).search(this.value).draw();
    });

    // ✅ Filter theo ngày (Từ - Đến)
    $('#bookingDateFrom, #bookingDateTo').on('change', function () {
        const fromDate = $('#bookingDateFrom').val();
        const toDate = $('#bookingDateTo').val();

        $.fn.dataTable.ext.search.push(function (settings, data) {
            const bookingDateStr = data[2]; // cột booking_date (dòng thứ 3)
            if (!bookingDateStr)
                return false;

            const bookingDate = new Date(bookingDateStr);
            const from = fromDate ? new Date(fromDate + 'T00:00:00') : null;
            const to = toDate ? new Date(toDate + 'T23:59:59') : null;

            if ((from && bookingDate < from) || (to && bookingDate > to)) {
                return false;
            }
            return true;
        });

        table.draw();
        $.fn.dataTable.ext.search.pop(); // tránh bị stack filter nhiều lần
    });


    // ✅ Đặt lại bộ lọc
    $('#reset-filters').on('click', function () {
        $('#filter-row input').val('');
        table.columns().search('');
        $('#bookingDateFrom, #bookingDateTo').val('');
        table.draw();
    });

    // ✅ Các handler giữ nguyên như đã gửi ở trên (btn-view-slots, btn-cancel-booking, btn-update-status)
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
            data: {bookingCode},
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
}
);



function loadBookingDetails(bookingCode) {
    $.get('/FB_N1/admin/booking/details', {bookingCode}, function (data) {
        const container = $('#booking-slots-container');
        container.empty();

        if (!data || data.length === 0) {
            container.append(`<p class="text-center fst-italic">Không có ca nào trong đơn này</p>`);
            return;
        }

        const now = new Date();

        data.forEach((slot, index) => {
            const {
                bookingDetailsCode,
                slot_date,
                start_time,
                end_time,
                field_name,
                field_type_name,
                price,
                status_id,
                status_name,
                note
            } = slot;

            const endDateTime = new Date(`${slot_date}T${end_time}`);
            let buttons = '';

            if (bookingDetailsCode && endDateTime > now && status_id !== 3) {
                const statusButtons = [];

                if (status_id !== 1 && status_id !== 4) {
                    statusButtons.push(`<button class="btn btn-sm btn-outline-success btn-update-status" data-code="${bookingDetailsCode}" data-status="1">Xác nhận đặt</button>`);
                }
                if (status_id !== 2) {
                    statusButtons.push(`<button class="btn btn-sm btn-outline-warning btn-update-status" data-code="${bookingDetailsCode}" data-status="2">Chờ xử lí huỷ</button>`);
                }
                if (status_id !== 3) {
                    statusButtons.push(`<button class="btn btn-sm btn-outline-danger btn-update-status" data-code="${bookingDetailsCode}" data-status="3">Huỷ</button>`);
                }


                if (statusButtons.length > 0) {
                    buttons = `
                        <div class="mt-2">
                            <span class="me-2">Cập nhật trạng thái:</span>
                            ${statusButtons.join('\n')}
                        </div>`;
                }
            }

            container.append(`
                <div class="border rounded p-2 mb-2 bg-light">
                    <div class="fw-bold mb-1">
                        #${index + 1} | ${safeText(slot_date)} ${safeText(start_time)} - ${safeText(end_time)}
                    </div>
                    <div class="mb-1">
                        <i class="bi bi-geo-alt-fill"></i> ${safeText(field_name)} (${safeText(field_type_name)})
                    </div>
                    <div class="mb-1">
                        <i class="bi bi-cash-stack"></i> Giá: <span class="text-success">${formatPrice(price)}</span>
                    </div>
                    <div class="mb-1">
                        <i class="bi bi-info-circle"></i> Trạng thái: ${renderSlotStatusBadge(status_name)}
                    </div>
                    <div>
                        <i class="bi bi-card-text"></i> Ghi chú: <span class="fst-italic">${safeText(note)}</span>
                    </div>
                    ${buttons}
                </div>
            `);
        });

        // ❌ Gỡ bỏ backdrop dư thừa nếu có
        $('.modal-backdrop').remove();
        $('body').removeClass('modal-open').css('padding-right', '');
        document.body.style.overflow = 'auto';


        // ✅ Mở modal
        const modalEl = document.getElementById('bookingSlotModal');
        const modal = bootstrap.Modal.getOrCreateInstance(modalEl);
        modal.show();

        // 🔁 Khi modal đóng, đảm bảo dọn dẹp giao diện
        modalEl.addEventListener('hidden.bs.modal', function () {
            $('.modal-backdrop').remove();
            $('body').removeClass('modal-open').css('padding-right', '');
        });
    }).fail(() => {
        showToast("error", "❌ Lỗi tải chi tiết ca!");
    });
}


function renderSlotStatusBadge(statusName) {
    const map = {
        'đã đặt': 'success',
        'đang chờ xử lí': 'warning',
        'chờ huỷ': 'warning',
        'đã huỷ': 'danger',
        'chờ thanh toán': 'info'
    };
    const key = (statusName || '').toLowerCase().trim();
    const color = map[key] || 'secondary';
    return `<span class="badge bg-${color}">${safeText(statusName)}</span>`;
}

function renderPayStatus(data) {
    const status = parseInt(data, 10);
    const map = {
        [-2]: '<span class="badge bg-danger">Đã huỷ bởi admin</span>',
        [-1]: '<span class="badge bg-danger">Đã huỷ do quá hạn</span>',
        [0]: '<span class="badge bg-warning text-dark">Chờ t.toán online</span>',
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
// Gắn sự kiện cho nút cập nhật trạng thái trong chi tiết ca
// Gắn sự kiện cho nút cập nhật trạng thái trong chi tiết ca
$(document).on('click', '.btn-update-status', function () {
    const $btn = $(this);
    const bookingDetailsCode = $btn.data('code');
    const newStatus = $btn.data('status');

    if (!bookingDetailsCode || !newStatus) {
        showToast('error', "❌ Thiếu thông tin cập nhật.");
        return;
    }

    // Xác nhận trước khi gửi
    showConfirmDialog(`Bạn có chắc chắn muốn cập nhật trạng thái booking [${bookingDetailsCode}] không?`, () => {
        // Disable nút khi đang gửi yêu cầu
        $btn.prop('disabled', true).text("Đang cập nhật...");

        fetch('/FB_N1/admin/update-slot-status', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                bookingDetailsCode: bookingDetailsCode,
                status: newStatus
            })
        })
                .then(res => res.json())
                .then(data => {
                    if (data.success) {
                        showToast('success', `✅ ${data.message}`);

                        // Gọi lại hàm load chi tiết ca nếu có///////
                        if (typeof loadBookingDetails === 'function') {
                            loadBookingDetails(currentBookingCode);
                        }
                        // ✅ Reload lại bảng booking chính///////
                        $('#booking-datatable').DataTable().ajax.reload(null, false);
                    } else {
                        showToast('error', `❌ ${data.message || 'Cập nhật thất bại.'}`);
                    }
                })
                .catch((err) => {
                    console.error("Lỗi gửi yêu cầu:", err);
                    showToast('error', "❌ Lỗi khi gửi yêu cầu cập nhật.");
                })
                .finally(() => {
                    // Bật lại nút
                    $btn.prop('disabled', false).text("Cập nhật");
                });
    });
});



