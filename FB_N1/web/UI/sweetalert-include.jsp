<%-- 
    Document   : sweetalert-include
    Created on : Jun 14, 2025, 11:24:17 PM
    Author     : Đỗ Tuấn Anh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>


<script>
    // ✅ Hàm xác nhận (bạn đã có sẵn)
    function showConfirmDialog(message, onConfirm) {
        Swal.fire({
            title: 'Bạn có chắc?',
            text: message || "Thao tác này không thể hoàn tác.",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#d33',
            cancelButtonColor: '#6c757d',
            confirmButtonText: 'Đồng ý',
            cancelButtonText: 'Hủy'
        }).then((result) => {
            if (result.isConfirmed && typeof onConfirm === 'function') {
                onConfirm();
            }
        });
    }

    // ✅ Hàm toast thông báo (bạn đã có sẵn)
    function showToast_sweetalert(message, type) {
        Swal.fire({
            toast: true,
            position: 'top-end',
            showConfirmButton: false,
            timer: 3000,
            timerProgressBar: true,
            icon: type || 'info',
            title: message || ''
        });
    }

    // ✅ Hàm thông báo thành công
    function showSuccessDialog(title, text) {
        Swal.fire({
            icon: 'success',
            title: title || 'Thành công!',
            text: text || '',
            confirmButtonText: 'OK'
        });
    }

    // ✅ Hàm thông báo lỗi chi tiết
    function showErrorDialog(title, text) {
        Swal.fire({
            icon: 'error',
            title: title || 'Đã có lỗi xảy ra!',
            text: text || 'Vui lòng thử lại.',
            confirmButtonText: 'OK'
        });
    }

    // ✅ Hàm loading khi đang xử lý (nhớ gọi Swal.close() để đóng)
    function showLoadingDialog(message) {
        Swal.fire({
            title: message || 'Đang xử lý...',
            allowOutsideClick: false,
            didOpen: () => {
                Swal.showLoading();
            }
        });
    }

    // ✅ Hàm nhập liệu nhanh (prompt input)
    function showPromptDialog(promptText, placeholder, onSubmit) {
        Swal.fire({
            title: promptText || 'Nhập thông tin',
            input: 'text',
            inputPlaceholder: placeholder || '',
            showCancelButton: true,
            confirmButtonText: 'Gửi',
            cancelButtonText: 'Hủy'
        }).then((result) => {
            if (result.isConfirmed && result.value && typeof onSubmit === 'function') {
                onSubmit(result.value);
            }
        });
    }

    // ✅ Hàm cảnh báo tự đóng (auto close)
    function showAutoCloseAlert(icon, message, durationMs = 2500) {
        Swal.fire({
            icon: icon || 'info',
            title: message || '',
            showConfirmButton: false,
            timer: durationMs,
            timerProgressBar: true,
        });
    }

    // ✅ Hàm xác nhận có lý do nhập từ input
    function showConfirmWithReasonDialog(message, onSubmit) {
        Swal.fire({
            title: 'Xác nhận thao tác',
            text: message || 'Vui lòng nhập lý do (nếu cần).',
            input: 'text',
            inputPlaceholder: 'Lý do...',
            showCancelButton: true,
            confirmButtonText: 'Xác nhận',
            cancelButtonText: 'Huỷ'
        }).then((result) => {
            if (result.isConfirmed && typeof onSubmit === 'function') {
                onSubmit(result.value || '');
            }
        });
    }
</script>
