<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <!-- �� 3���� ��Ÿ �±״� *�ݵ��* head �±��� ó���� �;��մϴ�; � �ٸ� ���������� �ݵ�� �� �±׵� *������* �;� �մϴ� -->
    <title>Todaydea</title>

    <!-- ��Ʈ��Ʈ�� -->
    <link href="etc/css/bootstrap.min.css" rel="stylesheet">
    <!-- main.css -->
    <link href="etc/css/main.css" rel="stylesheet">

    <!-- IE8 ���� HTML5 ��ҿ� �̵�� ������ ���� HTML5 shim �� Respond.js -->
    <!-- WARNING: Respond.js �� ����� file:// �� ���� �������� �� ���� �������� �ʽ��ϴ�. -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <link rel="favicon" href="http://localhost:8080/todaydea/etc/img/favicon.ico">
  </head>
<body>


<style type="text/css">
/* ���� ���� */
div.container {
	margin-top: 50px;
}
div.container div.col-md-10.col-xs-10.col-sm-10 {
	border-left-style: solid;
}
/* ǥ ���� */
div.container table tr th, 
div.container table tr td {
	width: 150px;
	text-align: center;
}
</style>

<%
	request.setCharacterEncoding("EUC-KR");
	int contentCheck = Integer.parseInt(request.getParameter("contentCheck"));
	String daytemp = request.getParameter("day");
	String day = "";
	String name = request.getParameter("name");
	String content = request.getParameter("content");
	
	// ���� ���ڵ�
	if("mon".equals(daytemp)) {
		day = "��";
	} else if ("tue".equals(daytemp)) {
		day = "ȭ";
	} else if ("wed".equals(daytemp)) {
		day = "��";
	} else if ("thu".equals(daytemp)) {
		day = "��";
	} else if ("fri".equals(daytemp)) {
		day = "��";
	} else if ("sat".equals(daytemp)) {
		day = "��";
	} else if ("sun".equals(daytemp)) {
		day = "��";
	}


%>

<div class="container">
	<div class="col-md-2 col-xs-2 col-sm-2">
		<div class="col-md-12 col-xs-12 col-sm-12">
			<a href="http://localhost:8181/todaydea/adminPage.jsp">��ü�ۺ���</a>
		</div>
		<div class="col-md-12 col-xs-12 col-sm-12">
			<a href="http://localhost:8181/todaydea/writeSelect.jsp">�۾���</a>
		</div>
	</div>
	<div class="col-md-10 col-xs-10 col-sm-10">
	
	
	<%
			// ���� ��ǰ ���� ��������
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost:3306/todaydea";
			String id = "root";
			String pass = "root";
			
			
			String intro = "";	// ��ǰ �Ұ�
			int maxContentIndex = 0;	// ��ǰ�� ���� ���� ȸ�� ��ȣ
			
			
			try {
				Connection conn = DriverManager.getConnection(url, id, pass);
				PreparedStatement pstmt = conn.prepareStatement("SELECT name, intro, max(contentIndex) FROM content WHERE contentCheck = ? GROUP BY name;");
				
				pstmt.setInt(1, contentCheck);
				ResultSet rs = pstmt.executeQuery();
				
				while(rs.next()) {
					name = rs.getString(1);
					intro = rs.getString(2);
					maxContentIndex = rs.getInt(3);
				}
			} catch(Exception e) {
				e.printStackTrace();
			}
		%>
	
	
	
	
	
		<h3>���� ��ǰ ���</h3>
		<br>
		<form action="writeImage.jsp" method="post">
		���� : <%=day %>����
		<br><br>
		���� : <%=name %>
		<br><br>
		��ǰ �Ұ� : <%=intro %>
		<br><br>
		��ǰ�� ȸ�� : <%=maxContentIndex+1 %>ȸ��
		<br><br>
		��ǰ ȸ�� ���� : 
		<input type="text" name="contentName">
		<br><br>
		��ǰ ������ �̹��� ����(ex 1) : 
		<input type="text" name="image">
		<br><br>
		<input type="hidden" name="content" value="<%=content %>">
		<input type="hidden" name="day" value="<%=daytemp %>">
		<input type="hidden" name="name" value="<%=name %>">
		<input type="hidden" name="intro" value="<%=intro %>">
		<input type="hidden" name="maxContentIndex" value="<%=maxContentIndex %>">
		<input type="hidden" name="contentCheck" value="<%=contentCheck %>">
		<input type="submit" value="����">
		</form>
		
	
	
	
	</div>
</div>

<!-- jQuery (��Ʈ��Ʈ���� �ڹٽ�ũ��Ʈ �÷������� ���� �ʿ��մϴ�) -->
		<script
			src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
		<!-- ��� �����ϵ� �÷������� �����մϴ� (�Ʒ�), ������ �ʴ´ٸ� �ʿ��� ������ ������ �����ϼ��� -->
		<script src="etc/js/bootstrap.min.js"></script>
</body>
</html>