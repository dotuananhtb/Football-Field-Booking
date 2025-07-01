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
import dao.BookingDAO;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import java.util.concurrent.*;

@WebListener
public class AutoCancelBookingListener implements ServletContextListener {

    private ScheduledExecutorService scheduler;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        scheduler = Executors.newSingleThreadScheduledExecutor();

        scheduler.scheduleAtFixedRate(() -> {
            try {
                System.out.println("🔄 Đang kiểm tra các booking quá hạn...");
                BookingDAO bookingDAO = new BookingDAO();
                bookingDAO.autoCancelExpiredBookings();
            } catch (Exception e) {
                System.err.println("❌ Lỗi khi huỷ booking tự động:");
                e.printStackTrace();
            }
        }, 0, 1, TimeUnit.MINUTES); // chạy mỗi 1 phút
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        if (scheduler != null && !scheduler.isShutdown()) {
            scheduler.shutdown();
        }
        System.out.println("🛑 Đã dừng AutoCancelBookingListener.");
    }
}
