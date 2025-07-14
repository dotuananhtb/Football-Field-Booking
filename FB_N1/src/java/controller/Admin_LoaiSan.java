/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.TypeOfFieldDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.TypeOfField;
import util.ToastUtil;

/**
 *
 * @author Admin
 */
@WebServlet(name = "Admin_LoaiSan", urlPatterns = {"/admin/Admin_LoaiSan"})
public class Admin_LoaiSan extends HttpServlet {

    private TypeOfFieldDAO dao = new TypeOfFieldDAO();

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
            out.println("<title>Servlet Admin_LoaiSan</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Admin_LoaiSan at " + request.getContextPath() + "</h1>");
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
        String editIdStr = request.getParameter("editId");
        if (editIdStr != null) {
            int editId = Integer.parseInt(editIdStr);
            TypeOfField editType = dao.getFieldTypeById(editId);
            request.setAttribute("type", editType);
        }
        List<TypeOfField> list = dao.getAllFieldTypes();
        request.setAttribute("types", list);
        request.getRequestDispatcher("/admin/QuanLyLoaiSan.jsp").forward(request, response);
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
        String name = request.getParameter("field_type_name");
        switch (action) {
            case "add":
                dao.insertFieldType(name);
                ToastUtil.setSuccessToast(request, "Thêm Loại sân Thành công");
                break;

            case "update":
                int updateId = Integer.parseInt(request.getParameter("field_type_id"));
                dao.updateFieldType(updateId, name);
                ToastUtil.setSuccessToast(request, "Cập nhật loại sân thành công.");
                break;

            case "delete":
                int deleteId = Integer.parseInt(request.getParameter("field_type_id"));
                if (dao.isTypeInUse(deleteId)) {
                    ToastUtil.setErrorToast(request, "Không thể xoá loại sân đang được sử dụng.");
                } else {
                    dao.deleteFieldType(deleteId);
                    ToastUtil.setSuccessToast(request, "Xoá loại sân thành công.");
                }
                break;
        }
        response.sendRedirect(request.getContextPath() + "/admin/Admin_LoaiSan");
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
