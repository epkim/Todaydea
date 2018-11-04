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
<link rel="favicon"
	href="http://localhost:8080/todaydea/etc/img/favicon.ico">
</head>
<body>



	<%	
		String path = "D:\\������ ����\\������\\Todaydea\\dev\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\todaydea\\content";
	
		File isDir = new File(path);
	
		if(!isDir.isDirectory()){
			isDir.mkdir();
		}
	
		/*
		��ǰ��ȣ 1�� �����
		content/1_thumbnail.jpg
		��ǰ��ȣ 1�� 1ȭ�� �����
		content/1_1_thumbnail.jpg
		��ǰ��ȣ 1�� 1ȭ�� ����
		content/1_1_1.jpg
		��ǰ��ȣ 1�� 1ȭ�� ����
		content/1_1_ad.jpg
		*/
		
		// ��ü ���ϸ��� ��� ����, filename, ��ǰ�����;��������;����;����;
		String fileNames = "";
	
		String uploadPath=request.getRealPath("content");
			
		int size = 10*1024*1024;
		
		
		String formName = "";		// ���� input�� ������ �̸� ������
		String filename = "";		// �ߺ�ó���� �̸�
		String originalName = "";	// �ߺ�ó�� �� ���� ���� �̸�
		long fileSize = 0;			// ���� ������
		String fileType = "";		// ���� Ÿ��
		
			
		try{
		    MultipartRequest multi=new MultipartRequest(request,uploadPath,size,"euc-kr",new DefaultFileRenamePolicy());
			
		    // �Ķ���� �� ����
		    String content = multi.getParameter("content");
			String daytemp = multi.getParameter("day");
			String day = "";
			String Mname = multi.getParameter("name");
			String intro = multi.getParameter("intro");
			String contentName = multi.getParameter("contentName");
			int image = Integer.parseInt(multi.getParameter("image"));
			int contentCheck = Integer.parseInt(multi.getParameter("contentCheck"));
			int maxContentIndex = Integer.parseInt(multi.getParameter("maxContentIndex"));
			
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
			

			// ������ ��ü ���� �̸����� ������
		    Enumeration forms = multi.getFileNames();
		    
		    while(forms.hasMoreElements()) {
		    	// form �±׿��� <input type="file" name="���⿡ ������ �̸�" />�� ������
			    formName = (String)forms.nextElement();		// ���� input�� ������ �̸��� ������
			    // �׿� �ش��ϴ� ���� ���� �̸��� ������
			    originalName = multi.getOriginalFileName(formName);
			 	// ���ϸ��� �ߺ��� ��� �ߺ� ��å�� ���� �ڿ� 1,2,3 ó�� �پ� unique�ϰ� ���ϸ��� �����ϴµ�
				// �̶� ������ �̸��� filesystemName�̶� �Ͽ� �� �̸� ������ �����´�.(�ߺ��� ���� ó��)
			    filename = multi.getFilesystemName(formName);
			 	// ���� Ÿ�� ������ ������
			 	fileType = multi.getContentType(formName);
			 	// input file name�� �ش��ϴ� ���� ������ ������
			 	File file = multi.getFile(formName);
			 	// �� ���� ��ü�� ũ�⸦ �˾Ƴ�
			 	fileSize = file.length();
			 	
			 	// DB�� ������ ���ϸ� ����
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
			
		 	// content�� new�̸� �ű�, old�̸� ���� / �űԿ� ������ DB �Է��� �����ϰ� �ϱ� ����
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
 				// ��ü ���ϸ��� ��� ����, filename, ��ǰ�����;��������;����;����;
 				fileNames = tempAl.get(0) + ";" + fileNames;
 			}
						
			// DB�� ��ǰ ���� �߰�
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
					maxIndex = 1;		// �ű� ��ǰ�� ��� 1�� ���� !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
				} else {
					
				}
				
				
				PreparedStatement pstmt = conn.prepareStatement("INSERT INTO content (`day`, `name`, `intro`, `contentIndex`, `contentName`, `image`, `imageName`, `contentCheck`) VALUES (?, ?, ?, ?, ?, ?, ?, ?);");
				pstmt.setString(1, day);
				pstmt.setString(2, Mname);
				pstmt.setString(3, intro);
				if("new".equals(content)) {
					pstmt.setInt(4, maxIndex);		// �ű� ��ǰ�� ��� 1�� ���� !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
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
		    out.print("alert('����� �Ϸ�Ǿ����ϴ�.');");
		    out.print("location.href='http://localhost:8181/todaydea/adminPage.jsp';");
		    out.print("</script>");
		
		} catch(Exception e){
		    e.printStackTrace();
		}
%>

<body>
	
	
	
</body>
</html>