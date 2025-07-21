/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Timestamp;
import java.util.List;
import model.Blog;
import model.Status_Blog;
import util.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;

/**
 *
 * @author VAN NGUYEN
 */
public class blogDAO extends DBContext {

    public List<Blog> getAllBlog() {
        List<Blog> blogs = new ArrayList<>();
        String sql = "SELECT b.*, s.status_blog_name "
                + "FROM Blog b "
                + "JOIN Status_Blog s ON b.status_blog_id = s.status_blog_id";

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Blog blog = new Blog();
                blog.setBlogId(rs.getInt("blog_id"));
                blog.setTitle(rs.getString("title"));
                blog.setSlug(rs.getString("slug"));
                blog.setSummary(rs.getString("summary"));
                blog.setContent(rs.getString("content"));
                blog.setThumbnailUrl(rs.getString("thumbnail_url"));
                blog.setAccountId(rs.getInt("account_id"));
                blog.setStatusBlogId(rs.getInt("status_blog_id"));
                blog.setCreatedAt(rs.getTimestamp("created_at"));
                blog.setUpdatedAt(rs.getTimestamp("updated_at"));
                blog.setTags(rs.getString("tags"));

                // Gán status_blog object
                Status_Blog status = new Status_Blog();
                status.setStatus_id(rs.getInt("status_blog_id"));
                status.setStatus_des(rs.getString("status_blog_name"));

                blog.setStatus(status);

                blogs.add(blog);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return blogs;
    }
    public List<Blog> getAllBlogStatus() {
        List<Blog> blogs = new ArrayList<>();
        String sql = "SELECT b.*, s.status_blog_name \n" +
"                FROM Blog b \n" +
"                JOIN Status_Blog s ON b.status_blog_id = s.status_blog_id\n" +
"				where s.status_blog_id = 1";

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Blog blog = new Blog();
                blog.setBlogId(rs.getInt("blog_id"));
                blog.setTitle(rs.getString("title"));
                blog.setSlug(rs.getString("slug"));
                blog.setSummary(rs.getString("summary"));
                blog.setContent(rs.getString("content"));
                blog.setThumbnailUrl(rs.getString("thumbnail_url"));
                blog.setAccountId(rs.getInt("account_id"));
                blog.setStatusBlogId(rs.getInt("status_blog_id"));
                blog.setCreatedAt(rs.getTimestamp("created_at"));
                blog.setUpdatedAt(rs.getTimestamp("updated_at"));
                blog.setTags(rs.getString("tags"));

                // Gán status_blog object
                Status_Blog status = new Status_Blog();
                status.setStatus_id(rs.getInt("status_blog_id"));
                status.setStatus_des(rs.getString("status_blog_name"));

                blog.setStatus(status);

                blogs.add(blog);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return blogs;
    }

