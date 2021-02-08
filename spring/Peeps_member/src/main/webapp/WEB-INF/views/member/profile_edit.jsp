<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로필 편집</title>

<link href="<c:url value="/resources/css/edit.css" />" rel="stylesheet">
</head>
<style>
# /*공통인부분*/
body {
	background-color: #fcf9f6;
}

#total_wrap {
	margin: 100px auto;
	height: 800px;
	width: 1500px;
}

#edit_menu {
	margin-top: 100px;
	height: 600px;
	width: 490px;
	float: left;
	text-align: center;
	border-right: solid 0.2px #CCC;
}

/*공통 끝*/
#edit_table {
	margin: 50px;
	height: 600px;
	width: 800px;
	float: right;
}

#table_right {
	font-weight: bold;
}

#table_right>input, #edit_bio {
	width: 300px;
	margin: 10px auto;
}

#choose {
	display: none;
}

#choose_btn {
	background-color: #fcf9f6;
	border: 0;
	outline: 0;
	font-size: 20px;
	margin-left: 13px;
	font-weight: bold;
}

#choose_btn:hover {
	cursor: pointer;
}

#profile {
	width: 200px;
	height: 200px;
	border-radius: 100%;
	text-align: center;
}

#edit_text {
	border: solid 0.2px #CCC;
	border-radius: 5%;
	height: 30px;
	width: 300px;
	font-size: 15px;
}

#edit_bio {
	border: solid 0.2px #CCC;
	border-radius: 5%;
	height: 50px;
	width: 300px;
	font-size: 15px;
}

#change {
	margin-left: 420px;
	width: 80px;
	height: 30px;
	font-size: 15px;
}

#menu_btn {
	margin-top: 80px;
}

h3 {
	display: inline;
}

#menu_btn>button {
	background-color: #fcf9f6;
	border: none;
	font-size: 35px;
	font-weight: bold;
	width: 300px;
	margin: 50px auto;
}
</style>
<body>
<!-- 	<div id="nav"> -->
<!-- 		<nav> -->
<!-- 			<ul class="icon"> -->
<!-- 				아이콘 경로 바꾸기 -->
<!-- 				<li class="left"><span><input type="search" -->
<!-- 						placeholder="검색"> <a href="/user/find_id"> -->
<!-- 							<button type="submit"> -->
<!-- 								<img -->
<%-- 									src="<c:url value="/resources/images/icon/navi/search.png"/>"> --%>

<!-- 							</button> -->
<!-- 					</a></span></li> -->
<!-- 				사진 크기 커서 주석처리 해놓음 -->
<!-- 								<li class="center"><a id="Logo"><img -->
<%-- 										src="<c:url value="/resources/images/plus.png"/>"></a></li> --%>

<!-- 				<li class="right"><a id="Home" href="#"><img -->
<%-- 						src="<c:url value="/resources/images/icon/navi/023-home.png"/>"></a> --%>
<!-- 					<a id="Content" href="#"><img -->
<%-- 						src="<c:url value="/resources/images/icon/navi/Content.png"/>"></a> --%>
<!-- 					<a id="Alarm" href="#"><img -->
<%-- 						src="<c:url value="/resources/images/icon/navi/008-notification.png"/>"></a> --%>
<!-- 					<a id="Chat" href="#"><img -->
<%-- 						src="<c:url value="/resources/images/icon/navi/050-wechat.png"/>"></a> --%>
<!-- 					<a id="MyPage" href="#"><img -->
<%-- 						src="<c:url value="/resources/images/icon/navi/010-user.png"/>"></a> --%>
<!-- 				</li> -->

<!-- 			</ul> -->

<!-- 		</nav> -->

<!-- 		<!-- 네비 바 들어갈 부분 --> -->
<!-- 	</div> -->
	<div id="total_wrap">
		<div id="edit_menu">
			<div id="menu_btn">
				<h3 id="email">${peeps.email}</h3>
				<h3>님</h3>
				<br>
				<button id="edit">프로필 편집</button>
				<button id="pw_ch">비밀번호 변경</button>
				<button id="delete">탈퇴하기</button>
			</div>
		</div>
		<div>
			<form id="edit_form" method="post" enctype="multipart/form-data">
				<table id="edit_table">
					<tr>
						<td id="table_left" rowspan="3"><img id="profile"
							src="<c:url value="${peeps.m_photo}"/>"><br> <input
							type="file" id="choose" name="m_photo" accept="img/*"><br>
							<button type="button" id="choose_btn">프로필 사진 바꾸기</button></td>

						<td id="table_right">아이디 <br> <input type="text"
							id="edit_text" name="id" value="${peeps.id}">
						</td>
					</tr>
					<tr>
						<td id="table_right">이름 <br> <input type="text"
							id="edit_text" name="name" value="${peeps.name}">
						</td>
					</tr>
					<tr>
						<td id="table_right">소개글 <br> <input type="text"
							id="edit_bio" name="bio" value="${peeps.bio}">
						</td>
					</tr>
					<tr>
						<td colspan="2"><input type="submit" id="change" value="변경">
						</td>
					</tr>
				</table>
			</form>
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


<script>
	$(function() {
		//버튼 클릭시 업로드창 실행
		$('#choose_btn').click(function() {
			console.log('fileadd');
			$("input[name='m_photo']").click();

		})

		//이미지 클릭시 업로드창 실행
		$('#profile').click(function() {
			console.log('fileadd');
			$("input[name='m_photo']").click();

		})
	});

	// 이미지로 파일 선택 시 미리보기
	function readURL(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();

			reader.onload = function(e) {
				$('#profile').attr('src', e.target.result);
			}

			reader.readAsDataURL(input.files[0]);
		}
	}

	$("#choose").change(function() {
		readURL(this);
	});
</script>

<script>
	$(function() {

		var email = $('#email').text();

		$("#edit")
				.click(
						function() {

							location.href = "${pageContext.request.contextPath}/profile/Info?email="
									+ email;

						});

		$("#pw_ch")
				.click(
						function() {

							location.href = "${pageContext.request.contextPath}/profile/pw?email="
									+ email;

						});

		$("#delete")
				.click(
						function() {

							location.href = "${pageContext.request.contextPath}/profile/delete?email="
									+ email;

						});
	})
</script>
</html>