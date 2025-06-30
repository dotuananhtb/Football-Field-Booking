package dao;

import model.OfflineUser;
import util.DBContext;

import java.sql.*;

public class OfflineUserDAO extends DBContext {

    public void setConnection(Connection conn) {
        this.connection = conn;
    }

    // Thêm OfflineUser mới vào DB, trả về ID được sinh ra
    public int insertOfflineUser(OfflineUser user) {
        String sql = """
            INSERT INTO OfflineUser (full_name, phone, email, created_date, created_by)
            OUTPUT INSERTED.offline_user_id
            VALUES (?, ?, ?, ?, ?)
        """;
        String now = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, user.getFullName());
            ps.setString(2, user.getPhone());
            ps.setString(3, user.getEmail());
            ps.setString(4, now);
            ps.setInt(5, user.getCreatedBy());

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("offline_user_id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return -1;
    }

    // Truy vấn thông tin OfflineUser theo ID
    public OfflineUser getOfflineUserById(int offlineUserId) {
        String sql = "SELECT * FROM OfflineUser WHERE offline_user_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, offlineUserId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                OfflineUser user = new OfflineUser();
                user.setOfflineUserId(rs.getInt("offline_user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setPhone(rs.getString("phone"));
                user.setEmail(rs.getString("email"));
                user.setCreatedDate(rs.getString("created_date"));
                user.setCreatedBy(rs.getInt("created_by"));
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public OfflineUser findByPhone(String phone) {
        String sql = "SELECT * FROM OfflineUser WHERE phone = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, phone);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    OfflineUser user = new OfflineUser();
                    user.setOfflineUserId(rs.getInt("offline_user_id"));
                    user.setFullName(rs.getString("full_name"));
                    user.setPhone(rs.getString("phone"));
                    user.setEmail(rs.getString("email"));
                    user.setCreatedDate(rs.getString("created_date"));
                    user.setCreatedBy(rs.getInt("created_by"));
                    return user;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

}
