/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.SelectSaleDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.ToastUtil;

/**
 *
 * @author VAN NGUYEN
 */
@WebServlet(name = "SaveSale", urlPatterns = {"/admin/luu-uu-dai"})
public class SaveSale extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String saleId = request.getParameter("saleId");
        SelectSaleDao ssDao = new SelectSaleDao();

        System.out.println("💾 Lưu saleId: " + saleId);  // Kiểm tra có lấy được không   
        ssDao.updateSelectSale(saleId);
        String currentSaleId = ssDao.getSaleBySaleID();
        response.setStatus(HttpServletResponse.SC_OK);

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
