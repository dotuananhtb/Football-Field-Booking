/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author VAN NGUYEN
 */
@WebServlet(name="testSession", urlPatterns={"/testSession"})
public class testSession extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
       @Override
       protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession(false); // lấy session hiện có, không tạo mới
        if (session != null) {
            java.util.Enumeration<String> names = session.getAttributeNames();

            while (names.hasMoreElements()) {
                String key = names.nextElement();
                Object value = session.getAttribute(key);

                out.println("Session attribute: " + key + " → " + value);
                out.println("→ Class: " + value.getClass().getName());
            }
        } else {
            out.println("❌ Session không tồn tại (null)");
        }
    }
}

