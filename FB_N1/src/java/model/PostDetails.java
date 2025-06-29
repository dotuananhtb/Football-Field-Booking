package model;

public class PostDetails {
    private int postId;
    private String matchDate;
    private String matchTime;
    private String fieldType;
   

    public PostDetails() {}

    public PostDetails(int postId, String matchDate, String matchTime, String fieldType) {
        this.postId = postId;
        this.matchDate = matchDate;
        this.matchTime = matchTime;
        this.fieldType = fieldType;
        
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

    public String getFieldType() {
        return fieldType;
    }

    public void setFieldType(String fieldType) {
        this.fieldType = fieldType;
    }

    @Override
    public String toString() {
        return "PostDetails{" +
                "postId=" + postId +
                ", matchDate='" + matchDate + '\'' +
                ", matchTime='" + matchTime + '\'' +
                ", fieldType='" + fieldType + '\'' +
                '}';
    }
} 