#### 1.连接远程数据库的方法

##### 环境

- windows10                               命令行工具 已安装mysql数据库，配置mysql的环境变量
- ubuntu 16.04                            mysql  cluster（虚拟机）
  - ipaddress 192.168.192.170 管理/数据节点
  - ipaddress 192.168.192.169 数据节点

##### 前提

- ubuntu16.04             

  - mysql服务正常运行
  - 两台虚拟机之间能够互相通信

  - mysql管理节点能顾与windows 10宿主机连接通信

- windows 10              能够ping通虚拟机



###### ubuntu 16.04

- 新建用户mysqlzero      密码123456
- 分配权限

```mysql
mysql> CREATE USER 'mysqlzero'@'%' IDENTIFIED BY '123456';
       ---- mysqlzero 为用户名  % 为该用户可任意ip地址进行访问     ‘123456’为密码
mysql> GRANT ALL ON *.* TO 'mysqlzero'@'%';
       ---- 分配所有权限 ALL 包含UPDATE INSERT DELETE SELECT    *.* 表示对任何数据库 其余参数同上
mysql> FLUSH PRIVILEGES;
       ---- 立即刷新权限配置
       
```

##### windows 10 远端访问

- 使用workbench 

  - 新建连接  命名test
  - 输入ip 地址  端口号  用户名
  - store in valut    输入密码并保存，以便下次再次输入密码

  ![image-20201107095036003](readme_imgs\image-20201107095036003.png)

- 使用命令行方式

  - 确保 **mysql 命令** 配置环境变量
  - 使用客户端访问

  ```mysql
  C:> mysql -h localhost  -u mysqlzero -p  #进入mql服务
  Enter password:123456
  mysql>show datebases;
        --- 显示数据库
  mysql>use datebase;
        --- 使用数据库database
  ```

  

##### 验证

- Ubuntu 16.04

  ``` mysql
  mysql$  mysql -h localhost  -u mysqlzero -p  #进入mql服务
  Enter password:123456
  mysql>show datebases;
        --- 显示数据库
  mysql>use datebase;
        --- 使用数据库database
  ```

- windows 10
  ![image-20201107095606180](readme_imgs\image-20201107095606180.png)



##### 所遇到问题

宿主机不能与虚拟机 ping 通
		解决方法：
				进入windows 10控制面板 -->  更改网络适配器   -->   重启vnet8（NAT模式的网卡）

#### 2.将csv文件导入数据库

##### 所遇难题

- 之前数据库导出的csv为ANSI编码格式，属性值包含中文，采用 mysql workbench 进行数据导入会出现中文乱码问题；原因 ：csv 文件 与导入编码格式不符
- 解决思路
  - 更换 csv 编码 方法
  - 采用 navicat 工具进行数据的导入

- 采用navicat方法进行导入
  ![](readme_imgs\navicat_import.gif)
  - 选中数据库  选表格 右键 import
  - 选择文件格式 csv
  - 设置编码格式  需与csv文件保持一致
  - 选中表格 设置主键等

- 采用上述方法，按照设计好的数据结构将需要导入的csv文件导入

#### 3、使用java jdbc连接数据库

##### 查看mysql版本

``` 
mysql@~: mysql -V
```

参考连接方法：

[java Mysql连接]: （https://www.runoob.com/java/java-mysql-connect.html

