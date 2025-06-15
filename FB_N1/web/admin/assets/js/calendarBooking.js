let calendar;
let selectedSlots = [];

document.addEventListener('DOMContentLoaded', function () {
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
            if (titleEl) {
                titleEl.style.display = 'none';
            }
        },

        events: function (fetchInfo, successCallback, failureCallback) {
            const fieldId = $('#fieldSelect').val();
            if (!fieldId) {
                successCallback([]);
                return;
            }

            $.ajax({
                url: '/FB_N1/checking-slots2',
                method: 'GET',
                data: {
                    fieldId: fieldId,
                    start: fetchInfo.startStr.substring(0, 10),
                    end: fetchInfo.endStr.substring(0, 10)
                },
                dataType: 'json',
                success: function (events) {
                    successCallback(events);
                },
                error: function (xhr, status, error) {
                    failureCallback(error);
                }
            });
        },

        eventClick: function (info) {
            const slot = info.event.extendedProps;

            if (slot.status === 0) {
                const existsIndex = selectedSlots.findIndex(s =>
                    String(s.slot_field_id) === String(slot.slot_field_id) &&
                            s.slot_date === slot.slot_date &&
                            s.start === info.event.startStr &&
                            s.end === info.event.endStr
                );

                if (existsIndex > -1) {
                    selectedSlots.splice(existsIndex, 1);
                    info.event.setProp('classNames', ['bg-success', 'text-white']);
                } else {
                    const newSlot = {
                        slot_field_id: slot.slot_field_id,
                        slot_date: slot.slot_date,
                        start: info.event.startStr,
                        end: info.event.endStr,
                        price: parseFloat(slot.price),
                        title: info.event.title
                    };
                    selectedSlots.push(newSlot);
                    info.event.setProp('classNames', ['bg-info', 'text-white']);
                }

                renderSelectedTable();
            } else if (slot.status === 1 || slot.status === 2) {
                openStatusModal(info.event);
            }
        }
    });

    calendar.render();

    $('#fieldSelect').on('change', function () {
        calendar.refetchEvents();
        renderSelectedTable();
    });

    $('#bookNowBtn').on('click', function () {
        if (selectedSlots.length === 0) {
            alert("⚠️ Bạn chưa chọn ca nào để đặt.");
            return;
        }

        const bookingDetailsList = selectedSlots.map(slot => ({
                bookingDetailsId: null,
                bookingId: null,
                slotFieldId: slot.slot_field_id,
                slotFieldPrice: slot.price,
                extraMinutes: 0,
                extraFee: 0,
                slotDate: slot.slot_date,
                note: null,
                statusCheckingId: 1
            }));

        $.ajax({
            url: '/FB_N1/dat-san',
            method: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(bookingDetailsList),
            success: function (response) {
                if (response && response.success) {
                    alert("✅ Đặt sân thành công!");
                    selectedSlots = [];
                    calendar.refetchEvents();
                    renderSelectedTable();
                } else {
                    alert("❌ Lỗi: " + (response.message || "Không rõ nguyên nhân"));
                }
            },
            error: function (xhr, status, error) {
                if (xhr.status === 401 || xhr.status === 302) {
                    alert("⚠️ Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.");
                    window.location.href = "/FB_N1/login";
                } else {
                    alert("⚠️ Lỗi máy chủ: " + (xhr.responseText || "Không xác định"));
                }
            }
        });
    });

    $('#modal-confirm-btn').on('click', function () {
        const slotId = $(this).data('slotId');
        const slotDate = $(this).data('slotDate');

        $.ajax({
            url: '/FB_N1/update-slot-status',
            method: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({
                slotFieldId: slotId,
                slotDate: slotDate,
                status: 'Confirmed'
            }),
            success: function () {
                alert("✅ Đã xác nhận ca!");
                $('#event-modal').modal('hide');
                calendar.refetchEvents();
            },
            error: function (xhr) {
                alert("❌ Lỗi xác nhận: " + (xhr.responseText || "Không xác định"));
            }
        });
    });

    $('#modal-cancel-btn').on('click', function () {
        const slotId = $(this).data('slotId');
        const slotDate = $(this).data('slotDate');

        $.ajax({
            url: '/FB_N1/update-slot-status',
            method: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({
                slotFieldId: slotId,
                slotDate: slotDate,
                status: 'Cancelled'
            }),
            success: function () {
                alert("🚫 Đã huỷ ca!");
                $('#event-modal').modal('hide');
                calendar.refetchEvents();
            },
            error: function (xhr) {
                alert("❌ Lỗi huỷ: " + (xhr.responseText || "Không xác định"));
            }
        });
    });
});

