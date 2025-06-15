/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Đỗ Tuấn Anh
 */
import java.util.Date;
import java.sql.Timestamp;

public class Comment {
    private int commentId;
    private int postId;
    private int accountId;
    private String contentCmt;
    private String cmtDate;
    private Account account;
    private Timestamp createdAt;
    private boolean isDeleted;

    public Comment() {
    }

    public Comment(int commentId, int postId, int accountId, String contentCmt, String cmtDate, Timestamp createdAt, boolean isDeleted) {
        this.commentId = commentId;
        this.postId = postId;
        this.accountId = accountId;
        this.contentCmt = contentCmt;
        this.cmtDate = cmtDate;
        this.createdAt = createdAt;
        this.isDeleted = isDeleted;
    }

    public int getCommentId() {
        return commentId;
    }

    public void setCommentId(int commentId) {
        this.commentId = commentId;
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

    public String getContentCmt() {
        return contentCmt;
    }

    public void setContentCmt(String contentCmt) {
        this.contentCmt = contentCmt;
    }

    public String getCmtDate() {
        return cmtDate;
    }

    public void setCmtDate(String cmtDate) {
        this.cmtDate = cmtDate;
    }

    public Account getAccount() {
        return account;
    }

    public void setAccount(Account account) {
        this.account = account;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public boolean isDeleted() {
        return isDeleted;
    }

    public void setDeleted(boolean deleted) {
        isDeleted = deleted;
    }

    @Override
    public String toString() {
        return "Comment{" + "commentId=" + commentId + ", postId=" + postId + ", accountId=" + accountId + ", contentCmt=" + contentCmt + ", cmtDate=" + cmtDate + '}';
    }
    
}