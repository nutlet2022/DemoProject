<%--
  Created by IntelliJ IDEA.
  User: WLJ
  Date: 2020/11/8
  Time: 22:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.List" %>
<%@ page import="com.movie.entity.PoMovie" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--
Author: W3layouts
Author URL: http://w3layouts.com
-->
<!doctype html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <title>流行电影</title>

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
            <h1><a href="index.jsp">电影院系统</a></h1>
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
                <i class="fa fa-angle-double-left menu-collapsed__left"><span>隐藏侧栏</span></i>
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
                <h1>电影推荐</h1>

            </div>

            <!-- statistics data -->
            <!-- chatting -->
            <div class="data-tables">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="card">

                            <div class="search-box">
                                <form name="popular" method="post" action="popular">
                                    <input class="search-input" placeholder="风格" type="search" id="search" name="genres">
                                    <br>人群:&nbsp&nbsp
                                    <input type="radio" name="people"  value="all_degree.degree" >ALL &nbsp&nbsp&nbsp
                                    <input type="radio" name="people" value="all_degree.m_degree" class="search-input" placeholder="用户id" type="search">Male&nbsp&nbsp&nbsp
                                    <input type="radio" name="people" value="all_degree.f_degree" class="search-input" placeholder="用户id" type="search">Female &nbsp&nbsp
                                    <button class="search-submit" ><span class="fa fa-search"></span></button>
                                </form>
                            </div>

                            <div class="card-header">
                                <table>
                                    <tr>
                                        <td style="width:900px;" align="center">
                                            Title
                                        </td>
                                        <td style="width:900px;" align="center">Genres</td>
                                    </tr>
                                </table>
                            </div>

                            <div class="inbox_people">

                                <div class="inbox_chat">

                                    <table border="1">
                                        <%
                                            //获取所有用户信息
                                            List<PoMovie> list = (List<PoMovie>)request.getAttribute("pomovie_list");
                                            //判断集合是否有效


                                            if(list == null || list.size() <1){
                                                out.print("没有数据，请重试！");
                                            }else{
                                                for(PoMovie pomovie : list){
                                        %>
                                        <tr align="center">
                                            <td style="width:900px">
                                                <%=pomovie.getTitle()%>
                                            </td>
                                            <td style="width:900px;"><%=pomovie.getGenres()%></td>
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
