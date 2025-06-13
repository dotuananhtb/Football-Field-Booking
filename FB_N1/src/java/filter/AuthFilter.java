package filter;

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
import java.io.IOException;
import model.Account;

@WebFilter(urlPatterns = {"/userProfile", "/dat-san", "/admin/*"})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        HttpSession session = req.getSession();
        Account acc = (session != null) ? (Account) session.getAttribute("account") : null;

        if (acc == null) {
            // AJAX request → trả JSON 401
            String requestedWith = req.getHeader("X-Requested-With");
            if ("XMLHttpRequest".equals(requestedWith)) {
                res.setContentType("application/json");
                res.setCharacterEncoding("UTF-8");
                res.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                res.getWriter().write("{\"success\": false, \"message\": \"Bạn chưa đăng nhập.\"}");
                return;
            }

            // Với request thường → redirect đến /login kèm lưu đường dẫn gốc
            String contextPath = req.getContextPath();   // VD: /FootballFieldBooking
            String requestURI = req.getRequestURI();     // VD: /FootballFieldBooking/dat-san
            String query = req.getQueryString();         // VD: slot=3&date=2025-06-13

// Lấy phần URI không bao gồm context path
            String path = requestURI.substring(contextPath.length()); // VD: /dat-san

// Gắn query string nếu có
            String redirectPath = path + (query != null ? "?" + query : ""); // VD: /dat-san?slot=3&date=...

// Gán vào session
            HttpSession newSession = req.getSession(true);
            newSession.setAttribute("redirectAfterLogin", redirectPath);

// Chuyển hướng đến trang login
            res.sendRedirect(contextPath + "/login");
            return;
        }

        // Đã đăng nhập → cho qua
        chain.doFilter(request, response);
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Không cần xử lý gì thêm khi init
    }

    @Override
    public void destroy() {
        // Không cần xử lý gì thêm khi destroy
    }
}
