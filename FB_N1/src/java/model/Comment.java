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

public class Comment {
    private int commentId;
    private int postId;
    private int accountId;
    private String contentCmt;
    private String cmtDate;
    private Account account;

    public Comment() {
    }

    public Comment(int commentId, int postId, int accountId, String contentCmt, String cmtDate) {
        this.commentId = commentId;
        this.postId = postId;
        this.accountId = accountId;
        this.contentCmt = contentCmt;
        this.cmtDate = cmtDate;
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

    @Override
    public String toString() {
        return "Comment{" + "commentId=" + commentId + ", postId=" + postId + ", accountId=" + accountId + ", contentCmt=" + contentCmt + ", cmtDate=" + cmtDate + '}';
    }
    
}