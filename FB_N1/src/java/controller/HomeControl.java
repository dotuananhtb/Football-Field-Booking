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

//                FieldDAO fdao = new FieldDAO();
//                Zone_DAO Zdao = new Zone_DAO();
//                // Vector<Field> list = dao.getAllField();
//                // List<Zone> listZ = Zdao.getAllZone();
//                //
//                // request.setAttribute("listF", list);
//                // request.setAttribute("listZ", listZ);
//
//                Vector<Field> daof = fdao.getAllFieldLast();
//                request.setAttribute("fdao", daof);
//
//                ProductDAO pdao = new ProductDAO();
//                Vector<Product> plist = pdao.getAllProductsWithCategory();
//                request.setAttribute("plist", plist);
//
//                Vector<FieldDetails> fieldList = fdao.getAllFieldDetails();
//                request.setAttribute("fieldList", fieldList);
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
        String zoneId = request.getParameter("zID");
        String cateId = request.getParameter("cid");
        SliderDAO sDao = new SliderDAO();
        FieldDAO fDao = new FieldDAO();
        Zone_DAO zDao = new Zone_DAO();
        EventDAO eDao = new EventDAO();
        TypeOfFieldDAO tDao = new TypeOfFieldDAO();
        PostDAO postDao = new PostDAO();

        CateProduct_DAO cDao = new CateProduct_DAO();
        ProductDAO pDao = new ProductDAO();
        List<Slider> listS = sDao.getAllSlider();
        List<Zone> listZ = zDao.getAllZone();
        Event listE = eDao.getAllEventByEventId(2);
        List<TypeOfField> listT = tDao.getAllFieldTypes();
        Vector<CateProduct> listC = cDao.getAllCategory2();
        Vector<Post> listPost = postDao.get3LastestPost();
        String pageStr = request.getParameter("page");
        int page = (pageStr != null && !pageStr.isEmpty()) ? Integer.parseInt(pageStr) : 1;
        int pageSize = 4;
        List<Field> listF1;
        if (zoneId != null) {
            listF1 = fDao.getAllFieldsByZoneID(zoneId);
        } else {
            listF1 = fDao.getAllFields();
        }
        
        
        // paging product
        Vector<Product> listP;
        int totalProduct = 0;
        int totalPage = 0;

        if (cateId != null) {
            int cateIDInt = Integer.parseInt(cateId);
            listP = pDao.pagingProductByCateID(cateIDInt, page, pageSize);
            totalProduct = pDao.countProductByCateID(cateIDInt);
            request.setAttribute("cid", cateIDInt); // để dùng lại trong phân trang link
        } else {
            listP = pDao.pagingProduct(page, pageSize);
            totalProduct = pDao.getTotalProduct();
        }
        totalPage = (int) Math.ceil((double) totalProduct / pageSize);
        
        
        
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("listPost", listPost);
        
        // end paging product 
        request.setAttribute("listT", listT);
        request.setAttribute("event", listE);
        request.setAttribute("listP", listP);
        request.setAttribute("listC", listC);
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
