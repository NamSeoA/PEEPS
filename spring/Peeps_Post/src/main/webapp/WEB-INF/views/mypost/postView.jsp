<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 작성 페이지</title>
</head>
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap')
	;
</style>

<style>
body {
	background-color: #fcf9f6;
	font-family: 'Nanum Gothic', sans-serif;
}

.post_wrap {
	width: 1000px;
	height: auto;
	background-color: white;
	margin: 200px auto;
	border: 1px solid #eef0ed;
}

.post {
	margin: 80px auto 65px;
}

.postuserphoto {
	width: 50px;
	height: 50px;
	border-radius: 50px;
}

.postuserphoto, .id, .followchk {
	float: left;
	margin-right: 10px;
}

.id, .followchk {
	/* height: 50px;
	line-height: 300%; */
	font-weight: 800;
	font-size: 20px;
	margin-top: 15px;
}

.ptitle {
	width: 800px;
	height: 50px;
	font-size: 1.5em;
	border-top: 2px solid #ccc;
	border-bottom: 2px solid #ccc;
	display: table-cell;
    vertical-align: middle;
}

.post_datenbutton {
	padding: 10px;
}

.pdate {
	/* text-align: right;  */
	float: left;
	font-weight: 800;
	font-size: 20px;
    margin: 10px 0;
}

.post_datenbutton>input {
	float: right;
	margin-left: 20px;
	font-size: 15px;
	border: 0px solid;
	width: 80px;
	height: 40px;
	font-family: 'Nanum Gothic', sans-serif;
}



.post_photoinput {
	margin: 20px 0;
}

.pcontent {
	resize: none;
	width: 770px;
	height: 600px;
	font-size: 1.2em;
	font-family: 'Nanum Gothic', sans-serif;
	padding: 15px;
	margin-top: 15px;
	margin-bottom: 5px;
}

.pcontent::-webkit-scrollbar {
	display: none;
}
/* 스크롤바 숨김 & 스크롤 정상 작동 */
.post_cnclorsubmt {
	text-align: right;
}

.post_cnclorsubmt>input {
	margin: 20px 0 0 20px;
	width: 100px;
	height: 40px;
	font-size: 1.1em;
	font-family: 'Nanum Gothic', sans-serif;
}
</style>

<!--jquery 라이브러리 로드-->
<script src="https://code.jquery.com/jquery-1.12.4.min.js" 
		integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ=" 
		crossorigin="anonymous">
</script>    

<body>

	<div class="post_wrap">
		<form method="post" enctype="multipart/form-data">
		<table class="post">
			<tr>
				<td class="post_top_wrap">
					<div class="post_top">
						<img class="postuserphoto" src="<spring:url value='/resources/img/cuteuserphoto.jpg'/>">
						<span class="id" >hxnky__</span>
						<span class="followchk" >·팔로잉</span>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="ptitle" name="ptitle">
					나만 없어 댕댕이...
					</div>
				</td>
			</tr>
			<tr>
				<td class="post_datenbutton">
					<%
						Date now = new Date();
						SimpleDateFormat ymd = new SimpleDateFormat("yyyy.MM.dd");
						SimpleDateFormat hms = new SimpleDateFormat("hh.mm.ss");
					%>
					<span class="pdate"><%= ymd.format(now) %></span>
					<input type="button" value="삭제">
					<input type="button" value="수정">
				</td>
			</tr>
			<tr>
				<td>
					<div>
						포토존
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div>
					
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="ploc">
						위치
					</div>
				</td>
			</tr>
			<tr>
				<td class="post_cnclorsubmt">
					<input type="button" value="취소">
					<input type="submit" value="등록">
				</td>
			</tr>
		</table>
		</form>
	</div>

</body>
</html>
