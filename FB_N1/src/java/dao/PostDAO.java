package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
import java.util.List;
import java.util.ArrayList;
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
                    rs.getInt(1),
                    rs.getInt(2),
                    rs.getString(3),
                    rs.getString(4), 
                    rs.getString(5), 
                    rs.getString(6) 
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
                       "WHERE p.status_post = 'active' " +
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
        String query = "SELECT COUNT(*) FROM Post WHERE status_post = 'active'";
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
                       "WHERE p.status_post = 'active' AND (p.title LIKE ? OR p.content_post LIKE ?) " +
                       "ORDER BY p.post_date DESC " +
                       "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            PreparedStatement ptm = connection.prepareStatement(query);
            ptm.setNString(1, "%" + title + "%");
            ptm.setNString(2, "%" + title + "%");
            ptm.setInt(3, (page - 1) * pageSize);
            ptm.setInt(4, pageSize);
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
        String query = "SELECT COUNT(*) FROM Post WHERE status_post = 'active' AND (title LIKE ? OR content_post LIKE ?)";
        try {
            PreparedStatement ptm = connection.prepareStatement(query);
            ptm.setNString(1, "%" + title + "%");
            ptm.setNString(2, "%" + title + "%");
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public Vector<Post> getRecentPosts(int limit) {
        Vector<Post> list = new Vector<>();
        String query = "SELECT TOP (?) p.*, a.username FROM Post p " +
                      "JOIN Account a ON p.account_id = a.account_id " +
                      "WHERE p.status_post = 'active' " +
                      "ORDER BY p.post_date DESC";
        try {
            PreparedStatement ptm = connection.prepareStatement(query);
            ptm.setInt(1, limit);
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

    public List<Post> getPostsByAccountId(int accountId) {
        List<Post> list = new ArrayList<>();
        String sql = "SELECT * FROM Post WHERE account_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, accountId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Post post = new Post();
                post.setPostId(rs.getInt("post_id"));
                post.setAccountId(rs.getInt("account_id"));
                post.setTitle(rs.getString("title"));
                post.setContentPost(rs.getString("content_post"));
                post.setPostDate(rs.getString("post_date"));
                post.setStatusPost(rs.getString("status_post"));
                list.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void softDeletePost(int postId) {
        String sql = "UPDATE Post SET status_post = 'deactive' WHERE post_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, postId);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void createPost(Post post) {
        String sql = "INSERT INTO Post (account_id, title, content_post, post_date, status_post) VALUES (?, ?, ?, GETDATE(), ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, post.getAccountId());
            st.setString(2, post.getTitle());
            st.setString(3, post.getContentPost());
            st.setString(4, post.getStatusPost());
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updatePost(Post post) {
        String sql = "UPDATE Post SET title = ?, content_post = ?, status_post = ? WHERE post_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, post.getTitle());
            st.setString(2, post.getContentPost());
            st.setString(3, post.getStatusPost());
            st.setInt(4, post.getPostId());
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Post> getPostsByAccountIdPaging(int accountId, int page, int pageSize) {
        List<Post> list = new ArrayList<>();
        String sql = "SELECT * FROM Post WHERE account_id = ? AND status_post = 'active' " +
                     "ORDER BY post_date DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, accountId);
            st.setInt(2, (page - 1) * pageSize);
            st.setInt(3, pageSize);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Post post = new Post();
                post.setPostId(rs.getInt("post_id"));
                post.setAccountId(rs.getInt("account_id"));
                post.setTitle(rs.getString("title"));
                post.setContentPost(rs.getString("content_post"));
                post.setPostDate(rs.getString("post_date"));
                post.setStatusPost(rs.getString("status_post"));
                list.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countPostsByAccountId(int accountId) {
        String sql = "SELECT COUNT(*) FROM Post WHERE account_id = ? AND status_post = 'active'";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, accountId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

public Vector<Post> get3LastestPost() {
        String sql = "SELECT TOP 3 *\n"
                + "FROM Post\n"
                + "WHERE status_post = 'active'\n"
                + "ORDER BY post_date DESC";
        Vector<Post> listPost = new Vector<>();
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Post p = new Post(rs.getInt(1), rs.getInt(2),
                        rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6)
                );
                listPost.add(p);
            }
        }catch (SQLException e) {
            e.printStackTrace();
        }
        return listPost;
    }

    public List<Post> getAllPosts() {
        List<Post> list = new ArrayList<>();
        String sql = "SELECT p.*, a.username FROM Post p JOIN Account a ON p.account_id = a.account_id ORDER BY p.post_date DESC";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
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
} 