<%@page import="java.util.StringTokenizer"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
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
  </head>
<body>

<%
	ArrayList<String> al = new ArrayList<String>();
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
	<div class="container select">
	<div class="row">
		<div class="col-md-8 col-xs-8 col-sm-8" style="height:100%;">
			<div class="row">
				<!-- 요일 -->
				<div class="col-md-12 col-xs-12 col-sm-12 day">
					<div class="col-md-1 col-xs-1 col-sm-1"><a href="http://localhost:8181/todaydea?day=mon">월요스토리</a></div>
					<div class="col-md-1 col-xs-1 col-sm-1"><a href="http://localhost:8181/todaydea?day=tue">화요스토리</a></div>
					<div class="col-md-1 col-xs-1 col-sm-1"><a href="http://localhost:8181/todaydea?day=wed">수요스토리</a></div>
					<div class="col-md-1 col-xs-1 col-sm-1"><a href="http://localhost:8181/todaydea?day=thu">목요스토리</a></div>
					<div class="col-md-1 col-xs-1 col-sm-1"><a href="http://localhost:8181/todaydea?day=fri">금요스토리</a></div>
					<!-- <div class="col-md-1 col-xs-1 col-sm-1"><a href="http://localhost:8181/todaydea?day=sat">토요일</a></div>
					<div class="col-md-1 col-xs-1 col-sm-1"><a href="http://localhost:8181/todaydea?day=sun">일요일</a></div> -->
				</div>
				<!-- 작품 소개 -->
				<div class="col-md-12 col-xs-12 col-sm-12" style="height: 150px;">
				
				
					<!-- DB 호출 -->
					<%
						int contentCheck = Integer.parseInt(request.getParameter("contentCheck"));
					
						Class.forName("com.mysql.jdbc.Driver");
						String url = "jdbc:mysql://localhost:3306/todaydea";
						String id = "root";
						String pass = "root";
						
						try {
							Connection conn = DriverManager.getConnection(url, id, pass);
							PreparedStatement pstmt = conn.prepareStatement("SELECT CONTENTCHECK, NAME, INTRO, imageName FROM CONTENT WHERE CONTENTCHECK = ? GROUP BY CONTENTCHECK;");
							
							pstmt.setInt(1, contentCheck);
							ResultSet rs = pstmt.executeQuery();
							
							request.setCharacterEncoding("EUC-KR");
							
							while(rs.next()) {
								contentCheck = rs.getInt(1);
								String name = rs.getString(2);
								String intro = rs.getString(3);
								String imageName = rs.getString(4);
								
								StringTokenizer stn = new StringTokenizer(imageName);
								
								while(stn.hasMoreTokens()) {
									al.add(stn.nextToken(";"));
								}
					%>
				
				
					<!-- 작품 이미지 -->
					<div class="col-md-2 col-xs-2 col-sm-2" style="height: 100px; margin-top: 25px; margin-bottom: 25px; width: 150px;">
						<img alt="썸네일" src="content/<%=al.get(0) %>" style="width: 100%; height: 100%;">
					</div>
					<!-- 여백 -->
					<div class="col-md-1 col-xs-1 col-sm-1">
					</div>
					<!-- 작품 설명 -->
					<div class="col-md-9 col-xs-9 col-sm-9" style="height: 100px; margin-top: 25px; margin-bottom: 25px;">
						<div class="col-md-12 col-xs-12 col-sm-12" style="height: 30%">
						<%=name %>
						</div>
						<div class="col-md-12 col-xs-12 col-sm-12" id="content_sub" style="height: 70%; display: table;">
							<div style="display: table-cell; vertical-align: middle;">
								<%=intro %>
							</div>
						</div>
					</div>
					
					
					<%
							}
						} catch(SQLException e) {
							e.printStackTrace();
						}
					%>
					
					
				</div>
				<!-- 회차 소개 -->
				<div class="col-md-12 col-xs-12 col-sm-12" id="epi_intro" style="height: 50px;">
					<!-- 이미지 -->
					<div class="col-md-1 col-xs-1 col-sm-1 intro">이미지
					</div>
					<!-- 제목 -->
					<div class="col-md-6 col-xs-6 col-sm-6 intro">제목
					</div>
					<!-- 별점 -->
					<div class="col-md-2 col-xs-2 col-sm-2 intro">별점
					</div>
					<!-- 등록일 -->
					<div class="col-md-2 col-xs-2 col-sm-2 intro" id="regi">등록일
					</div>
				</div>
				<!-- 회차 목록 -->
				<div class="col-md-12 col-xs-12 col-sm-12" style="height: 100%;">
				
				
					<%
						try {
							// SimpleDateFormat 객체 생성. 날짜 표기형식 "yyyy-MM-dd"
							SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
							Date day = new Date();
							
							Connection conn = DriverManager.getConnection(url, id, pass);
							PreparedStatement pstmt = conn.prepareStatement("SELECT CONTENTINDEX, CONTENTNAME, STAR, UPLOADDATE, imageName FROM content WHERE CONTENTCHECK = ?;");
							
							pstmt.setInt(1, contentCheck);
							ResultSet rs = pstmt.executeQuery();
							
							while(rs.next()) {
								int contentIndex = rs.getInt(1);
								String contentName = rs.getString(2);
								float star = rs.getFloat(3);
								/* String uploadDate = String.valueOf(rs.getTimestamp(4)); */
								day = rs.getTimestamp(4);
								String imageName = rs.getString(5);
								
								StringTokenizer stn = new StringTokenizer(imageName);
								
								al.clear();
								while(stn.hasMoreTokens()) {
									al.add(stn.nextToken(";"));
								}
										
					%>
				
				
					<a href="http://localhost:8181/todaydea/view.jsp?contentCheck=<%=contentCheck %>&contentIndex=<%=contentIndex%>">
					<div class="row">
						<!-- 이미지 -->
						<div class="col-md-1 col-xs-1 col-sm-1 content"><img alt="썸네일" src="content/<%=al.get(1)%>">
						</div>
						<!-- 제목 -->
						<div class="col-md-6 col-xs-6 col-sm-6 content"><%=contentName %>
						</div>
						<!-- 별점 -->
						<div class="col-md-2 col-xs-2 col-sm-2 content" id="star_con"><%=star %>
						</div>
						<!-- 등록일 -->
						<div class="col-md-2 col-xs-2 col-sm-2 content" id="regi_con"><%=sdf.format(day) %>
						</div>
					</div>
					</a>
					
					
					<%
							}
						} catch(SQLException e) {
							e.printStackTrace();
						}
					%>
					
					
					<div class="row">
						<!-- 이미지 -->
						<div class="col-md-1 col-xs-1 col-sm-1 content"><img alt="썸네일" src="etc/img/thumb.jpg">
						</div>
						<!-- 제목 -->
						<div class="col-md-6 col-xs-6 col-sm-6 content">미아
						</div>
						<!-- 별점 -->
						<div class="col-md-2 col-xs-2 col-sm-2 content" id="star_con">9.97
						</div>
						<!-- 등록일 -->
						<div class="col-md-2 col-xs-2 col-sm-2 content" id="regi_con">2018.09.07
						</div>
					</div>
					<div class="row">
						<!-- 이미지 -->
						<div class="col-md-1 col-xs-1 col-sm-1 content"><img alt="썸네일" src="etc/img/thumb.jpg">
						</div>
						<!-- 제목 -->
						<div class="col-md-6 col-xs-6 col-sm-6 content">미아
						</div>
						<!-- 별점 -->
						<div class="col-md-2 col-xs-2 col-sm-2 content" id="star_con">5.89
						</div>
						<!-- 등록일 -->
						<div class="col-md-2 col-xs-2 col-sm-2 content" id="regi_con">2018.09.07
						</div>
					</div>
					<div class="row">
						<!-- 이미지 -->
						<div class="col-md-1 col-xs-1 col-sm-1 content"><img alt="썸네일" src="etc/img/thumb.jpg">
						</div>
						<!-- 제목 -->
						<div class="col-md-6 col-xs-6 col-sm-6 content">나야
						</div>
						<!-- 별점 -->
						<div class="col-md-2 col-xs-2 col-sm-2 content" id="star_con">9.99
						</div>
						<!-- 등록일 -->
						<div class="col-md-2 col-xs-2 col-sm-2 content" id="regi_con">2018.09.07
						</div>
					</div>
					<div class="row">
						<!-- 이미지 -->
						<div class="col-md-1 col-xs-1 col-sm-1 content"><img alt="썸네일" src="etc/img/thumb.jpg">
						</div>
						<!-- 제목 -->
						<div class="col-md-6 col-xs-6 col-sm-6 content">나야나
						</div>
						<!-- 별점 -->
						<div class="col-md-2 col-xs-2 col-sm-2 content" id="star_con">1.08
						</div>
						<!-- 등록일 -->
						<div class="col-md-2 col-xs-2 col-sm-2 content" id="regi_con">2018.09.07
						</div>
					</div>
				</div>
				<!-- 회차 목록 끝-->
				
				<!-- 작품 순서 -->
				<div class="col-md-12 col-xs-12 col-sm-12" style="height: 50px;">
					<div class="order">
						<div class="col-md-4 col-xs-4 col-sm-4" id="order1"></div>
						<div class="col-md-4 col-xs-4 col-sm-4" id="order2">
						1&nbsp;&nbsp;2&nbsp;&nbsp;3&nbsp;&nbsp;4&nbsp;&nbsp;5&nbsp;&nbsp;6&nbsp;&nbsp;7&nbsp;&nbsp;8&nbsp;&nbsp;9&nbsp;&nbsp;10&nbsp;&nbsp;다음>
						</div>
						<div class="col-md-4 col-xs-4 col-sm-4" id="order3"></div>
					</div>
				</div>
				<!-- 작품 순서 끝-->
		</div>
		</div>
		
		<!-- 광고 영역 -->
		<div class="col-md-4 col-xs-4 col-sm-4" style="height: 100%;">
			<div class="row">
				<div class="col-md-12 col-xs-12 col-sm-12" style="height: 200px;">
					<img alt="광고" src="etc/img/ad1.jpg">
				</div>
			</div>
			<div class="row">
				<div class="col-md-12 col-xs-12 col-sm-12" style="height:100px;">
					<img alt="광고" src="etc/img/ad2.jpg">
				</div>
			</div>
			<div class="row">
				<div class="col-md-12 col-xs-12 col-sm-12" style="height:100px;">
					<img alt="광고" src="etc/img/ad3.jpg">
				</div>
			</div>
		</div>
		<!-- 광고 영역 끝 -->
		</div>
	</div>



		<!-- footer -->
		<footer class="footer">
			<div class="container">
				<div class="row">이용약관 | 개인정보처리방침 | 책임의 한계와 법적고지 | 고객센터 | 광고 문의
				</div>
				<div class="row">&copy; TODAYDEA CORP.</div>
				<div class="row">본 콘텐츠의 저작권은 저자 또는 제공처에 있으며, 이를 무단 이용하는 경우
					저작권법 등에 따라 법적 책임을 질 수 있습니다.</div>
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