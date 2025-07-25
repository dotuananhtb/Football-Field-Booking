/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.*;
import dao.UserProfileDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.Vector;
import model.Account;
import model.Field;
import model.UserProfile;
import model.Zone;
import java.util.Vector;
import model.UserProfile;
import model.Field;
import model.*;

/**
 *
 * @author VAN NGUYEN
 */
@WebServlet(name = "HomeControl", urlPatterns = {"/home"})

public class HomeControl extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the
    // + sign on the left to edit the code.">
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

        // lay param tu jsp ve 
        String zoneId = request.getParameter("zID");
        String cateId = request.getParameter("cid");

        String pageStr = request.getParameter("page");

        // khoi tao DAO
        blogDAO blogDao = new blogDAO();
        AccountDAO aDao = new AccountDAO();
        BookingDAO bDao = new BookingDAO();
        SliderDAO sDao = new SliderDAO();
        SaleDAO saleDao = new SaleDAO();
        FieldDAO fDao = new FieldDAO();
        Zone_DAO zDao = new Zone_DAO();
        EventDAO eDao = new EventDAO();
        TypeOfFieldDAO tDao = new TypeOfFieldDAO();

        CateProduct_DAO cDao = new CateProduct_DAO();
        ProductDAO pDao = new ProductDAO();
        SelectDAO selectDao = new SelectDAO();
        SelectSaleDao selectSale = new SelectSaleDao();
        String eventId = selectDao.getSelectedThemeEventId();
        String currentSale = selectSale.getSaleBySaleID();
        Sale currentObjectSale = saleDao.getSaleBySaleId(currentSale);
        // lay du lieu tu dao
        List<Blog> listB1 = blogDao.getLatest3Blogs();
        List<Slider> listS = sDao.getAllSlider();
        List<Zone> listZ = zDao.getAllZoneWithStatus();

        List<TypeOfField> listT = tDao.getAllFieldTypes();
        Vector<CateProduct> listC = (Vector<CateProduct>) cDao.getAllCategory2();

        List<Field> listF2 = fDao.get2Field();

        Event event = eDao.getAllEventByEventId(eventId);

        // lay so luong 
        int countA = aDao.countAccount();
        int countB = bDao.countBooking();
        int countF = fDao.countField();
        int countZ = zDao.countZone();

        request.setAttribute("countA", countA);
        request.setAttribute("countB", countB);
        request.setAttribute("countF", countF);
        request.setAttribute("countZ", countZ);

        // slider field 
        int page = (pageStr != null && !pageStr.isEmpty()) ? Integer.parseInt(pageStr) : 1;
        int pageSize = 4;
        List<Field> listF1;
        if (zoneId != null) {
            listF1 = fDao.get6FieldByZoneId(zoneId);
        } else {
            listF1 = fDao.get6Field();
        }

        // paging product
        Vector<Product> listP;
        int totalProduct = 0;
        int totalPage = 0;

        if (cateId != null) {
            int cateIDInt = Integer.parseInt(cateId);
            listP = (Vector<Product>) pDao.pagingProductByCateID(cateIDInt, page, pageSize);
            totalProduct = pDao.countProductByCateID(cateIDInt);
            request.setAttribute("cid", cateIDInt); // để dùng lại trong phân trang link
        } else {
            listP = (Vector<Product>) pDao.pagingProduct(page, pageSize);
            totalProduct = pDao.getTotalProduct();
        }
        totalPage = (int) Math.ceil((double) totalProduct / pageSize);

        // set thuoc tinh de ban sang jsp
        request.setAttribute("currentSale", currentObjectSale);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPage", totalPage);

        // end paging product 
        request.setAttribute("listB1", listB1);
        request.setAttribute("listT", listT);
        request.setAttribute("event", event);
        request.setAttribute("listP", listP);
        request.setAttribute("listC", listC);
        request.setAttribute("field2", listF2);
        request.setAttribute("field", listF1);
        request.setAttribute("zone", listZ);
        request.setAttribute("listS", listS);
        request.getRequestDispatcher("UI/homePage.jsp").forward(request, response);

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
