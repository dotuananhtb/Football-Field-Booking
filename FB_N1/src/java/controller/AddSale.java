/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dao.SaleDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Sale;
import util.ToastUtil;

/**
 *
 * @author VAN NGUYEN
 */
@WebServlet(name="AddSale", urlPatterns={"/admin/them-uu-dai"})
public class AddSale extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
       
    } 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        SaleDAO sDao = new SaleDAO();
        List<Sale> listSale = sDao.getAllSales();
        
        request.setAttribute("listSale", listSale);
        request.getRequestDispatcher("manage-sale.jsp").forward(request, response);
    } 
   

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        int salePercent = Integer.parseInt(request.getParameter("salePercent"));
        int minSlot = Integer.parseInt(request.getParameter("minSlot"));
        int maxSlot = Integer.parseInt(request.getParameter("maxSlot"));
        String description = request.getParameter("description");
        
        
        if(minSlot > maxSlot){
            ToastUtil.setErrorToast(request, "Lỗi: Số ca tối thiểu không thể lớn hơn số ca tối đa");
            response.sendRedirect(request.getContextPath() + "/admin/quan-li-uu-dai");
            return;
        }else if (  salePercent > 100){
            ToastUtil.setErrorToast(request, "Lỗi: Phần trăm ưu đãi không thể lớn hơn 100");
            response.sendRedirect(request.getContextPath() + "/admin/quan-li-uu-dai");
            return;
        }else{
            Sale sale = new Sale(minSlot, maxSlot, salePercent, description);
            SaleDAO sDao = new SaleDAO();
        
         
        if(sDao.insertSale(sale)){
            ToastUtil.setSuccessToast(request, "Thêm ưu đãi thành công");
        }else{
            ToastUtil.setErrorToast(request, "Thêm ưu đãi không thành công");
        }
        response.sendRedirect(request.getContextPath() + "/admin/quan-li-uu-dai");
        }
        
        
        
        
        
    }
     

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
