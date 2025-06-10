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
import model.Field;
import model.Zone;
import java.util.Vector;
import model.UserProfile;
import model.Field;
import model.*;

/**
 *
 * @author VAN NGUYEN
 */
@WebServlet(name = "HomeControl", urlPatterns = { "/home" })

public class HomeControl extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * 
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        FieldDAO dao = new FieldDAO();
        Zone_DAO Zdao = new Zone_DAO();
        Vector<Field> list = dao.getAllField();
        List<Zone> listZ = Zdao.getAllZone();

        request.setAttribute("listF", list);
        request.setAttribute("listZ", listZ);

    

    
    FieldDAO fdao = new FieldDAO();
    Vector<Field> list = new Vector<>();
    ProductDAO pdao = new ProductDAO();
    Vector<Product> plist = pdao.getAllProductsWithCategory();request.setAttribute("plist",plist);

    Vector<FieldDetails> fieldList = fdao.getAllFieldDetails();request.setAttribute("fieldList",fieldList);
    UserProfileDAO dao = new UserProfileDAO();
    Contact ct = dao.getContact();request.setAttribute("ct",ct);

    request.getRequestDispatcher("UI/trang-chu.jsp").forward(request,response);

    // response.sendRedirect("UI/trang-chu.jsp");
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the
    // + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)

            throws ServletException, IOException {

        request.getRequestDispatcher("UI/homePage.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     * 
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
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
