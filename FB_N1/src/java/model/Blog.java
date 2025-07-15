/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;

/**
 *
 * @author VAN NGUYEN
 */
public class Blog {
   private int blogId;
    private String title;
    private String slug;
    private String summary;
    private String content;
    private String thumbnailUrl;
    private int accountId;
    private int statusBlogId;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private String tags;
    private Status_Blog status;

    public Blog(int blogId, String title, String slug, String summary, String content, String thumbnailUrl, int accountId, int statusBlogId, Timestamp createdAt, Timestamp updatedAt, String tags, Status_Blog status) {
        this.blogId = blogId;
        this.title = title;
        this.slug = slug;
        this.summary = summary;
        this.content = content;
        this.thumbnailUrl = thumbnailUrl;
        this.accountId = accountId;
        this.statusBlogId = statusBlogId;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.tags = tags;
        this.status = status;
    }

    public Blog(String title, String slug, String summary, String content, String thumbnailUrl, int accountId, int statusBlogId, Timestamp createdAt, Timestamp updatedAt, String tags, Status_Blog status) {
        this.title = title;
        this.slug = slug;
        this.summary = summary;
        this.content = content;
        this.thumbnailUrl = thumbnailUrl;
        this.accountId = accountId;
        this.statusBlogId = statusBlogId;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.tags = tags;
        this.status = status;
    }
    

   

    public Blog() {
    }

    public int getBlogId() {
        return blogId;
    }

    public void setBlogId(int blogId) {
        this.blogId = blogId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getSlug() {
        return slug;
    }

    public void setSlug(String slug) {
        this.slug = slug;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getThumbnailUrl() {
        return thumbnailUrl;
    }

    public void setThumbnailUrl(String thumbnailUrl) {
        this.thumbnailUrl = thumbnailUrl;
    }

    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }

    public int getStatusBlogId() {
        return statusBlogId;
    }

    public void setStatusBlogId(int statusBlogId) {
        this.statusBlogId = statusBlogId;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    public String getTags() {
        return tags;
    }

    public void setTags(String tags) {
        this.tags = tags;
    }

    public Status_Blog getStatus() {
        return status;
    }

    public void setStatus(Status_Blog status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Blog{" + "blogId=" + blogId + ", title=" + title + ", slug=" + slug + ", summary=" + summary + ", content=" + content + ", thumbnailUrl=" + thumbnailUrl + ", accountId=" + accountId + ", statusBlogId=" + statusBlogId + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + ", tags=" + tags + ", status=" + status + '}';
    }

    
    
    
   
    
    
    
    
    
    
    
    
    
}
