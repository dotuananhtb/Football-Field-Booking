package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@WebServlet("/callback")
public class GoogleCallbackServlet extends HttpServlet {

    private static final String CLIENT_ID = "1087404832-coiq7i1ifndcqak60g34hed9ci54mlgv.apps.googleusercontent.com";
    private static final String CLIENT_SECRET = "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";
    private static final String REDIRECT_URI = "http://localhost:9999/FB_N1/callback";
    private static final String TOKEN_URL = "https://oauth2.googleapis.com/token";
    private static final String USER_INFO_URL = "https://www.googleapis.com/oauth2/v2/userinfo";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String code = request.getParameter("code");
        String state = request.getParameter("state");
        String error = request.getParameter("error");
        String expectedState = (String) request.getSession().getAttribute("oauth_state");

        response.setContentType("text/html;charset=UTF-8");

        if (error != null) {
            response.getWriter().println("<h2>Lỗi từ Google: " + error + "</h2>");
            return;
        }

        if (state == null || expectedState == null || !state.equals(expectedState)) {
            response.getWriter().println("<h2>State không hợp lệ</h2>");
            return;
        }

        if (code != null) {
            try {
                // Gửi yêu cầu lấy token
                String postData = "code=" + URLEncoder.encode(code, StandardCharsets.UTF_8)
                        + "&client_id=" + URLEncoder.encode(CLIENT_ID, StandardCharsets.UTF_8)
                        + "&client_secret=" + URLEncoder.encode(CLIENT_SECRET, StandardCharsets.UTF_8)
                        + "&redirect_uri=" + URLEncoder.encode(REDIRECT_URI, StandardCharsets.UTF_8)
                        + "&grant_type=authorization_code";

                URL url = new URL(TOKEN_URL);
                HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                conn.setRequestMethod("POST");
                conn.setDoOutput(true);
                conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

                try (OutputStream os = conn.getOutputStream()) {
                    os.write(postData.getBytes(StandardCharsets.UTF_8));
                }

                // Đọc phản hồi từ Google
                StringBuilder tokenResponseData = new StringBuilder();
                try (BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8))) {
                    String line;
                    while ((line = br.readLine()) != null) {
                        tokenResponseData.append(line);
                    }
                }

                JsonElement tokenJsonElement = new JsonParser().parse(tokenResponseData.toString());
                JsonObject tokenJson = tokenJsonElement.getAsJsonObject();
                String accessToken = tokenJson.get("access_token").getAsString();

                // Gửi yêu cầu lấy thông tin người dùng
                URL userInfoUrl = new URL(USER_INFO_URL + "?access_token=" + URLEncoder.encode(accessToken, StandardCharsets.UTF_8));
                HttpURLConnection userInfoConn = (HttpURLConnection) userInfoUrl.openConnection();
                userInfoConn.setRequestMethod("GET");

                StringBuilder userInfoData = new StringBuilder();
                try (BufferedReader br = new BufferedReader(new InputStreamReader(userInfoConn.getInputStream(), StandardCharsets.UTF_8))) {
                    String line;
                    while ((line = br.readLine()) != null) {
                        userInfoData.append(line);
                    }
                }

                JsonElement userInfoElement = new JsonParser().parse(userInfoData.toString());
                JsonObject userInfo = userInfoElement.getAsJsonObject();

                // In ra toàn bộ dữ liệu userInfo dưới dạng HTML
                response.getWriter().println("<h2>Thông tin người dùng từ Google:</h2>");
                response.getWriter().println("<pre>" + userInfo.toString() + "</pre>");

            } catch (Exception e) {
                response.getWriter().println("<h2>Lỗi khi xử lý đăng nhập Google:</h2>");
                response.getWriter().println("<pre>" + e.getMessage() + "</pre>");
                e.printStackTrace(response.getWriter());
            }
        } else {
            response.getWriter().println("<h2>Thiếu mã ủy quyền (code)</h2>");
        }
    }
}
