$(document).ready(function () {
    const tableId = '#scroll-horizontal-datatable';

    const table = $(tableId).DataTable({
        scrollX: true,
        orderCellsTop: true,
    
        ajax: {
            url: '/FB_N1/checking-slots2',
            dataSrc: ''
        },
        columns: [
            {data: null, title: 'STT', render: (data, type, row, meta) => meta.row + 1},
            {data: 'extendedProps.booking_details_code'},
            {data: 'extendedProps.slot_date'},
            {
                data: null,
                render: (data, type, row) => {
                    const ep = row.extendedProps || {};
                    return (ep.start_time || '-') + ' - ' + (ep.end_time || '-');
                }
            },
            {data: 'extendedProps.field_name'},
            {data: 'extendedProps.field_type_name'},
            {
                data: 'extendedProps.status',
                render: function (data) {
                    if (data === 1)
                        return '<span class="badge bg-success">Đã đặt</span>';
                    if (data === 2)
                        return '<span class="badge bg-warning text-dark">Chờ xử lý</span>';
                    if (data === 3)
                        return '<span class="badge bg-danger">Đã huỷ</span>';
                    return '<span class="badge bg-secondary">Không xác định</span>';
                }
            },
            {data: 'extendedProps.userInfo.name'},
            {
                data: null,
                render: (data, type, row) => row?.extendedProps?.userInfo?.phone || '-',
                createdCell: function (td, cellData, rowData) {
                    const phone = rowData?.extendedProps?.userInfo?.phone;
                    td.style.fontWeight = phone ? 'bold' : 'normal';
                }
            },
            {data: 'extendedProps.userInfo.email'},
            {data: 'extendedProps.booking_date'},
            {
                data: 'extendedProps.price',
                render: (data) => data !== null ? $.fn.dataTable.render.number(',', '.', 0, '', ' đ').display(data) : '-'
            },
            {
                data: null,
                title: 'Ghi chú',
                render: function (data, type, row) {
                    return row?.extendedProps?.note || '-';
                }
            }

        ],
        pageLength: 10,
        language: {
            info: "Hiển thị _START_ đến _END_ trong tổng _TOTAL_ dòng",
            infoEmpty: "Không có dữ liệu để hiển thị",
            lengthMenu: "Hiển thị _MENU_ dòng mỗi trang",
            search: "Tìm kiếm:",
            zeroRecords: "Không tìm thấy kết quả phù hợp",
            emptyTable: "Không có dữ liệu trong bảng",
            paginate: {
                previous: "<i class='ri-arrow-left-s-line'></i>",
                next: "<i class='ri-arrow-right-s-line'></i>"
            }
        },
        drawCallback: function () {
            $(".dataTables_paginate > .pagination").addClass("pagination-rounded");
        },
        initComplete: function () {
            const api = this.api();

            // Gán sự kiện cho từng ô tìm kiếm
            api.columns().every(function (colIdx) {
                const input = $('#filter-row th').eq(colIdx).find('input[type="text"]');
                if (input.length) {
                    input.on('keyup change', function () {
                        api.column(colIdx).search(this.value).draw();
                    });
                }
            });

            // Tìm kiếm theo khoảng ngày "Ngày đá" và "Ngày đặt"
            $('#slotDateFrom, #slotDateTo, #bookingDateFrom, #bookingDateTo').on('change', function () {
                api.draw();
            });

            // Bộ lọc custom
            $.fn.dataTable.ext.search.push(function (settings, data, dataIndex) {
                const slotDate = data[2];
                const bookingDate = data[10];

                const fromSlot = $('#slotDateFrom').val();
                const toSlot = $('#slotDateTo').val();
                const fromBook = $('#bookingDateFrom').val();
                const toBook = $('#bookingDateTo').val();

                let isSlotInRange = true;
                let isBookingInRange = true;

                if (fromSlot && slotDate < fromSlot)
                    isSlotInRange = false;
                if (toSlot && slotDate > toSlot)
                    isSlotInRange = false;

                if (fromBook && bookingDate < fromBook)
                    isBookingInRange = false;
                if (toBook && bookingDate > toBook)
                    isBookingInRange = false;

                return isSlotInRange && isBookingInRange;
            });

            // Nút đặt lại
            $('#reset-filters').on('click', function () {
                $('#filter-row input').val('');
                api.columns().search('');
                api.draw();
            });
        }
    });
});