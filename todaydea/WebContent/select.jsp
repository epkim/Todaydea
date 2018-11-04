<%@page import="java.util.StringTokenizer"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
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
    <link rel="favicon" href="http://52.78.185.92:8080/todaydea/etc/img/favicon.ico">
  </head>
<body>

<%
	ArrayList<String> al = new ArrayList<String>();
%>

<!-- navbar -->
<nav class="navbar navbar-inverse navbar-fixed-top topbar">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="http://52.78.185.92:8080/todaydea"><img alt="����" src="etc/img/naver.gif" class="topbarLogo"></a>
        </div>
        <div id="navbar" class="collapse navbar-collapse">
          <ul class="nav navbar-nav topbarManu">
            <li><a href=""><span class="glyphicon glyphicon-user topbar-hover" aria-hidden="true"></span></a></li>
            <li><a href=""><span class="glyphicon glyphicon-search topbar-hover" aria-hidden="true"></span></a></li>
            <li><a href="#contact"><span class="glyphicon glyphicon-envelope topbar-hover" aria-hidden="true"></span></a></li>
            <li><a href="#contact"><span class="glyphicon glyphicon-th topbar-hover" aria-hidden="true"></span></a></li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </nav>

	<!-- main container -->
	<div class="container select">
	<div class="row">
		<div class="col-md-8 col-xs-8 col-sm-8" style="height:100%;">
			<div class="row">
				<!-- ���� -->
				<div class="col-md-12 col-xs-12 col-sm-12 day">
					<div class="col-md-1 col-xs-1 col-sm-1"><a href="http://localhost:8181/todaydea?day=mon">���佺�丮</a></div>
					<div class="col-md-1 col-xs-1 col-sm-1"><a href="http://localhost:8181/todaydea?day=tue">ȭ�佺�丮</a></div>
					<div class="col-md-1 col-xs-1 col-sm-1"><a href="http://localhost:8181/todaydea?day=wed">���佺�丮</a></div>
					<div class="col-md-1 col-xs-1 col-sm-1"><a href="http://localhost:8181/todaydea?day=thu">��佺�丮</a></div>
					<div class="col-md-1 col-xs-1 col-sm-1"><a href="http://localhost:8181/todaydea?day=fri">�ݿ佺�丮</a></div>
					<!-- <div class="col-md-1 col-xs-1 col-sm-1"><a href="http://localhost:8181/todaydea?day=sat">�����</a></div>
					<div class="col-md-1 col-xs-1 col-sm-1"><a href="http://localhost:8181/todaydea?day=sun">�Ͽ���</a></div> -->
				</div>
				<!-- ��ǰ �Ұ� -->
				<div class="col-md-12 col-xs-12 col-sm-12" style="height: 150px;">
				
				
					<!-- DB ȣ�� -->
					<%
						int contentCheck = Integer.parseInt(request.getParameter("contentCheck"));
					
						Class.forName("com.mysql.jdbc.Driver");
						String url = "jdbc:mysql://localhost:3306/todaydea";
						String id = "root";
						String pass = "root";
						
						try {
							Connection conn = DriverManager.getConnection(url, id, pass);
							PreparedStatement pstmt = conn.prepareStatement("SELECT CONTENTCHECK, NAME, INTRO, imageName FROM CONTENT WHERE CONTENTCHECK = ? GROUP BY CONTENTCHECK;");
							
							pstmt.setInt(1, contentCheck);
							ResultSet rs = pstmt.executeQuery();
							
							request.setCharacterEncoding("EUC-KR");
							
							while(rs.next()) {
								contentCheck = rs.getInt(1);
								String name = rs.getString(2);
								String intro = rs.getString(3);
								String imageName = rs.getString(4);
								
								StringTokenizer stn = new StringTokenizer(imageName);
								
								while(stn.hasMoreTokens()) {
									al.add(stn.nextToken(";"));
								}
					%>
				
				
					<!-- ��ǰ �̹��� -->
					<div class="col-md-2 col-xs-2 col-sm-2" style="height: 100px; margin-top: 25px; margin-bottom: 25px; width: 150px;">
						<img alt="�����" src="content/<%=al.get(0) %>" style="width: 100%; height: 100%;">
					</div>
					<!-- ���� -->
					<div class="col-md-1 col-xs-1 col-sm-1">
					</div>
					<!-- ��ǰ ���� -->
					<div class="col-md-9 col-xs-9 col-sm-9" style="height: 100px; margin-top: 25px; margin-bottom: 25px;">
						<div class="col-md-12 col-xs-12 col-sm-12" style="height: 30%">
						<%=name %>
						</div>
						<div class="col-md-12 col-xs-12 col-sm-12" id="content_sub" style="height: 70%; display: table;">
							<div style="display: table-cell; vertical-align: middle;">
								<%=intro %>
							</div>
						</div>
					</div>
					
					
					<%
							}
						} catch(SQLException e) {
							e.printStackTrace();
						}
					%>
					
					
				</div>
				<!-- ȸ�� �Ұ� -->
				<div class="col-md-12 col-xs-12 col-sm-12" id="epi_intro" style="height: 50px;">
					<!-- �̹��� -->
					<div class="col-md-1 col-xs-1 col-sm-1 intro">�̹���
					</div>
					<!-- ���� -->
					<div class="col-md-6 col-xs-6 col-sm-6 intro">����
					</div>
					<!-- ���� -->
					<div class="col-md-2 col-xs-2 col-sm-2 intro">����
					</div>
					<!-- ����� -->
					<div class="col-md-2 col-xs-2 col-sm-2 intro" id="regi">�����
					</div>
				</div>
				<!-- ȸ�� ��� -->
				<div class="col-md-12 col-xs-12 col-sm-12" style="height: 100%;">
				
				
					<%
						try {
							// SimpleDateFormat ��ü ����. ��¥ ǥ������ "yyyy-MM-dd"
							SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
							Date day = new Date();
							
							Connection conn = DriverManager.getConnection(url, id, pass);
							PreparedStatement pstmt = conn.prepareStatement("SELECT CONTENTINDEX, CONTENTNAME, STAR, UPLOADDATE, imageName FROM content WHERE CONTENTCHECK = ?;");
							
							pstmt.setInt(1, contentCheck);
							ResultSet rs = pstmt.executeQuery();
							
							while(rs.next()) {
								int contentIndex = rs.getInt(1);
								String contentName = rs.getString(2);
								float star = rs.getFloat(3);
								/* String uploadDate = String.valueOf(rs.getTimestamp(4)); */
								day = rs.getTimestamp(4);
								String imageName = rs.getString(5);
								
								StringTokenizer stn = new StringTokenizer(imageName);
								
								al.clear();
								while(stn.hasMoreTokens()) {
									al.add(stn.nextToken(";"));
								}
										
					%>
				
				
					<a href="http://localhost:8181/todaydea/view.jsp?contentCheck=<%=contentCheck %>&contentIndex=<%=contentIndex%>">
					<div class="row">
						<!-- �̹��� -->
						<div class="col-md-1 col-xs-1 col-sm-1 content"><img alt="�����" src="content/<%=al.get(1)%>">
						</div>
						<!-- ���� -->
						<div class="col-md-6 col-xs-6 col-sm-6 content"><%=contentName %>
						</div>
						<!-- ���� -->
						<div class="col-md-2 col-xs-2 col-sm-2 content" id="star_con"><%=star %>
						</div>
						<!-- ����� -->
						<div class="col-md-2 col-xs-2 col-sm-2 content" id="regi_con"><%=sdf.format(day) %>
						</div>
					</div>
					</a>
					
					
					<%
							}
						} catch(SQLException e) {
							e.printStackTrace();
						}
					%>
					
					
					<div class="row">
						<!-- �̹��� -->
						<div class="col-md-1 col-xs-1 col-sm-1 content"><img alt="�����" src="etc/img/thumb.jpg">
						</div>
						<!-- ���� -->
						<div class="col-md-6 col-xs-6 col-sm-6 content">�̾�
						</div>
						<!-- ���� -->
						<div class="col-md-2 col-xs-2 col-sm-2 content" id="star_con">9.97
						</div>
						<!-- ����� -->
						<div class="col-md-2 col-xs-2 col-sm-2 content" id="regi_con">2018.09.07
						</div>
					</div>
					<div class="row">
						<!-- �̹��� -->
						<div class="col-md-1 col-xs-1 col-sm-1 content"><img alt="�����" src="etc/img/thumb.jpg">
						</div>
						<!-- ���� -->
						<div class="col-md-6 col-xs-6 col-sm-6 content">�̾�
						</div>
						<!-- ���� -->
						<div class="col-md-2 col-xs-2 col-sm-2 content" id="star_con">5.89
						</div>
						<!-- ����� -->
						<div class="col-md-2 col-xs-2 col-sm-2 content" id="regi_con">2018.09.07
						</div>
					</div>
					<div class="row">
						<!-- �̹��� -->
						<div class="col-md-1 col-xs-1 col-sm-1 content"><img alt="�����" src="etc/img/thumb.jpg">
						</div>
						<!-- ���� -->
						<div class="col-md-6 col-xs-6 col-sm-6 content">����
						</div>
						<!-- ���� -->
						<div class="col-md-2 col-xs-2 col-sm-2 content" id="star_con">9.99
						</div>
						<!-- ����� -->
						<div class="col-md-2 col-xs-2 col-sm-2 content" id="regi_con">2018.09.07
						</div>
					</div>
					<div class="row">
						<!-- �̹��� -->
						<div class="col-md-1 col-xs-1 col-sm-1 content"><img alt="�����" src="etc/img/thumb.jpg">
						</div>
						<!-- ���� -->
						<div class="col-md-6 col-xs-6 col-sm-6 content">���߳�
						</div>
						<!-- ���� -->
						<div class="col-md-2 col-xs-2 col-sm-2 content" id="star_con">1.08
						</div>
						<!-- ����� -->
						<div class="col-md-2 col-xs-2 col-sm-2 content" id="regi_con">2018.09.07
						</div>
					</div>
				</div>
				<!-- ȸ�� ��� ��-->
				
				<!-- ��ǰ ���� -->
				<div class="col-md-12 col-xs-12 col-sm-12" style="height: 50px;">
					<div class="order">
						<div class="col-md-4 col-xs-4 col-sm-4" id="order1"></div>
						<div class="col-md-4 col-xs-4 col-sm-4" id="order2">
						1&nbsp;&nbsp;2&nbsp;&nbsp;3&nbsp;&nbsp;4&nbsp;&nbsp;5&nbsp;&nbsp;6&nbsp;&nbsp;7&nbsp;&nbsp;8&nbsp;&nbsp;9&nbsp;&nbsp;10&nbsp;&nbsp;����>
						</div>
						<div class="col-md-4 col-xs-4 col-sm-4" id="order3"></div>
					</div>
				</div>
				<!-- ��ǰ ���� ��-->
		</div>
		</div>
		
		<!-- ���� ���� -->
		<div class="col-md-4 col-xs-4 col-sm-4" style="height: 100%;">
			<div class="row">
				<div class="col-md-12 col-xs-12 col-sm-12" style="height: 200px;">
					<img alt="����" src="etc/img/ad1.jpg">
				</div>
			</div>
			<div class="row">
				<div class="col-md-12 col-xs-12 col-sm-12" style="height:100px;">
					<img alt="����" src="etc/img/ad2.jpg">
				</div>
			</div>
			<div class="row">
				<div class="col-md-12 col-xs-12 col-sm-12" style="height:100px;">
					<img alt="����" src="etc/img/ad3.jpg">
				</div>
			</div>
		</div>
		<!-- ���� ���� �� -->
		</div>
	</div>



		<!-- footer -->
		<footer class="footer">
			<div class="container">
				<div class="row">�̿��� | ��������ó����ħ | å���� �Ѱ�� �������� | ������ | ���� ����
				</div>
				<div class="row">&copy; TODAYDEA CORP.</div>
				<div class="row">�� �������� ���۱��� ���� �Ǵ� ����ó�� ������, �̸� ���� �̿��ϴ� ���
					���۱ǹ� � ���� ���� å���� �� �� �ֽ��ϴ�.</div>
			</div>
		</footer>
		<!-- end footer -->

		<!-- jQuery (��Ʈ��Ʈ���� �ڹٽ�ũ��Ʈ �÷������� ���� �ʿ��մϴ�) -->
		<script
			src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
		<!-- ��� �����ϵ� �÷������� �����մϴ� (�Ʒ�), ������ �ʴ´ٸ� �ʿ��� ������ ������ �����ϼ��� -->
		<script src="etc/js/bootstrap.min.js"></script>
</body>
</html>