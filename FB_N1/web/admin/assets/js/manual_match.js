$(document).ready(function () {
    loadPendingPayments();
});

function loadPendingPayments() {
    $.get('/FB_N1/admin/ho-tro-thanh-toan')
        .done(function (data) {
            const tbody = $('#paymentTable tbody');
            tbody.empty();
            if (data.length === 0) {
                tbody.append('<tr><td colspan="8" class="text-center">Không có giao dịch chờ đối soát</td></tr>');
                return;
            }
            data.forEach(payment => {
                const row = `
<tr>
    <td>${payment.transaction_code}</td>
    <td>${payment.transfer_amount}</td>
    <td>${payment.pay_time || ''}</td>
    <td>${payment.content || ''}</td>
    <td>${payment.gateway || ''}</td>
    <td>${payment.pay_status === 'pending' ? 'Đang chờ xử lý' : (payment.pay_status || '')}</td>
    <td>${payment.description || ''}</td>
    <td>
        <button class="btn btn-sm btn-primary" onclick="openManualMatchModal('${payment.transaction_code}')">Đối soát</button>
    </td>
</tr>`;
                tbody.append(row);
            });
        })
        .fail(function (xhr) {
            showToast('error', `Lỗi tải payment: ${xhr.responseText || xhr.statusText}`);
        });
}

function openManualMatchModal(transactionCode) {
    $('#transactionCodeHidden').val(transactionCode);
    $('#transactionCodeDisplay').text(transactionCode);
    $('#bookingCode').val('');
    $('#matchNote').val('');
    $('#bookingDetails').empty();
    $('#bookingInfo').hide();
    $('#btnMatchPayment').prop('disabled', true);
    $('#manualMatchModal').modal('show');
}

$('#btnCheckBooking').click(function () {
    const bookingCode = $('#bookingCode').val().trim();
    if (!bookingCode) {
        showToast('warning', 'Vui lòng nhập booking code');
        return;
    }

    $.get(`/FB_N1/admin/check-booking-slots?bookingCode=${encodeURIComponent(bookingCode)}`)
        .done(function (data) {
            $('#bookingDetails').empty();
            if (data.slots && data.slots.length > 0) {
                let html = '<ul>';
                data.slots.forEach(slot => {
                    html += `<li><strong>${slot.field_name}</strong> | ${slot.slot_date} ${slot.start_time}-${slot.end_time} | Trạng thái: ${slot.status_name}</li>`;
                });
                html += '</ul>';
                $('#bookingDetails').html(html);
                $('#bookingInfo').show();

                if (data.canMatch) {
                    $('#btnMatchPayment').prop('disabled', false);
                    showToast('success', data.message || 'Có thể đối soát.');
                } else {
                    $('#btnMatchPayment').prop('disabled', true);
                    if (data.invalidSlots && data.invalidSlots.length > 0) {
                        data.invalidSlots.forEach(slot => {
                            const msg = `${slot.field_name} | ${slot.slot_date} ${slot.start_time}-${slot.end_time}: ${slot.reason}`;
                            showToast('error', msg);
                        });
                    } else {
                        showToast('error', data.message || 'Không thể đối soát do ca không hợp lệ');
                    }
                }
            } else {
                $('#bookingInfo').hide();
                showToast('error', data.message || 'Không tìm thấy booking hoặc ca');
            }
        })
        .fail(function (xhr) {
            showToast('error', `Lỗi kiểm tra booking: ${xhr.responseText || xhr.statusText}`);
        });
});

$('#btnMatchPayment').click(function () {
    const transactionCode = $('#transactionCodeHidden').val();
    const bookingCode = $('#bookingCode').val().trim();
    const description = $('#matchNote').val().trim();

    if (!transactionCode || !bookingCode) {
        showToast('warning', 'Thiếu thông tin giao dịch hoặc booking');
        return;
    }

    $.ajax({
        url: '/FB_N1/admin/ho-tro-thanh-toan',
        method: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({
            transactionCode: transactionCode,
            bookingCode: bookingCode,
            confirmedBy: 'Admin',
            description: description
        }),
        success: function (data) {
            if (data.success) {
                showToast('success', data.message || 'Đối soát thành công');
                $('#manualMatchModal').modal('hide');
                loadPendingPayments();
            } else {
                showToast('error', data.message || 'Đối soát thất bại');
            }
        },
        error: function (xhr) {
            showToast('error', `Lỗi đối soát: ${xhr.responseText || xhr.statusText}`);
        }
    });
});
