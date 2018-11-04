<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*"%>
<%@ page import="java.lang.*" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->
    <title>Todaydea</title>

    <!-- 부트스트랩 -->
    <link href="etc/css/bootstrap.min.css" rel="stylesheet">
    <!-- main.css -->
    <link href="etc/css/main.css" rel="stylesheet">

    <!-- IE8 에서 HTML5 요소와 미디어 쿼리를 위한 HTML5 shim 와 Respond.js -->
    <!-- WARNING: Respond.js 는 당신이 file:// 을 통해 페이지를 볼 때는 동작하지 않습니다. -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <link rel="favicon" href="http://52.78.185.92:8080/todaydea/etc/img/favicon.ico">
    <link href="https://fonts.googleapis.com/css?family=Nanum+Gothic|Nanum+Pen+Script" rel="stylesheet">
  </head>
<body>

<!-- ArrayList + StringTokenizer test -->
<%
	String temp = "abc;def;ghi;";
	ArrayList<String> al2 = new ArrayList<String>();
	
	StringTokenizer stn2 = new StringTokenizer(temp);
	
	while(stn2.hasMoreElements()) {
		String result2 = stn2.nextToken(";");
		al2.add(result2);
		System.out.println(al2);
	}
	System.out.println(al2.get(1));
%>

