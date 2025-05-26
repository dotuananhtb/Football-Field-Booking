/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author VAN NGUYEN
 */
public class PostViewDetail {
    private int postId;
    private String userName;
    private String avatar;
    private int accountId;
    private String title;
    private String contentPost;
    private Date postDate;
    private String statusPost;
    private int commentID;
    private String content_cmt;
    private Date cmtDate;

    public PostViewDetail(int postId, String userName, String avatar, int accountId, String title, String contentPost, Date postDate, String statusPost, int commentID, String content_cmt, Date cmtDate) {
        this.postId = postId;
        this.userName = userName;
        this.avatar = avatar;
        this.accountId = accountId;
        this.title = title;
        this.contentPost = contentPost;
        this.postDate = postDate;
        this.statusPost = statusPost;
        this.commentID = commentID;
        this.content_cmt = content_cmt;
        this.cmtDate = cmtDate;
    }

    public PostViewDetail() {
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
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

    public int getCommentID() {
        return commentID;
    }

    public void setCommentID(int commentID) {
        this.commentID = commentID;
    }

    public String getContent_cmt() {
        return content_cmt;
    }

    public void setContent_cmt(String content_cmt) {
        this.content_cmt = content_cmt;
    }

    public Date getCmtDate() {
        return cmtDate;
    }

    public void setCmtDate(Date cmtDate) {
        this.cmtDate = cmtDate;
    }
    
    

}
