<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*"%>

<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.jsoup.Jsoup"%>
<%@ page import="org.jsoup.nodes.Document"%>
<%@ page import="java.util.StringTokenizer"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
	long start = System.currentTimeMillis();
%>
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>분산병렬 프로젝트</title>




<!-- Bootstrap core CSS-->
<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom fonts for this template-->
<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
	type="text/css">

<!-- Page level plugin CSS-->
<link href="vendor/datatables/dataTables.bootstrap4.css"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="css/sb-admin.css" rel="stylesheet">

<link href="css/text.css" rel="stylesheet">
<body id="page-top">

	<nav class="navbar navbar-expand navbar-dark bg-dark static-top"
		style="background: #003f5d !important;"> <a
		class="navbar-brand mr-1" href="#">WORDS COUNTING PROGRAM</a>

	<button class="btn btn-link btn-sm text-white order-1 order-sm-0"
		id="sidebarToggle" href="#">
		<i class="fas fa-bars"></i>
	</button>

	<!-- Navbar Search -->
	<form method="post" action="result.jsp"
		class="d-none d-md-inline-block form-inline ml-auto mr-0 mr-md-3 my-2 my-md-0">
		<div class="input-group">
			<input type="text" name="searchwords" class="form-control"
				placeholder="찾는 단어 검색.." aria-label="Search"
				aria-describedby="basic-addon2">
			<div class="input-group-append">
				<button type="submit" name="searchbutton" class="btn btn-primary"
					style="color: #fff; background-color: #424c56 !important; border-color: #424c56 !important;">
					<i class="fas fa-search"></i>
				</button>
			</div>


		</div>
	</form>

	<!-- Navbar -->
	<ul class="navbar-nav ml-auto ml-md-0">
		<li class="nav-item dropdown no-arrow mx-1"><a
			class="nav-link dropdown-toggle" href="#" id="alertsDropdown"
			role="button" data-toggle="dropdown" aria-haspopup="true"
			aria-expanded="false"> <i class="fas fa-fw fa-chart-area"></i> <span
				class="badge badge-danger">SPEED?</span>
		</a>
			<div class="dropdown-menu dropdown-menu-right"
				aria-labelledby="alertsDropdown">
				<a class="dropdown-item" href="#">속도</a>
				<!--DB 수에따른 속도 -->
			</div></li>
	</ul>

	</nav>

	<div id="wrapper">
		<!-- Sidebar -->

		<ul class="sidebar navbar-nav">
			<li class="nav-item active"><a class="nav-link"
				href="index.html"> <i class="fas fa-fw fa-tachometer-alt"></i> <span>WORDS
						COUNTING</span>
			</a></li>
			<li class="nav-item dropdown"><a
				class="nav-link dropdown-toggle" href="main.jsp" id="pagesDropdown"
				role="button" data-toggle="dropdown" aria-haspopup="true"
				aria-expanded="false"> <i class="fas fa-fw fa-table"></i> <span>메인으로</span>


			</a></li>

		</ul>
		<div id="content-wrapper">

			<div class="container-fluid">

				<!-- Area Chart Example-->




				<!-- DataTables Example -->
				<div class="card mb-3">
					<div class="card-header">
						<i class="fas fa-table"></i> 워드 카운팅 결과
					</div>
					<div class="card-body">
						<div class="table-responsive">
							<div id="dataTable_wrapper"
								class="dataTables_wrapper dt-bootstrap4">
								<div class="row">
									<div class="col-sm-12" style="witdh: 300px; height: 500px;">
										<%
											ArrayList<String> strs = new ArrayList<>();
											BufferedReader in = null;
											request.setCharacterEncoding("UTF-8");
											String searchwords = request.getParameter("searchwords");
											session.setAttribute("searchwords", searchwords);
											Class.forName("com.mysql.jdbc.Driver");
											String url = "jdbc:mysql://localhost/mydb";
											Connection conn = null;
											conn = DriverManager.getConnection(url, "root", "wldnrwldnr1");
											String surl;
											PreparedStatement pstmt = null;
											CallableStatement cstmt = null;
											try {

												cstmt = (CallableStatement) conn.prepareCall("{call wordcounting() }");
												cstmt.execute();
												System.out.println("프로시저 실행1");
											} catch (SQLException e) {
												e.printStackTrace();
											} finally {
												try {
													cstmt.close();
												} catch (SQLException e) {
													e.printStackTrace();
												}

											}
											for (int j = 0; j < 2; j++) {
												surl = "https://search.naver.com/search.naver?&where=news&query=%EB%89%B4%EC%8A%A4&sm=tab_pge&sort=0&photo=0&field=0&report"
														+ "er_article=&pd=0&ds=&de=&docid=&nso=so:r,p:all,a:all&mynews=0&cluster_rank=10&start="
														+ j * 10 + 1 + "&refresh_start=0";

												Document document = Jsoup.connect(surl).get(); // document 객체 생성.

												String temp = document.toString();
												temp = temp.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
												temp = temp.replaceAll("/(<([^>]+)>)/ig", "");
												temp = temp.replaceAll("[0-9]", "");
												String match = "[^\uAC00-\uD7A3xfe0-9a-zA-Z가-힣\\s]"; // 특수문자 전부 제거(알파벳 숫자 한글만 남김)

												temp = temp.replaceAll(match, ""); // 특수문자 전부 ""로 대체
												temp = temp.toLowerCase(); // 알파벳 전부 소문자로 변경
												temp = temp.replaceAll("1", "");
												temp = temp.replaceAll("l", "");
												
												StringTokenizer st = new StringTokenizer(temp);
												String str; // 임시 토큰 변수
												while (st.hasMoreTokens()) {
													str = st.nextToken();
													//out.print(str+"<br>");
													strs.add(str);
												}
											}
											/*
											try {
												in = new BufferedReader(new FileReader("C:/Users/HONG/workspace/project/WebContent/Img/46-0.txt")); // 소설 파일 읽기
												String read = null;
											
												while ((read = in.readLine()) != null) { // 한줄씩 읽기
													String match = "[^\uAC00-\uD7A3xfe0-9a-zA-Z가-힣\\s]"; // 특수문자 전부 제거(알파벳 숫자 한글만 남김)
													read = read.replaceAll(match, ""); // 특수문자 전부 ""로 대체
											
													// String str = "/([ㄱ-ㅎ가-?ㅏ-ㅣ])+[은|는|이|가](\\s)+/g, '')";
											
													read = read.toLowerCase(); // 알파벳 전부 소문자로 변경
											
													// System.out.println(read);
													StringTokenizer st = new StringTokenizer(read); // 한줄을 토큰 단위로 분해
													String str; // 임시 토큰 변수
													String s;
													while (st.hasMoreTokens()) {
														str = st.nextToken();
														strs.add(str);
													}
											
												}
												// System.out.println("데이터 읽어서 저장 완료");
											} catch (IOException e) {
												System.out.println("어디선가 오류 발생: " + e);
												e.printStackTrace();
											} finally {
												try {
													in.close();
												} catch (Exception e) {
												}
											}
											
											for (int i = 0; i < strs.size(); i++) {
											
												out.println(strs.get(i));
												//    pstmt.setString(1, strs.get(i));
												// pstmt.executeUpdate();
											}
											*/

											try {

												String s = "INSERT INTO wordstore VALUES(?);";

												for (int i = 0; i < strs.size(); i++) {
													pstmt = conn.prepareStatement(s);
													pstmt.setString(1, strs.get(i));
													pstmt.executeUpdate();
													//out.println(strs.get(i));
												}

											} catch (SQLException e) {
												e.printStackTrace();
											} finally {
												try {
													pstmt.close();
												} catch (SQLException e) {
													e.printStackTrace();
												}

											}

											try {

												cstmt = (CallableStatement) conn.prepareCall("{call result() }");
												cstmt.execute();
												System.out.println("프로시저 실행2");
											} catch (SQLException e) {
												e.printStackTrace();
											} finally {
												try {
													cstmt.close();
												} catch (SQLException e) {
													e.printStackTrace();
												}

											}
											try {

												String sql = "select * from res";
												pstmt = conn.prepareStatement(sql);

												ResultSet rs = pstmt.executeQuery();

												while (rs.next()) {
													out.print(rs.getString(1) + " (");
													out.print(rs.getInt(2) + ")개<br>");
												}
												rs.close();
												pstmt.close();
												conn.close();
											} catch (Exception e) {
												System.out.println(e);
											}
										
										%>







									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="card-footer small text-muted">words counting
						program</div>
				</div>

			</div>
			<!-- /.container-fluid -->

		</div>
		<!-- /.content-wrapper -->

	</div>
	<!-- /#wrapper -->
	</div>



</body>
<%
	long end = System.currentTimeMillis(); //프로그램이 끝나는 시점 계산
	System.out.println("실행 시간 : " + (end - start) / 1000 + "초");
%>
<script>
	window.onload = function() {
		var time =
<%=(end - start) / 1000%>
	;
		alert(time + "초 걸렸습니다.")

	}
</script>
</html>