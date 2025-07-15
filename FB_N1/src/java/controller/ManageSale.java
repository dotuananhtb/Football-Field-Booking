/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dao.SaleDAO;
import dao.SelectSaleDao;
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
@WebServlet(name="ManageSale", urlPatterns={"/admin/quan-li-uu-dai"})
public class ManageSale extends HttpServlet {
   
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
       
    } 

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String saleId = request.getParameter("saleId");
        
        SaleDAO sDao = new SaleDAO();
        SelectSaleDao ssDao = new SelectSaleDao();
        String currentSaleId = ssDao.getSaleBySaleID();
        System.out.println(currentSaleId +"+===");
        if(saleId != null){
            Sale sale = sDao.getSaleBySaleId(saleId);
            
            request.setAttribute("sale", sale);
        }
        List<Sale> listSale = sDao.getAllSales();
        request.setAttribute("currentSaleId", currentSaleId);
        request.setAttribute("listSale", listSale);
        
        request.getRequestDispatcher("manage-sale.jsp").forward(request, response);
        
        
        
    } 

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
        int saleId = Integer.parseInt(request.getParameter("saleId"));
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
        }
            else{
            Sale sale = new Sale(saleId, minSlot, maxSlot, salePercent, description);
        SaleDAO sDao = new SaleDAO();
        
         
        if(sDao.updateSale(sale)){
            ToastUtil.setSuccessToast(request, "Thêm ưu đãi thành công");
        }else{
            ToastUtil.setErrorToast(request, "Thêm ưu đãi không thành công");
        }
                    response.sendRedirect(request.getContextPath() + "/admin/quan-li-uu-dai");
        }
        
        
        
        
        
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
