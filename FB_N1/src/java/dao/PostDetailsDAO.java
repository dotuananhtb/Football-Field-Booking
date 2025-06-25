package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.PostDetails;
import util.DBContext;

public class PostDetailsDAO extends DBContext {
    public void insert(PostDetails postDetails) {
        String sql = "INSERT INTO PostDetails (post_id, match_date, match_time, field_type) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, postDetails.getPostId());
            ps.setString(2, postDetails.getMatchDate());
            ps.setString(3, postDetails.getMatchTime());
            ps.setString(4, postDetails.getFieldType());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public PostDetails getByPostId(int postId) {
        String sql = "SELECT * FROM PostDetails WHERE post_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, postId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new PostDetails(
                        rs.getInt("post_id"),
                        rs.getString("match_date"),
                        rs.getString("match_time"),
                        rs.getString("field_type")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<PostDetails> getAll() {
        List<PostDetails> list = new ArrayList<>();
        String sql = "SELECT * FROM PostDetails";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new PostDetails(
                    rs.getInt("post_id"),
                    rs.getString("match_date"),
                    rs.getString("match_time"),
                    rs.getString("field_type")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void update(PostDetails postDetails) {
        String sql = "UPDATE PostDetails SET match_date = ?, match_time = ?, field_type = ? WHERE post_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, postDetails.getMatchDate());
            ps.setString(2, postDetails.getMatchTime());
            ps.setString(3, postDetails.getFieldType());
            ps.setInt(4, postDetails.getPostId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void delete(int postId) {
        String sql = "DELETE FROM PostDetails WHERE post_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, postId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void update(int postId, String matchDate, String matchTime, String fieldType) {
        String sql = "UPDATE PostDetails SET match_date = ?, match_time = ?, field_type = ? WHERE post_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, matchDate);
            ps.setString(2, matchTime);
            ps.setString(3, fieldType);
            ps.setInt(4, postId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
} 