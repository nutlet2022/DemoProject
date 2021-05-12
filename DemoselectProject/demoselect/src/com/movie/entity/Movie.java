package com.movie.entity;

public class Movie {
    private int MovieId;
    private String Title;
    private String Genres;

    public int getMovieId() {
        return MovieId;
    }

    public void setGenres(String genres) {
        Genres = genres;
    }

    public String getGenres() {
        return Genres;
    }

    public void setMovieId(int movieId) {
        MovieId = movieId;
    }

    public void setTitle(String title) {
        Title = title;
    }

    public String getTitle() {
        return Title;
    }
}
