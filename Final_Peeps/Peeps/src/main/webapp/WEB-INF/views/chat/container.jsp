<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>container_jsp</title>
<link href="<c:url value="/resources/css/default.css" />"
	rel="stylesheet">
</head>

<body>

	<div id="container">
		<aside>
			<header>

				<div class="srch_bar">
					<div class="stylish-input-group">
						<span id="searchbar"><input type="text" placeholder="search user 👥" id="sr_input" style="width: 140px;">
							<button id="srch_b">
								<img src="<c:url value='/resources/images/icon/navi/search.png' />">
							</button></span>
					</div>
				</div>

			</header>
			<div class="rooms" id="roomdata">
				<ul>
				
				</ul>
			</div>
		</aside>

		<main>
			<header>
				<a id="rm_photo"></a>
				<div id="id_print">
					<input type="hidden" value="rm_idx" id="rm"> 
					<input type="hidden" id="rm_id">
					<h2 id="rm_idx"></h2>
				</div>
			</header>

			<div class="well" id="chatdata">
				<br /> <br />
				<!-- User Session Info Hidden -->
				<input type="hidden" value="${m_idx}" id="me"> 
				<input type="hidden" value="${id}" id="me_id">
				<h2 id="start">
					Peeps 채팅을 시작해 보세요 👩🏻 💻 <img id="startimg" src="<c:url value='/resources/images/start_2.png' />">
				</h2>

				<div class="msgImg">
					<div class="clearBoth"></div>

				</div>
				
				<!-- 21.03.08 한경 추가 -->
				<div id="msgContent"></div>
			</div>
		
			<footer>

				<img id="emt1" onclick="sendemt('emt1')" style="cursor: pointer"
				src="<c:url value='/resources/images/emoji/clap.png' />"> 
				<img id="emt2" onclick="sendemt('emt2')" style="cursor: pointer"
				src="<c:url value='/resources/images/blue.png' />"> 
				<img id="emt3" onclick="sendemt('emt3')" style="cursor: pointer"
				src="<c:url value='/resources/images/emoji/heart.png' />"> 
				<img id="emt4" onclick="sendemt('emt4')" style="cursor: pointer"
				src="<c:url value='/resources/images/KakaoTalk_20210127_164336960.png' />">
				<img id="emt5" onclick="sendemt('emt5')" style="cursor: pointer"
				src="<c:url value='/resources/images/smile.png' />">

				<div class="send">
					<input type="text" id="message" name="ch_ms" placeholder="Type your message" />
					<button type="button" id="sendBtn">전송</button>
				</div>

			</footer>

		</main>

	</div>

</body>
</html>