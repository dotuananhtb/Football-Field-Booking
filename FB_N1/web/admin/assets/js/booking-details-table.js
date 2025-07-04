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

                    // Kiểm tra nếu ca đã qua thì không hiện nút cập nhật
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

                    const updateBtn = showUpdateBtn
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
            {data: 'extendedProps.userInfo.email'},
            {data: 'extendedProps.booking_date'},
            {
                data: 'extendedProps.price',
                render: (data) => data != null ? $.fn.dataTable.render.number(',', '.', 0, '', ' đ').display(data) : '-'
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
        }
    });

    $(document).on('click', '.btn-update-status', function () {
        currentSlotFieldId = $(this).data('slotFieldId');
        currentSlotDate = $(this).data('slotDate');
        currentBookingDetailsCode = $(this).data('bookingDetailsCode');
        const currentStatus = parseInt($(this).data('status'));

        const infoText = currentBookingDetailsCode
                ? `Cập nhật ca: ${currentBookingDetailsCode}`
                : `Cập nhật ca: ${currentSlotFieldId} - ${currentSlotDate}`;
        $('#modal-slot-info').text(infoText);

        // Reset nút
        $('#btn-status-1').show();
        $('#btn-status-2').show();
        $('#btn-status-3').show();

        // Ẩn nút tương ứng với trạng thái hiện tại
        if (currentStatus === 1) {
            $('#btn-status-1').hide();
        } else if (currentStatus === 2) {
            $('#btn-status-2').hide();
        } else if (currentStatus === 3) {
            $('#btn-status-3').hide();
        }

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

    console.log("Payload gửi:", payload); // Debug

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
