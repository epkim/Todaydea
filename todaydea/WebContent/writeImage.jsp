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
    <link rel="favicon" href="http://52.78.185.92:8080/todaydea/etc/img/favicon.ico">
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
	String content = request.getParameter("content");
	String daytemp = request.getParameter("day");
	String day = "";
	String name = request.getParameter("name");
	String intro = request.getParameter("intro");
	String contentName = request.getParameter("contentName");
	int image = Integer.parseInt(request.getParameter("image"));
	int maxContentIndex = Integer.parseInt(request.getParameter("maxContentIndex"));
	int contentCheck = Integer.parseInt(request.getParameter("contentCheck"));
	
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
		if("new".equals(content)) {
	%>
	
	
		<h3>�ű� ��ǰ ���</h3>
		<br>
		�̹����� �������ּ���.<br>
		
		<form action="writeAction.jsp" method="post" enctype="multipart/form-data">
		
		<br>
		��ǰ�� ����� : <input type="file" name="file1"><br><br>
		��ǰ 1ȭ�� ����� : <input type="file" name="file2"><br><br>
		��ǰ 1ȭ�� ���� : <input type="file" name="file3"><br><br>
		��ǰ 1ȭ�� ���� : 
		
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
		
		<input type="submit" value="����ϱ�">
		</form>
		
		
	<%
		} else if("old".equals(content)) {
	%>
		
		
		<h3>���� ��ǰ ���</h3>
		<br>
		�̹����� �������ּ���.<br>
		
		<form action="writeAction.jsp" method="post" enctype="multipart/form-data">
		
		<br>
		
		��ǰ <%=maxContentIndex+1 %>ȭ�� ����� : <input type="file" name="file1"><br><br>
		��ǰ <%=maxContentIndex+1 %>ȭ�� ���� : <input type="file" name="file2"><br><br>
		��ǰ <%=maxContentIndex+1 %>ȭ�� ���� : 
		
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
		
		<input type="submit" value="����ϱ�">
		</form>
		
		
	<%
		}
	%>
	
	<br><br>�������<br><br>
	��ǰ��ȣ 1�� �����<br>
	content/1_thumbnail.jpg<p><br>
	��ǰ��ȣ 1�� 1ȭ�� �����<br>
	content/1_1_thumbnail.jpg<p><br>
	��ǰ��ȣ 1�� 1ȭ�� ����<br>
	content/1_1_1.jpg<p><br>
	��ǰ��ȣ 1�� 1ȭ�� ����<br>
	content/1_1_ad.jpg<p><br>
	
	</div>
</div>

<!-- jQuery (��Ʈ��Ʈ���� �ڹٽ�ũ��Ʈ �÷������� ���� �ʿ��մϴ�) -->
		<script
			src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
		<!-- ��� �����ϵ� �÷������� �����մϴ� (�Ʒ�), ������ �ʴ´ٸ� �ʿ��� ������ ������ �����ϼ��� -->
		<script src="etc/js/bootstrap.min.js"></script>
</body>
</html>