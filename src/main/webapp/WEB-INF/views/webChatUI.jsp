<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="/assets/css/chat_ui.css" />
</head>
<body>
	<script type="text/javascript">
		var messageWindow;
		var inputMessage;
		var chat_id;
		var webSocket;
		var logWindow;

		window.onload = function() {
			messageWindow = document.getElementById("messageWindow");
			messageWindow.scrollTop = messageWindow.scrollHeight;
			inputMessage = document.getElementById('inputMessage');
			chat_id = document.getElementById('chat_id').value;
			logWindow = document.getElementById('logWindow');

			webSocket = new WebSocket('ws://localhost:8088/EchoServer');
			webSocket.onopen = function(event) {
				wsOpen(event);
			};
			webSocket.onmessage = function(event) {
				wsMessage(event);
			};
			webSocket.onclose = function(event) {
				wsClose(event);
			};
			webSocket.onerror = function(event) {
				wsError(event);
			};
		}
		function wsOpen(event) {
			writeResponse("연결성공");
		}
		function wsMessage(event) {
			var message = event.data.split("|");
			var sender = message[0];
			var content = message[1];
			var msg;

			writeResponse(event.data);
			if (content == "" || content == undefined) {
				//날라온 내용이 없으므로 아무것도 하지않는다.
			} else {
				//내용에 / 가 있다면 귓속말이므로...
				if (content.match("/")) {
					//해당 아이디(닉네임) 에게만 디스플레이 한다.
					if (content.match(("/" + chat_id))) {
						var temp = content.replace(("/" + chat_id), "[귓속말]");
						//메세지에 UI를 적용하는 부분
						msg = makeBalloon(sender, temp);
						messageWindow.innerHTML += msg;

						//대화영역의 스크롤바를 항상 아래로 내려준다. 
						messageWindow.scrollTop = messageWindow.scrollHeight;
					}
				} else {
					//귓속말이 아니면 모두에게 디스플레이 한다.
					msg = makeBalloon(sender, content);
					messageWindow.innerHTML += msg;
					//스크롤바 처리
					messageWindow.scrollTop = messageWindow.scrollHeight;
				}
			}
		}
		function wsClose(event) {
			writeResponse("대화 종료");
		}
		function wsError(event) {
			writeResponse("에러 발생");
			writeResponse(event.data);
		}

		//상대방이 보낸 메세지를 출력하기 위한 부분
		function makeBalloon(id, cont) {
			var time = nowTime();
			var msg = '';
			msg = "<div class='othertalk' style='margin-top:10px;'>"
					+ "<div class=\"profile_image\" style=\"background: url(/assets/img/profile_image.png) no-repeat;\">\n"
					+ "</div>\n" + "<div class=\"box\">\n"
					+ "<div class=\"profile_name\">이름:" + id + "\n"
					+ "</div>\n" + "<div class=\"a\">\n" + "</div>\n"
					+ "<div class=\"b\" style='padding:6px 8px 0px 5px;'>\n"
					+ cont + "\n" + "</div>\n" + "<div class=\"time\">\n"
					+ time + "\n" + "</div>\n" + "</div>\n" + "</div>\n";

			return msg;
		}
		function sendMessage() {
			//웹소켓 서버로 대화내용을 전송한다.  
			webSocket.send(chat_id + '|' + inputMessage.value);

			//내가 보낸 내용에 UI를 적용한다. 
			var msg = '';
			var time = nowTime();
			//msg += '<div style="text-align:right;">'+inputMessage.value+'</div>';
			msg = "<div class='mytalk' style='margin-top:10px;'>"
					+ "<div class=\"b\">\n" + "</div>\n"
					+ "<div class=\"a\"  style='padding:6px 8px 0px 5px;'>\n"
					+ inputMessage.value + "\n" + "</div>\n"
					+ "<div class=\"time\">\n" + time + "\n" + "</div>\n"
					+ "</div>\n";

			messageWindow.innerHTML += msg;
			inputMessage.value = "";

			//대화영역의 스크롤바를 항상 아래로 내려준다. 
			messageWindow.scrollTop = messageWindow.scrollHeight;
		}
		function enterkey() {
			/*
			키보드를 눌렀다가 땠을때 호출되며, 눌려진 키보드의 
			키코드가 13일때, 즉 엔터키일때 아래 함수를 즉시 호출한다. 
			 */
			if (window.event.keyCode == 13) {
				sendMessage();
			}
		}
		function writeResponse(text) {
			logWindow.innerHTML += "<br/>" + text;
		}
		function nowTime() {
			var d = new Date();
			var ampm = (d.getHours() >= 12 ? "PM" : "AM");
			var h = (d.getHours() > 12 ? d.getHours() - 12 : d.getHours());
			var m = d.getMinutes();

			return ampm + " " + h + ":" + m;
		}
	</script>
	<input type="hidden" id="chat_id" value="${param.chat_id }" />
	<input type="hidden" id="chat_room" value="${param.chat_room }" />
	<div class="chat_ui" id="chat_ui_test"
		style="width: 320px; height: 480px;">
		<div class="msg" id="messageWindow"></div>
		<div class="sendmsg">
			<textarea class="textarea" id="inputMessage" onkeyup="enterkey();"></textarea>
			<div class="button" onclick="sendMessage();">
				<p>전송</p>
			</div>
			<div class="clear"></div>
		</div>
	</div>
	<div id="logWindow" class="border border-danger"
		style="height: 130px; overflow: auto;"></div>
</body>
</html>