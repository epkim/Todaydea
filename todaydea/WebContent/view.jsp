<%@page import="org.apache.jasper.tagplugins.jstl.core.Catch"%>
<%@page import="java.util.StringTokenizer"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
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
	href="http://52.78.185.92:8080/todaydea/etc/img/favicon.ico">
</head>
<body>

<%
	ArrayList<String> al = new ArrayList<String>();
%>

	<!-- ��� ������ -->
	<nav class="navbar navbar-inverse navbar-fixed-top topbar">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#navbar" aria-expanded="false"
					aria-controls="navbar">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="http://52.78.185.92:8080/todaydea"><img
					alt="����" src="etc/img/naver.gif" class="topbarLogo"></a>
			</div>
			<div id="navbar" class="collapse navbar-collapse">
				<ul class="nav navbar-nav topbarManu">
					<li><a href=""><span
							class="glyphicon glyphicon-user topbar-hover" aria-hidden="true"></span></a></li>
					<li><a href=""><span
							class="glyphicon glyphicon-search topbar-hover"
							aria-hidden="true"></span></a></li>
					<li><a href="#contact"><span
							class="glyphicon glyphicon-envelope topbar-hover"
							aria-hidden="true"></span></a></li>
					<li><a href="#contact"><span
							class="glyphicon glyphicon-th topbar-hover" aria-hidden="true"></span></a></li>
				</ul>
			</div>
			<!--/.nav-collapse -->
		</div>
	</nav>
	<!-- ��� ������ �� -->

	<!-- ���� -->
	<div class="container mainName">
		<!-- ���� -->
		<div class="row v_day">
			<div class="container day" id="day">
				<!-- <div class="col-md-1 col-xs-1 col-sm-1 no"></div> -->
				<div class="col-md-1 col-xs-1 col-sm-1"><a href="http://localhost:8181/todaydea?day=mon">���佺�丮</a></div>
				<div class="col-md-1 col-xs-1 col-sm-1"><a href="http://localhost:8181/todaydea?day=tue">ȭ�佺�丮</a></div>
				<div class="col-md-1 col-xs-1 col-sm-1"><a href="http://localhost:8181/todaydea?day=wed">���佺�丮</a></div>
				<div class="col-md-1 col-xs-1 col-sm-1"><a href="http://localhost:8181/todaydea?day=thu">��佺�丮</a></div>
				<div class="col-md-1 col-xs-1 col-sm-1"><a href="http://localhost:8181/todaydea?day=fri">�ݿ佺�丮</a></div>
				<!-- <div class="col-md-1 col-xs-1 col-sm-1"><a href="http://localhost:8181/todaydea?day=sat">�����</a></div>
				<div class="col-md-1 col-xs-1 col-sm-1"><a href="http://localhost:8181/todaydea?day=sun">�Ͽ���</a></div> -->
				<div class="col-md-4 col-xs-4 col-sm-4"></div>
			</div>
		</div>
		<!-- ���� �� -->
		<!-- ���� -->
		<div class="row v_name">
			<div class="col-md-1 col-xs-1 col-sm-1 no"></div>
			<div class="col-md-11 col-xs-11 col-sm-11" style="height: 150px;">


				<%
					int contentCheck = Integer.parseInt(request.getParameter("contentCheck"));
					int contentIndex = Integer.parseInt(request.getParameter("contentIndex"));

					Class.forName("com.mysql.jdbc.Driver");
					String url = "jdbc:mysql://localhost:3306/todaydea";
					String id = "root";
					String pass = "root";
					
					try {
						Connection conn = DriverManager.getConnection(url, id, pass);
						PreparedStatement pstmt = conn.prepareStatement(
								"SELECT imageName FROM content WHERE CONTENTCHECK = ? && CONTENTINDEX = ?;");

						pstmt.setInt(1, contentCheck);
						pstmt.setInt(2, contentIndex);
						ResultSet rs = pstmt.executeQuery();

						while (rs.next()) {
							String imageName = rs.getString(1);
							
							StringTokenizer stn = new StringTokenizer(imageName);
							
							while(stn.hasMoreTokens()) {
								al.add(stn.nextToken(";"));
							}
						}
					} catch(SQLException e) {
							e.printStackTrace();
					}

					try {
						Connection conn = DriverManager.getConnection(url, id, pass);
						PreparedStatement pstmt = conn.prepareStatement(
								"SELECT NAME, INTRO FROM content WHERE CONTENTCHECK = ? GROUP BY CONTENTCHECK;");

						pstmt.setInt(1, contentCheck);
						ResultSet rs = pstmt.executeQuery();
						
						request.setCharacterEncoding("EUC-KR");

						while (rs.next()) {
							String name = rs.getString(1);
							String intro = rs.getString(2);
				%>


				<!-- ��ǰ �̹��� -->
				<div class="col-md-2 col-xs-2 col-sm-2"
					style="height: 100px; width: 25%; margin-top: 25px; margin-bottom: 25px;">
					<img alt="�����" src="content/<%=al.get(0)%>"
						style="width: 100%; height: 100%;">
				</div>
				<!-- ��ǰ ���� -->
				<div class="col-md-6 col-xs-6 col-sm-6"
					style="height: 100px; width:60%; margin-top: 25px; margin-bottom: 25px;">
					<div class="col-md-12 col-xs-12 col-sm-12" id="v_name"
						style="height: 30%">
						<%=name%>
					</div>
					<div class="col-md-12 col-xs-12 col-sm-12" id="content_sub"
						style="height: 70%; display: table;">
						<div style="display: table-cell; vertical-align: middle;">
							<%=intro%>
						</div>
					</div>
				</div>


				<%
					}
					} catch (SQLException e) {
						e.printStackTrace();
					}
				%>


			</div>
		</div>
		<!-- ���� �� -->
		<!-- ���� -->
		<div class="row v_intro">


			<%
				try {
					Connection conn = DriverManager.getConnection(url, id, pass);
					PreparedStatement pstmt = conn.prepareStatement(
							"SELECT CONTENTNAME, HITS FROM CONTENT WHERE CONTENTCHECK = ? && CONTENTINDEX = ?;");

					System.out.println(contentCheck);
					System.out.println(contentIndex);
					pstmt.setInt(1, contentCheck);
					pstmt.setInt(2, contentIndex);
					ResultSet rs = pstmt.executeQuery();
					int hits = 0;

					while (rs.next()) {
						String contentName = rs.getString(1);
						hits = rs.getInt(2);
			%>


			<div class="col-md-1 col-xs-1 col-sm-1 no"></div>
			<div class="col-md-10 col-xs-10 col-sm-10" style="height: 50px; width: 50%;"><%=contentName%></div>
			<div class="col-md-10 col-xs-10 col-sm-10" id="viewHits" style="height: 50px; width: 33.3%; color: #7A7A7A; text-align: right;">��ȸ�� : <%=hits+1%></div>
			<div class="col-md-1 col-xs-1 col-sm-1 no"></div>
			<div></div>


			<%
				}
					PreparedStatement pstmt2 = conn.prepareStatement("UPDATE content SET hits = ? WHERE CONTENTCHECK = ? && CONTENTINDEX = ?;");
					pstmt2.setInt(1, hits+1);
					pstmt2.setInt(2, contentCheck);
					pstmt2.setInt(3, contentIndex);
					pstmt2.executeUpdate();
					
				} catch (SQLException e) {
					e.printStackTrace();
				}
			%>


		</div>
		<!-- ���� �� -->
		<!-- ���� -->
		<div class="row v_content">
			<div class="col-md-1 col-xs-1 col-sm-1 no"></div>
			<div class="col-md-10 col-xs-10 col-sm-10" style="height: 100%;">


				<%
					try {
						Connection conn = DriverManager.getConnection(url, id, pass);
						PreparedStatement pstmt = conn
								.prepareStatement("SELECT IMAGE FROM content WHERE CONTENTCHECK = ? && CONTENTINDEX = ?;");

						pstmt.setInt(1, contentCheck);
						pstmt.setInt(2, contentIndex);
						ResultSet rs = pstmt.executeQuery();
						int image = 0;

						while (rs.next()) {
							image = rs.getInt(1);
						}

						
				%>

				<!-- ����� ȯ�� -->
				<%
					String ua = request.getHeader("User-Agent").toLowerCase();

							if (ua.matches(".*(android|avantgo|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\\/|plucker|pocket|psp|symbian|treo|up\\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino).*") || ua.substring(0, 4).matches(
											"1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\\-(n|u)|c55\\/|capi|ccwa|cdm\\-|cell|chtm|cldc|cmd\\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\\-s|devi|dica|dmob|do(c|p)o|ds(12|\\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\\-|_)|g1 u|g560|gene|gf\\-5|g\\-mo|go(\\.w|od)|gr(ad|un)|haie|hcit|hd\\-(m|p|t)|hei\\-|hi(pt|ta)|hp( i|ip)|hs\\-c|ht(c(\\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\\-(20|go|ma)|i230|iac( |\\-|\\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\\/)|klon|kpt |kwc\\-|kyo(c|k)|le(no|xi)|lg( g|\\/(k|l|u)|50|54|e\\-|e\\/|\\-[a-w])|libw|lynx|m1\\-w|m3ga|m50\\/|ma(te|ui|xo)|mc(01|21|ca)|m\\-cr|me(di|rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\\-2|po(ck|rt|se)|prox|psio|pt\\-g|qa\\-a|qc(07|12|21|32|60|\\-[2-7]|i\\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\\-|oo|p\\-)|sdk\\/|se(c(\\-|0|1)|47|mc|nd|ri)|sgh\\-|shar|sie(\\-|m)|sk\\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\\-|v\\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\\-|tdg\\-|tel(i|m)|tim\\-|t\\-mo|to(pl|sh)|ts(70|m\\-|m3|m5)|tx\\-9|up(\\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|xda(\\-|2|g)|yas\\-|your|zeto|zte\\-")) {
				%>


				<!-- ĳ����(�ڵ� �ѱ��) ����, ��ȯ ����, �ε������� ���� -->
				<div id="carousel-example-generic" class="carousel slide" data-wrap="false">
				
				  <!-- Wrapper for slides -->
				  <div class="carousel-inner" role="listbox">
				    <div class="item active">
				      <img src="content/<%=al.get(3) %>" alt="...">
				    </div>
				    <%
				    	for (int i = 1; i < image; i++) {
				    %>
				    <div class="item">
				      <img src="content/<%=al.get(i+3) %>" alt="...">
				    </div>
				    <%
				    	}
				    %>
				  </div>
				
				  <!-- Controls -->
				  <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
				    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
				    <span class="sr-only">Previous</span>
				  </a>
				  <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
				    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
				    <span class="sr-only">Next</span>
				  </a>
				</div>


				<%
					} else {
					//response.sendRedirect("http://mysite.com/mobile_version");
					for (int i = 0; i < image; i++) {
						System.out.println(al.get(i+3));
				%>
				<!-- PC ȯ�� -->

				<img src="content/<%=al.get(i+3) %>">


				<%
					}
						}
					} catch (SQLException e) {
						e.printStackTrace();
					}
				%>


			</div>
			<div class="col-md-1 col-xs-1 col-sm-1 no"></div>
		</div>
		<!-- ���� �� -->
		
		<hr color="#D8D8D8" style="height: 3px;">
		<!-- ���� -->
		<div class="row v_ad">
			<div class="col-md-1 col-xs-1 col-sm-1 no"></div>
			<div class="col-md-10 col-xs-10 col-sm-10" style="height: 100%;">
				<img src="content/<%=al.get(2) %>">
			</div>
			<div class="col-md-1 col-xs-1 col-sm-1 no"></div>
		</div>
		<!-- ���� �� -->
	</div>
	<!-- ���� �� -->


	<!-- footer -->
	<footer class="footer">
		<div class="container">
			<div class="row">�̿��� | ��������ó����ħ | å���� �Ѱ�� �������� | ������ | ���� ����
			</div>
			<div class="row">&copy; TODAYDEA CORP.</div>
			<div class="row">�� �������� ���۱��� ���� �Ǵ� ����ó�� ������, �̸� ���� �̿��ϴ� ��� ���۱ǹ�
				� ���� ���� å���� �� �� �ֽ��ϴ�.</div>
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