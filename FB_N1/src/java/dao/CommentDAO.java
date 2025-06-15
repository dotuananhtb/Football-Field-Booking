package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
import model.Comment;
import model.Account;
import util.DBContext;

import java.sql.Connection;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class CommentDAO extends DBContext {
    
    public Vector<Comment> getCommentsByPostId(int postId) {
        Vector<Comment> list = new Vector<>();
        String query = "SELECT c.*, a.username FROM Comment c "
                + "JOIN Account a ON c.account_id = a.account_id "
                + "WHERE c.post_id = ? "
                + "ORDER BY c.cmt_date DESC";
        try {
            PreparedStatement ptm = connection.prepareStatement(query);
            ptm.setInt(1, postId);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Comment comment = new Comment();
                comment.setCommentId(rs.getInt("comment_id"));
                comment.setPostId(rs.getInt("post_id"));
                comment.setAccountId(rs.getInt("account_id"));
                comment.setContentCmt(rs.getString("content_cmt"));
                comment.setCmtDate(rs.getString("cmt_date"));
                
                Account account = new Account();
                account.setUsername(rs.getString("username"));
                comment.setAccount(account);
                
                list.add(comment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countCommentsByPostId(int postId) {
        String sql = "SELECT COUNT(*) FROM Comment WHERE post_id = ?";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setInt(1, postId);
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public void addComment(Comment comment) {
        String query = "INSERT INTO Comment (post_id, account_id, content_cmt, cmt_date) "
                + "VALUES (?, ?, ?, CONVERT(NVARCHAR(50), GETDATE(), 120))";
        try {
            PreparedStatement ptm = connection.prepareStatement(query);
            ptm.setInt(1, comment.getPostId());
            ptm.setInt(2, comment.getAccountId());
            ptm.setString(3, comment.getContentCmt());
            ptm.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Comment getCommentById(int commentId) {
        String sql = "SELECT c.*, a.username FROM Comment c " +
                    "JOIN Account a ON c.account_id = a.account_id " +
                    "WHERE c.comment_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, commentId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Comment comment = new Comment();
                comment.setCommentId(rs.getInt("comment_id"));
                comment.setPostId(rs.getInt("post_id"));
                comment.setAccountId(rs.getInt("account_id"));
                comment.setContentCmt(rs.getString("content_cmt"));
                comment.setCmtDate(rs.getString("cmt_date"));
                
                Account account = new Account();
                account.setAccountId(rs.getInt("account_id"));
                account.setUsername(rs.getString("username"));
                comment.setAccount(account);
                
                return comment;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void deleteComment(int commentId) {
        String sql = "DELETE FROM Comment WHERE comment_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, commentId);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
} 