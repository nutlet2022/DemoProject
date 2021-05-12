package com.movie.entity;

//获取某个用户所看电影，对其的评分，
public class Rating {
    private String title;
    private float rating;
    private float relevance;
    private String tag;

    public float getRating() {
        return rating;
    }

    public float getRelevance() {
        return relevance;
    }


    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getTag() {
        return tag;
    }

    public void setRating(float rating) {
        this.rating = rating;
    }

    public void setRelevance(float relevance) {
        this.relevance = relevance;
    }

    public void setTag(String tag) {
        this.tag = tag;
    }
}
