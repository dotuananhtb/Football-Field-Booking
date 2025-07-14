/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author VAN NGUYEN
 */
public class Slider {
    private int  slider_id;
    private String slider_name;
    private String image;
    private String content1_big;
    private String content1_small;
    private String content2_small;

    public Slider(int slider_id, String slider_name, String image, String content1_big, String content1_small, String content2_small) {
        this.slider_id = slider_id;
        this.slider_name = slider_name;
        this.image = image;
        this.content1_big = content1_big;
        this.content1_small = content1_small;
        this.content2_small = content2_small;
    }

    public Slider(String slider_name, String image, String content1_big, String content1_small, String content2_small) {
        this.slider_name = slider_name;
        this.image = image;
        this.content1_big = content1_big;
        this.content1_small = content1_small;
        this.content2_small = content2_small;
    }

    public Slider() {
    }

    public int getSlider_id() {
        return slider_id;
    }

    public void setSlider_id(int slider_id) {
        this.slider_id = slider_id;
    }

    public String getSlider_name() {
        return slider_name;
    }

    public void setSlider_name(String slider_name) {
        this.slider_name = slider_name;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getContent1_big() {
        return content1_big;
    }

    public void setContent1_big(String content1_big) {
        this.content1_big = content1_big;
    }

    public String getContent1_small() {
        return content1_small;
    }

    public void setContent1_small(String content1_small) {
        this.content1_small = content1_small;
    }

    public String getContent2_small() {
        return content2_small;
    }

    public void setContent2_small(String content2_small) {
        this.content2_small = content2_small;
    }

    @Override
    public String toString() {
        return "Slider{" + "slider_id=" + slider_id + ", slider_name=" + slider_name + ", image=" + image + ", content1_big=" + content1_big + ", content1_small=" + content1_small + ", content2_small=" + content2_small + '}';
    }

   

   

    
    
    
    
    
    
}
