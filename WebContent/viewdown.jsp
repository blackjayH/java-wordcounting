<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

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
				href="main.jsp"> <i class="fas fa-fw fa-tachometer-alt"></i> <span>WORDS
						COUNTING</span>
			</a></li>
			<li class="nav-item dropdown" ><a
				class="nav-link dropdown-toggle" href="main.jsp" id="pagesDropdown"
				role="button" data-toggle="dropdown" aria-haspopup="true"
				aria-expanded="false"form= "submit"action="main.jsp"> <i class="fas fa-fw fa-table"></i> <span>메인으로</span>


			</a></li>

		</ul>
		<div id="content-wrapper">

			<div class="container-fluid">

				<!-- Area Chart Example-->




				<!-- DataTables Example -->
				<div class="card mb-3">
					<div class="card-header">
						<i class="fas fa-table"></i> 워드 카운팅 결과 내림차순
					</div>
					<div class="card-body">
						<div class="table-responsive">
							<div id="dataTable_wrapper"
								class="dataTables_wrapper dt-bootstrap4">
								<div class="row">
									<div class="col-sm-12" style="witdh: 300px; height: 500px;">
										<%
											request.setCharacterEncoding("UTF-8");
											String searchwords = request.getParameter("searchwords");
											session.setAttribute("searchwords", searchwords);
											Connection conn = null;
											/*
											CallableStatement cstmt = null;
											try {
												Class.forName("com.mysql.jdbc.Driver");
												String url = "jdbc:mysql://localhost/mydb";
												conn = DriverManager.getConnection(url, "root", "wldnrwldnr1");
											
												cstmt = (CallableStatement) conn.prepareCall("{call result() }");
												cstmt.execute();
												out.println("프로시저 실행");
											} catch (SQLException e) {
												e.printStackTrace();
											} finally {
												try {
													cstmt.close();
												} catch (SQLException e) {
													e.printStackTrace();
												}
											
											}
											*/
											PreparedStatement pstmt = null;
											try {
												Class.forName("com.mysql.jdbc.Driver");
												String url = "jdbc:mysql://localhost/mydb";
												conn = DriverManager.getConnection(url, "root", "wldnrwldnr1");
												String sql = "select * from viewdown" ;
												pstmt = conn.prepareStatement(sql);

												ResultSet rs = pstmt.executeQuery();

												while (rs.next()) {
													out.print(rs.getString(1)+ " (");
													out.println(rs.getInt(2)+"개)<br>");
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
</html>
