/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Timestamp;
import util.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import model.ChatBox;

/**
 *
 * @author VAN NGUYEN
 */
public class ChatBoxDAO extends DBContext {
    
   public void saveChatHistory(ChatBox chat) {
    String sql = "INSERT INTO ChatHistory (account_id, user_input, bot_response) VALUES (?, ?, ?)";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        if (chat.getAccount_id() == 0) {
            ps.setNull(1, java.sql.Types.INTEGER); // nếu không đăng nhập
        } else {
            ps.setInt(1, chat.getAccount_id());
        }
        ps.setString(2, chat.getUser_input());
        ps.setString(3, chat.getBot_response());
        ps.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    }
}
    public List<ChatBox> getHistoryByAccountId(int accountId) {
    List<ChatBox> list = new ArrayList<>();
    String sql = "SELECT * FROM ChatHistory WHERE account_id = ? ORDER BY created_at";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, accountId);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            ChatBox chat = new ChatBox();
            chat.setId(rs.getInt("id"));
            chat.setAccount_id(accountId);
            chat.setUser_input(rs.getString("user_input"));
            chat.setBot_response(rs.getString("bot_response"));
            chat.setCreatedAt(rs.getTimestamp("created_at"));
            list.add(chat);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}

    public static void main(String[] args) {
        
    }
    
    
    
    
}
