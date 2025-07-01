package dao;

import model.ImageStorage;
import util.DBContext;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ImageStorageDAO {

    // Thêm ảnh mới
    public boolean insertImage(String url, String relatedType, int relatedId) {
        String sql = "INSERT INTO ImageStorage (image_url, related_type, related_id) VALUES (?, ?, ?)";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, url);
            ps.setString(2, relatedType);
            ps.setInt(3, relatedId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Lấy danh sách ảnh theo đối tượng
    public List<ImageStorage> getImages(String relatedType, int relatedId) {
        List<ImageStorage> list = new ArrayList<>();
        String sql = "SELECT * FROM ImageStorage WHERE related_type = ? AND related_id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, relatedType);
            ps.setInt(2, relatedId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ImageStorage img = new ImageStorage();
                img.setImageId(rs.getInt("image_id"));
                img.setImageUrl(rs.getString("image_url"));
                img.setRelatedType(rs.getString("related_type"));
                img.setRelatedId(rs.getInt("related_id"));
                img.setIsMain(rs.getBoolean("is_main"));
                img.setUploadDate(rs.getTimestamp("upload_date").toLocalDateTime());
                list.add(img);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean setMainImage(int imageId) {
        String getInfoSql = "SELECT related_type, related_id FROM ImageStorage WHERE image_id = ?";
        String resetMainSql = "UPDATE ImageStorage SET is_main = 0 WHERE related_type = ? AND related_id = ?";
        String setMainSql = "UPDATE ImageStorage SET is_main = 1 WHERE image_id = ?";

        try (Connection conn = DBContext.getConnection()) {
            conn.setAutoCommit(false); // Bắt đầu transaction

            String relatedType = null;
            int relatedId = -1;

            // B1: Lấy related_type và related_id
            try (PreparedStatement ps = conn.prepareStatement(getInfoSql)) {
                ps.setInt(1, imageId);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    relatedType = rs.getString("related_type");
                    relatedId = rs.getInt("related_id");
                } else {
                    return false; // Không tìm thấy ảnh
                }
            }

            // B2: Reset tất cả is_main = 0
            try (PreparedStatement ps = conn.prepareStatement(resetMainSql)) {
                ps.setString(1, relatedType);
                ps.setInt(2, relatedId);
                ps.executeUpdate();
            }

            // B3: Đặt ảnh được chọn là is_main
            try (PreparedStatement ps = conn.prepareStatement(setMainSql)) {
                ps.setInt(1, imageId);
                int updated = ps.executeUpdate();
                conn.commit();
                return updated > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

}
