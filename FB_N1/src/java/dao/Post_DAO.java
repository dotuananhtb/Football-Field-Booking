/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Date;
import java.util.Stack;
import model.Post;
import util.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author VAN NGUYEN
 */
public class Post_DAO extends DBContext {

    public Vector<Post> getAllPost() {
        String sql = "SELECT *\n"
                + "  FROM [FootballFieldBooking].[dbo].[Post]";
        Vector<Post> listPost = new Vector<>();
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Post p = new Post(rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getString(4), 
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7));
                        
                listPost.add(p);
            }
        } catch (SQLException e) {
            e.getStackTrace();
        }
        return listPost;

    }

    public void updatePost(Post p) {
        String sql = "UPDATE [dbo].[Post]\n"
                + "   SET \n"
                + "      ,[title] = ?\n"
                + "      ,[content_post] = ?\n"
                + "      ,[status_post] = edited\n"
                + " WHERE [post_id] = ?";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setString(1, p.getTitle());
            ptm.setString(2, p.getContentPost());
            ptm.setString(3, p.getStatusPost());
            ptm.setInt(4, p.getPostId());
            ptm.executeUpdate();
        } catch (SQLException e) {
            e.getStackTrace();
        }
    }

    public int insertPost(Post p) {
        String sql = "INSERT INTO [dbo].[Post]\n"
                + "           [title]\n"
                + "           ,[content_post]\n"
                + "     VALUES\n"
                + "           (?,?)";
        int n = 0;
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setString(1, p.getTitle());
            ptm.setString(2, p.getContentPost());
            n = ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.getStackTrace();
        }
        return n;

    }

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
                    rs.getInt(1),    // post_id
                    rs.getInt(2),    // account_id
                    rs.getString(3), // title
                    rs.getString(4), // content_post
                    rs.getString(5), // post_date
                    rs.getString(6), // img
                    rs.getString(7)  // status_post
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public int deletePost(int postID) {
        int n = 0;
        String sql = "DELETE FROM [dbo].[Post]\n"
                + "      WHERE post_id =?";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setInt(1,postID);
             n = ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.getStackTrace();
        }
        
        return n;
    }

}