    public Blog getBlogBySlug(String slug) {
        Blog blog = null;
        String sql = "SELECT * FROM Blog WHERE slug = ? and status_blog_id = 1";
        try (PreparedStatement ps = connection.prepareStatement(sql);) {
            ps.setString(1, slug);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                blog = new Blog(rs.getInt(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getString(5), rs.getString(6),
                        rs.getInt(7), rs.getInt(8), rs.getTimestamp(9), rs.getTimestamp(10),
                        rs.getString(11));
                // set dữ liệu từ rs vào blog
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return blog;
    }
    public Blog getBlogById(int blogId) {
        Blog blog = null;
        String sql = "SELECT * FROM Blog WHERE blog_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql);) {
            ps.setInt(1, blogId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                blog = new Blog(rs.getInt(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getString(5), rs.getString(6),
                        rs.getInt(7), rs.getInt(8), rs.getTimestamp(9), rs.getTimestamp(10),
                        rs.getString(11));
                // set dữ liệu từ rs vào blog
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return blog;
    }

    public boolean insertBlog(Blog blog) {
        String sql = "INSERT INTO Blog (title, slug, summary, content, thumbnail_url, account_id, status_blog_id, tags) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, blog.getTitle());
            ps.setString(2, blog.getSlug());
            ps.setString(3, blog.getSummary());
            ps.setString(4, blog.getContent());
            ps.setString(5, blog.getThumbnailUrl());
            ps.setInt(6, blog.getAccountId());
            ps.setInt(7, blog.getStatusBlogId());
            ps.setString(8, blog.getTags());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
    
    
    

    public boolean updateBlog(Blog blog) {
        String sql = "UPDATE Blog SET title = ?, slug = ?, summary = ?, content = ?, thumbnail_url = ?, "
                + "  updated_at = ?, tags = ? "
                + "WHERE blog_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, blog.getTitle());
            ps.setString(2, blog.getSlug());
            ps.setString(3, blog.getSummary());
            ps.setString(4, blog.getContent());
            ps.setString(5, blog.getThumbnailUrl());
            ps.setTimestamp(6, blog.getUpdatedAt());
            ps.setString(7, blog.getTags());
            ps.setInt(8, blog.getBlogId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean changeStatus(int blogId, int newStatusId) {
        String sql = "UPDATE Blog SET status_blog_id = ?, updated_at = ? WHERE blog_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, newStatusId);
            ps.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
            ps.setInt(3, blogId);

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public List<Blog> searchBlogsByTitle(String keyword) {
        List<Blog> blogs = new ArrayList<>();
        String sql = "SELECT b.*, s.status_blog_name "
                + "FROM Blog b "
                + "JOIN Status_Blog s ON b.status_blog_id = s.status_blog_id "
                + "WHERE b.title LIKE ? and b.status_blog_id = 1";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Blog blog = new Blog();
                    blog.setBlogId(rs.getInt("blog_id"));
                    blog.setTitle(rs.getString("title"));
                    blog.setSlug(rs.getString("slug"));
                    blog.setSummary(rs.getString("summary"));
                    blog.setContent(rs.getString("content"));
                    blog.setThumbnailUrl(rs.getString("thumbnail_url"));
                    blog.setAccountId(rs.getInt("account_id"));
                    blog.setStatusBlogId(rs.getInt("status_blog_id"));
                    blog.setCreatedAt(rs.getTimestamp("created_at"));
                    blog.setUpdatedAt(rs.getTimestamp("updated_at"));
                    blog.setTags(rs.getString("tags"));

                    // Gán status
                    Status_Blog status = new Status_Blog();
                    status.setStatus_id(rs.getInt("status_blog_id"));
                    status.setStatus_des(rs.getString("status_blog_name"));
                    blog.setStatus(status);

                    blogs.add(blog);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return blogs;
    }

    public List<Blog> getLatest3Blogs() {
        List<Blog> blogs = new ArrayList<>();
        String sql = "SELECT TOP 3 b.*, s.status_blog_name "
                + "FROM Blog b "
                + "JOIN Status_Blog s ON b.status_blog_id = s.status_blog_id "
                + "WHERE b.status_blog_id = 1 "
                + // chỉ lấy bài viết đang hiển thị (nếu cần)
                "ORDER BY b.created_at DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Blog blog = new Blog();
                blog.setBlogId(rs.getInt("blog_id"));
                blog.setTitle(rs.getString("title"));
                blog.setSlug(rs.getString("slug"));
                blog.setSummary(rs.getString("summary"));
                blog.setContent(rs.getString("content"));
                blog.setThumbnailUrl(rs.getString("thumbnail_url"));
                blog.setAccountId(rs.getInt("account_id"));
                blog.setStatusBlogId(rs.getInt("status_blog_id"));
                blog.setCreatedAt(rs.getTimestamp("created_at"));
                blog.setUpdatedAt(rs.getTimestamp("updated_at"));
                blog.setTags(rs.getString("tags"));

                // Gán status
                Status_Blog status = new Status_Blog();
                status.setStatus_id(rs.getInt("status_blog_id"));
                status.setStatus_des(rs.getString("status_blog_name"));
                blog.setStatus(status);

                blogs.add(blog);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return blogs;
    }

    public List<Blog> searchBlogsByTag(String tag) {
        List<Blog> blogs = new ArrayList<>();
        String sql = "SELECT b.*, s.status_blog_name "
                + "FROM Blog b "
                + "JOIN Status_Blog s ON b.status_blog_id = s.status_blog_id "
                + "WHERE b.tags LIKE ? and b.status_blog_id = 1";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + tag + "%");

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Blog blog = new Blog();
                    blog.setBlogId(rs.getInt("blog_id"));
                    blog.setTitle(rs.getString("title"));
                    blog.setSlug(rs.getString("slug"));
                    blog.setSummary(rs.getString("summary"));
                    blog.setContent(rs.getString("content"));
                    blog.setThumbnailUrl(rs.getString("thumbnail_url"));
                    blog.setAccountId(rs.getInt("account_id"));
                    blog.setStatusBlogId(rs.getInt("status_blog_id"));
                    blog.setCreatedAt(rs.getTimestamp("created_at"));
                    blog.setUpdatedAt(rs.getTimestamp("updated_at"));
                    blog.setTags(rs.getString("tags"));

                    // Gán status
                    Status_Blog status = new Status_Blog();
                    status.setStatus_id(rs.getInt("status_blog_id"));
                    status.setStatus_des(rs.getString("status_blog_name"));
                    blog.setStatus(status);

                    blogs.add(blog);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return blogs;
    }

    public Set<String> getAllTags() {
        Set<String> tagsSet = new HashSet<>();
        String sql = "SELECT tags FROM Blog WHERE tags IS NOT NULL and status_blog_id = 1";

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                String tagsRaw = rs.getString("tags");
                if (tagsRaw != null && !tagsRaw.trim().isEmpty()) {
                    String[] tags = tagsRaw.split(",");
                    for (String tag : tags) {
                        tag = tag.trim().toLowerCase(); // chuẩn hóa (có thể bỏ if không cần)
                        if (!tag.isEmpty()) {
                            tagsSet.add(tag);
                        }
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return tagsSet;
    }
    public static void main(String[] args) {
        blogDAO bDao = new blogDAO();
        List<Blog> list = bDao.getAllBlogStatus();
        for (Blog blog : list) {
            System.out.println(blog);
        }
        Blog b = bDao.getBlogBySlug("blog-2");
        System.out.println(b);
    }

}
