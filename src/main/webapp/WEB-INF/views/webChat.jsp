<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script type="text/javascript">
		var messageWindow;
		var inputMessage;
		var chat_id;
		var webScoket;
		var logWindow;

		window.onload = function() {
			messageWindow = document.getElementById("messageWindow");
			messageWindow.scrollTop = messageWindow.scrollHeight;
			inputMessage = document.getElementById("inputMessage");
			chat_id = document.getElementById("chat_id").value;
			logWindow = document.getElementById("logWindow");

			webSocket = new WebSocket('ws://localhost:8088/EchoServer');

			webSocket.onopen = function(event) {
				wsOpen(event);
			}

			webSocket.onmessage = function(event) {
				wsMessage(event);
			}

			webSocket.onclose = function(event) {
				wsClose(event);
			}

			webSocket.onerror = function(event) {
				wsError(event);
			}
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

			if (content = "") {

			} else {
				if (content.match("/")) {
					if (content.match(("/" + chat_id))) {
						var temp = content.replace(("/" + chat_id), "[귓속말]");
						msg = makeBalloon(sender, temp);
						messageWindow.innerHTML += msg;
						messageWindow.scrollTop = messageWindow.scrollHeight;
					}
				} else {
					msg = makeBalloon(sender, content);
					messageWindow.innerHTML += msg;
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

		function makeBalloon(id, cont) {
			var msg = '';
			msg += '<div>' + id + ":" + cont + '</div>';
			return msg;
		}

		function sendMessage() {
			webSocket.send(chat_id + '|' + inputMessage.value);

			var msg = '';
			msg += '<div style="text-align:right;">' + inputMessage.value
					+ '</div>';

			messageWindow.innerHTML += msg;
			inputMessage.value = "";
			messageWindow.scrollTop = messageWindow.scrollHeight;
		}

		function enterkey() {
			if (window.event.keyCode == 13) {
				sendMessage();
			}
		}

		function writeResponse(text) {
			logWindow.innerHTML += "<br />" + text;
		}
	</script>
	<div class="container">
		<input type="hid den" id="chat_id" value="${param.chat_id }" /> <input
			type="hid den" id="chat_room" value="${param.chat_room }" />
		<table class="table table-bordered">
			<tr>
				<td>방명:</td>
				<td>${param.chat_room }</td>
			</tr>
			<tr>
				<td>닉네임:</td>
				<td>${param.chat_id }</td>
			</tr>
			<tr>
				<td>메시지:</td>
				<td><input type="text" id="inputMessage"
					class="form-control float-left mr-1" style="width: 75%"
					onkeyup="enterkey();" /> <input type="button" id="sendBtn"
					onclick="sendMessage();" value="전송" class="btn btn-info float-left" />
				</td>
			</tr>
		</table>
		<div id="messageWindow" class="border border-primary"
			style="height: 300px; overflow: auto;">
			<div style="text-align: right;">내가쓴거</div>
			<div>상대가보낸거</div>
		</div>
		<div id="logWindow" class="border border-danger"
			style="height: 130px; overflow: auto;"></div>

	</div>
</body>

</html>