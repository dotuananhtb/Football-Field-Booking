/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author VAN NGUYEN
 */
public class Title {
  private int titleID;
  private String title1;
  

    public Title(int titleID, String title1) {
        this.titleID = titleID;
        this.title1 = title1;
        
    }

    public Title(String title1) {
        this.title1 = title1;
        
    }

    public Title() {
    }

    public int getTitleID() {
        return titleID;
    }

    public void setTitleID(int titleID) {
        this.titleID = titleID;
    }

    public String getTitle1() {
        return title1;
    }

    public void setTitle1(String title1) {
        this.title1 = title1;
    }

    @Override
    public String toString() {
        return "Title{" + "titleID=" + titleID + ", title1=" + title1 + '}';
    }

   

  
    
  
  
  
  
}
