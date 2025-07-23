package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
import java.util.List;
import java.util.ArrayList;
import model.Post;
import model.*;
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
                account.setAccountId(rs.getInt("account_id")); // thêm dòng này để có accountId
                account.setUsername(rs.getString("username"));
                post.setAccount(account);
                
                // Lấy thêm PostDetails
                dao.PostDetailsDAO postDetailsDAO = new dao.PostDetailsDAO();
                model.PostDetails postDetails = postDetailsDAO.getByPostId(post.getPostId());
                post.setPostDetails(postDetails);
                
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
        String query = "SELECT p.*, a.username FROM Post p " +
                       "JOIN Account a ON p.account_id = a.account_id " +
                       "WHERE p.account_id = ? AND p.status_post = 'active' " +
                       "ORDER BY p.post_date DESC";
        try {
            PreparedStatement ptm = connection.prepareStatement(query);
            ptm.setInt(1, accountId);
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

    public void softDeletePost(int postId) {
        String query = "UPDATE Post SET status_post = 'deactive' WHERE post_id = ?";
        try {
            PreparedStatement ptm = connection.prepareStatement(query);
            ptm.setInt(1, postId);
            ptm.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int createPost(Post post) {
        String query = "INSERT INTO Post (account_id, title, content_post, post_date, status_post) VALUES (?, ?, ?, ?, ?)";
        try {
            PreparedStatement ptm = connection.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS);
            ptm.setInt(1, post.getAccountId());
            ptm.setString(2, post.getTitle());
            ptm.setString(3, post.getContentPost());
            ptm.setString(4, post.getPostDate());
            ptm.setString(5, post.getStatusPost());
            ptm.executeUpdate();
            try (ResultSet rs = ptm.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1); // trả về post_id vừa tạo
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; // lỗi
    }

    public void updatePost(Post post) {
        String query = "UPDATE Post SET title = ?, content_post = ? WHERE post_id = ?";
        try {
            PreparedStatement ptm = connection.prepareStatement(query);
            ptm.setString(1, post.getTitle());
            ptm.setString(2, post.getContentPost());
            ptm.setInt(3, post.getPostId());
            ptm.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Post> getPostsByAccountIdPaging(int accountId, int page, int pageSize) {
        List<Post> list = new ArrayList<>();
        String query = "SELECT p.*, a.username FROM Post p " +
                       "JOIN Account a ON p.account_id = a.account_id " +
                       "WHERE p.account_id = ? AND p.status_post = 'active' " +
                       "ORDER BY p.post_date DESC " +
                       "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            PreparedStatement ptm = connection.prepareStatement(query);
            ptm.setInt(1, accountId);
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

    public int countPostsByAccountId(int accountId) {
        String query = "SELECT COUNT(*) FROM Post WHERE account_id = ? AND status_post = 'active'";
        try {
            PreparedStatement ptm = connection.prepareStatement(query);
            ptm.setInt(1, accountId);
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public Vector<Post> get3LastestPost() {
        Vector<Post> list = new Vector<>();
        String query = "SELECT TOP 3 p.*, a.username FROM Post p " +
                      "JOIN Account a ON p.account_id = a.account_id " +
                      "WHERE p.status_post = 'active' " +
                      "ORDER BY p.post_date DESC";
        try {
            PreparedStatement ptm = connection.prepareStatement(query);
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

    public List<Post> getAllPosts() {
        List<Post> list = new ArrayList<>();
        String query = "SELECT p.*, a.username FROM Post p " +
                       "JOIN Account a ON p.account_id = a.account_id " +
                       "WHERE p.status_post = 'active' " +
                       "ORDER BY p.post_date DESC";
        try {
            PreparedStatement ptm = connection.prepareStatement(query);
            ResultSet rs = ptm.executeQuery();
            PostDetailsDAO postDetailsDAO = new PostDetailsDAO();
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
                // Lấy PostDetails cho từng post
                try {
                    PostDetails details = postDetailsDAO.getByPostId(post.getPostId());
                    post.setPostDetails(details);
                } catch (Exception e) {
                    post.setPostDetails(null);
                }
                list.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Vector<Post> getPostsByUser(int accountId, int page, int pageSize) {
        Vector<Post> list = new Vector<>();
        String query = "SELECT p.*, a.username FROM Post p " +
                       "JOIN Account a ON p.account_id = a.account_id " +
                       "WHERE p.status_post = 'active' AND p.account_id = ? " +
                       "ORDER BY p.post_date DESC " +
                       "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            PreparedStatement ptm = connection.prepareStatement(query);
            ptm.setInt(1, accountId);
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

    public int getTotalPostsByUser(int accountId) {
        String query = "SELECT COUNT(*) FROM Post WHERE status_post = 'active' AND account_id = ?";
        try {
            PreparedStatement ptm = connection.prepareStatement(query);
            ptm.setInt(1, accountId);
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public Vector<Post> searchPostsByUserAndTitle(int accountId, String title, int page, int pageSize) {
        Vector<Post> list = new Vector<>();
        String query = "SELECT p.*, a.username FROM Post p " +
                       "JOIN Account a ON p.account_id = a.account_id " +
                       "WHERE p.status_post = 'active' AND p.account_id = ? AND (p.title LIKE ? OR p.content_post LIKE ?) " +
                       "ORDER BY p.post_date DESC " +
                       "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            PreparedStatement ptm = connection.prepareStatement(query);
            ptm.setInt(1, accountId);
            ptm.setString(2, "%" + title + "%");
            ptm.setString(3, "%" + title + "%");
            ptm.setInt(4, (page - 1) * pageSize);
            ptm.setInt(5, pageSize);
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

    public int countPostsByUserAndTitle(int accountId, String title) {
        String query = "SELECT COUNT(*) FROM Post WHERE status_post = 'active' AND account_id = ? AND (title LIKE ? OR content_post LIKE ?)";
        try {
            PreparedStatement ptm = connection.prepareStatement(query);
            ptm.setInt(1, accountId);
            ptm.setString(2, "%" + title + "%");
            ptm.setString(3, "%" + title + "%");
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public Vector<Post> getRecentPostsByUser(int accountId, int limit) {
        Vector<Post> list = new Vector<>();
        String query = "SELECT TOP (?) p.*, a.username FROM Post p " +
                      "JOIN Account a ON p.account_id = a.account_id " +
                      "WHERE p.status_post = 'active' AND p.account_id = ? " +
                      "ORDER BY p.post_date DESC";
        try {
            PreparedStatement ptm = connection.prepareStatement(query);
            ptm.setInt(1, limit);
            ptm.setInt(2, accountId);
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

    public List<Post> getPostsWithPagination(int page, int pageSize) {
        List<Post> list = new ArrayList<>();
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

    public int countAllPosts() {
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

    public List<Post> searchPosts(String search, int page, int pageSize) {
        List<Post> list = new ArrayList<>();
        String query = "SELECT p.*, a.username FROM Post p " +
                       "JOIN Account a ON p.account_id = a.account_id " +
                       "WHERE p.status_post = 'active' AND (p.title LIKE ? OR p.content_post LIKE ?) " +
                       "ORDER BY p.post_date DESC " +
                       "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            PreparedStatement ptm = connection.prepareStatement(query);
            ptm.setString(1, "%" + search + "%");
            ptm.setString(2, "%" + search + "%");
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

    public int countSearchPosts(String search) {
        String query = "SELECT COUNT(*) FROM Post WHERE status_post = 'active' AND (title LIKE ? OR content_post LIKE ?)";
        try {
            PreparedStatement ptm = connection.prepareStatement(query);
            ptm.setString(1, "%" + search + "%");
            ptm.setString(2, "%" + search + "%");
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Post> getPostsByStaffAndAdmin(int page, int pageSize) {
        List<Post> list = new ArrayList<>();
        String query = "SELECT p.*, a.username FROM Post p " +
                       "JOIN Account a ON p.account_id = a.account_id " +
                       "JOIN UserProfile up ON a.account_id = up.account_id " +
                       "WHERE p.status_post = 'active' AND (up.role_id = 1 OR up.role_id = 2) " +
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

    public int countPostsByStaffAndAdmin() {
        String query = "SELECT COUNT(*) FROM Post p " +
                       "JOIN Account a ON p.account_id = a.account_id " +
                       "JOIN UserProfile up ON a.account_id = up.account_id " +
                       "WHERE p.status_post = 'active' AND (up.role_id = 1 OR up.role_id = 2)";
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

    public List<Post> searchPostsByStaffAndAdmin(String search, int page, int pageSize) {
        List<Post> list = new ArrayList<>();
        String query = "SELECT p.*, a.username FROM Post p " +
                       "JOIN Account a ON p.account_id = a.account_id " +
                       "JOIN UserProfile up ON a.account_id = up.account_id " +
                       "WHERE p.status_post = 'active' AND (up.role_id = 1 OR up.role_id = 2) " +
                       "AND (p.title LIKE ? OR p.content_post LIKE ?) " +
                       "ORDER BY p.post_date DESC " +
                       "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            PreparedStatement ptm = connection.prepareStatement(query);
            ptm.setString(1, "%" + search + "%");
            ptm.setString(2, "%" + search + "%");
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

    public int countSearchPostsByStaffAndAdmin(String search) {
        String query = "SELECT COUNT(*) FROM Post p " +
                       "JOIN Account a ON p.account_id = a.account_id " +
                       "JOIN UserProfile up ON a.account_id = up.account_id " +
                       "WHERE p.status_post = 'active' AND (up.role_id = 1 OR up.role_id = 2) " +
                       "AND (p.title LIKE ? OR p.content_post LIKE ?)";
        try {
            PreparedStatement ptm = connection.prepareStatement(query);
            ptm.setString(1, "%" + search + "%");
            ptm.setString(2, "%" + search + "%");
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Post> getRecentPostsByStaffAndAdmin(int limit) {
        List<Post> list = new ArrayList<>();
        String query = "SELECT TOP (?) p.*, a.username FROM Post p " +
                      "JOIN Account a ON p.account_id = a.account_id " +
                      "JOIN UserProfile up ON a.account_id = up.account_id " +
                      "WHERE p.status_post = 'active' AND (up.role_id = 1 OR up.role_id = 2) " +
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

    public Vector<Post> getPostsByRegularUsers(int page, int pageSize) {
        Vector<Post> list = new Vector<>();
        String query = "SELECT p.*, a.username FROM Post p " +
                       "JOIN Account a ON p.account_id = a.account_id " +
                       "JOIN UserProfile up ON a.account_id = up.account_id " +
                       "WHERE p.status_post = 'active' AND up.role_id = 3 " +
                       "ORDER BY p.post_date DESC " +
                       "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            PreparedStatement ptm = connection.prepareStatement(query);
            ptm.setInt(1, (page - 1) * pageSize);
            ptm.setInt(2, pageSize);
            ResultSet rs = ptm.executeQuery();
            PostDetailsDAO postDetailsDAO = new PostDetailsDAO();
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
                // Lấy PostDetails cho từng post
                PostDetails details = postDetailsDAO.getByPostId(post.getPostId());
                post.setPostDetails(details);
                list.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countPostsByRegularUsers() {
        String query = "SELECT COUNT(*) FROM Post p " +
                       "JOIN Account a ON p.account_id = a.account_id " +
                       "JOIN UserProfile up ON a.account_id = up.account_id " +
                       "WHERE p.status_post = 'active' AND up.role_id = 3";
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

    public Vector<Post> searchPostsByRegularUsers(String search, int page, int pageSize) {
        Vector<Post> list = new Vector<>();
        String query = "SELECT p.*, a.username FROM Post p " +
                       "JOIN Account a ON p.account_id = a.account_id " +
                       "JOIN UserProfile up ON a.account_id = up.account_id " +
                       "WHERE p.status_post = 'active' AND up.role_id = 3 " +
                       "AND (p.title LIKE ? OR p.content_post LIKE ?) " +
                       "ORDER BY p.post_date DESC " +
                       "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            PreparedStatement ptm = connection.prepareStatement(query);
            ptm.setString(1, "%" + search + "%");
            ptm.setString(2, "%" + search + "%");
            ptm.setInt(3, (page - 1) * pageSize);
            ptm.setInt(4, pageSize);
            ResultSet rs = ptm.executeQuery();
            PostDetailsDAO postDetailsDAO = new PostDetailsDAO();
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
                // Lấy PostDetails cho từng post
                PostDetails details = postDetailsDAO.getByPostId(post.getPostId());
                post.setPostDetails(details);
                list.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countSearchPostsByRegularUsers(String search) {
        String query = "SELECT COUNT(*) FROM Post p " +
                       "JOIN Account a ON p.account_id = a.account_id " +
                       "JOIN UserProfile up ON a.account_id = up.account_id " +
                       "WHERE p.status_post = 'active' AND up.role_id = 3 " +
                       "AND (p.title LIKE ? OR p.content_post LIKE ?)";
        try {
            PreparedStatement ptm = connection.prepareStatement(query);
            ptm.setString(1, "%" + search + "%");
            ptm.setString(2, "%" + search + "%");
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public Vector<Post> getRecentPostsByRegularUsers(int limit) {
        Vector<Post> list = new Vector<>();
        String query = "SELECT TOP (?) p.*, a.username FROM Post p " +
                      "JOIN Account a ON p.account_id = a.account_id " +
                      "JOIN UserProfile up ON a.account_id = up.account_id " +
                      "WHERE p.status_post = 'active' AND up.role_id = 3 " +
                      "ORDER BY p.post_date DESC";
        try {
            PreparedStatement ptm = connection.prepareStatement(query);
            ptm.setInt(1, limit);
            ResultSet rs = ptm.executeQuery();
            PostDetailsDAO postDetailsDAO = new PostDetailsDAO();
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
                // Lấy PostDetails cho từng post
                PostDetails details = postDetailsDAO.getByPostId(post.getPostId());
                post.setPostDetails(details);
                list.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Lấy tất cả bài viết của user theo role_id (ví dụ: 3 = user thường)
     */
    public List<Post> getAllPostsByUserRole(int roleId) {
        List<Post> list = new ArrayList<>();
        String query = "SELECT p.*, a.username FROM Post p " +
                       "JOIN Account a ON p.account_id = a.account_id " +
                       "JOIN UserProfile u ON a.account_id = u.account_id " +
                       "WHERE u.role_id = ? " +
                       "ORDER BY p.post_date DESC";
        try {
            PreparedStatement ptm = connection.prepareStatement(query);
            ptm.setInt(1, roleId);
            ResultSet rs = ptm.executeQuery();
            PostDetailsDAO postDetailsDAO = new PostDetailsDAO();
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
                // Lấy PostDetails cho từng post
                try {
                    PostDetails details = postDetailsDAO.getByPostId(post.getPostId());
                    post.setPostDetails(details);
                } catch (Exception e) {
                    post.setPostDetails(null);
                }
                list.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countAllPostsOfUserRole3() {
        String query = "SELECT COUNT(*) FROM Post p JOIN Account a ON p.account_id = a.account_id JOIN UserProfile up ON a.account_id = up.account_id WHERE p.status_post = 'active' AND up.role_id = 3";
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

    public void updatePostStatus(int postId, String newStatus) {
        String query = "UPDATE Post SET status_post = ? WHERE post_id = ?";
        try {
            PreparedStatement ptm = connection.prepareStatement(query);
            ptm.setString(1, newStatus);
            ptm.setInt(2, postId);
            ptm.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
}