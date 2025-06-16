// calendar-ui.js

// Biến toàn cục
let calendar;
let selectedSlots = [];

// Khởi động
document.addEventListener('DOMContentLoaded', function () {
    initCalendar();
    calendar.render();
    bindUIEvents();
});

// 🔹 1. Khởi tạo FullCalendar
function initCalendar() {
    const calendarEl = document.getElementById('calendar');

    calendar = new FullCalendar.Calendar(calendarEl, {
        initialView: 'dayGridMonth',
        headerToolbar: {
            left: 'prev,next today',
            center: 'title',
            right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
        },
        views: {
            dayGridMonth: {buttonText: 'Tháng'},
            timeGridWeek: {buttonText: 'Tuần'},
            timeGridDay: {buttonText: 'Ngày'},
            listWeek: {buttonText: 'Danh sách'}
        },
        locale: 'vi',
        height: 'auto',
        eventDidMount: function (info) {
            const titleEl = info.el.querySelector('.fc-event-title');
            if (titleEl)
                titleEl.style.display = 'none';
        },
        events: fetchSlotEvents,
        eventClick: handleEventClick
    });
}

// 🔹 2. UI xử lý chọn slot
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
                <td><button class="remove-slot-btn btn btn-sm btn-danger">Xoá</button></td>
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

// 🔹 3. Khôi phục lại màu ca đã huỷ chọn
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

// 🔹 4. Hiển thị modal Admin
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

}

// 🔹 5. Gán sự kiện UI
function bindUIEvents() {
    $('#fieldSelect').on('change', function () {
        calendar.refetchEvents();
        renderSelectedTable();
    });

    $('#bookNowBtn').on('click', handleBookingSubmit);

    $('#modal-confirm-btn, #btn-confirm-slot').on('click', function () {
        const slotId = $(this).data('slotId');
        const slotDate = $(this).data('slotDate');
        updateSlotStatus(slotId, slotDate, 1);
    });
    $('#modal-pending-btn, #btn-pending-slot').on('click', function () {
        const slotId = $(this).data('slotId');
        const slotDate = $(this).data('slotDate');
        updateSlotStatus(slotId, slotDate, 2);
    });
    $('#modal-cancel-btn, #btn-cancel-slot').on('click', function () {
        const slotId = $(this).data('slotId');
        const slotDate = $(this).data('slotDate');
        updateSlotStatus(slotId, slotDate, 3);
    });



}