<!-- navbar -->
<nav class="navbar navbar-inverse navbar-fixed-top topbar">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="http://52.78.185.92:8080/todaydea"><img alt="메인" src="etc/img/naver.gif" class="topbarLogo"></a>
        </div>
        <div id="navbar" class="collapse navbar-collapse">
          <ul class="nav navbar-nav topbarManu">
            <li><a href=""><span class="glyphicon glyphicon-user topbar-hover" aria-hidden="true"></span></a></li>
            <li><a href=""><span class="glyphicon glyphicon-search topbar-hover" aria-hidden="true"></span></a></li>
            <li><a href="#contact"><span class="glyphicon glyphicon-envelope topbar-hover" aria-hidden="true"></span></a></li>
            <li><a href="#contact"><span class="glyphicon glyphicon-th topbar-hover" aria-hidden="true"></span></a></li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </nav>

	<!-- main container -->
	<div class="container mainName">
		<div class="starter-templete">
			<h1 style="color: #86694E;">TODAY'dea</h1>
			<br><br>
			<div class="lead" style="font-family: 'Nanum Pen Script', cursive;">
				<p>당신의 이야기가 세상의 이야기가 되는 곳,</p>
				<p>당신의 가치가 세상의 가치가 되는 곳,</p>
				<p>저희는 TODAY'dea입니다.</p>
			</div>
		</div>
	</div>

	<!-- content -->
	<div class="container">
		<div class="container">
			<div class="container day" id="day" style="padding: 0px; text-align: center;">
				<!-- <div class="col-md-2 col-xs-2 col-sm-2"></div> -->
				<div class="col-md-1 col-xs-1 col-sm-1" id="indexDayMon"><a href="http://localhost:8181/todaydea?day=mon">월요스토리</a></div>
				<div class="col-md-1 col-xs-1 col-sm-1" id="indexDayTue"><a href="http://localhost:8181/todaydea?day=tue">화요스토리</a></div>
				<div class="col-md-1 col-xs-1 col-sm-1" id="indexDayWed"><a href="http://localhost:8181/todaydea?day=wed">수요스토리</a></div>
				<div class="col-md-1 col-xs-1 col-sm-1" id="indexDayThu"><a href="http://localhost:8181/todaydea?day=thu">목요스토리</a></div>
				<div class="col-md-1 col-xs-1 col-sm-1" id="indexDayFri"><a href="http://localhost:8181/todaydea?day=fri">금요스토리</a></div>
				<!-- <div class="col-md-1 col-xs-1 col-sm-1"><a href="http://localhost:8181/todaydea?day=sat">토요일</a></div>
				<div class="col-md-1 col-xs-1 col-sm-1"><a href="http://localhost:8181/todaydea?day=sun">일요일</a></div>
				<div class="col-md-3 col-xs-3 col-sm-3"></div> -->
			</div>
		</div>
		
		
		<div class="container">
			<div class="row">
			
			
			<%
			String daytemp = "";
			String day = "";
			
			if(request.getParameter("day") == null) {
				daytemp = "mon";
				day = "";
			} else {
				daytemp = request.getParameter("day");
				day = "";
			}
			
			// 요일 인코딩
			if("mon".equals(daytemp)) {
				day = "월";
			} else if ("tue".equals(daytemp)) {
				day = "화";
			} else if ("wed".equals(daytemp)) {
				day = "수";
			} else if ("thu".equals(daytemp)) {
				day = "목";
			} else if ("fri".equals(daytemp)) {
				day = "금";
			} else if ("sat".equals(daytemp)) {
				day = "토";
			} else if ("sun".equals(daytemp)) {
				day = "일";
			}
			
			// 요일이 선택됐을때 강조, out을 통해 style 직접 적용
			if("mon".equals(daytemp)) {
				out.println("<style> #indexDayMon { font-weight: bold; border: 0px solid black; border-radius: 15px; background-color: #FFD9EC; } </style>");
			} else if ("tue".equals(daytemp)) {
				out.println("<style> #indexDayTue { font-weight: bold; border: 0px solid black; border-radius: 15px; background-color: #FFD9EC; } </style>");
			} else if ("wed".equals(daytemp)) {
				out.println("<style> #indexDayWed { font-weight: bold; border: 0px solid black; border-radius: 15px; background-color: #FFD9EC; } </style>");
			} else if ("thu".equals(daytemp)) {
				out.println("<style> #indexDayThu { font-weight: bold; border: 0px solid black; border-radius: 15px; background-color: #FFD9EC; } </style>");
			} else if ("fri".equals(daytemp)) {
				out.println("<style> #indexDayFri { font-weight: bold; border: 0px solid black; border-radius: 15px; background-color: #FFD9EC; } </style>");
			} else if ("sat".equals(daytemp)) {
				out.println("<style> #indexDaySat { font-weight: bold; border: 0px solid black; border-radius: 15px; background-color: #FFD9EC; } </style>");
			} else if ("sun".equals(daytemp)) {
				out.println("<style> #indexDaySun { font-weight: bold; border: 0px solid black; border-radius: 15px; background-color: #FFD9EC; } </style>");
			}
			
			
			// DB호출
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost:3306/todaydea";
			String id = "root";
			String pass = "root";
			
			try {
				Connection conn = DriverManager.getConnection(url, id, pass);
				PreparedStatement pstmt = conn.prepareStatement("SELECT NAME, CONTENTCHECK, imageName, MAX(hits) FROM content WHERE DAY = ? GROUP BY CONTENTCHECK;");
				pstmt.setString(1, day);
				ResultSet rs = pstmt.executeQuery();
				/*
				Statement stmt = conn.createStatement();
				
				String sqlList = "SELECT NAME, CONTENTCHECK FROM CONTENT WHERE DAY = '월' GROUP BY CONTENTCHECK;";
				ResultSet rs = stmt.executeQuery(sqlList);
				*/
				
				request.setCharacterEncoding("EUC-KR");
				
				while(rs.next()) {
					String name = rs.getString(1);
					int contentCheck = rs.getInt(2);
					String imageName = rs.getString(3);
					int hits = rs.getInt(4);
					
					ArrayList<String> al = new ArrayList<String>();
					StringTokenizer stn = new StringTokenizer(imageName);
					
					while(stn.hasMoreElements()) {
						al.add(stn.nextToken(";"));
					}
		%>
		
		
				<div class="col-md-4 col-xs-4 col-sm-4">
					<a href="http://localhost:8181/todaydea/select.jsp?contentCheck=<%=contentCheck %>">
					<div class="row col-md-12 col-xs-12 col-sm-12">
						<div class="col-md-12 col-xs-12 col-sm-12 imgIn"><img alt="이미지" src="content/<%=al.get(0) %>"></div>
						<div class="col-md-12 col-xs-12 col-sm-12 content EllipsText"><%=name %><p>조회수 : <%=hits %></div>
					</div>
					</a>
				</div>
				
				
		<%
				}
			} catch(SQLException e) {
				e.printStackTrace();
			}
		%>	
			
			</div>
		</div>
	</div>
	
	<!-- banner -->
	<div class="jumbotron">	
	<div class="container main_carousel">
				<div id="myCarousel" class="carousel slide" data-ride="carousel">
					<ol class="carousel-indicators">
						<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
						<li data-target="#myCarousel" data-slide-to="1"></li>
						<li data-target="#myCarousel" data-slide-to="2"></li>
					</ol>
					<div class="carousel-inner">
						<div class="item active">
							<img src="etc/img/banner.jpg">
						</div>
						<div class="item">
							<img src="etc/img/banner2.png">
						</div>
						<div class="item">
							<img src="etc/img/banner.jpg">
						</div>
					</div>
					<a class="left carousel-control" href="#myCarousel" data-slide="prev">
						<span class="glyphicon glyphicon-chevron-left"></span>
					</a>
					<a class="right carousel-control" href="#myCarousel" data-slide="next">
						<span class="glyphicon glyphicon-chevron-right"></span>
					</a>
				</div>
			</div>
	</div>
	
	
	<!-- footer -->
	<footer class="footer">
      <div class="container">
      	<div class="row">
      		이용약관 | 개인정보처리방침 | 책임의 한계와 법적고지 | 고객센터 | 광고 문의
      	</div>
      	<div class="row">
      		&copy; TODAYDEA CORP.
      	</div>
      	<div class="row">
      		본 콘텐츠의 저작권은 저자 또는 제공처에 있으며, 이를 무단 이용하는 경우 저작권법 등에 따라 법적 책임을 질 수 있습니다.
      	</div>
      </div>
    </footer>
	<!-- end footer -->

	<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
	<script src="etc/js/bootstrap.min.js"></script>
</body>
</html>