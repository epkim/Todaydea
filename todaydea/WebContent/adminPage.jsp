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
    <link rel="favicon" href="http://localhost:8080/todaydea/etc/img/favicon.ico">
  </head>
<body>

<!-- style test -->
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

<!-- main container -->
<div class="container">
	<!-- menu -->
	<div class="col-md-2 col-xs-2 col-sm-2">
		<div class="col-md-12 col-xs-12 col-sm-12">
			<a href="http://localhost:8181/todaydea/adminPage.jsp">전체글보기</a>
		</div>
		<div class="col-md-12 col-xs-12 col-sm-12">
			<a href="http://localhost:8181/todaydea/writeSelect.jsp">글쓰기</a>
		</div>
	</div>
	<!-- data view -->
	<div class="col-md-10 col-xs-10 col-sm-10">
		<table>
			<tr>
				<th>작품순서</th>
				<th>요일</th>
				<th>제목</th>
				<th>소개</th>
				<th>회차번호</th>
				<th>회차제목</th>
				<th>별점</th>
				<th>업로드시간</th>
				<th>이미지 갯수</th>
				<th>작품 고유번호</th>
				<th>삭제</th>
			</tr>
			
			
			<!-- DB 호출 -->
			<%
				Class.forName("com.mysql.jdbc.Driver");
				String url = "jdbc:mysql://localhost:3306/todaydea";
				String id = "root";
				String pass = "root";
				
				try {
					Connection conn = DriverManager.getConnection(url, id, pass);
					Statement stmt = conn.createStatement();
					
					
					String sqlList = "SELECT * FROM CONTENT;";
					ResultSet rs = stmt.executeQuery(sqlList);
					while(rs.next()) {
						int idx = rs.getInt(1);			// 작품 고유번호
						String day = rs.getString(2);		// 요일
						String name = rs.getString(3);		// 이름
						String intro = rs.getString(4);		// 소개
						int contentIdx = rs.getInt(5);		// 작품 개별번호
						String contentName = rs.getString(6);	// 작품 개별이름
						float star = rs.getFloat(7);		// 평점
						String uploadDate = String.valueOf(rs.getTimestamp(8));		// 등록일
						int image = rs.getInt(9);		// 이미지 갯수
						String imageName = rs.getString(10);		// 이미지 경로
						int contentCheck = rs.getInt(11);		//작품 중복확인
			%>
			
			
			<tr>
				<td><%=idx %></td>
				<td><%=day %></td>
				<td><%=name %></td>
				<td><%=intro %></td>
				<td><%=contentIdx %></td>
				<td><%=contentName %></td>
				<td><%=star %></td>
				<td><%=uploadDate %></td>
				<td><%=image %></td>
				<td><%=contentCheck %></td>
				<td><input type="button" value="삭제하기" id="<%=idx %>" onclick="location='delete.jsp?index=<%=idx %>'"></td>
			</tr>
			
			
			<%
					}
				} catch(SQLException e) {
					e.printStackTrace();
				}
			%>
		</table>
	</div>
</div>




<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
		<script
			src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
		<!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
		<script src="etc/js/bootstrap.min.js"></script>
</body>
</html>