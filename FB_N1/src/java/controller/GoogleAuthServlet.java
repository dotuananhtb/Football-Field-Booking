package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.UUID;

@WebServlet("/google-auth")
public class GoogleAuthServlet extends HttpServlet {
    private static final String CLIENT_ID = config.SecretsConfig.get("GOOGLE_CLIENT_ID");
    private static final String REDIRECT_URI = config.SecretsConfig.get("GOOGLE_REDIRECT_URI");
    private static final String GOOGLE_AUTH_URL = "https://accounts.google.com/o/oauth2/v2/auth";
    private static final String SCOPE = "https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email openid";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Tạo state ngẫu nhiên để chống CSRF
            String state = UUID.randomUUID().toString();
            request.getSession().setAttribute("oauth_state", state);

            // Tạo URL ủy quyền
            String authUrl = GOOGLE_AUTH_URL
                    + "?client_id=" + URLEncoder.encode(CLIENT_ID, StandardCharsets.UTF_8)
                    + "&redirect_uri=" + URLEncoder.encode(REDIRECT_URI, StandardCharsets.UTF_8)
                    + "&response_type=code"
                    + "&scope=" + URLEncoder.encode(SCOPE, StandardCharsets.UTF_8)
                    + "&state=" + URLEncoder.encode(state, StandardCharsets.UTF_8)
                    + "&access_type=offline"
                    + "&prompt=consent";

            System.out.println("Generated Google Auth URL: " + authUrl);
            response.sendRedirect(authUrl);
        } catch (Exception e) {
            System.out.println("Lỗi trong GoogleSignInServlet: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("error.jsp?message="
                    + URLEncoder.encode("Không thể khởi tạo đăng nhập Google", StandardCharsets.UTF_8));
        }
    }
}