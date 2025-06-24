package model;

public class PostDetails {
    private int postId;
    private String matchDate;
    private String matchTime;
    private int fieldTypeId;
    private String createdAt;

    public PostDetails() {}

    public PostDetails(int postId, String matchDate, String matchTime, int fieldTypeId, String createdAt) {
        this.postId = postId;
        this.matchDate = matchDate;
        this.matchTime = matchTime;
        this.fieldTypeId = fieldTypeId;
        this.createdAt = createdAt;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public String getMatchDate() {
        return matchDate;
    }

    public void setMatchDate(String matchDate) {
        this.matchDate = matchDate;
    }

    public String getMatchTime() {
        return matchTime;
    }

    public void setMatchTime(String matchTime) {
        this.matchTime = matchTime;
    }

    public int getFieldTypeId() {
        return fieldTypeId;
    }

    public void setFieldTypeId(int fieldTypeId) {
        this.fieldTypeId = fieldTypeId;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }
} 