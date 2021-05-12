package com.movie.servelt;

import com.movie.entity.Movie;
import com.movie.utils.JDBCTools;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class MovieServlet extends HttpServlet {


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = JDBCTools.getConnection();
        PreparedStatement prstmt = null;
        ResultSet rs = null;
        String x = request.getParameter("keyword");

        try {
            // 执行查询

            String sql;
            sql = "select movieId,title,genres from movies where title like \'%" + x + "%\';";

            System.out.println(sql);
            prstmt = conn.prepareStatement(sql);

            //prstmt.setString(1,x);
            rs = prstmt.executeQuery();



            List<Movie> list = new ArrayList<Movie>();

            while(rs.next()){

                Movie movie = new Movie();
                int movieId  = rs.getInt("movieId");
                String title = rs.getString("title");
                String genres = rs.getString("genres");
                movie.setMovieId(movieId);
                movie.setTitle(title);
                movie.setGenres(genres);
                list.add(movie);
            }

            request.setAttribute("movie_list",list);
            rs.close();
            prstmt.close();
            conn.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            JDBCTools.release(conn,prstmt,rs);
        }

        request.getRequestDispatcher("movie_list.jsp").forward(request,response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        Connection conn = JDBCTools.getConnection();
        Statement stmt = null;
        ResultSet rs = null;
        try {
/*
            // 注册 JDBC 驱动
            Class.forName(JDBC_DRIVER);

            // 打开链接
            System.out.println("连接数据库...");
            conn = DriverManager.getConnection(DB_URL,USER,PASS);
*/
            // 执行查询
            System.out.println(" 实例化Statement对象...");
            stmt = conn.createStatement();
            String sql;
            sql = "SELECT movieId,title,genres FROM movies limit 1000;";

            rs = stmt.executeQuery(sql);


            List<Movie> list = new ArrayList<Movie>();

            while(rs.next()){
                Movie movie = new Movie();

                int movieId  = rs.getInt("movieId");
                String title = rs.getString("title");
                String genres = rs.getString("genres");
                movie.setMovieId(movieId);
                movie.setTitle(title);
                movie.setGenres(genres);
                list.add(movie);
            }

            request.setAttribute("movie_list",list);
            rs.close();
            stmt.close();
            conn.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            JDBCTools.release(conn,stmt,rs);
        }

        request.getRequestDispatcher("movie_list.jsp").forward(request,response);
    }


}
