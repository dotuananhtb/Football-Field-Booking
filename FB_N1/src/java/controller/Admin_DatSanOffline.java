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
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.reflect.TypeToken;
import dao.OfflineUserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Account;
import model.BookingDetails;
import service.BookingService;

import java.io.BufferedReader;
import java.io.IOException;
import java.lang.reflect.Type;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import model.OfflineUser;

/**
 *
 * @author Đỗ Tuấn Anh
 */
@WebServlet(name = "Admin_DatSanOffline", urlPatterns = {"/admin/dat-san-offline"})
public class Admin_DatSanOffline extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        Gson gson = new Gson();
        JsonObject result = new JsonObject();

        // ✅ Lấy session
        HttpSession session = request.getSession(false);
        Account account = (session != null && session.getAttribute("account") != null)
                ? (Account) session.getAttribute("account")
                : null;
        if (account == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            result.addProperty("success", false);
            result.addProperty("type", "error");
            result.addProperty("message", "⚠️ Phiên đăng nhập đã hết hạn.");
            response.getWriter().write(result.toString());
            return;
        }

        // ✅ Đọc JSON body
        BufferedReader reader = request.getReader();
        String json = reader.lines().collect(Collectors.joining());
        JsonObject jsonObj = gson.fromJson(json, JsonObject.class);

        // ✅ Lấy thông tin offline user
        String fullName = jsonObj.get("fullName").getAsString();
        String phone = jsonObj.get("phone").getAsString();
        String email = jsonObj.has("email") && !jsonObj.get("email").isJsonNull()
                ? jsonObj.get("email").getAsString()
                : null;

        // ✅ Parse danh sách booking
        Type listType = new TypeToken<List<BookingDetails>>() {}.getType();
        List<BookingDetails> detailsList = gson.fromJson(jsonObj.get("details"), listType);

        // ✅ Kiểm tra offline user
        OfflineUserDAO offlineUserDAO = new OfflineUserDAO();
        OfflineUser offlineUser = offlineUserDAO.findByPhone(phone);
        String now = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());

        if (offlineUser == null) {
            offlineUser = new OfflineUser();
            offlineUser.setFullName(fullName);
            offlineUser.setPhone(phone);
            offlineUser.setEmail(email);
            offlineUser.setCreatedBy(account.getAccountId());
            offlineUser.setCreatedDate(now);
            int newId = offlineUserDAO.insertOfflineUser(offlineUser);
            if (newId == -1) {
                result.addProperty("success", false);
                result.addProperty("type", "error");
                result.addProperty("message", "❌ Không thể lưu thông tin khách offline.");
                response.getWriter().write(result.toString());
                return;
            }
            offlineUser.setOfflineUserId(newId);
        }

        // ✅ Gọi BookingService
        BookingService service = new BookingService();
        boolean success = service.createOfflineBooking(offlineUser, account.getAccountId(), detailsList);

        if (success) {
            result.addProperty("success", true);
            result.addProperty("type", "success");
            result.addProperty("message", "✅ Đặt sân offline thành công!");
        } else {
            result.addProperty("success", false);
            result.addProperty("type", "error");
            result.addProperty("message", "❌ Không thể đặt sân. Vui lòng thử lại!");
        }
        response.getWriter().write(result.toString());
    }
}
