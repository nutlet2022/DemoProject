package com.movie.servelt;

import com.movie.entity.Rating;
import com.movie.utils.JDBCTools;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class RatingServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = JDBCTools.getConnection();
        PreparedStatement prstmt = null;
        ResultSet rs = null;
        int x = Integer.parseInt(request.getParameter("userId"));
        try {
            // 执行查询
            //System.out.println(" 实例化Statement对象...");
            String sql;
            sql = "select A.title,A.rating,A.relevance,genome_tags.tag\n" +
                    "from\n" +
                    "(SELECT\n" +
                    "movies.title,rating,relevance,userId, tagId as newtagId\n" +
                    "FROM genome_scores,ratings,movies\n" +
                    "where genome_scores.movieId = ratings.movieId and movies.movieId =\n" +
                    "ratings.movieId ORDER BY timestamp desc) A,\n" +
                    "genome_tags where A.newtagId = genome_tags.tagId\n" +
                    "and A.userId=?;\n";
            prstmt = conn.prepareStatement(sql);

            prstmt.setInt(1,x);
            rs = prstmt.executeQuery();



            List<Rating> list = new ArrayList<Rating>();

            while(rs.next()){
                Rating rating = new Rating();

                String title  = rs.getString("title");
                float rating1 = rs.getFloat("rating");
                float relevance = rs.getFloat("relevance");
                String tag = rs.getString("tag");

                rating.setTitle(title);
                rating.setRating(rating1);
                rating.setRelevance(relevance);
                rating.setTag(tag);
                list.add(rating);
            }

            request.setAttribute("rating_list",list);
            rs.close();
            prstmt.close();
            conn.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            JDBCTools.release(conn,prstmt,rs);
        }

        request.getRequestDispatcher("rating.jsp").forward(request,response);
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
            //System.out.println(" 实例化Statement对象...");
            stmt = conn.createStatement();
            String sql;
            sql = "select A.title,A.rating,A.relevance,genome_tags.tag\n" +
                    "from\n" +
                    "(SELECT\n" +
                    "movies.title,rating,relevance,userId, tagId as newtagId\n" +
                    "FROM genome_scores,ratings,movies\n" +
                    "where genome_scores.movieId = ratings.movieId and movies.movieId =\n" +
                    "ratings.movieId ORDER BY timestamp desc) A,\n" +
                    "genome_tags where A.newtagId = genome_tags.tagId\n" +
                    "and A.userId=1;\n";

            rs = stmt.executeQuery(sql);


            List<Rating> list = new ArrayList<Rating>();

            while(rs.next()){
                Rating rating = new Rating();

                String title  = rs.getString("title");
                float rating1 = rs.getFloat("rating");
                float relevance = rs.getFloat("relevance");
                String tag = rs.getString("tag");

                rating.setTitle(title);
                rating.setRating(rating1);
                rating.setRelevance(relevance);
                rating.setTag(tag);
                list.add(rating);
            }

            request.setAttribute("rating_list",list);
            rs.close();
            stmt.close();
            conn.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            JDBCTools.release(conn,stmt,rs);
        }

        request.getRequestDispatcher("rating.jsp").forward(request,response);
    }


}
