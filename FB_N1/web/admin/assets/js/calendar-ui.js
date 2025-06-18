// calendar-ui.js

let calendar;
let selectedSlots = [];

document.addEventListener('DOMContentLoaded', function () {
    initCalendar();
    calendar.render();
    bindUIEvents();
});

// 🔹 1. Hiển thị bảng slot đã chọn
function renderSelectedTable() {
    const tbody = $("#selectedSlotsTable tbody");
    tbody.empty();
    let total = 0;

    selectedSlots.forEach((slot, index) => {
        const price = parseFloat(slot.price) || 0;
        total += price;

        tbody.append(`
            <tr data-index="${index}">
                <td>${slot.slot_date}</td>
                <td>${slot.title}</td>
                <td>${price.toLocaleString('vi-VN')}₫</td>
                <td>
                    <input type="text" class="form-control slot-note-input" data-index="${index}" 
                        placeholder="Nhập ghi chú..." value="${slot.note || ''}">
                </td>
                <td>
                    <button class="remove-slot-btn btn btn-sm btn-danger">Xoá</button>
                </td>
            </tr>
        `);
    });

    $(".remove-slot-btn").off("click").on("click", function () {
        const rowIndex = $(this).closest("tr").data("index");
        if (rowIndex !== undefined) {
            restoreSlotAppearance(selectedSlots[rowIndex]);
            selectedSlots.splice(rowIndex, 1);
            renderSelectedTable();
        }
    });

    $("#selectedSlotsTable").toggle(selectedSlots.length > 0);
    $("#totalPrice").toggle(selectedSlots.length > 0)
            .html('Tổng tiền: ' + total.toLocaleString('vi-VN') + '₫');
    $("#bookNowBtn").toggle(selectedSlots.length > 0);
}

// 🔹 2. Khôi phục slot
function restoreSlotAppearance(removedSlot) {
    calendar.getEvents().forEach(event => {
        const props = event.extendedProps;
        if (
                String(props.slot_field_id) === String(removedSlot.slot_field_id) &&
                props.slot_date === removedSlot.slot_date &&
                event.startStr === removedSlot.start &&
                event.endStr === removedSlot.end
                ) {
            event.setProp('classNames', ['bg-success', 'text-white']);
        }
    });
}

// 🔹 3. Modal chi tiết slot
function openStatusModal(event) {
    const slot = event.extendedProps;
    $('#event-modal').modal('show');
    $('#event-date').val(slot.slot_date);
    $('#event-time').val(event.title);
    $('#event-price').val(Number(slot.price).toLocaleString('vi-VN') + '₫');
    $('#event-status').val(slot.status);

    $('#btn-confirm-slot, #modal-confirm-btn').data('slotId', slot.slot_field_id).data('slotDate', slot.slot_date);
    $('#btn-cancel-slot, #modal-cancel-btn').data('slotId', slot.slot_field_id).data('slotDate', slot.slot_date);
    $('#btn-pending-slot, #modal-pending-btn').data('slotId', slot.slot_field_id).data('slotDate', slot.slot_date);

    $.ajax({
        url: '/FB_N1/check-slot-info',
        method: 'GET',
        data: {
            slotDate: slot.slot_date,
            slotFieldId: slot.slot_field_id
        },
        success: function (data) {
            if (data) {
                $('#btn-show-customer').data('customerInfo', data);
                $('#event-field-name').val(data.fieldName || '---');
                $('#event-field-type').val(data.fieldTypeName || '---');
                $('#event-status').val(data.slotStatus || '---');
            }
        },
        error: function () {
            $('#btn-show-customer').data('customerInfo', null);
        }
    });
}

// 🔹 4. Modal thông tin người đặt
function showCustomerInfoModal(info) {
    $('#ci-name').text(info.customerName || '---');
    $('#ci-phone').text(info.phone || '---');
    $('#ci-email').text(info.email || '---');
    $('#ci-note').text(info.note || '---');
    $('#ci-booking-id').text(info.bookingId || '---');
    $('#ci-booking-details-id').text(info.bookingDetailsId || '---');
    $('#ci-booking-date').text(info.bookingDate || '---');
    $('#customer-info-modal').modal('show');
}

// 🔹 5. Sự kiện UI
function bindUIEvents() {
    $('#fieldSelect').on('change', function () {
        calendar.refetchEvents();
        renderSelectedTable();
    });

    $('#bookNowBtn').on('click', handleBookingSubmit);

    $('#modal-confirm-btn, #btn-confirm-slot').on('click', function () {
        updateSlotStatus($(this).data('slotId'), $(this).data('slotDate'), 1);
    });

    $('#modal-pending-btn, #btn-pending-slot').on('click', function () {
        updateSlotStatus($(this).data('slotId'), $(this).data('slotDate'), 2);
    });

    $('#modal-cancel-btn, #btn-cancel-slot').on('click', function () {
        updateSlotStatus($(this).data('slotId'), $(this).data('slotDate'), 3);
    });

    $('#btn-show-customer').on('click', function () {
        const info = $(this).data('customerInfo');
        if (!info) {
            showToast("warning", "Không tìm thấy thông tin người đặt.");
            return;
        }
        showCustomerInfoModal(info);
    });
}
