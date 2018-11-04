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
	request.setCharacterEncoding("EUC-KR");
	int idx = Integer.parseInt(request.getParameter("index"));
	
	// idx의 contentCheck 번호
	int contentCheck = 0;
	// 마지막 작품인지 확인
	int last = 0;
	// 삭제할 이미지명
	String imageName = "";
	// 삭제할 이미지의 갯수
	int imageNum = 0;
	// 삭제할 이미지명을 분할하여 저장
	ArrayList<String> al = new ArrayList<String>();
	// 삭제할 파일이 존재하는 디렉토리
	String fileDir = "content";
	
	// 작품 삭제
	Class.forName("com.mysql.jdbc.Driver");
	String url = "jdbc:mysql://localhost:3306/todaydea";
	String id = "root";
	String pass = "root";
	
	try {
		Connection conn = DriverManager.getConnection(url, id, pass);
		// 삭제할 이미지명 불러오기
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
		
		// 해당 idx가 마지막 contentCheck인지 확인
		PreparedStatement pstmt3 = conn.prepareStatement("SELECT count(*) FROM content WHERE `contentCheck` = ?;");
		pstmt3.setInt(1, contentCheck);
		ResultSet rs2 = pstmt3.executeQuery();
		while(rs2.next()) {
			last = rs2.getInt(1);
		}
		
		// last가 1이면 마지막 작품이므로 작품의 썸네일까지 전부 다 삭제
		if(last == 1) {
			// 이미지 파일 삭제
			for(int i = 0; i < imageNum+3; i++) {	// +3은 작품 썸네일, 제목 썸네일, 광고
				String filePath = request.getRealPath(fileDir) + "/";	// 파일이 존재하는 실제경로
				filePath += al.get(i);
				File f = new File(filePath);	// 파일 객체 생성
				if(f.exists()) {
					f.delete();		// 파일이 존재하면 파일을 삭제한다.
				}
			}
		} else {	// 마지막 작품이 아닐때는 작품 썸네일은 삭제 X
			// 이미지 파일 삭제
			for(int i = 1; i < imageNum+3; i++) {
				String filePath = request.getRealPath(fileDir) + "/";	// 파일이 존재하는 실제경로
				filePath += al.get(i);
				File f = new File(filePath);	// 파일 객체 생성
				if(f.exists()) {
					f.delete();		// 파일이 존재하면 파일을 삭제한다.
				}
			}
		}
		
		// DB에서 삭제
		PreparedStatement pstmt = conn.prepareStatement("DELETE FROM `todaydea`.`content` WHERE `index` = ?;");
		
		pstmt.setInt(1, idx);
		pstmt.executeUpdate();
		
		out.print("<script type='text/javascript'>");
	    out.print("alert('삭제가 완료되었습니다.');");
	    out.print("location.href='http://localhost:8181/todaydea/adminPage.jsp';");
	    out.print("</script>");
		
	} catch(SQLException e) {
		e.printStackTrace();
	}	
%>


<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
		<script
			src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
		<!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
		<script src="etc/js/bootstrap.min.js"></script>
</body>
</html>