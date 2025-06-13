package filter;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.Account;

@WebFilter(urlPatterns = {"/userProfile", "/dat-san", "/admin/*"})

public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);
        Account acc = (session != null) ? (Account) session.getAttribute("account") : null;

        if (acc == null) {
            String requestedWith = req.getHeader("X-Requested-With");

            if ("XMLHttpRequest".equals(requestedWith)) {
                // Nếu là AJAX request → trả về JSON báo lỗi
                res.setContentType("application/json");
                res.setCharacterEncoding("UTF-8");
                res.setStatus(HttpServletResponse.SC_UNAUTHORIZED); // 401
                res.getWriter().write("{\"success\": false, \"message\": \"Bạn chưa đăng nhập.\"}");
            } else {
                // Nếu là request thông thường (trình duyệt load trang) → redirect
                res.sendRedirect(req.getContextPath() + "/login");
            }
            return;
        }

        chain.doFilter(request, response);
    }
}