function renderSelectedTable() {
    const tbody = $("#selectedSlotsTable tbody");
    tbody.empty();
    let total = 0;

    selectedSlots.forEach((slot, index) => {
        const price = typeof slot.price === 'number' ? slot.price : parseFloat(slot.price) || 0;
        const priceFormatted = price.toLocaleString('vi-VN') + '₫';

        const rowHTML =
                '<tr data-index="' + index + '">' +
                '<td>' + slot.slot_date + '</td>' +
                '<td>' + slot.title + '</td>' +
                '<td>' + priceFormatted + '</td>' +
                '<td><button class="remove-slot-btn btn btn-sm btn-danger">Xoá</button></td>' +
                '</tr>';

        tbody.append(rowHTML);
        total += price;
    });

    $(".remove-slot-btn").off("click").on("click", function () {
        const rowIndex = $(this).closest("tr").data("index");

        if (rowIndex !== undefined) {
            const removedSlot = selectedSlots[rowIndex];

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

            selectedSlots.splice(rowIndex, 1);
            renderSelectedTable();
        }
    });

    if (selectedSlots.length > 0) {
        $("#selectedSlotsTable").show();
        $("#totalPrice").show().html('Tổng tiền: ' + total.toLocaleString('vi-VN') + '₫');
        $("#bookNowBtn").show();
    } else {
        $("#selectedSlotsTable").hide();
        $("#totalPrice").hide();
        $("#bookNowBtn").hide();
    }
}

function openStatusModal(event) {
    const slot = event.extendedProps;

    $('#event-modal').modal('show');

    $('#event-date').val(slot.slot_date);
    $('#event-time').val(event.title);
    $('#event-price').val(Number(slot.price).toLocaleString('vi-VN') + '₫');
    $('#event-status').val(slot.status);

    $('#btn-confirm-slot').data('slotId', slot.slot_field_id);
    $('#btn-confirm-slot').data('slotDate', slot.slot_date);

    $('#btn-cancel-slot').data('slotId', slot.slot_field_id);
    $('#btn-cancel-slot').data('slotDate', slot.slot_date);
}

$('#btn-confirm-slot').on('click', function () {
    const slotId = $(this).data('slotId');
    const slotDate = $(this).data('slotDate');

    $.ajax({
        url: '/FB_N1/update-slot-status',
        method: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({
            slotFieldId: slotId,
            slotDate: slotDate,
            status: 'Confirmed'
        }),
        success: function () {
            alert("✅ Đã xác nhận ca!");
            $('#event-modal').modal('hide');
            calendar.refetchEvents();
        },
        error: function (xhr) {
            alert("❌ Lỗi xác nhận: " + (xhr.responseText || "Không xác định"));
        }
    });
});

$('#btn-cancel-slot').on('click', function () {
    const slotId = $(this).data('slotId');
    const slotDate = $(this).data('slotDate');

    $.ajax({
        url: '/FB_N1/update-slot-status',
        method: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({
            slotFieldId: slotId,
            slotDate: slotDate,
            status: 'Cancelled'
        }),
        success: function () {
            alert("🚫 Đã huỷ ca!");
            $('#event-modal').modal('hide');
            calendar.refetchEvents();
        },
        error: function (xhr) {
            alert("❌ Lỗi huỷ: " + (xhr.responseText || "Không xác định"));
        }
    });
});

