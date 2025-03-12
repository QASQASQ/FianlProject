<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
	<meta name="description" content="Smarthr - Bootstrap Admin Template">
	<meta name="keywords" content="admin, estimates, bootstrap, business, html5, responsive, Projects">
	<meta name="author" content="Dreams technologies - Bootstrap Admin Template">
	<meta name="robots" content="noindex, nofollow">
	<title>HRMS LOGIN</title>

	<!-- Favicon -->
	<link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.png">

	<!-- Apple Touch Icon -->
	<link rel="apple-touch-icon" sizes="180x180" href="assets/img/apple-touch-icon.png">

	<!-- Bootstrap CSS -->
	<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/bootstrap.min.css">

	<!-- Feather CSS -->
	<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/plugins/icons/feather/feather.css">

	<!-- Tabler Icon CSS -->
	<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/plugins/tabler-icons/tabler-icons.css">

	<!-- Fontawesome CSS -->
	<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/plugins/fontawesome/css/fontawesome.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/plugins/fontawesome/css/all.min.css">

	<!-- Main CSS -->
	<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/style.css">
	
	
	<script type="text/javascript">
	
	</script>
	
</head>

<body class="bg-linear-gradiant">

	<div id="global-loader" style="display: none;">
		<div class="page-loader"></div>
	</div>

	<!-- Main Wrapper -->
	<div class="main-wrapper">
		<div class="container-fuild">
			<div class="w-100 overflow-hidden position-relative flex-wrap d-block vh-100">
				<div class="row justify-content-center align-items-center vh-100 overflow-auto flex-wrap ">
					<div class="col-md-4 mx-auto vh-100">
						<form action="/login" method="post" class="vh-100">
							<div class="vh-100 d-flex flex-column justify-content-between p-4 pb-0">
								<div class=" mx-auto mb-5 text-center">
								</div>
								<div class="">
									<div class="text-center mb-3">
									<img src="${pageContext.request.contextPath }/assets/img/logoStart.png"
											class="img-fluid" style="width: 300px; height: 100px;" alt="Logo">
									</div>
									<div class="mb-3">
										<label class="form-label">아이디(사번)</label>
										<div class="input-group">
											<input type="text" value="" style="font-size: 20px; height: 40px;" class="form-control border-end-0" id="username" name="username">
											<span class="input-group-text border-start-0">
												<i class="ti ti-mail"></i>
											</span>											
										</div>
										<div class="form-label" style="color:red;">${errorMessage}</div>
									</div>
									<div class="mb-3">
										<label class="form-label">비밀번호</label>
										<div class="pass-group">
											<input type="password" style="font-size: 20px; height: 40px;" class="pass-input form-control" id="oasswird" name="password">
											<span class="ti toggle-password ti-eye-off"></span>
										</div>
									</div>
									<br/>
									<div class="mb-3">
										<input type="submit" style="font-size: 20px; height: 50px;" value="로그인" class="btn btn-primary w-100">
									</div>
								</div>
								<div class="mt-5 pb-4 text-center">
									
									<p class="mb-0 text-gray-9">Copyright &copy; 2025 - HERMES</p>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- /Main Wrapper -->

	<!-- jQuery -->
	<script src="${pageContext.request.contextPath }/assets/js/jquery-3.7.1.min.js"></script>

	<!-- Bootstrap Core JS -->
	<script src="${pageContext.request.contextPath }/assets/js/bootstrap.bundle.min.js"></script>

	<!-- Feather Icon JS -->
	<script src="${pageContext.request.contextPath }/assets/js/feather.min.js"></script>

	<!-- Custom JS -->
	<script src="${pageContext.request.contextPath }/assets/js/script.js"></script>

</body>
<script type="text/javascript">
let queryStr = window.location.search;
console.log(queryStr);
</script>
</html>