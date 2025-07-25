/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.SlotsOfDayDAO;
import dao.TypeOfFieldDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.SlotsOfDay;
import model.TypeOfField;
import util.ToastUtil;

/**
 *
 * @author Admin
 */
@WebServlet(name = "Admin_CaTheoLoaiSan", urlPatterns = {"/admin/quan-ly-ca-theo-loai-san"})
public class Admin_CaTheoLoaiSan extends HttpServlet {

    private SlotsOfDayDAO slotDAO = new SlotsOfDayDAO();
    private TypeOfFieldDAO typeDAO = new TypeOfFieldDAO();

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
            out.println("<title>Servlet quan-ly-ca-theo-loai-san</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet quan-ly-ca-theo-loai-san at " + request.getContextPath() + "</h1>");
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
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }
        switch (action) {
            case "add":
                List<TypeOfField> typesForAdd = typeDAO.getAllFieldTypes();
                request.setAttribute("types", typesForAdd);
                request.getRequestDispatcher("/admin/QuanLyCacCa.jsp").forward(request, response);
                break;

            case "edit":
                int editId = Integer.parseInt(request.getParameter("id"));
                SlotsOfDay slotToEdit = slotDAO.getSlotById(editId);
                List<TypeOfField> typesForEdit = typeDAO.getAllFieldTypes();
                request.setAttribute("slot", slotToEdit);
                request.setAttribute("types", typesForEdit);
                request.getRequestDispatcher("/admin/QuanLyCacCa.jsp").forward(request, response);
                break;

            case "delete":
                int deleteId = Integer.parseInt(request.getParameter("id"));
                slotDAO.deleteSlot(deleteId);
                response.sendRedirect("quan-ly-ca-theo-loai-san");
                break;
            default: // list
                List<SlotsOfDay> slotList = slotDAO.getAllSlots2();
                List<TypeOfField> typeList = typeDAO.getAllFieldTypes();

                // Tạo Map<field_type_id, field_type_name> để tra cứu trong JSP
                Map<Integer, String> typeMap = new HashMap<>();
                for (TypeOfField type : typeList) {
                    typeMap.put(type.getFieldTypeId(), type.getFieldTypeName());
                }

                request.setAttribute("list", slotList);
                request.setAttribute("types", typeList);
                request.setAttribute("typeMap", typeMap);
                request.getRequestDispatcher("/admin/QuanLyCacCa.jsp").forward(request, response);
        }
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
        String start = request.getParameter("start_time");
        String end = request.getParameter("end_time");
        String fieldTypeIdRaw = request.getParameter("field_type_id");

        // ✅ Thêm nhiều ca bằng checkbox
        if ("checkbox_bulk_add".equals(action)) {
            String[] selectedSlots = request.getParameterValues("selected_slots");
            System.out.println(" Selected slots: " + Arrays.toString(selectedSlots));

            System.out.println("==> fieldTypeIdRaw = " + fieldTypeIdRaw);
            System.out.println("==> selectedSlots = " + Arrays.toString(selectedSlots));

            try {
                int fieldTypeId = Integer.parseInt(fieldTypeIdRaw);
                if (selectedSlots != null) {
                    for (String slotRange : selectedSlots) {
                        String[] parts = slotRange.split("-");
                        if (parts.length == 2) {
                            start = parts[0].trim();
                            end = parts[1].trim();
                            // ✅ Check trùng slot
                            if (slotDAO.isTimeSlotOverlap(start, end, fieldTypeId)) {
                                ToastUtil.setErrorToast(request, "Ca này đã tồn tại!");
                                continue;
                            }
                            SlotsOfDay slot = new SlotsOfDay(0, start, end, fieldTypeId);
                            slotDAO.addSlot(slot);
                            ToastUtil.setSuccessToast(request, "Đã thêm các ca đã chọn!");
                        }
                    }
                }
            } catch (NumberFormatException e) {
                ToastUtil.setErrorToast(request, "Loại sân không hợp lệ!");
                e.printStackTrace();
            }

            response.sendRedirect("quan-ly-ca-theo-loai-san");
            return;
        }

        // ✅ Thêm/Sửa 1 ca
        try {
            int fieldTypeId = Integer.parseInt(fieldTypeIdRaw);

            if ("add".equals(action)) {
                if (start.compareTo(end) >= 0) {
                    ToastUtil.setWarningToast(request, "Giờ bắt đầu phải nhỏ hơn giờ kết thúc!");
                } else if (slotDAO.isTimeSlotOverlap(start, end, fieldTypeId)) {
                    ToastUtil.setWarningToast(request, "Khung giờ bị trùng với ca đã tồn tại!");
                } else {
                    SlotsOfDay newSlot = new SlotsOfDay(0, start, end, fieldTypeId);
                    slotDAO.addSlot(newSlot);
                    ToastUtil.setSuccessToast(request, "Thêm khung giờ thành công!");
                }
            } else if ("edit".equals(action)) {
                String idRaw = request.getParameter("id");
                if (idRaw != null && !idRaw.isEmpty()) {
                    int id = Integer.parseInt(idRaw);
                    if (start.compareTo(end) >= 0) {
                        ToastUtil.setWarningToast(request, "Giờ bắt đầu phải nhỏ hơn giờ kết thúc!");
                    } else if (slotDAO.isTimeSlotOverlapExceptId(start, end, fieldTypeId,id)) {
                        ToastUtil.setWarningToast(request, "Khung giờ bị trùng với ca đã tồn tại!");
                    } else {
                        SlotsOfDay updatedSlot = new SlotsOfDay(id, start, end, fieldTypeId);
                        slotDAO.updateSlot(updatedSlot);
                        ToastUtil.setSuccessToast(request, "Cập nhật khung giờ thành công!");
                    }
                } else {
                    ToastUtil.setWarningToast(request, "Thiếu ID để cập nhật!");
                }
            }

        } catch (NumberFormatException e) {
            ToastUtil.setErrorToast(request, "Dữ liệu không hợp lệ!");
            e.printStackTrace();
        }

        response.sendRedirect("quan-ly-ca-theo-loai-san");
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
