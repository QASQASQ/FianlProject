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
	<title>Smarthr Admin Template</title>

	<!-- Favicon -->
	<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath }/assets/img/favicon.png">

	<!-- Apple Touch Icon -->
	<link rel="apple-touch-icon" sizes="180x180" href="${pageContext.request.contextPath }/assets/img/apple-touch-icon.png">

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
	<link rel="stylesheet" href="${pageContext.request.contextPath }/ssets/css/style.css">

</head>

<body class="bg-linear-gradiant">

	<div id="global-loader" style="display: none;">
		<div class="page-loader"></div>
	</div>

	<!-- Main Wrapper -->
	<div class="main-wrapper">

		<div class="container">
			<div>
				<div class="row justify-content-center align-items-center">
					
					<div class="col-md-8 d-flex justify-content-center align-items-center mx-auto">
						<div>
							<div class="error-images mb-4">
								<img src="${pageContext.request.contextPath }/assets/img/bg/error-500.svg" alt="image" class="img-fluid">
							</div>
							<div class="text-center">
								<h1 class="mb-3">500 ERROR</h1>
								<p class="fs-16 text-center">에러가 발생했습니다.<br>다시 시도해 주세요</p>
								<div class="d-flex justify-content-center pb-4">
									<a href="history.back()" class="btn btn-primary d-flex align-items-center"><i class="ti ti-arrow-left me-2"></i>뒤로가기</a>
								</div>
							</div>
						</div>
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

</html>