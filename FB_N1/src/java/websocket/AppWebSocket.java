package websocket;

import jakarta.websocket.*;
import jakarta.websocket.server.ServerEndpoint;

import java.io.IOException;
import java.util.*;
import java.util.concurrent.CopyOnWriteArraySet;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

@ServerEndpoint(value = "/ws/app")
public class AppWebSocket {

    private static final Set<Session> sessions = new CopyOnWriteArraySet<>();
    private static final ExecutorService executor = Executors.newFixedThreadPool(10); // hoặc Executors.newCachedThreadPool();

    @OnOpen
    public void onOpen(Session session) {
        Map<String, String> params = parseQuery(session.getQueryString());
        if (params.get("accountId") != null && params.get("roleId") != null) {
            session.getUserProperties().put("accountId", params.get("accountId"));
            session.getUserProperties().put("roleId", params.get("roleId"));
            session.getUserProperties().put("fieldId", params.get("fieldId"));
            sessions.add(session);
            System.out.println("✅ WebSocket connected: " + params);
        } else {
            try {
                session.close(new CloseReason(
                        CloseReason.CloseCodes.CANNOT_ACCEPT, "Missing required parameters"));
            } catch (IOException e) {
                e.printStackTrace();
            }
            System.err.println("❌ WebSocket rejected: missing parameters");
        }
    }

    @OnClose
    public void onClose(Session session) {
        sessions.remove(session);
        System.out.println("❌ WebSocket disconnected");
    }

    @OnError
    public void onError(Session session, Throwable throwable) {
        sessions.remove(session);
        System.err.println("🔥 WebSocket error:");
        throwable.printStackTrace();
    }

    @OnMessage
    public void onMessage(Session session, String message) {
        System.out.println("💬 Message from client: " + message);
    }

    // Gửi tới tất cả user có role cụ thể
    public static void broadcastToRole(String roleId, String type, String content) {
        String json = buildJson(type, content);
        for (Session s : sessions) {
            if (s.isOpen() && roleId.equals(s.getUserProperties().get("roleId"))) {
                executor.submit(() -> {
                    try {
                        s.getBasicRemote().sendText(json);
                    } catch (IOException e) {
                        System.err.println("❌ Lỗi gửi WebSocket đến roleId=" + roleId + ": " + e.getMessage());
                    }
                });
            }
        }
    }

    // Gửi thông báo notify riêng cho 1 account
    public static void sendNotificationToAccount(String accountId, String message) {
        String json = buildJson("notify", message);
        for (Session s : sessions) {
            if (s.isOpen() && accountId.equals(s.getUserProperties().get("accountId"))) {
                executor.submit(() -> {
                    try {
                        s.getBasicRemote().sendText(json);
                    } catch (IOException e) {
                        System.err.println("❌ Lỗi gửi notify cho accountId=" + accountId + ": " + e.getMessage());
                    }
                });
            }
        }
    }

    // Gửi đến 1 người cụ thể
    public static void sendToAccount(String accountId, String type, String content) {
        String json = buildJson(type, content);
        for (Session s : sessions) {
            if (s.isOpen() && accountId.equals(s.getUserProperties().get("accountId"))) {
                executor.submit(() -> {
                    try {
                        s.getBasicRemote().sendText(json);
                    } catch (IOException e) {
                        System.err.println("❌ Lỗi gửi socket cho accountId=" + accountId + ": " + e.getMessage());
                    }
                });
            }
        }
    }

    // Gửi cập nhật lịch đến người đang xem fieldId đó
    public static void broadcastCalendarUpdate(String fieldId) {
        String json = buildJson("refreshCalendar", "Lịch sân đã được cập nhật.");
        for (Session s : sessions) {
            String watchingField = (String) s.getUserProperties().get("fieldId");
            if (s.isOpen() && ("*".equals(fieldId) || fieldId.equals(watchingField))) {
                executor.submit(() -> {
                    try {
                        s.getBasicRemote().sendText(json);
                    } catch (IOException e) {
                        System.err.println("❌ Lỗi gửi lịch cập nhật fieldId=" + fieldId + ": " + e.getMessage());
                    }
                });
            }
        }
    }

    // Gửi lịch cập nhật đến nhiều sân
    public static void broadcastCalendarUpdates(Collection<String> fieldIds) {
        for (String fieldId : fieldIds) {
            broadcastCalendarUpdate(fieldId);
        }
    }

    // ========== Utilities ==========
    private static Map<String, String> parseQuery(String query) {
        Map<String, String> map = new HashMap<>();
        if (query == null || query.isEmpty()) {
            return map;
        }

        for (String param : query.split("&")) {
            String[] kv = param.split("=");
            if (kv.length == 2) {
                map.put(kv[0], kv[1]);
            }
        }
        return map;
    }

    private static String buildJson(String type, String message) {
        return String.format("{\"type\":\"%s\",\"message\":\"%s\"}", type, escape(message));
    }

    private static String escape(String s) {
        return s == null ? "" : s.replace("\"", "\\\"").replace("\n", " ");
    }

    // Gọi khi shutdown server nếu muốn dọn dẹp thread pool
    public static void shutdownExecutor() {
        executor.shutdown(); // hoặc shutdownNow()
    }
}
