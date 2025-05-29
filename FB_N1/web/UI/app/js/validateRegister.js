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

    const nameRegex = /^[A-Za-zÀ-ỹà-ỹ\s]+$/u;

    if (fields.lastname === "") {
        showToast("Vui lòng nhập họ", "error");
        isValid = false;
    } else if (!nameRegex.test(fields.lastname)) {
        showToast("Họ chỉ được chứa chữ cái", "error");
        isValid = false;
    }

    if (fields.firstname === "") {
        showToast("Vui lòng nhập tên", "error");
        isValid = false;
    } else if (!nameRegex.test(fields.firstname)) {
        showToast("Tên chỉ được chứa chữ cái", "error");
        isValid = false;
    }

    if (fields.username === "") {
        showToast("Vui lòng nhập tên đăng nhập", "error");
        isValid = false;
    } else if (!/^[a-zA-Z0-9_.]+$/.test(fields.username)) {
        showToast("Tên đăng nhập chỉ được chứa chữ cái không dấu, số, dấu _ và dấu .", "error");
        isValid = false;
    } else if (fields.username.length < 6) {
        showToast("Tên đăng nhập phải có ít nhất 6 ký tự", "error");
        isValid = false;
    }

    if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(fields.email)) {
        showToast("Email không hợp lệ", "error");
        isValid = false;
    }

    if (!/^[0-9]{10}$/.test(fields.phone)) {
        showToast("Số điện thoại không hợp lệ (10 chữ số)", "error");
        isValid = false;
    }

    if (fields.address === "") {
        showToast("Vui lòng nhập địa chỉ", "error");
        isValid = false;
    }

    if (fields.dob === "") {
        showToast("Vui lòng chọn ngày sinh", "error");
        isValid = false;
    } else {
        const today = new Date();
        const dob = new Date(fields.dob);
        if (dob >= today) {
            showToast("Ngày sinh phải trước ngày hiện tại", "error");
            isValid = false;
        }
    }

    if (fields.gender === "") {
        showToast("Vui lòng chọn giới tính", "error");
        isValid = false;
    }

    const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[^A-Za-z\d]).{8,}$/;
    if (!passwordRegex.test(fields.password)) {
        showToast("Mật khẩu phải ít nhất 8 ký tự, gồm chữ, số và ký tự đặc biệt", "error");
        isValid = false;
    }

    if (fields.password !== fields.password_confirm) {
        showToast("Mật khẩu nhập lại không khớp", "error");
        isValid = false;
    }

    if (!fields.check) {
        showToast("Bạn phải đồng ý với điều khoản", "error");
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
                        setTimeout(() => location.reload(), 1000);
                    }
                })
                .catch(err => {
                    showToast("Lỗi gửi dữ liệu. Vui lòng thử lại.", "error");
                    console.error("Lỗi khi gửi dữ liệu:", err);
                });
    }
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
