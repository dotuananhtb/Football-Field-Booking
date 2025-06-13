/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author VAN NGUYEN
 */
public class Event {
    private int eventID;
    private String image_video;
    private String image2;
    private String title_content;
    private String content1;
    private String content2;
    private Title title;

    public Event(int eventID, String image_video, String image2, String title_content, String content1, String content2, Title title) {
        this.eventID = eventID;
        this.image_video = image_video;
        this.image2 = image2;
        this.title_content = title_content;
        this.content1 = content1;
        this.content2 = content2;
        this.title = title;
    }

    public Event(String image_video, String image2, String title_content, String content1, String content2, Title title) {
        this.image_video = image_video;
        this.image2 = image2;
        this.title_content = title_content;
        this.content1 = content1;
        this.content2 = content2;
        this.title = title;
    }

    public Event() {
    }

    public int getEventID() {
        return eventID;
    }

    public void setEventID(int eventID) {
        this.eventID = eventID;
    }

    public String getImage_video() {
        return image_video;
    }

    public void setImage_video(String image_video) {
        this.image_video = image_video;
    }

    public String getImage2() {
        return image2;
    }

    public void setImage2(String image2) {
        this.image2 = image2;
    }

    public String getTitle_content() {
        return title_content;
    }

    public void setTitle_content(String title_content) {
        this.title_content = title_content;
    }

    public String getContent1() {
        return content1;
    }

    public void setContent1(String content1) {
        this.content1 = content1;
    }

    public String getContent2() {
        return content2;
    }

    public void setContent2(String content2) {
        this.content2 = content2;
    }

    public Title getTitle() {
        return title;
    }

    public void setTitle(Title title) {
        this.title = title;
    }

    @Override
    public String toString() {
        return "Event{" + "eventID=" + eventID + ", image_video=" + image_video + ", image2=" + image2 + ", title_content=" + title_content + ", content1=" + content1 + ", content2=" + content2 + ", title=" + title + '}';
    }
    
    

    
    

    
    
    
    
    
}
