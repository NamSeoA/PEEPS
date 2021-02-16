<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- css -->
<link rel="styleSheet" href="<c:url value="/css/default.css"/>">

<style>
#right {
	text-align: right;
	width: auto;
	max-width: 70%;
	background-color: #F2D665;
	border-radius: 5px;
	margin: 30px;
	word-wrap: break-word;
}

#left {
	text-align: left;
	width: auto;
	max-width: 70%;
	background-color: #F4F4F4;
	border-radius: 5px;
	margin: 30px;
	word-wrap: break-word;
}
</style>

<!-- SocketJS CDN -->
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
</head>

<body>
</body>

<script>
	sock = new SockJS("<c:url value="/chat"/>");

	sock.onopen = onOpen;
	sock.onmessage = onMessage;
	sock.onclose = onClose;	
	
	$(document).ready(function() {
		$('#message').keypress(function(event) {
			var keycode = (event.keyCode ? event.keyCode : event.which);
			if (keycode == '13') {
				sendMessage();
			}
			event.stopPropagation();
		});

		$('#sendBtn').click(function() {
			sendMessage();
			console.log("sendMessage() - 메서드 실행 ");	
		});		
		
		$.ajax({
			url : "requestObject",
			type : "POST",
		    success: function(msg) {
		 
		       var text = msg.responseText,
		       text = text.replace(/(<([^>]+)>)/ig,""); //HTML 태그 모두 공백으로 대체
		       text = '[' + text + ']';
		       var json = $.parseJSON(text);
		       
		       var rain_state = json[0].response.body.items.item[1].obsrValue;
		       var rain = json[0].response.body.items.item[3].obsrValue;
		       var sky = json[0].response.body.items.item[4].obsrValue;
		       var temperature = json[0].response.body.items.item[5].obsrValue;
		       
		           if(rain_state != 0) {
		               switch(rain_state) {
		                   case 1:   // 비
		                           $("#chatdata").css({"background":"url(/icon/sun.jpg)"});
		                           console.log('비');
		                       break;
		                   case 2:   // 비/눈
		                      $("#chatdata").css({"background":"url(/icon/snow.jpg)"});
		                      console.log('비/눈);
		                       break;
		                   case 3:   // 눈
		                      $("#chatdata").css({"background":"url(/icon/snow.jpg)"});
		                      console.log(' 눈');
		                       break;
		               }
		           }else {
		               switch(sky) {
		                   case 1:   // 맑음
		                      $("#chatdata").css({"background":"url(/icon/sun.jpg')"});
		                      console.log('맑음');
		                       break;
		                   case 3:   // 구름 많음
		                      $("#chatdata").css({"background":"url(/icon/snow.jpg')"});
		                      console.log('구름 많음');
		                       break;
		                   case 4:   // 흐림
		                      $("#chatdata").css({"background":"url(/icon/navi/search.png')"});
		                      console.log('흐림');
		                       break;
		                   }    
		               } //if 종료
		               $("#chatdata").css({"background":"url(/icon/sun.jpg')"});
		               console.log('날씨 해당 없음');
		        } //success func 종료
		    })    
		}

		
		
		
		
		
		
	});

	function onOpen() {
		console.log('open');
	};

	function sendMessage() {
		//	var t = getTimeStamp();
		var date = new Date();		// 자바스크립트 Date 객체
		var str = date.toJSON();	// Date 객체를 JSON 형식의 문자열로 변환
			
		var mes = {
			ch_idx : '1',
			m_idx : '${m_idx}',
			rm_idx : '${rm_idx}', 
			ch_ms : $("#message").val(),
			ch_time :  str
		}

		if(mes != ""){
		
		sock.send(JSON.stringify(mes));
		console.log(JSON.stringify(mes));
		console.log('위 메세지 소켓에 전송');
	
	} else {
		return false;
	}
		
	} 
	
	function onMessage(evt) {
				var data = evt.data;
				var obj = JSON.parse(data);
				
				var currentuser_session = $('#sessionuserid').val();
		
				if(obj != ""){
				
				if (obj.m_idx == currentuser_session) { //m_idx = m_idx
					var printHTML = "<div id='right'>";
					printHTML += "<strong>" + obj.m_idx + "</strong> <br>";
					printHTML += "<strong>" + obj.ch_ms + "</strong> <br>";
					printHTML += "<strong>" + obj.ch_time + "</strong> <br>";
					printHTML += "</div>";
		
					$('#chatdata').append(printHTML);
		
				} else {
					var printHTML = "<div id='left'>";
					printHTML += "<strong>" + obj.m_idx + "</strong> <br>";
					printHTML += "<strong>" + obj.ch_ms + "</strong> <br>";
					printHTML += "<strong>" + obj.ch_time + "</strong> <br>";
					printHTML += "</div>";
		
					$('#chatdata').append(printHTML);
			  }
				}else {
					return false;
				}
	};

	function onClose() {
		console.log('console close');
	};

	
	
</script>
</html>