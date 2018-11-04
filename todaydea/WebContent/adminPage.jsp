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

<!-- style test -->
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

<!-- main container -->
<div class="container">
	<!-- menu -->
	<div class="col-md-2 col-xs-2 col-sm-2">
		<div class="col-md-12 col-xs-12 col-sm-12">
			<a href="http://localhost:8181/todaydea/adminPage.jsp">��ü�ۺ���</a>
		</div>
		<div class="col-md-12 col-xs-12 col-sm-12">
			<a href="http://localhost:8181/todaydea/writeSelect.jsp">�۾���</a>
		</div>
	</div>
	<!-- data view -->
	<div class="col-md-10 col-xs-10 col-sm-10">
		<table>
			<tr>
				<th>��ǰ����</th>
				<th>����</th>
				<th>����</th>
				<th>�Ұ�</th>
				<th>ȸ����ȣ</th>
				<th>ȸ������</th>
				<th>����</th>
				<th>���ε�ð�</th>
				<th>�̹��� ����</th>
				<th>��ǰ ������ȣ</th>
				<th>����</th>
			</tr>
			
			
			<!-- DB ȣ�� -->
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
						int idx = rs.getInt(1);			// ��ǰ ������ȣ
						String day = rs.getString(2);		// ����
						String name = rs.getString(3);		// �̸�
						String intro = rs.getString(4);		// �Ұ�
						int contentIdx = rs.getInt(5);		// ��ǰ ������ȣ
						String contentName = rs.getString(6);	// ��ǰ �����̸�
						float star = rs.getFloat(7);		// ����
						String uploadDate = String.valueOf(rs.getTimestamp(8));		// �����
						int image = rs.getInt(9);		// �̹��� ����
						String imageName = rs.getString(10);		// �̹��� ���
						int contentCheck = rs.getInt(11);		//��ǰ �ߺ�Ȯ��
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
				<td><input type="button" value="�����ϱ�" id="<%=idx %>" onclick="location='delete.jsp?index=<%=idx %>'"></td>
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




<!-- jQuery (��Ʈ��Ʈ���� �ڹٽ�ũ��Ʈ �÷������� ���� �ʿ��մϴ�) -->
		<script
			src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
		<!-- ��� �����ϵ� �÷������� �����մϴ� (�Ʒ�), ������ �ʴ´ٸ� �ʿ��� ������ ������ �����ϼ��� -->
		<script src="etc/js/bootstrap.min.js"></script>
</body>
</html>