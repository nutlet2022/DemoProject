<%--
  Created by IntelliJ IDEA.
  User: WLJ
  Date: 2020/11/8
  Time: 22:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.movie.entity.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="com.movie.utils.JDBCTools" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!doctype html>
<html lang="en">

<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <title>首页</title>

  <!-- Template CSS -->
  <link rel="stylesheet" href="assets/css/style-starter.css">

  <!-- google fonts -->
</head>

<body class="sidebar-menu-collapsed">
<div class="se-pre-con" style="display: none;"></div>
<section>
  <!-- sidebar menu start -->
  <div class="sidebar-menu sticky-sidebar-menu">

    <!-- logo start -->
    <div class="logo">
      <h1><a href="index.html">电影院系统</a></h1>
    </div>

    <div class="sidebar-menu-inner">

      <div class="logo-icon text-center">
        <a href="index.jsp" title="logo" methods="get"><img src="assets/imgs/logo.png" alt="logo-icon"> </a>
      </div>
      <!-- sidebar nav start -->
      <ul class="nav nav-pills nav-stacked custom-nav">
        <li class="active"><a href="index.jsp" ><i class="fa fa-tachometer"></i><span> 用户预览</span></a>
        </li>
        <li><a href="movies?"><i class="fa fa-table"></i> <span>电影预览</span></a></li>
        <li><a href="popularmovies.jsp"><i class="fa fa-cogs"></i><span>电影推荐</span></a></li>
        <li><a href="rating.jsp"><i class="fa fa-th"></i> <span>特殊查询</span></a></li>
      </ul>
      <!-- //sidebar nav end -->
      <!-- toggle button start -->
      <a class="toggle-btn">
        <i class="fa fa-angle-double-left menu-collapsed__left"><span>隐藏</span></i>
        <i class="fa fa-angle-double-right menu-collapsed__right"></i>
      </a>
      <!-- //toggle button end -->
    </div>
  </div>
  <!-- //sidebar menu end -->
  <!-- header-starts -->
  <div class="header sticky-header">

    <!-- notification menu start -->
    <div class="menu-right">
      <div class="navbar user-panel-top">

      </div>
    </div>
  </div>
  <!--notification menu end -->
  </div>
  <!-- //header-ends -->
  <!-- main content start -->
  <div class="main-content">

    <!-- content -->
    <div class="container-fluid content-top-gap">


      <div class="welcome-msg pt-3 pb-4">
        <h1>用户预览</h1>

      </div>

      <!-- statistics data -->
      <!-- chatting -->
      <div class="data-tables">
        <div class="row">
          <div class="col-lg-12">
            <div class="card">
              <div class="card-header">
                <table>
                  <tr>
                    <td style="width:600px;" align="center">
                      用户id
                    </td>
                    <td style="width:600px;" align="center">性别</td>
                    <td style="width:600px;" align="center">姓名</td>
                  </tr>
                </table>
              </div>

              <div class="inbox_people">


                <div class="inbox_chat">

                  <table border="1">
                    <%
                      List<User> list = null;
                      Connection conn = JDBCTools.getConnection();
                      Statement stmt = null;
                      ResultSet rs = null;
                      try {
                        // 执行查询
                        System.out.println(" 实例化Statement对象...");
                        stmt = conn.createStatement();
                        String sql;
                        sql = "SELECT userId,gender,name FROM users2 \n" +
                                "UNION\n" +
                                "SELECT userId,gender,name FROM users1 ORDER BY userId ASC limit 1000; ";

                        rs = stmt.executeQuery(sql);


                        list = new ArrayList<User>();

                        while(rs.next()){
                          User user = new User();

                          int userId  = rs.getInt("userID");
                          String gender = rs.getString("gender");
                          String name = rs.getString("name");
                          user.setUserID(userId);
                          user.setGender(gender);
                          user.setName(name);
                          list.add(user);
                        }
                        rs.close();
                        stmt.close();
                        conn.close();

                      } catch (SQLException e) {
                        e.printStackTrace();
                      }finally {
                        JDBCTools.release(conn,stmt,rs);
                      }
                    if(list == null || list.size() <1){
                      out.print("没有数据，请重试！");
                    }else{
                      for(User user : list){
                  %>
                  <tr align="center">
                    <td style="width:600px;">
                      <%=user.getUserID()%>
                    </td>
                    <td style="width:600px;"><%=user.getGender()%></td>
                    <td style="width:600px;"><%=user.getName()%></td>
                  </tr>
                  <%
                      }
                    }
                  %>
                  </table>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

        <!-- //chatting -->
</section>
<!--footer section start-->
<footer class="dashboard">
  <h2>
    欢迎使电影院系统
  </h2>
</footer>
<!--footer section end-->
<!-- move top -->
<button onclick="topFunction()" id="movetop" class="bg-primary" title="Go to top">
  <span class="fa fa-angle-up"></span>
</button>
<script>
  // When the user scrolls down 20px from the top of the document, show the button
  window.onscroll = function () {
    scrollFunction()
  };

  function scrollFunction() {
    if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
      document.getElementById("movetop").style.display = "block";
    } else {
      document.getElementById("movetop").style.display = "none";
    }
  }

  // When the user clicks on the button, scroll to the top of the document
  function topFunction() {
    document.body.scrollTop = 0;
    document.documentElement.scrollTop = 0;
  }
</script>
<!-- /move top -->


<script src="assets/js/jquery-3.3.1.min.js"></script>

<!-- Different scripts of charts.  Ex.Barchart, Linechart -->
<script src="assets/js/bar.js"></script>
<script src="assets/js/linechart.js"></script>
<!-- //Different scripts of charts.  Ex.Barchart, Linechart -->


<script src="assets/js/jquery.nicescroll.js"></script>
<script src="assets/js/scripts.js"></script>

<!-- close script -->
<script>
  var closebtns = document.getElementsByClassName("close-grid");
  var i;

  for (i = 0; i < closebtns.length; i++) {
    closebtns[i].addEventListener("click", function () {
      this.parentElement.style.display = 'none';
    });
  }
</script>
<!-- //close script -->

<!-- disable body scroll when navbar is in active -->
<script>
  $(function () {
    $('.sidebar-menu-collapsed').click(function () {
      $('body').toggleClass('noscroll');
    })
  });
</script>
<!-- disable body scroll when navbar is in active -->

<!-- loading-gif Js -->
<script src="assets/js/modernizr.js"></script>
<script>
  $(window).load(function () {
    // Animate loader off screen
    $(".se-pre-con").fadeOut("slow");;
  });
</script>
<!--// loading-gif Js -->

<!-- Bootstrap Core JavaScript -->
<script src="assets/js/bootstrap.min.js"></script>

</body>

</html>
