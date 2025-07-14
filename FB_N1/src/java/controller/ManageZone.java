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
@WebServlet(name="ManageZone", urlPatterns={"/admin/quan-li-khu-vuc"})
public class ManageZone extends HttpServlet {
   
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
    } 

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
        
      
    String zone_id = request.getParameter("zone_id");
    Zone zone = null;

    if (zone_id != null) {
        Zone_DAO zDao = new Zone_DAO();
        zone = zDao.getZonebyZoneId(zone_id);
        request.setAttribute("zone", zone); // Đẩy đối tượng Zone để hiển thị vào modal
    }

    // Luôn load danh sách
    Zone_DAO zDao = new Zone_DAO();
    List<Zone> listZone = zDao.getAllZone();
    request.setAttribute("listZone", listZone);

    request.getRequestDispatcher("manage-zone.jsp").forward(request, response);
    } 

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
          int zone_id_Raw = Integer.parseInt(request.getParameter("zone_id"));
        String zoneName = request.getParameter("zone_name");
        String address = request.getParameter("address");
        Zone_DAO zDao = new Zone_DAO();
        Zone zone = new Zone(zone_id_Raw,zoneName, address);
        
        if(zDao.UpdateZone(zone)){
            ToastUtil.setSuccessToast(request, "Thêm Khu vực thành công");
        }else{
            ToastUtil.setErrorToast(request, "Thêm Khu vực không thành công");
        }
        response.sendRedirect(request.getContextPath() + "/admin/quan-li-khu-vuc");
    }

   
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
