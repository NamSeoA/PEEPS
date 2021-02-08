<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="apple-touch-icon" sizes="76x76"
	href="resources/img/apple-icon.png">
<link rel="icon" type="image/png" href="resources/img/favicon.png">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>PEEPS 비밀번호 찾기</title>
<meta
	content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'
	name='viewport' />
<meta name="viewport" content="width=device-width" />

<!--     Fonts and icons     -->
<link
	href="http://netdna.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.css"
	rel="stylesheet">

<!-- CSS Files -->
<link href="<c:url value="/resources/css/bootstrap.min.css" />"
	rel="stylesheet">
<link href="<c:url value="/resources/css/gsdk-bootstrap-wizard.css"/>"
	rel="stylesheet" />

<!-- CSS Just for demo purpose, don't include it in your project -->
<link href="<c:url value="/resources/css/demo.css"/>" rel="stylesheet" />
<link href="<c:url value="/resources/css/reg.css"/>" rel="stylesheet" />
</head>
<style>
/* 21.02.01 로그인 css 추가*/
#login_img {
	width: 100px;
	height: 100px;
	float: left;
}

td {
	width: 200px;
}

h4 {
	text-align: center;
	font-size: 21px;
}
</style>
<body>
	<div class="image-container set-full-height"
		style="background-color: #fcf9f6">
		<div class="logo-container">
			<!-- 로고 넣기 -->
			<a href="<c:url value = "/" />"><img id="logo"
				src="${pageContext.request.contextPath}/resources/images/plus.png">
			</a>
		</div>

		<!--   Big container   -->
		<div class="container">
			<div class="row">
				<div class="col-sm-8 col-sm-offset-2">

					<!--      Wizard container        -->
					<div class="wizard-container">

						<div class="card wizard-card" id="wizardProfile">

							<!--        You can switch ' data-color="orange" '  with one of the next bright colors: "blue", "green", "orange", "red"          -->

							<div class="wizard-header">
								<h3>
									<b>PEEPS</b> <br>
								</h3>
							</div>

							<!-- nav css 수정하기 -->
							<div>
								<ul>
									<li id="top_nav">비밀번호 찾기</li>
								</ul>
							</div>
							<h4>찾으시려는 계정의 이메일과 아이디를 입력해주세요!</h4>
							<form id="FindForm" method="post">
								<div>
									<!-- 표 만들기 -->

									<table>
										<tr>
											<td rowspan="2"><img id="login_img"
												src="${pageContext.request.contextPath}/resources/images/plus.png"></td>
											<td>
												<div class="form-group-left">
													<input type="email" class="login_text" id="email"
														name="email" placeholder=" 이메일">
												</div>
											</td>

										</tr>
										<tr>
											<td>
												<div class="form-group-right">
													<input type="text" class="login_text" id="id" name="id"
														placeholder=" 아이디 ">
												</div>
											</td>
										</tr>
									</table>
								</div>

								<input type="submit" id="sign_btn" value="비밀번호 찾기" />
							</form>
							<div class="wizard-footer height-wizard">
								<div class="clearfix">
									<br>
								</div>
							</div>

						</div>
					</div>
					<!-- wizard container -->
				</div>
			</div>
			<!-- end row -->
		</div>
		<!--  big container -->

		<div class="footer">
			PEEPS<i class="fa fa-heart heart"></i>GNJKK
		</div>

	</div>

</body>
<!--   Core JS Files   -->
<script src="<c:url value="/resources/js/jquery-2.2.4.min.js"/>"
	type="text/javascript"></script>
<script src="<c:url value="/resources/js/bootstrap.min.js"/>"
	type="text/javascript"></script>
<script src="<c:url value="/resources/js/jquery.bootstrap.wizard.js"/>"
	type="text/javascript"></script>

<!--  Plugin for the Wizard -->
<%-- <script src="<c:url value="/resources/js/gsdk-bootstrap-wizard.js"/>"></script> --%>

<!--  More information about jquery.validate here: http://jqueryvalidation.org/	 -->
<script src="<c:url value="/resources/js/jquery.validate.min.js"/>"></script>

<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
	$(function(){
		
		var email = $('#email').val();
		console.log(email);
		
		$("#sign_btn").click(function(){
			$.ajax({
				url : "${pageContext.request.contextPath}/member/find",
				type : "POST",
				data : {
					id : $("#id").val(),
					email : $("#email").val()
				},
				success : function(data) {
					if(data==1){
						alert("메일을 발송하였습니다.");
						console.log("보내짐");
						location.href = "${pageContext.request.contextPath}/TimeLime?email="+email
					} else{
						alert("회원 정보가 일치하지 않습니다.");
						location.href = "${pageContext.request.contextPath}/member/find"
					}
					
					
				},
			})
		});
	})
</script>

</html>