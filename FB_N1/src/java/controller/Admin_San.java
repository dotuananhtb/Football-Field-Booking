/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.FieldDAO;
import dao.TypeOfFieldDAO;
import dao.Zone_DAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.util.List;
import logic.CloudinaryUploader;
import model.Field;
import model.TypeOfField;
import model.Zone;
import util.ToastUtil;

/**
 *
 * @author Admin
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
@WebServlet(name = "Admin_San", urlPatterns = {"/admin/quan-ly-San"})
public class Admin_San extends HttpServlet {

    private final CloudinaryUploader uploader = new CloudinaryUploader();

    private boolean isBlank(String s) {
        // Null, rỗng, hoặc chỉ toàn khoảng trắng
        if (s == null || s.trim().isEmpty()) {
            return true;
        }
        // Regex cho phép chữ cái, số, khoảng trắng và dấu nháy đơn ('), gạch ngang (-)
        return !s.matches("^[\\p{L}\\d\\s'-]+$");
    }

    private final FieldDAO fieldDAO = new FieldDAO();
    private final Zone_DAO zoneDAO = new Zone_DAO();
    private final TypeOfFieldDAO typeDAO = new TypeOfFieldDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Admin_San</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Admin_San at " + request.getContextPath() + "</h1>");
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
        List<Field> fields = fieldDAO.getAllFields2();
        List<Zone> zones = zoneDAO.getAllZone();
        List<TypeOfField> types = typeDAO.getAllFieldTypes();

        request.setAttribute("fields", fields);
        request.setAttribute("zones", zones);
        request.setAttribute("types", types);

        request.getRequestDispatcher("/admin/QuanLySan.jsp").forward(request, response);
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

        try {
            // Lấy dữ liệu từ form
            String fieldName = request.getParameter("field_name");
            String status = request.getParameter("status");
            String description = request.getParameter("description");
            String zoneIdRaw = request.getParameter("zone_id");
            String typeIdRaw = request.getParameter("type_id");
            String fieldIdRaw = request.getParameter("field_id");

            Part filePart = request.getPart("image");
            String imageUrl = null;
            // Ảnh gửi từ form (input name="image")

            // Validate đầu vào
            if (isBlank(fieldName)) {
                ToastUtil.setErrorToast(request, "Tên sân không khả dụng!");
                response.sendRedirect("quan-ly-San");
                return;
            }
            if (isBlank(status)) {
                ToastUtil.setErrorToast(request, "Trạng thái không được để trống!");
                response.sendRedirect("quan-ly-San");
                return;
            }
            if (isBlank(zoneIdRaw) || isBlank(typeIdRaw)) {
                ToastUtil.setErrorToast(request, "Khu vực và loại sân là bắt buộc!");
                response.sendRedirect("quan-ly-San");
                return;
            }

            int zoneId = Integer.parseInt(zoneIdRaw);
            int typeId = Integer.parseInt(typeIdRaw);
            int fieldId = -1;
            if (fieldIdRaw != null && !fieldIdRaw.isEmpty()) {
                fieldId = Integer.parseInt(fieldIdRaw);
            }
            if (filePart != null && filePart.getSize() > 0) {
                imageUrl = uploader.uploadImage(filePart, "field");
            } else {
                if ("add".equals(action)) {
                    ToastUtil.setErrorToast(request, "Vui lòng chọn ảnh hợp lệ (jpg, png, jpeg, gif, webp)!");
                    response.sendRedirect("quan-ly-San");
                    return;
                } else if ("update".equals(action) && fieldId != -1) {
                    imageUrl = fieldDAO.getFieldByFieldID(fieldId).getImage(); // giữ ảnh cũ
                }
            }
            // Kiểm tra trùng tên trong khu vực
            if (fieldDAO.isFieldNameExist(fieldName, "update".equals(action) ? fieldId : null)) {
                ToastUtil.setErrorToast(request, "Tên sân đã tồn tại!");
                response.sendRedirect("quan-ly-San");
                return;
            }
            // Thêm hoặc cập nhật
            if ("add".equals(action)) {
                Zone zone = zoneDAO.getZonebyZoneId(zoneIdRaw);
                TypeOfField typeOfField = typeDAO.getFieldTypeById(typeId);
                Field field1 = new Field(fieldName, imageUrl, status, description, zone, typeOfField);
                fieldDAO.insertField(field1);
                ToastUtil.setSuccessToast(request, "Đã thêm sân thành công!");
            } else if ("update".equals(action) && fieldId != -1 && fieldDAO.getFieldByFieldID(fieldId).getZone().getStatus() == 1) {
                Field field = fieldDAO.getFieldByFieldID(fieldId);
                field.setFieldName(fieldName);
                field.setStatus(status);
                field.setDescription(description);
                if (imageUrl != null) {
                    field.setImage(imageUrl); // Chỉ set khi có ảnh
                }

                int oldTypeId = field.getTypeOfField().getFieldTypeId();
                // Nếu loại sân thay đổi → kiểm tra và sync slot
                if (oldTypeId != typeId) {
                    boolean ok = fieldDAO.syncSlotsAfterTypeUpdate(fieldId, typeId);
                    if (!ok) {
                        ToastUtil.setErrorToast(request, "Không thể đổi loại sân vì có khung giờ đã được đặt!");
                        response.sendRedirect("quan-ly-San");
                        return;
                    }
                    field.setTypeOfField(typeDAO.getFieldTypeById(typeId));
                }

                fieldDAO.updateField(field);

                ToastUtil.setSuccessToast(request, "Đã cập nhật sân thành công!");
            } else {
                if (fieldDAO.getFieldByFieldID(fieldId).getZone().getStatus() == 2) {
                    ToastUtil.setErrorToast(request, "Khu vực hiện không hoạt động");
                } else {
                    ToastUtil.setErrorToast(request, "Cập nhật thất bại");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("LOI CU THE: " + e.getMessage());
            ToastUtil.setErrorToast(request, "Có lỗi xảy ra khi xử lý dữ liệu!");
        }

        response.sendRedirect("quan-ly-San");
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
