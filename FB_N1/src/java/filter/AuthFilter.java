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
import util.ToastUtil;

@WebFilter(urlPatterns = {"/ho-so-nguoi-dung", "/dat-san", "/chi-tiet-dat-san","/doi-mat-khau", "/admin/*", "/lich-su-dat-san", "/login", "/dang-ki"})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        HttpSession session = req.getSession();
        Account acc = (session != null) ? (Account) session.getAttribute("account") : null;

        String uri = req.getRequestURI();  // VD: /FB_N1/login
        String contextPath = req.getContextPath(); // VD: /FB_N1
        String path = uri.substring(contextPath.length()); // VD: /login hoặc /register

        // ✅ Nếu đã đăng nhập mà cố vào /login hoặc /register → redirect về /dat-san
        if (acc != null && (path.equals("/login") || path.equals("/dang-ki"))) {
            res.sendRedirect(contextPath + "/home");
            return;
        }

        // ✅ Nếu chưa đăng nhập và đang vào vùng bảo vệ → chặn
        if (acc == null && (path.startsWith("/chi-tiet-dat-san") || path.startsWith("/ho-so-nguoi-dung") || path.startsWith("/lich-su-dat-san") || path.startsWith("/dat-san") || path.startsWith("/doi-mat-khau") || path.startsWith("/admin"))) {

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
            String query = req.getQueryString();
            String redirectPath = path + (query != null ? "?" + query : "");

            session.setAttribute("redirectAfterLogin", redirectPath);
            res.sendRedirect(contextPath + "/login");
            return;
        }
        // ✅ Nếu đã đăng nhập nhưng truy cập /admin mà không đủ quyền → chặn
        if (path.startsWith("/admin") && acc != null && acc.getUserProfile().getRoleId() != 1 && acc.getUserProfile().getRoleId() != 2) {
            ToastUtil.setErrorToast(req, "Bạn không có quyền truy cập vào trang này");

            // Mặc định luôn redirect về /home
            res.sendRedirect(contextPath + "/home");
            return;
        }

        // ✅ Trường hợp hợp lệ → cho qua
        chain.doFilter(request, response);
    }
}
