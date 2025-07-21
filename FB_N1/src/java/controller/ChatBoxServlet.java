/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ChatBoxDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Timestamp;
import model.Account;
import model.ChatBox;
import org.json.JSONObject;
import org.json.JSONArray;

/**
 *
 * @author VAN NGUYEN
 */
@WebServlet(name = "ChatBoxServlet", urlPatterns = {"/chat-bot-servlet"})
public class ChatBoxServlet extends HttpServlet {

    private static final String API_KEY = "AIzaSyBy5WFNXgura96PeI1cRbx5r1ey0IfrR6s"; // Thay thế bằng API Key của bạn

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        
        
        request.getRequestDispatcher("UI/chatbox.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userInput = request.getParameter("prompt");
        String botResponse = "";

        try {
            URL url = new URL("https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=" + API_KEY);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setDoOutput(true);

            String jsonInput = """
    {
        "contents": [
            {
                "parts": [
                    { "text": "%s" }
                ]
            }
        ]
    }
    """.formatted(userInput.replace("\"", "\\\""));  // Escape nếu cần

            try (OutputStream os = conn.getOutputStream()) {
                os.write(jsonInput.getBytes("utf-8"));
            }

            int responseCode = conn.getResponseCode();
            InputStream is = (responseCode >= 200 && responseCode < 300)
                    ? conn.getInputStream()
                    : conn.getErrorStream();

            StringBuilder result = new StringBuilder();
            try (BufferedReader br = new BufferedReader(new InputStreamReader(is, "utf-8"))) {
                String line;
                while ((line = br.readLine()) != null) {
                    result.append(line.trim());
                }
            }

            System.out.println("🔁 Response JSON: " + result.toString());

            if (responseCode >= 200 && responseCode < 300) {
                // Phân tích JSON (dùng org.json hoặc thư viện tương đương)
                JSONObject json = new JSONObject(result.toString());
                JSONArray candidates = json.getJSONArray("candidates");
                JSONObject content = candidates.getJSONObject(0).getJSONObject("content");
                JSONArray parts = content.getJSONArray("parts");
                botResponse = parts.getJSONObject(0).getString("text");
            } else {
                botResponse = "⚠️ Lỗi từ Gemini API: " + result.toString();
            }
            HttpSession session = request.getSession(false);
            Account acc = (session != null) ? (Account) session.getAttribute("account") : null;
            Integer accountId = (acc != null) ? acc.getAccountId(): null;

            ChatBox chat = new ChatBox();
            chat.setUser_input(userInput);
            chat.setBot_response(botResponse);
            chat.setAccount_id(accountId != null ? accountId : 0); // nếu bạn xử lý 0 như khách tạm
            chat.setCreatedAt(new Timestamp(System.currentTimeMillis()));

            new ChatBoxDAO().saveChatHistory(chat);

        } catch (Exception e) {
            e.printStackTrace();
            botResponse = "❌ Lỗi gọi Gemini API: " + e.getMessage();
        }

        response.setContentType("text/plain");
        response.getWriter().write(botResponse);

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
