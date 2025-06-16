/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.FieldDAO;
import dao.Zone_DAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Field;
import model.SlotsOfField;
import model.Zone;

/**
 *
 * @author Admin
 */
@WebServlet(name = "DanhSachSan", urlPatterns = {"/DanhSachSan"})
public class DanhSachSan extends HttpServlet {

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
            out.println("<title>Servlet DanhSachSan</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DanhSachSan at " + request.getContextPath() + "</h1>");
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
        FieldDAO dao = new FieldDAO();
        Zone_DAO zDAO = new Zone_DAO();
        List<Zone> listZ = zDAO.getAllZone();
        String indexPage = request.getParameter("index");
        String sortBy = request.getParameter("sortBy");

        int index = 1;
        if (sortBy == null || sortBy.isEmpty()) {
            sortBy = "";
        }
        if (indexPage != null && !indexPage.isEmpty()) {
            index = Integer.parseInt(indexPage);
        }
        int count = dao.getTotalFiled();
        int endPage = count / 6;

        if (count % 6 != 0) {
            endPage++;
        }

        List<Field> listP = dao.pagingField(index, sortBy);
        for (Field f : listP) {
            f.setSlots(dao.getFieldSlotsWithDetails(f.getFieldId()));
        }

        Map<Integer, BigDecimal[]> priceMap = new HashMap<>();
        Map<Integer, Integer> totalSlotMap = new HashMap<>();

        for (Field f : listP) {
            List<SlotsOfField> slots = dao.getFieldSlotsWithDetails(f.getFieldId());
            f.setSlots(slots);

            // Tính giá min/max
            BigDecimal min = null, max = null;
            for (SlotsOfField s : slots) {
                BigDecimal p = s.getSlotFieldPrice();
                if (min == null || p.compareTo(min) < 0) {
                    min = p;
                }
                if (max == null || p.compareTo(max) > 0) {
                    max = p;
                }
            }
            priceMap.put(f.getFieldId(), new BigDecimal[]{min, max});

            // Tính tổng slot
            totalSlotMap.put(f.getFieldId(), slots.size());
        }

        int showing = listP.size();

        request.setAttribute("listF", listP);
        request.setAttribute("endP", endPage);
        request.setAttribute("listZ", listZ);
        request.setAttribute("page", index);
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("total", count);
        request.setAttribute("showing", showing);
        request.setAttribute("priceMap", priceMap);
        request.setAttribute("totalSlotMap", totalSlotMap);
        request.getRequestDispatcher("UI/danhSachSan.jsp").forward(request, response);
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
        processRequest(request, response);
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
