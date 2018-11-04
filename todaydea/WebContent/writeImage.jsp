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
	String name = request.getParameter("name");
	String intro = request.getParameter("intro");
	String contentName = request.getParameter("contentName");
	int image = Integer.parseInt(request.getParameter("image"));
	int maxContentIndex = Integer.parseInt(request.getParameter("maxContentIndex"));
	int contentCheck = Integer.parseInt(request.getParameter("contentCheck"));
	
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
		이미지를 선택해주세요.<br>
		
		<form action="writeAction.jsp" method="post" enctype="multipart/form-data">
		
		<br>
		작품의 썸네일 : <input type="file" name="file1"><br><br>
		작품 1화의 썸네일 : <input type="file" name="file2"><br><br>
		작품 1화의 광고 : <input type="file" name="file3"><br><br>
		작품 1화의 내용 : 
		
		<%
			for(int i = 0; i < image; i++) {
		%>
		
		<br><input type="file" name="file<%=i+4 %>">
		
		<%
			}
		%>
		
		<br><br>
		<input type="hidden" name="content" value="<%=content%>">
		<input type="hidden" name="day" value="<%=daytemp%>">
		<input type="hidden" name="name" value="<%=name%>">
		<input type="hidden" name="intro" value="<%=intro%>">
		<input type="hidden" name="contentName" value="<%=contentName%>">
		<input type="hidden" name="image" value="<%=image%>">
		<input type="hidden" name="contentCheck" value=1>
		<input type="hidden" name="maxContentIndex" value="<%=maxContentIndex%>">
		
		<input type="submit" value="등록하기">
		</form>
		
		
	<%
		} else if("old".equals(content)) {
	%>
		
		
		<h3>기존 작품 등록</h3>
		<br>
		이미지를 선택해주세요.<br>
		
		<form action="writeAction.jsp" method="post" enctype="multipart/form-data">
		
		<br>
		
		작품 <%=maxContentIndex+1 %>화의 썸네일 : <input type="file" name="file1"><br><br>
		작품 <%=maxContentIndex+1 %>화의 광고 : <input type="file" name="file2"><br><br>
		작품 <%=maxContentIndex+1 %>화의 내용 : 
		
		<%
			for(int i = 0; i < image; i++) {
		%>
		
		<br><input type="file" name="file<%=i+3%>">
		
		<%
			}
		%>
		
	
		<br><br>
		<input type="hidden" name="content" value="<%=content%>">
		<input type="hidden" name="day" value="<%=daytemp%>">
		<input type="hidden" name="name" value="<%=name%>">
		<input type="hidden" name="intro" value="<%=intro%>">
		<input type="hidden" name="contentName" value="<%=contentName%>">
		<input type="hidden" name="image" value="<%=image%>">
		<input type="hidden" name="maxContentIndex" value="<%=maxContentIndex%>">
		<input type="hidden" name="contentCheck" value="<%=contentCheck%>">
		
		<input type="submit" value="등록하기">
		</form>
		
		
	<%
		}
	%>
	
	<br><br>참고사항<br><br>
	작품번호 1의 썸네일<br>
	content/1_thumbnail.jpg<p><br>
	작품번호 1의 1화의 썸네일<br>
	content/1_1_thumbnail.jpg<p><br>
	작품번호 1의 1화의 내용<br>
	content/1_1_1.jpg<p><br>
	작품번호 1의 1화의 광고<br>
	content/1_1_ad.jpg<p><br>
	
	</div>
</div>

<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
		<script
			src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
		<!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
		<script src="etc/js/bootstrap.min.js"></script>
</body>
</html>