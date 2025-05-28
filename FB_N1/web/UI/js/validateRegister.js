function validateAndSubmit() {
    const form = document.getElementById("dkiform");
    clearErrors();

    const fields = {
        lastname: form.lastname.value.trim(),
        firstname: form.firstname.value.trim(),
        username: form.username.value.trim(),
        email: form.email.value.trim(),
        phone: form.phone.value.trim(),
        address: form.address.value.trim(),
        dob: form.dob.value,
        gender: form.gender.value,
        password: form.password.value,
        password_confirm: form.password_confirm.value,
        check: form.check.checked
    };

    let isValid = true;

    if (fields.lastname === "") {
        showFloatingError("lastname", "Vui lòng nhập họ");
        isValid = false;
    }

    if (fields.firstname === "") {
        showFloatingError("firstname", "Vui lòng nhập tên");
        isValid = false;
    }

    if (fields.username === "") {
        showFloatingError("username", "Vui lòng nhập tên đăng nhập");
        isValid = false;
    }

    if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(fields.email)) {
        showFloatingError("email", "Email không hợp lệ");
        isValid = false;
    }

    if (!/^[0-9]{10}$/.test(fields.phone)) {
        showFloatingError("phone", "Số điện thoại không hợp lệ (10 chữ số)");
        isValid = false;
    }

    if (fields.address === "") {
        showFloatingError("address", "Vui lòng nhập địa chỉ");
        isValid = false;
    }

    if (fields.dob === "") {
        showFloatingError("dob", "Vui lòng chọn ngày sinh");
        isValid = false;
    }

    if (fields.gender === "") {
        showFloatingError("gender", "Vui lòng chọn giới tính");
        isValid = false;
    }

    if (fields.password.length < 6) {
        showFloatingError("password", "Mật khẩu phải ít nhất 6 ký tự");
        isValid = false;
    }

    if (fields.password !== fields.password_confirm) {
        showFloatingError("password_confirm", "Mật khẩu nhập lại không khớp");
        isValid = false;
    }

    if (!fields.check) {
        showFloatingError("check", "Bạn phải đồng ý với điều khoản");
        isValid = false;
    }

    if (isValid) {
        const formData = new URLSearchParams(new FormData(form));

        fetch(form.action, {
            method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded"
            },
            body: formData
        })
                .then(res => res.text())
                .then(msg => {
                    const isSuccess = msg.toLowerCase().includes("thành công");
                    showToast(msg, isSuccess ? "success" : "error");


                    if (isSuccess) {
                        setTimeout(() => location.reload(),3000);
                    }
                })
                .catch(err => {
                    showToast("Lỗi gửi dữ liệu. Vui lòng thử lại.", "error");
                    console.error("Lỗi khi gửi dữ liệu:", err);
                });
    }

}

function showFloatingError(fieldId, message) {
    const field = document.getElementById(fieldId);
    const rect = field.getBoundingClientRect();

    const tooltip = document.createElement("div");
    tooltip.className = "tooltip-error";
    tooltip.innerText = message;

    document.body.appendChild(tooltip);

    const scrollTop = window.pageYOffset || document.documentElement.scrollTop;
    tooltip.style.top = `${rect.top + scrollTop - tooltip.offsetHeight - 5}px`;
    tooltip.style.left = `${rect.left}px`;

    field.classList.add("is-invalid");

    setTimeout(() => {
        tooltip.remove();
        field.classList.remove("is-invalid");
    }, 4000);
}

function clearErrors() {
    document.querySelectorAll(".tooltip-error").forEach(e => e.remove());
    document.querySelectorAll(".is-invalid").forEach(e => e.classList.remove("is-invalid"));
}

function showToast(message, type = "success") {
    const toast = document.createElement("div");
    toast.innerText = message;
    toast.style.minWidth = "250px";
    toast.style.marginBottom = "10px";
    toast.style.padding = "15px 20px";
    toast.style.borderRadius = "6px";
    toast.style.color = "white";
    toast.style.boxShadow = "0 2px 6px rgba(0,0,0,0.2)";
    toast.style.fontSize = "14px";
    toast.style.backgroundColor = type === "success" ? "#28a745" : "#dc3545";
    toast.style.animation = "fadein 0.5s, fadeout 0.5s 3s";
    toast.style.position = "relative";

    document.getElementById("toast-container").appendChild(toast);

    setTimeout(() => toast.remove(), 4000);
}
