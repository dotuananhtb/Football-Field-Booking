/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.FieldDAO;
import dao.SlotsOfDayDAO;
import dao.SlotsOfFieldDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import model.Field;
import model.SlotsOfDay;
import model.SlotsOfField;
import util.ToastUtil;

/**
 *
 * @author Admin
 */
@WebServlet(name = "Admin_GiaTungCa", urlPatterns = {"/admin/quan-ly-gia-tung-ca"})
public class Admin_GiaTungCa extends HttpServlet {

    private final FieldDAO fieldDAO = new FieldDAO();
    private final SlotsOfDayDAO slotDAO = new SlotsOfDayDAO();
    private final SlotsOfFieldDAO slotFieldDAO = new SlotsOfFieldDAO();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Admin_GiaTungCa</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Admin_GiaTungCa at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Field> fields = fieldDAO.getAllFields();
        List<SlotsOfField> slotPrices;

        String fieldIdRaw = request.getParameter("field_id");

        int fieldId = -1;
        List<SlotsOfDay> slots = new ArrayList<>();
        Set<Integer> existingSlotIds = new HashSet<>();

        if (fieldIdRaw != null && !fieldIdRaw.isEmpty()) {
            fieldId = Integer.parseInt(fieldIdRaw);
            Field field = fieldDAO.getFieldByFieldID(fieldId);

            if (field != null && field.getTypeOfField() != null) {
                int fieldTypeId = field.getTypeOfField().getFieldTypeId();
                slots = slotDAO.getSlotsByFieldType(fieldTypeId);

                slotPrices = slotFieldDAO.getSlotsByField2(fieldId);
                for (SlotsOfField sof : slotPrices) {
                    if (sof.getField().getFieldId() == fieldId) {
                        existingSlotIds.add(sof.getSlotInfo().getSlotId());
                    }
                }
            } else {
                slotPrices = slotFieldDAO.getAllSlotPricesWithDetails();
            }
        } else {
            // chưa chọn sân: hiện toàn bộ
            slotPrices = slotFieldDAO.getAllSlotPricesWithDetails();
        }

        request.setAttribute("selectedFieldId", fieldId);
        request.setAttribute("fields", fields);
        request.setAttribute("slots", slots);
        request.setAttribute("slotPrices", slotPrices);
        request.setAttribute("existingSlotIds", existingSlotIds);

        request.getRequestDispatcher("/admin/QuanLyGiaTungCa.jsp").forward(request, response);

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("save_bulk_price".equals(action)) {
            try {
                String fieldIdRaw = request.getParameter("field_id");
                String[] slotIdsRaw = request.getParameterValues("slot_ids");
                String priceRaw = request.getParameter("slot_field_price");
                String submitType = request.getParameter("submitType");

                String errorMsg = null;
                if (slotIdsRaw == null || slotIdsRaw.length == 0) {
                    errorMsg = "Vui lòng chọn ít nhất 1 ca!";
                } else if (priceRaw == null || priceRaw.trim().isEmpty()) {
                    errorMsg = "Giá không được để trống!";
                }
                if (fieldIdRaw == null || fieldIdRaw.trim().isEmpty()) {
                    errorMsg = "Vui lòng chọn sân!";
                }
                if (errorMsg != null) {
                    ToastUtil.setWarningToast(request, errorMsg);
                    response.sendRedirect("quan-ly-gia-tung-ca");
                    return;
                }
                int fieldId = Integer.parseInt(fieldIdRaw);
                BigDecimal price;
                try {
                    price = new BigDecimal(priceRaw);
                } catch (NumberFormatException ex) {
                    ToastUtil.setErrorToast(request, "Giá không hợp lệ!");
                    response.sendRedirect("quan-ly-gia-tung-ca");
                    return;
                }

                if (price.compareTo(BigDecimal.ZERO) <= 0) {
                    ToastUtil.setWarningToast(request, "Giá phải lớn hơn 0!");
                    response.sendRedirect("quan-ly-gia-tung-ca");
                    return;
                }

                for (String slotIdRaw : slotIdsRaw) {
                    int slotId = Integer.parseInt(slotIdRaw);

                    boolean exists = slotFieldDAO.existsSlotPrice(fieldId, slotId);
                    if ("insert".equals(submitType)) {
                        if (exists) {
                            ToastUtil.setWarningToast(request, "Một số ca đã có giá! Không thể thêm mới.");
                            continue;
                        }
                        slotFieldDAO.insertSlotPrice(fieldId, slotId, price);
                        ToastUtil.setSuccessToast(request, "Đã thêm giá Thành Công");

                    } else if ("update".equals(submitType)) {
                        if (!exists) {
                            ToastUtil.setWarningToast(request, "Một số ca chưa có giá! Không thể cập nhật.");
                            continue;
                        }
                        slotFieldDAO.updateSlotPrice(fieldId, slotId, price);
                        ToastUtil.setSuccessToast(request, "Cập nhật giá Thành Công");
                    }
                }

            } catch (Exception e) {
                e.printStackTrace();
                ToastUtil.setErrorToast(request, "Có lỗi xảy ra khi xử lý dữ liệu!");
            }

            response.sendRedirect("quan-ly-gia-tung-ca");
        } else if ("delete_price".equals(action)) {
            try {
                int slotFieldId = Integer.parseInt(request.getParameter("slot_field_id"));

                if (slotFieldDAO.isSlotPriceUsedInBooking(slotFieldId)) {
                    ToastUtil.setWarningToast(request, "Không thể xóa: Giá này đã được dùng trong đặt sân!");
                } else {
                    boolean deleted = slotFieldDAO.deleteSlotPriceById(slotFieldId);
                    if (deleted) {
                        ToastUtil.setSuccessToast(request, "Xóa giá thành công!");
                    } else {
                        ToastUtil.setErrorToast(request, "Không thể xóa giá. Vui lòng thử lại.");
                    }
                }

            } catch (Exception e) {
                e.printStackTrace();
                ToastUtil.setErrorToast(request, "Có lỗi xảy ra khi xoá!");
            }

            String fieldId = request.getParameter("field_id");
            response.sendRedirect("quan-ly-gia-tung-ca" + (fieldId != null ? "?field_id=" + fieldId : ""));

        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
