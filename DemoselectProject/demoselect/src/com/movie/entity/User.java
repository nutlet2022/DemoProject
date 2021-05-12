package com.movie.entity;

public class User {
    private int userID;
    private String gender;
    private String name;

    public  void setUserID(int userID){
        this.userID = userID;
    }

    public int getUserID(){
        return userID;
    }


   public void setGender(String gender){
        this.gender = gender;
    }


    public  String getGender(){
        return gender;
    }

   public  void setName(String name){
        this.name = name;
    }

   public  String getName(){
        return name;
    }
}
