<%@page import="java.util.StringTokenizer"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.io.File"%>
<%@ page import="java.util.Enumeration"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
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
<link rel="favicon"
	href="http://localhost:8080/todaydea/etc/img/favicon.ico">
</head>
<body>



	<%	
		String path = "D:\\나만의 공부\\웹개발\\Todaydea\\dev\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\todaydea\\content";
	
		File isDir = new File(path);
	
		if(!isDir.isDirectory()){
			isDir.mkdir();
		}
	
		/*
		작품번호 1의 썸네일
		content/1_thumbnail.jpg
		작품번호 1의 1화의 썸네일
		content/1_1_thumbnail.jpg
		작품번호 1의 1화의 내용
		content/1_1_1.jpg
		작품번호 1의 1화의 광고
		content/1_1_ad.jpg
		*/
		
		// 전체 파일명을 담는 변수, filename, 작품썸네일;제목썸네일;광고;내용;
		String fileNames = "";
	
		String uploadPath=request.getRealPath("content");
			
		int size = 10*1024*1024;
		
		
		String formName = "";		// 파일 input에 지정한 이름 가져옴
		String filename = "";		// 중복처리된 이름
		String originalName = "";	// 중복처리 전 실제 원본 이름
		long fileSize = 0;			// 파일 사이즈
		String fileType = "";		// 파일 타입
		
			
		try{
		    MultipartRequest multi=new MultipartRequest(request,uploadPath,size,"euc-kr",new DefaultFileRenamePolicy());
			
		    // 파라미터 값 저장
		    String content = multi.getParameter("content");
			String daytemp = multi.getParameter("day");
			String day = "";
			String Mname = multi.getParameter("name");
			String intro = multi.getParameter("intro");
			String contentName = multi.getParameter("contentName");
			int image = Integer.parseInt(multi.getParameter("image"));
			int contentCheck = Integer.parseInt(multi.getParameter("contentCheck"));
			int maxContentIndex = Integer.parseInt(multi.getParameter("maxContentIndex"));
			
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
			

			// 전송한 전체 파일 이름들을 가져옴
		    Enumeration forms = multi.getFileNames();
		    
		    while(forms.hasMoreElements()) {
		    	// form 태그에서 <input type="file" name="여기에 지정한 이름" />을 가져옴
			    formName = (String)forms.nextElement();		// 파일 input에 지정한 이름을 가져옴
			    // 그에 해당하는 실제 파일 이름을 가져옴
			    originalName = multi.getOriginalFileName(formName);
			 	// 파일명이 중복될 경우 중복 정책에 의해 뒤에 1,2,3 처럼 붙어 unique하게 파일명을 생성하는데
				// 이때 생성된 이름을 filesystemName이라 하여 그 이름 정보를 가져온다.(중복에 대한 처리)
			    filename = multi.getFilesystemName(formName);
			 	// 파일 타입 정보를 가져옴
			 	fileType = multi.getContentType(formName);
			 	// input file name에 해당하는 실제 파일을 가져옴
			 	File file = multi.getFile(formName);
			 	// 그 파일 객체의 크기를 알아냄
			 	fileSize = file.length();
			 	
			 	// DB에 저정할 파일명 생성
			 	fileNames = filename + ";" + fileNames;
			 	
			 	System.out.println("-------------------------------------");
			 	System.out.println("path : " + uploadPath);
			 	System.out.println("formName : " + formName);
			 	System.out.println("originalName : " + originalName);
			 	System.out.println("filename : " + filename);
			 	System.out.println("filetype : " + fileType);
			 	System.out.println("file : " + file);
			 	System.out.println("fileSize : " + fileSize);
		    }
			
		 	// content가 new이면 신규, old이면 기존 / 신규와 기존의 DB 입력을 동일하게 하기 위해
 			if("new".equals(content)) {
 				
 			} else if("old".equals(content)) {
 				Class.forName("com.mysql.jdbc.Driver");
 				String url = "jdbc:mysql://localhost:3306/todaydea";
 				String id = "root";
 				String pass = "root";
 				String tempImageName = "";
 				ArrayList<String> tempAl = new ArrayList<String>();
 				
 				try {
 					Connection conn = DriverManager.getConnection(url, id, pass);
 					PreparedStatement pstmt = conn.prepareStatement("SELECT imageName FROM content WHERE contentCheck = ?;");
 					pstmt.setInt(1, contentCheck);
 					ResultSet rs = pstmt.executeQuery();
 					while(rs.next()) {
 						tempImageName = rs.getString(1);
 						
 						StringTokenizer stn = new StringTokenizer(tempImageName);
 						while(stn.hasMoreTokens()) {
 							tempAl.add(stn.nextToken(";"));
 						}
 					}
 				} catch(SQLException e) {
 					e.printStackTrace();
 				}
 				// 전체 파일명을 담는 변수, filename, 작품썸네일;제목썸네일;광고;내용;
 				fileNames = tempAl.get(0) + ";" + fileNames;
 			}
						
			// DB에 작품 정보 추가
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost:3306/todaydea";
			String id = "root";
			String pass = "root";
			int maxContent = 0;
			int maxIndex = 0;
			
			try {
				Connection conn = DriverManager.getConnection(url, id, pass);
				Statement stmt = conn.createStatement();
				String sql = "SELECT MAX(CONTENTCHECK) FROM content";
				ResultSet rs = stmt.executeQuery(sql);
				
				while(rs.next()) {
					maxContent = rs.getInt(1);
				}
				
				
				
				PreparedStatement pstmt2 = conn.prepareStatement("SELECT MAX(CONTENTINDEX) FROM content WHERE NAME = ?;");
				pstmt2.setString(1, Mname);
				ResultSet rs2 = pstmt2.executeQuery();
				
				while(rs2.next()) {
					maxIndex = rs2.getInt(1)+1;
				}
				
				if("new".equals(content)) {
					maxIndex = 1;		// 신규 작품일 경우 1로 고정 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
				} else {
					
				}
				
				
				PreparedStatement pstmt = conn.prepareStatement("INSERT INTO content (`day`, `name`, `intro`, `contentIndex`, `contentName`, `image`, `imageName`, `contentCheck`) VALUES (?, ?, ?, ?, ?, ?, ?, ?);");
				pstmt.setString(1, day);
				pstmt.setString(2, Mname);
				pstmt.setString(3, intro);
				if("new".equals(content)) {
					pstmt.setInt(4, maxIndex);		// 신규 작품일 경우 1로 고정 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
				} else if("old".equals(content)) {
					pstmt.setInt(4, maxIndex);
				}
				pstmt.setString(5, contentName);
				pstmt.setInt(6, image);
				pstmt.setString(7, fileNames);
				if("new".equals(content)) {
					pstmt.setInt(8, maxContent+1);
				} else if("old".equals(content)) {
					pstmt.setInt(8, contentCheck);
				}

				pstmt.executeUpdate();
				
			} catch(SQLException e) {
				e.printStackTrace();
			}
			
		    
		    out.print("<script type='text/javascript'>");
		    out.print("alert('등록이 완료되었습니다.');");
		    out.print("location.href='http://localhost:8181/todaydea/adminPage.jsp';");
		    out.print("</script>");
		
		} catch(Exception e){
		    e.printStackTrace();
		}
%>

<body>
	
	
	
</body>
</html>