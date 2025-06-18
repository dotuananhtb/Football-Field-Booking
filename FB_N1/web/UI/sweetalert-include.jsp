<%-- 
    Document   : sweetalert-include
    Created on : Jun 14, 2025, 11:24:17 PM
    Author     : Đỗ Tuấn Anh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
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
</script>