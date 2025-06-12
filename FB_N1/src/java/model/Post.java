/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
import java.sql.Date;

public class Post {
    private int postId;
    private int accountId;
    private String title;
    private String img;
    private String contentPost;
    private String postDate;
    private String statusPost;
    private Account account;

    public Post() {
    }

    public Post(int postId, int accountId, String title, String img, String contentPost, String postDate, String statusPost) {
        this.postId = postId;
        this.accountId = accountId;
        this.title = title;
        this.img = img;
        this.contentPost = contentPost;
        this.postDate = postDate;
        this.statusPost = statusPost;
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

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public String getContentPost() {
        return contentPost;
    }

    public void setContentPost(String contentPost) {
        this.contentPost = contentPost;
    }

    public String getPostDate() {
        return postDate;
    }

    public void setPostDate(String postDate) {
        this.postDate = postDate;
    }

    public String getStatusPost() {
        return statusPost;
    }

    public void setStatusPost(String statusPost) {
        this.statusPost = statusPost;
    }

    public Account getAccount() {
        return account;
    }

    public void setAccount(Account account) {
        this.account = account;
    }

    @Override
    public String toString() {
        return "Post{" + "postId=" + postId + ", accountId=" + accountId + ", title=" + title + ", img=" + img + ", contentPost=" + contentPost + ", postDate=" + postDate + ", statusPost=" + statusPost + '}';
    }
    
}
