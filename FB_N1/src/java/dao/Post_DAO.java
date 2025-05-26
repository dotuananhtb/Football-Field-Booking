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
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author VAN NGUYEN
 */
public class Post_DAO extends DBContext {

    public Stack<Post> getAllPost() {
        String sql = "SELECT *\n"
                + "  FROM [FootballFieldBooking].[dbo].[Post]";
        Stack<Post> listPost = new Stack<>();
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Post p = new Post(rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getDate(5),
                        rs.getString(6));
                listPost.push(p);
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
        String sql = "SELECT *\n"
                + "  FROM [FootballFieldBooking].[dbo].[Post] p\n"
                + "  where p.title = ? ";

        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setString(1, title);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                return new Post(rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getDate(5),
                        rs.getString(6));
            }
        } catch (SQLException ex) {
            ex.getStackTrace();
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
