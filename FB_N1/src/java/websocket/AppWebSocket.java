package websocket;

import jakarta.websocket.*;
import jakarta.websocket.server.ServerEndpoint;
import java.util.*;
import java.util.concurrent.CopyOnWriteArraySet;

@ServerEndpoint(value = "/ws/app")
public class AppWebSocket {

    private static final Set<Session> sessions = new CopyOnWriteArraySet<>();

    @OnOpen
    public void onOpen(Session session) {
        Map<String, String> params = parseQuery(session.getQueryString());
        session.getUserProperties().put("accountId", params.get("accountId"));
        session.getUserProperties().put("roleId", params.get("roleId"));
        session.getUserProperties().put("fieldId", params.get("fieldId"));
        sessions.add(session);

        System.out.println("✅ WebSocket connected: " + params);
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
        // Có thể xử lý lệnh như "switchFieldId=..." ở đây nếu cần
    }

    // Gửi đến tất cả user có role nhất định (Admin/Khách/Quản lý...)
    public static void broadcastToRole(String roleId, String type, String content) {
        String json = buildJson(type, content);
        for (Session s : sessions) {
            if (roleId.equals(s.getUserProperties().get("roleId"))) {
                s.getAsyncRemote().sendText(json);
            }
        }
    }

    // Gửi đến một người cụ thể
    public static void sendToAccount(String accountId, String type, String content) {
        String json = buildJson(type, content);
        for (Session s : sessions) {
            if (accountId.equals(s.getUserProperties().get("accountId"))) {
                s.getAsyncRemote().sendText(json);
            }
        }
    }

    // Gửi thông báo cập nhật lịch cho những người đang xem sân có fieldId tương ứng
    public static void broadcastCalendarUpdate(String fieldId) {
        for (Session s : sessions) {
            String watchingField = (String) s.getUserProperties().get("fieldId");
            if (fieldId.equals(watchingField)) {
                s.getAsyncRemote().sendText("{\"type\":\"refreshCalendar\"}");
            }
        }
    }

    // Gửi cập nhật lịch tới nhiều sân (ví dụ đặt nhiều ca ở nhiều sân)
    public static void broadcastCalendarUpdates(Collection<String> fieldIds) {
        for (String fieldId : fieldIds) {
            broadcastCalendarUpdate(fieldId);
        }
    }

    // ========= Utilities =========
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
}
