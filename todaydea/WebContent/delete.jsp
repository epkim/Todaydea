<%@page import="java.util.StringTokenizer"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
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


<%
	request.setCharacterEncoding("EUC-KR");
	int idx = Integer.parseInt(request.getParameter("index"));
	
	// idx�� contentCheck ��ȣ
	int contentCheck = 0;
	// ������ ��ǰ���� Ȯ��
	int last = 0;
	// ������ �̹�����
	String imageName = "";
	// ������ �̹����� ����
	int imageNum = 0;
	// ������ �̹������� �����Ͽ� ����
	ArrayList<String> al = new ArrayList<String>();
	// ������ ������ �����ϴ� ���丮
	String fileDir = "content";
	
	// ��ǰ ����
	Class.forName("com.mysql.jdbc.Driver");
	String url = "jdbc:mysql://localhost:3306/todaydea";
	String id = "root";
	String pass = "root";
	
	try {
		Connection conn = DriverManager.getConnection(url, id, pass);
		// ������ �̹����� �ҷ�����
		PreparedStatement pstmt2 = conn.prepareStatement("SELECT imageName, image, contentCheck FROM content WHERE `index` = ?;");
		pstmt2.setInt(1, idx);
		ResultSet rs = pstmt2.executeQuery();
		while(rs.next()) {
			imageName = rs.getString(1);
			imageNum = rs.getInt(2);
			contentCheck = rs.getInt(3);
			
			StringTokenizer stn = new StringTokenizer(imageName);
			while(stn.hasMoreTokens()) {
				al.add(stn.nextToken(";"));
			}
		}
		
		// �ش� idx�� ������ contentCheck���� Ȯ��
		PreparedStatement pstmt3 = conn.prepareStatement("SELECT count(*) FROM content WHERE `contentCheck` = ?;");
		pstmt3.setInt(1, contentCheck);
		ResultSet rs2 = pstmt3.executeQuery();
		while(rs2.next()) {
			last = rs2.getInt(1);
		}
		
		// last�� 1�̸� ������ ��ǰ�̹Ƿ� ��ǰ�� ����ϱ��� ���� �� ����
		if(last == 1) {
			// �̹��� ���� ����
			for(int i = 0; i < imageNum+3; i++) {	// +3�� ��ǰ �����, ���� �����, ����
				String filePath = request.getRealPath(fileDir) + "/";	// ������ �����ϴ� �������
				filePath += al.get(i);
				File f = new File(filePath);	// ���� ��ü ����
				if(f.exists()) {
					f.delete();		// ������ �����ϸ� ������ �����Ѵ�.
				}
			}
		} else {	// ������ ��ǰ�� �ƴҶ��� ��ǰ ������� ���� X
			// �̹��� ���� ����
			for(int i = 1; i < imageNum+3; i++) {
				String filePath = request.getRealPath(fileDir) + "/";	// ������ �����ϴ� �������
				filePath += al.get(i);
				File f = new File(filePath);	// ���� ��ü ����
				if(f.exists()) {
					f.delete();		// ������ �����ϸ� ������ �����Ѵ�.
				}
			}
		}
		
		// DB���� ����
		PreparedStatement pstmt = conn.prepareStatement("DELETE FROM `todaydea`.`content` WHERE `index` = ?;");
		
		pstmt.setInt(1, idx);
		pstmt.executeUpdate();
		
		out.print("<script type='text/javascript'>");
	    out.print("alert('������ �Ϸ�Ǿ����ϴ�.');");
	    out.print("location.href='http://localhost:8181/todaydea/adminPage.jsp';");
	    out.print("</script>");
		
	} catch(SQLException e) {
		e.printStackTrace();
	}	
%>


<!-- jQuery (��Ʈ��Ʈ���� �ڹٽ�ũ��Ʈ �÷������� ���� �ʿ��մϴ�) -->
		<script
			src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
		<!-- ��� �����ϵ� �÷������� �����մϴ� (�Ʒ�), ������ �ʴ´ٸ� �ʿ��� ������ ������ �����ϼ��� -->
		<script src="etc/js/bootstrap.min.js"></script>
</body>
</html>