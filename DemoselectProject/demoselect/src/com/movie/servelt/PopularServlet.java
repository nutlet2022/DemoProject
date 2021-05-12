package com.movie.servelt;
import com.movie.entity.PoMovie;
import com.movie.utils.JDBCTools;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class PopularServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = JDBCTools.getConnection();
        PreparedStatement prstmt = null;
        ResultSet rs = null;
        String style= request.getParameter("genres");
        String type = request.getParameter("people");

        try {
            // 执行查询

            String sql;
            sql = "select movies.title,movies.genres\n" +
                    "from movies,all_degree\n" +
                    "where movies.movieId=all_degree.movieId\n" +
                    "and movies.genres like \'%" + style +"%\'\n" +
                    "group by movies.movieId\n" +
                    "order by "+ type +" desc limit 20;\n";


            if(type == null){
                type ="all_degree.degree";
            }
            prstmt = conn.prepareStatement(sql);

            //prstmt.setString(1,type);
            System.out.println(sql);
            rs = prstmt.executeQuery();



            List<PoMovie> list = new ArrayList<PoMovie>();

            while(rs.next()){
                PoMovie pomovie = new PoMovie();
                String title = rs.getString("title");
                String genres = rs.getString("genres");
                pomovie.setTitle(title);
                pomovie.setGenres(genres);
                list.add(pomovie);
            }

            request.setAttribute("pomovie_list",list);
            rs.close();
            prstmt.close();
            conn.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            JDBCTools.release(conn,prstmt,rs);
        }

        request.getRequestDispatcher("popularmovies.jsp").forward(request,response);
    }

}
