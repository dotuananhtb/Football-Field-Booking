function autoResize(textarea) {
    textarea.style.height = 'auto'; // reset
    textarea.style.height = textarea.scrollHeight + 'px'; // fit content
}
function editField(id, name, image, typeId, zoneId, status, description) {
    document.getElementById("formAction").value = "update";
    document.getElementById("fieldId").value = id;
    document.getElementById("fieldName").value = name.trim();
    document.getElementById("fieldImagePreview").src = image;
    document.getElementById("typeId").value = typeId;
    document.getElementById("zoneId").value = zoneId;

    // Đảm bảo status khớp với option trong <select>
    document.getElementById("fieldstatus").value = status.trim();

    document.getElementById("description").value = description;

    // Chuyển sang chế độ cập nhật
    document.getElementById("btnAdd").style.display = "none";
    document.getElementById("btnUpdate").style.display = "inline-block";
    document.getElementById("btnCancel").style.display = "inline-block";
    window.scrollTo({top: 0, behavior: 'smooth'});

    const modal = new bootstrap.Modal(document.getElementById("bs-example-modal-lg"));
    modal.show();
}

function cancelEdit() {
    document.getElementById("formAction").value = "add";
    document.getElementById("fieldId").value = "";
    document.getElementById("fieldName").value = "";

    // ✅ Reset input file bằng cách tạo lại
    const oldInput = document.getElementById("fieldImage");
    const newInput = oldInput.cloneNode();
    oldInput.parentNode.replaceChild(newInput, oldInput);

    // ✅ Reset ảnh preview
    document.getElementById("fieldImagePreview").src = "";

    document.getElementById("typeId").selectedIndex = 0;
    document.getElementById("zoneId").selectedIndex = 0;
    document.getElementById("fieldstatus").selectedIndex = 0;
    document.getElementById("description").value = "";

    document.getElementById("btnAdd").style.display = "inline-block";
    document.getElementById("btnUpdate").style.display = "none";
    document.getElementById("btnCancel").style.display = "none";
}
function resetFieldForm() {
    document.getElementById("formAction").value = "add";
    document.getElementById("fieldId").value = "";
    document.getElementById("fieldName").value = "";
    document.getElementById("fieldImagePreview").src = "";
    document.getElementById("typeId").selectedIndex = 0;
    document.getElementById("zoneId").selectedIndex = 0;
    document.getElementById("fieldstatus").selectedIndex = 0;
    document.getElementById("description").value = "";

    document.getElementById("btnAdd").style.display = "inline-block";
    document.getElementById("btnUpdate").style.display = "none";
    document.getElementById("btnCancel").style.display = "none";
}

document.addEventListener("DOMContentLoaded", function () {
    document.querySelectorAll(".editFieldBtn").forEach(function (btn) {
        btn.addEventListener("click", function () {
            const id = this.dataset.id;
            const name = this.dataset.name;
            const image = this.dataset.image;
            const typeId = this.dataset.type;
            const zoneId = this.dataset.zone;
            const status = this.dataset.status;
            const description = this.dataset.description;

            editField(id, name, image, typeId, zoneId, status, description);
        });
    });
});

