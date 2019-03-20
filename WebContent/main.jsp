<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>분산병렬 프로젝트</title>


<!--타이머 -->
<style>
body {
	font-size: 15px;
}

.timer {
	background: #cecece63;
	display: inline-block;
	padding: 0.9em 2.2em;
	font-size: 1.6em;
	color: black;
	align: center;
}

button--wrap {
	display: block;
}
</style>

<script>
	document.addEventListener('DOMContentLoaded', function() {
		// Global Scope Variables
		var hours = document.getElementById('hour'), minutes = document
				.getElementById('min'), seconds = document
				.getElementById('sec'), start = document
				.getElementById('start'), clear = document
				.getElementById('clear'), stop = document
				.getElementById('stop'), sec = 0;
		// functions
		function pad(val) {
			return val > 9 ? val : "0" + val;
		}
		function start() {
			alert('힛');
		}
		function timer() {
			++sec;
			seconds.innerHTML = pad(sec % 60);
			minutes.innerHTML = pad(parseInt(sec / 60, 10) % 60);
			hours.innerHTML = pad(parseInt(sec / 3600, 10) % 60);
			/*   if (sec==3){
			      alert('응');
			      clearInterval(intervalId);

			   }
			 */
		}
		// Event Listeners  
		button.addEventListener('click', function() {
			//location.href = 'test.jsp';
			intervalId = setInterval(timer, 1000);
			this.setAttribute('disabled', true)

		});

	});
</script>
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


	<form method="post" action="searchword.jsp"
		class="d-none d-md-inline-block form-inline ml-auto mr-0 mr-md-3 my-2 my-md-0">
		<div class="input-group">
			<select name="class_1" onchange="location.href=this.value">
				<option>선택해주세요</option>
				<option value="viewup.jsp">오름차순</option>
				<option value="viewdown.jsp">내림차순</option>
				<option value="viewmost.jsp">최대단어</option>
				<option value="viewleast.jsp">최소단어</option>
			</select> <input type="text" name="searchwords" class="form-control"
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
				class="nav-link dropdown-toggle" href="#" id="pagesDropdown"
				role="button" data-toggle="dropdown" aria-haspopup="true"
				aria-expanded="false"> <i class="fas fa-fw fa-table"></i> <span>DB1</span>
			</a> <!-- 
            <div class="dropdown-menu" aria-labelledby="pagesDropdown">
               <h6 class="dropdown-header">WHAT</h6>
               <a class="dropdown-item" href="#">SHOULD</a> <a
                  class="dropdown-item" href="#">WE</a> <a class="dropdown-item"
                  href="#">DO</a>
            </div> --></li>
			<li class="nav-item"><a class="nav-link" href="#"> <i
					class="fas fa-fw fa-table"></i> <span>DB2</span>
			</a></li>
			<li class="nav-item"><a class="nav-link" href="#"> <i
					class="fas fa-fw fa-table"></i> <span>DB4</span>
			</a></li>
		</ul>

		<div id="content-wrapper">
			<div class="container-fluid">
				<!-- DataTables Example -->
				<div class="card mb-3">
					<div class="card-header">
						<i class="fas fa-table"></i> 워드 카운팅 메인화면
					</div>
					<div align="center" class="card-header">
						<!-- /.container-fluid -->
						<div align="center" class="image" width=200px; height=200px;>
							<img id="button" src="Img/time.png"
								onclick="location='result.jsp'">
						</div>

						<div align="center" class="timer"font-family:'Oswald', sans-serif;">
							<span style="font-size: 4em;" id="hour" align-text="center">00</span><span
								style="font-size: 4em;"> : </span> <span style="font-size: 4em;"
								id="min" align-text="center">00</span><span
								style="font-size: 4em;"> : </span> <span style="font-size: 4em;"
								id="sec" align-text="center">00</span>
						</div>

						<div align="center" class="button--wrap" width=40px;
							height=40px;font-family:'Oswald', sans-serif;">
							<span>시계를 눌러주세요 워드카운팅을 시작합니다</span>
						</div>

					</div>
					<!-- /.content-wrapper -->
				</div>
				<!-- /#wrapper -->
			</div>
		</div>


		<!-- Scroll to Top Button-->
		<a class="scroll-to-top rounded" href="#page-top"> <i
			class="fas fa-angle-up"></i>
		</a>

		<!-- Bootstrap core JavaScript-->
		<script src="vendor/jquery/jquery.min.js"></script>
		<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

		<!-- Core plugin JavaScript-->
		<script src="vendor/jquery-easing/jquery.easing.min.js"></script>

		<!-- Page level plugin JavaScript-->
		<script src="vendor/chart.js/Chart.min.js"></script>
		<script src="vendor/datatables/jquery.dataTables.js"></script>
		<script src="vendor/datatables/dataTables.bootstrap4.js"></script>

		<!-- Custom scripts for all pages-->
		<script src="js/sb-admin.min.js"></script>

		<!-- Demo scripts for this page-->
		<script src="js/demo/datatables-demo.js"></script>
		<script src="js/demo/chart-area-demo.js"></script>
</body>
</html>