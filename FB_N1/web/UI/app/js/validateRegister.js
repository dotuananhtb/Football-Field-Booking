document.addEventListener("DOMContentLoaded", () => {
    const form = document.getElementById("dkiform");
    if (form) {
        form.addEventListener("submit", function (event) {
            event.preventDefault(); // Ngăn form reload trang
            validateAndSubmit();
        });
    }
});

function validateAndSubmit() {
    const form = document.getElementById("dkiform");

    const fields = {
        dob: form.dob.value,
        password: form.password.value,
        password_confirm: form.password_confirm.value,
        check: form.check.checked
    };

    let isValid = true;

    // Kiểm tra ngày sinh
    if (fields.dob === "") {
        showToast11("Vui lòng chọn ngày sinh", "error");
        isValid = false;
    } else {
        const today = new Date();
        const dob = new Date(fields.dob);
        if (dob >= today) {
            showToast11("Ngày sinh phải trước ngày hiện tại", "error");
            isValid = false;
        }
    }

    // Kiểm tra mật khẩu và nhập lại
    if (fields.password === "" || fields.password_confirm === "") {
        showToast11("Vui lòng nhập đầy đủ mật khẩu", "error");
        isValid = false;
    } else if (fields.password !== fields.password_confirm) {
        showToast11("Mật khẩu nhập lại không khớp", "error");
        isValid = false;
    }

    // Kiểm tra checkbox đồng ý điều khoản
    if (!fields.check) {
        showToast11("Bạn phải đồng ý với điều khoản", "error");
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
                    showToast11(msg, isSuccess ? "success" : "error");

                    if (isSuccess) {
                        setTimeout(() => location.reload(), 1000);
                    }
                })
                .catch(err => {
                    showToast11("Lỗi gửi dữ liệu. Vui lòng thử lại.", "error");
                    console.error("Lỗi khi gửi dữ liệu:", err);
                });
    }
}

function showToast11(message, type = "success") {
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