> Mysql 8.0 版本以上的连接有所不同
>
> - 1、MySQL 8.0 以上版本驱动包版本 [mysql-connector-java-8.0.16.jar](https://static.runoob.com/download/mysql-connector-java-8.0.16.jar)。
> - 2、**com.mysql.jdbc.Driver** 更换为 **com.mysql.cj.jdbc.Driver**。
> - MySQL 8.0 以上版本不需要建立 SSL 连接的，需要显示关闭。
> - allowPublicKeyRetrieval=true 允许客户端从服务器获取公钥。
> - 最后还需要设置 CST。
>
> 加载驱动与连接数据库方式如下：
>
> ```java
> Class.forName("com.mysql.cj.jdbc.Driver");
> conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/test_demo?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC","root","password");
> ```

##### 进行测试连接

1. 创建数据库 新增表格数据

   ``` mysql
   CREATE DATABASE runoob;
   use runoob;
   -- 建立表格
   CREATE TABLE `websites` (
     `id` int(11) NOT NULL AUTO_INCREMENT,
     `name` char(20) NOT NULL DEFAULT '' COMMENT '站点名称',
     `url` varchar(255) NOT NULL DEFAULT '',
     `alexa` int(11) NOT NULL DEFAULT '0' COMMENT 'Alexa 排名',
     `country` char(10) NOT NULL DEFAULT '' COMMENT '国家',
     PRIMARY KEY (`id`)
   ) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
   
   -- 插入一些测试值
   INSERT INTO `websites` VALUES ('1', 'Google', 'https://www.google.cm/', '1', 'USA'), ('2', '淘宝', 'https://www.taobao.com/', '13', 'CN'), ('3', '菜鸟教程', 'http://www.runoob.com', '5892', ''), ('4', '微博', 'http://weibo.com/', '20', 'CN'), ('5', 'Facebook', 'https://www.facebook.com/', '3', 'USA');
   ```

2. 建立java工程

3. 导入 jar 包
   [mysql-connector-java-8.0.11.jar](lib)

4. 代码

   ``` java
   package com.database.util;
   import java.sql.*;
   
   
   public class MySQLDemo {
   
       // MySQL 8.0 以下版本 - JDBC 驱动名及数据库 URL
       //static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
       //static final String DB_URL = "jdbc:mysql://192.168.192.170:3306/RUNOOB";
   
       // MySQL 8.0 以上版本 - JDBC 驱动名及数据库 URL
       static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
       static final String DB_URL = "jdbc:mysql://192.168.192.170:3306/runoob?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
       //static final String DB_URL = "jdbc:mysql://192.168.192.170:3306/RUNOOB?useUnicode=true&characterEncoding=UTF-8&zeroDateTimeBehavior=convertToNull&allowMultiQueries=true";
   
   
       // 数据库的用户名与密码，需要根据自己的设置
       static final String USER = "mysqlzero";
       static final String PASS = "123456";
   
       public static void main(String[] args) {
           Connection conn = null;
           Statement stmt = null;
           try{
               // 注册 JDBC 驱动
               Class.forName(JDBC_DRIVER);
   
               // 打开链接
               System.out.println("连接数据库...");
               conn = DriverManager.getConnection(DB_URL,USER,PASS);
   
               // 执行查询
               System.out.println(" 实例化Statement对象...");
               stmt = conn.createStatement();
               String sql;
               sql = "SELECT id, name, url FROM websites";
               ResultSet rs = stmt.executeQuery(sql);
   
               // 展开结果集数据库
               while(rs.next()){
                   // 通过字段检索
                   int id  = rs.getInt("id");
                   String name = rs.getString("name");
                   String url = rs.getString("url");
   
                   // 输出数据
                   System.out.print("ID: " + id);
                   System.out.print(", 站点名称: " + name);
                   System.out.print(", 站点 URL: " + url);
                   System.out.print("\n");
               }
               // 完成后关闭
               rs.close();
               stmt.close();
               conn.close();
           }catch(SQLException se){
               // 处理 JDBC 错误
               se.printStackTrace();
           }catch(Exception e){
               // 处理 Class.forName 错误
               e.printStackTrace();
           }finally{
               // 关闭资源
               try{
                   if(stmt!=null) stmt.close();
               }catch(SQLException se2){
               }// 什么都不做
               try{
                   if(conn!=null) conn.close();
               }catch(SQLException se){
                   se.printStackTrace();            }
           }
           System.out.println("Goodbye!");
       }
   }
   ```
   
##### JDBC   

   - 全称 Java DataBase Connectivity，是一套面向对象的应用程序接口，指定统一的访问关系型数据库的标准接口
     - 与数据库建立连接
     - 向数据库发送SQL语句
     - 处理从数据库返回的结果
   - 需要嵌入sql语句进行对数据的增、删、查、改

##### ODBC 

- Open DataBase Connectivity， 开放数据库互联

  > [微软公司](https://baike.baidu.com/item/微软公司/732128)开放服务结构(WOSA，Windows Open Services Architecture)中有关数据库的一个组成部分，它建立了一组规范，并提供了一组对数据库访问的标准[API](https://baike.baidu.com/item/API/10154)（[应用程序编程接口](https://baike.baidu.com/item/应用程序编程接口/3350958)）。这些API利用SQL来完成其大部分任务。ODBC本身也提供了对SQL语言的支持，用户可以直接将SQL语句送给[ODBC](https://baike.baidu.com/item/ODBC/759553)。一组数据的位置，可以使用 ODBC[驱动程序](https://baike.baidu.com/item/驱动程序)访问该位置

#### 3、访问 movie 数据库的 users 表

[users.sql](lib/)

- 将  users.sql 文件导入数据库


**测试**

``` java
package com.database.util; 
import java.sql.*;


public class MySQLDemo {

    // MySQL 8.0 以下版本 - JDBC 驱动名及数据库 URL
    //static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    //static final String DB_URL = "jdbc:mysql://192.168.192.170:3306/RUNOOB";

    // MySQL 8.0 以上版本 - JDBC 驱动名及数据库 URL
    static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    static final String DB_URL = "jdbc:mysql://192.168.192.170:3306/movie?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    //static final String DB_URL = "jdbc:mysql://192.168.192.170:3306/RUNOOB?useUnicode=true&characterEncoding=UTF-8&zeroDateTimeBehavior=convertToNull&allowMultiQueries=true";


    // 数据库的用户名与密码，需要根据自己的设置
    static final String USER = "mysqlzero";
    static final String PASS = "123456";

    public static void main(String[] args) {
        Connection conn = null;
        Statement stmt = null;
        try{
            // 注册 JDBC 驱动
            Class.forName(JDBC_DRIVER);

            // 打开链接
            System.out.println("连接数据库...");
            conn = DriverManager.getConnection(DB_URL,USER,PASS);

            // 执行查询
            System.out.println(" 实例化Statement对象...");
            stmt = conn.createStatement();
            String sql;
            sql = "SELECT * FROM users";
            ResultSet rs = stmt.executeQuery(sql);

            // 展开结果集数据库
            while(rs.next()){
                // 通过字段检索
                int userId  = rs.getInt("userID");
                String gender = rs.getString("gender");
                String name = rs.getString("name");

                // 输出数据
                System.out.print("ID: " + userId);
                System.out.print(", 性别: " + gender);
                System.out.print(", 姓名: " + name);
                System.out.print("\n");
            }
            // 完成后关闭
            rs.close();
            stmt.close();
            conn.close();
        }catch(SQLException se){
            // 处理 JDBC 错误
            se.printStackTrace();
        }catch(Exception e){
            // 处理 Class.forName 错误
            e.printStackTrace();
        }finally{
            // 关闭资源
            try{
                if(stmt!=null) stmt.close();
            }catch(SQLException se2){
            }// 什么都不做
            try{
                if(conn!=null) conn.close();
            }catch(SQLException se){
                se.printStackTrace();
            }
        }
        System.out.println("Goodbye!");
    }
}
```

#### 4、Servlet

**简介**

Java Servlet 是运行在Web服务器上的程序，它是作为来自Web 浏览器或其他HTTP客户端的请求和HTTP服务器傻瓜的数据库或应用程序的中间层。

使用Servlet，程序在收集来自网页表单的用户的输入，呈现来自数据库或者其他源的记录，同时可以动态创建网页。

**Servlet架构**
![Servlet 架构](https://www.runoob.com/wp-content/uploads/2014/07/servlet-arch.jpg)
**任务**

- 读取客户端（浏览器）发送的显示数据，包括网页上的HTML表单，或者也可以来自applet（小程序）或自定义HTTP客户端程序的表单。
- 读取客户端（浏览器）发送的隐式HTTP请求数据，包括cookies，媒体类型和浏览器能理解的压缩格式等。
- 处理数据并生成结果。这个过程可能需要访问数据库，执行RMI或CORBA调用，调用Web服务，或者直接计算得出对应响应。
- 发送显示数据（文档）到客户端（浏览器）。改文档的格式可以是多种多样，包括文本文件（HTML或XML）、二进制文件（GIF图像）、Excel等，本次实验中我们用到了对数据库的操作。
- 发送隐式的HTTP响应到客户端（浏览器）。包括告诉浏览器或者其他客户端被返回的文档类型如HTML，设置cookies和缓存参数，以及其他类似任务。

#### 5、 JSP

JSP 与PHP、ASP、ASP。NET等语言类似，运行在服务端的语言。

JSP 全称java server pages ，是由Sun Mirosystem公司倡导许多工地参与共同创建的一种使软件开发者可以响应客户端请求，而动态生成HTML、XML或者其他格式文档的Web网页的技术标准。

JSP技术以Java语言为脚本语言，JSP网页为整个服务器端的Java库单元提供了一个接口来服务于HTTP的应用程序。

JSP开发的Web应用可以跨平台使用既可以运行在Linux上，也能运行在Windows上，这当然也与Java的跨平台性密切相关。

#### 6、Tomcat

Servlet容器

参考：https://blog.csdn.net/qq_36119192/article/details/84279392
			https://www.jianshu.com/p/7f27b2362f62
			菜鸟教程等

#### 7 、项目说明

**所用方式**
Tomcat+Servlet+JSP

![查看源图像](https://tse2-mm.cn.bing.net/th/id/OIP.dhpqkYlT3flWUzDfDT7LEQHaDw?pid=Api&rs=1)

##### 项目介绍

该项目主要通过java的jdbc接口实现对数据库连接，进行简单的查询操作，通过servlet+jsp方式，将查询结果显示在浏览器页面上。

##### 环境依赖：

- idea 2020.02
- java SE 12
- tomcat 9.0.1

##### 目录结构

├── Readme.md               					   // help
├── out                        							 // 输出
├── src                    								 // 配置
│   ├── come.movie
│   		├──entity                // 实例对象
│   				├── Movie        				  // 电影类
│   				├── PoMovie         			// 流行电影类
│   				├── Rating				         // 评分类
│   				├── User       					 // 用户类 
│   		├── servlet              				  // Servlet，用于响应页面请求
│   				├── MovieServlet      	   // 响应用户关键词查询电影
│   				├── PopularServlet         // 响应流行电影查询请求
│   				├── RatingsServle           // 响应A
│   		├── utils              				     // 工具类
│   				├── JDBCTools      	      // 用于连接数据库
│   └── c3p0-config.xml                      // 数据库申请配置 
├──web                								 // web项目主体
│   ├── assets
│   		├──css                                     // css布局
│   		├──fonts                                 // 字体，等
│   		├──imgs                                  // 图片
│   		├──js                                       // js以及jqueary插件
│   ├── WEB-INF								 
│   		├── lib									//依赖包
│   		├── web.xml						 //配置说明
│   ├── index.jsp								//首页，用户预览页
│   ├── movie_list.jsp                  	  //电影预览，关键词查询
│   ├── ratings.jsp							 //用户所看电影评分页
│   └── popularmovies.jsp      	    //流行电影推荐

##### 使用方法

- 修改c3p0-config中的配置信息：如用户名，密码，实现连接数据库

- 通过 idea 将项目布置到tomcat服务器，使用浏览器访问配置路径即可

##### 存在问题

- 未编写过滤器，对浏览器表单 get post 方法发送的数据处理存在问题
- 未将项目结构进行优化，如增加接口类等

##### 使用示例

![](readme_imgs\demoselect.gif)
![](readme_imgs\demoselect1.gif)

