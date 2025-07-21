/* global bootstrap */
//booking-details-table.js
let currentSlotFieldId = null;
let currentSlotDate = null;
let currentBookingDetailsCode = null;

$(document).ready(function () {
    const table = $('#scroll-horizontal-datatable').DataTable({
        scrollX: true,
        orderCellsTop: true,
        ajax: {
            url: '/FB_N1/checking-slots2',
            dataSrc: ''
        },
        columns: [
            {data: null, title: 'STT', render: (data, type, row, meta) => meta.row + 1},
            {data: 'extendedProps.booking_details_code'},
            {data: 'extendedProps.slot_date'},
            {
                data: null,
                render: (data, type, row) => {
                    const ep = row.extendedProps || {};
                    return (ep.start_time || '-') + ' - ' + (ep.end_time || '-');
                }
            },
            {data: 'extendedProps.field_name'},
            {data: 'extendedProps.field_type_name'},
            {
                data: 'extendedProps.status',
                render: function (data, type, row) {
                    let badge = '';
                    switch (data) {
                        case 1:
                            badge = '<span class="badge bg-success">Đã đặt</span>';
                            break;
                        case 2:
                            badge = '<span class="badge bg-warning text-dark">Chờ huỷ</span>';
                            break;
                        case 3:
                            badge = '<span class="badge bg-danger">Đã huỷ</span>';
                            break;
                        case 4:
                            badge = '<span class="badge bg-primary">Chờ thanh toán</span>';
                            break;
                        default:
                            badge = '<span class="badge bg-secondary">Không xác định</span>';
                    }

                    const now = new Date();
                    const slotDate = row.extendedProps.slot_date;
                    const endTime = row.extendedProps.end_time;
                    let showUpdateBtn = true;

                    if (slotDate && endTime) {
                        const slotDateTimeStr = `${slotDate}T${endTime}`;
                        const slotEndTime = new Date(slotDateTimeStr);
                        if (slotEndTime < now) {
                            showUpdateBtn = false;
                        }
                    }

                    const updateBtn = (showUpdateBtn && data !== 3) // 👈 Chặn nút nếu trạng thái là "Đã huỷ"
                            ? `<button class="btn btn-sm btn-outline-primary btn-update-status ms-1"
        data-slot-field-id="${row.extendedProps.slot_field_id}"
        data-slot-date="${row.extendedProps.slot_date}"
        data-booking-details-code="${row.extendedProps.booking_details_code}"
        data-status="${data}">
        <i class="bi bi-pencil-square"></i>
    </button>`
                            : '';


                    return `${badge} ${updateBtn}`;
                }
            },
            {data: 'extendedProps.userInfo.name'},
            {
                data: null,
                render: (data, type, row) => row?.extendedProps?.userInfo?.phone || '-',
                createdCell: (td, cellData, rowData) => {
                    const phone = rowData?.extendedProps?.userInfo?.phone;
                    td.style.fontWeight = phone ? 'bold' : 'normal';
                }
            },

            {data: 'extendedProps.booking_date'},
            {
                data: 'extendedProps.price',
                render: (data) => data !== null ? $.fn.dataTable.render.number(',', '.', 0, '', ' đ').display(data) : '-'
            },
            {
                data: null,
                title: 'Ghi chú',
                render: (data, type, row) => row?.extendedProps?.note || '-'
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
        },
        initComplete: function () {
            const api = this.api();

            // Áp dụng tìm kiếm cho từng ô input text
            api.columns().every(function (colIdx) {
                const input = $('#filter-row th').eq(colIdx).find('input[type="text"]');
                if (input.length) {
                    input.on('keyup change', function () {
                        api.column(colIdx).search(this.value).draw();
                    });
                }
            });

            // Tìm kiếm theo ngày
            $('#slotDateFrom, #slotDateTo, #bookingDateFrom, #bookingDateTo').on('change', function () {
                api.draw();
            });

            // Custom search theo khoảng ngày
            $.fn.dataTable.ext.search.push(function (settings, data, dataIndex) {
                const slotDateStr = data[2];       // cột "Ngày đá"
                const bookingDateStr = data[9];    // cột "Ngày đặt" (đúng với bảng bạn gửi)

                const fromSlot = $('#slotDateFrom').val();
                const toSlot = $('#slotDateTo').val();
                const fromBook = $('#bookingDateFrom').val();
                const toBook = $('#bookingDateTo').val();

                let isSlotInRange = true;
                let isBookingInRange = true;

                if (slotDateStr) {
                    const slotDate = new Date(slotDateStr);
                    const from = fromSlot ? new Date(fromSlot + 'T00:00:00') : null;
                    const to = toSlot ? new Date(toSlot + 'T23:59:59') : null;

                    if ((from && slotDate < from) || (to && slotDate > to)) {
                        isSlotInRange = false;
                    }
                }

                if (bookingDateStr) {
                    const bookingDate = new Date(bookingDateStr);
                    const from = fromBook ? new Date(fromBook + 'T00:00:00') : null;
                    const to = toBook ? new Date(toBook + 'T23:59:59') : null;

                    if ((from && bookingDate < from) || (to && bookingDate > to)) {
                        isBookingInRange = false;
                    }
                }

                return isSlotInRange && isBookingInRange;
            });

            // Đặt lại bộ lọc
            $('#reset-filters').on('click', function () {
                $('#filter-row input').val('');
                $('#filter-row input[type="date"]').val('');
                api.columns().search('');
                api.draw();
            });
        }

    });

    // Xử lý cập nhật trạng thái
    $(document).on('click', '.btn-update-status', function () {
        currentSlotFieldId = $(this).data('slotFieldId');
        currentSlotDate = $(this).data('slotDate');
        currentBookingDetailsCode = $(this).data('bookingDetailsCode');
        const currentStatus = parseInt($(this).data('status'));

        const infoText = currentBookingDetailsCode
                ? `Cập nhật ca: ${currentBookingDetailsCode}`
                : `Cập nhật ca: ${currentSlotFieldId} - ${currentSlotDate}`;
        $('#modal-slot-info').text(infoText);

        $('#btn-status-1').show();
        $('#btn-status-2').show();
        $('#btn-status-3').show();

        if (currentStatus === 1)
            $('#btn-status-1').hide();
        else if (currentStatus === 2)
            $('#btn-status-2').hide();
        else if (currentStatus === 3)
            $('#btn-status-3').hide();

        const modal = new bootstrap.Modal(document.getElementById('updateStatusModal'));
        modal.show();
    });

    $('#btn-status-1').click(() => {
        showConfirmDialog("Bạn muốn cập nhật trạng thái thành 'Đã đặt'?", () => updateSlotStatus(1));
    });
    $('#btn-status-2').click(() => {
        showConfirmDialog("Bạn muốn cập nhật trạng thái thành 'Chờ huỷ'?", () => updateSlotStatus(2));
    });
    $('#btn-status-3').click(() => {
        showConfirmDialog("Bạn muốn cập nhật trạng thái thành 'Đã huỷ'?", () => updateSlotStatus(3));
    });
});

function updateSlotStatus(statusId) {
    const payload = {status: statusId};

    if (currentBookingDetailsCode) {
        payload.bookingDetailsCode = currentBookingDetailsCode;
    } else if (currentSlotFieldId && currentSlotDate) {
        payload.slotFieldId = currentSlotFieldId;
        payload.slotDate = currentSlotDate;
    } else {
        showToast("error", "❌ Không đủ dữ liệu để cập nhật ca!");
        return;
    }

    console.log("Payload gửi:", payload);

    $.ajax({
        url: '/FB_N1/admin/update-slot-status',
        method: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(payload),
        success: (response) => {
            showToast("success", response.message || "Cập nhật thành công!");
            $('#updateStatusModal').modal('hide');
            $('#scroll-horizontal-datatable').DataTable().ajax.reload();
        },
        error: (xhr) => {
            let errorMsg = "❌ Lỗi cập nhật: ";
            if (xhr.responseJSON?.message) {
                errorMsg += xhr.responseJSON.message;
            } else if (xhr.responseText) {
                errorMsg += xhr.responseText;
            } else {
                errorMsg += "Không xác định";
            }
            showToast("error", errorMsg);
        }
    });
}
