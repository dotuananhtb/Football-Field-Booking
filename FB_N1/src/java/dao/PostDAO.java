package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
import model.Post;
import model.Account;
import util.DBContext;

public class PostDAO extends DBContext {
    
    public Post searchPostByTitle(String title) {
        String sql = "SELECT post_id, account_id, title, content_post, post_date, img, status_post\n"
                + "FROM [FootballFieldBooking].[dbo].[Post] p\n"
                + "WHERE p.title = ?";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setString(1, title);
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) {
                return new Post(
                    rs.getInt(1),
                    rs.getInt(2),
                    rs.getString(3),
                    rs.getString(4),
                    rs.getString(5),
                    
                    rs.getString(6)
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Vector<Post> getAllPost() {
        String sql = "SELECT post_id, account_id, title, content_post, post_date, status_post\n"
                + "FROM [FootballFieldBooking].[dbo].[Post]";
        Vector<Post> listPost = new Vector<>();
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Post p = new Post(
                    rs.getInt(1),    // post_id
                    rs.getInt(2),    // account_id
                    rs.getString(3), // title
                    rs.getString(4), // content_post
                    rs.getString(5), // post_date
                    rs.getString(6)  // status_post
                );
                listPost.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listPost;
    }

    public Vector<Post> getAllPosts(int page, int pageSize) {
        Vector<Post> list = new Vector<>();
        String query = "SELECT p.*, a.username FROM Post p " +
                       "JOIN Account a ON p.account_id = a.account_id " +
                       "ORDER BY p.post_date DESC " +
                       "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            PreparedStatement ptm = connection.prepareStatement(query);
            ptm.setInt(1, (page - 1) * pageSize);
            ptm.setInt(2, pageSize);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Post post = new Post();
                post.setPostId(rs.getInt("post_id"));
                post.setAccountId(rs.getInt("account_id"));
                post.setTitle(rs.getString("title"));
                post.setContentPost(rs.getString("content_post"));
                post.setPostDate(rs.getString("post_date"));
                post.setStatusPost(rs.getString("status_post"));
                Account account = new Account();
                account.setUsername(rs.getString("username"));
                post.setAccount(account);
                list.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Post getPostById(int postId) {
        String query = "SELECT p.*, a.username FROM Post p "
                + "JOIN Account a ON p.account_id = a.account_id "
                + "WHERE p.post_id = ?";
        try {
            PreparedStatement ptm = connection.prepareStatement(query);
            ptm.setInt(1, postId);
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) {
                Post post = new Post();
                post.setPostId(rs.getInt("post_id"));
                post.setAccountId(rs.getInt("account_id"));
                post.setTitle(rs.getString("title"));
                post.setContentPost(rs.getString("content_post"));
                post.setPostDate(rs.getString("post_date"));
                post.setStatusPost(rs.getString("status_post"));
                
                Account account = new Account();
                account.setUsername(rs.getString("username"));
                post.setAccount(account);
                
                return post;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public int getTotalPosts() {
        String query = "SELECT COUNT(*) FROM Post";
        try {
            PreparedStatement ptm = connection.prepareStatement(query);
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public Vector<Post> searchPostsByTitle(String title, int page, int pageSize) {
        Vector<Post> list = new Vector<>();
        String query = "SELECT p.*, a.username FROM Post p " +
                       "JOIN Account a ON p.account_id = a.account_id " +
                       "WHERE p.title LIKE N? " +
                       "ORDER BY p.post_date DESC " +
                       "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            PreparedStatement ptm = connection.prepareStatement(query);
            ptm.setString(1, "%" + title + "%");
            ptm.setInt(2, (page - 1) * pageSize);
            ptm.setInt(3, pageSize);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Post post = new Post();
                post.setPostId(rs.getInt("post_id"));
                post.setAccountId(rs.getInt("account_id"));
                post.setTitle(rs.getString("title"));
                post.setContentPost(rs.getString("content_post"));
                post.setPostDate(rs.getString("post_date"));
                post.setStatusPost(rs.getString("status_post"));
                Account account = new Account();
                account.setUsername(rs.getString("username"));
                post.setAccount(account);
                list.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countPostsByTitle(String title) {
        String query = "SELECT COUNT(*) FROM Post WHERE title LIKE N?";
        try {
            PreparedStatement ptm = connection.prepareStatement(query);
            ptm.setString(1, "%" + title + "%");
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
} 