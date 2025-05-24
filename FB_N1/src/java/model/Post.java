/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
import java.util.Date;

public class Post {
    private int postId;
    private int accountId;
    private String title;
    private String contentPost;
    private Date postDate;
    private String statusPost;

    public Post(int postId, int accountId, String title, String contentPost, Date postDate, String statusPost) {
        this.postId = postId;
        this.accountId = accountId;
        this.title = title;
        this.contentPost = contentPost;
        this.postDate = postDate;
        this.statusPost = statusPost;
    }

    public Post() {
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContentPost() {
        return contentPost;
    }

    public void setContentPost(String contentPost) {
        this.contentPost = contentPost;
    }

    public Date getPostDate() {
        return postDate;
    }

    public void setPostDate(Date postDate) {
        this.postDate = postDate;
    }

    public String getStatusPost() {
        return statusPost;
    }

    public void setStatusPost(String statusPost) {
        this.statusPost = statusPost;
    }

    @Override
    public String toString() {
        return "Post{" + "postId=" + postId + ", accountId=" + accountId + ", title=" + title + ", contentPost=" + contentPost + ", postDate=" + postDate + ", statusPost=" + statusPost + '}';
    }
    
}
