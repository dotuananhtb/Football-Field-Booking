/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dao.Zone_DAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Zone;
import util.ToastUtil;

/**
 *
 * @author VAN NGUYEN
 */
@WebServlet(name="AddZone", urlPatterns={"/admin/them-khu-vuc"})
public class AddZone extends HttpServlet {
   
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
        Zone_DAO zDao = new Zone_DAO();
        List<Zone> listZone = zDao.getAllZone();
        
        
        
        request.setAttribute("listZone", listZone);
        request.getRequestDispatcher("manage-zone.jsp").forward(request, response);
    } 

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String zoneName = request.getParameter("zone_name");
        String address = request.getParameter("address");
        Zone_DAO zDao = new Zone_DAO();
        Zone zone = new Zone(zoneName, address);
        
        if(zDao.InsertZone(zone)){
            ToastUtil.setSuccessToast(request, "Thêm Khu vực thành công");
        }else{
            ToastUtil.setErrorToast(request, "Thêm Khu vực không thành công");
        }
       response.sendRedirect(request.getContextPath() + "/admin/quan-li-khu-vuc");
        
        
        
        
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
