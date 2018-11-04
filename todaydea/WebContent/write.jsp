<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
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


<style type="text/css">
/* 위쪽 여백 */
div.container {
	margin-top: 50px;
}
div.container div.col-md-10.col-xs-10.col-sm-10 {
	border-left-style: solid;
}
/* 표 간격 */
div.container table tr th, 
div.container table tr td {
	width: 150px;
	text-align: center;
}
</style>

<%
	request.setCharacterEncoding("EUC-KR");
	String content = request.getParameter("content");
	String daytemp = request.getParameter("day");
	String day = "";
	
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


%>

<div class="container">
	<div class="col-md-2 col-xs-2 col-sm-2">
		<div class="col-md-12 col-xs-12 col-sm-12">
			<a href="http://localhost:8181/todaydea/adminPage.jsp">전체글보기</a>
		</div>
		<div class="col-md-12 col-xs-12 col-sm-12">
			<a href="http://localhost:8181/todaydea/writeSelect.jsp">글쓰기</a>
		</div>
	</div>
	<div class="col-md-10 col-xs-10 col-sm-10">
	
	
	<%
		if("new".equals(content)) {
	%>
	
	
		<h3>신규 작품 등록</h3>
		<br>
		<form action="writeImage.jsp" method="post">
		요일 : 
		<select name="day">
			<option value="" selected="selected">요일선택</option>
			<option value="mon">월요일</option>
			<option value="tue">화요일</option>
			<option value="wed">수요일</option>
			<option value="thu">목요일</option>
			<option value="fri">금요일</option>
			<option value="sat">토요일</option>
			<option value="sun">일요일</option>
		</select>
		<br><br>
		제목 : 
		<input type="text" name="name">
		<br><br>
		작품 소개 : 
		<input type="text" name="intro">
		<br><br>
		작품 회차 제목 : 
		<input type="text" name="contentName">
		<br><br>
		작품 내용의 이미지 갯수(ex 1) : 
		<input type="text" name="image">
		<br><br>
		<input type="hidden" name="content" value=<%=content %>>
		<input type="hidden" name="maxContentIndex" value=1>
		<input type="hidden" name="contentCheck" value=1>
		<input type="submit" value="다음">
		</form>
		
		
	<%
		} else if("old".equals(content)) {
	%>
		

		<h3>기존 작품 등록</h3>
		<br>
		
		
		<%
			// 기존 작품 정보 가져오기
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost:3306/todaydea";
			String id = "root";
			String pass = "root";
			
			try {
				Connection conn = DriverManager.getConnection(url, id, pass);
				PreparedStatement pstmt = conn.prepareStatement("SELECT name, contentCheck FROM content WHERE day = ? GROUP BY name;");
				
				pstmt.setString(1, day);
				ResultSet rs = pstmt.executeQuery();
				
				while(rs.next()) {
					String name = rs.getString(1);
					int contentCheck = rs.getInt(2);
		%>
		
		<input type="button" value="<%=name%>" onclick="location='write2.jsp?content=<%=content%>&day=<%=daytemp%>&name=<%=name%>&contentCheck=<%=contentCheck%>'">
		<br><br>
		
	<%
				}
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
	%>
	
	
	</div>
</div>

<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
		<script
			src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
		<!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
		<script src="etc/js/bootstrap.min.js"></script>
</body>
</html>