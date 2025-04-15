<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</head>
<body>
	<script type="text/javascript">
		var messageWindow;
		var inputMessage;
		var chatId;
		var webSocket;
		var logWindow;

		window.onload = function() {
			messageWindow = document.getElementById("messageWindow");
			//messageWindow.scrollTop = messageWindow.scrollHeight;
			inputMessage = document.getElementById('inputMessage');
			chatId = document.getElementById('chatId').value;
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
			var sender = message[0]; // 닉네임
			var content = "temp";
			content = message[1];

			writeResponse(event.data);

			if (content == "") {

			} else {
				if (content.match("/")) {
					if (content.match(("/" + chat_id))) {
						console.log("notify()");
						notify(content);
					}
				} else {

				}
			}

		}

		function wsClose(event) {
			writeResponse("대화종료");
		}

		function wsError(event) {
			writeResponse("오류발생");
			writeResponse(event.data);
		}

		function sendMessage() {
			receiveId = $("#receiveId").val();
			inputMessage = '/' + receiveId + ' ' + $("#inputMessage").val();

			var sendMessage = chatId + '|' + inputMessage;
			console.log('sendMessage : ' + sendMessage);
			webSocket.send(sendMessage);
		}

		function enterkey() {
			if (window.event.keyCode == 13) {
				sendMessage();
			}
		}
		function writeResponse(text) {
			//logWindow.innerHTML += "<br/>"+text;
			console.log(text);
		}
		function notify(notiMsg) {
			if (Notification.permission !== 'granted') {
				alert('notification is disabled');
			} else {
				var notification = new Notification(
						notiMsg,
						{
							icon : 'https://t4.ftcdn.net/jpg/00/78/87/93/500_F_78879336_2f2Ivwq2jN2EFMSJSi72OevDAQob2JJv.jpg',
							body : '쪽지가 왔습니다.',
						});
				//Noti에 핸들러를 사용한다.
				notification.onclick = function() {
					alert('링크를 이용해서 해당페이지로 이동할 수 있다.');
				};
			}
			//토스트로 표시
			$('.toast-body').html(notiMsg);
			$('.toast').toast({
				delay : 5000
			}).toast('show');
		}
	</script>


	<div class="container">
		<table class="table table-bordered">
			<tr>
				<td>방명:</td>
				<td><input type="text" id="chatRoom" class="form-control"
					value="${sessionScope.chatRoom }" readonly /></td>
			</tr>
			<tr>
				<td>닉네임:</td>
				<td><input type="text" id="chatId" class="form-control"
					value="${sessionScope.chatId }" readonly/></td>
			</tr>
			<tr>
				<td>받는사람아이디:</td>
				<td><input type="text" id="receiveId" class="form-control"
					value="" placeholder="받는사람 아이디를 입력하세요" /></td>
			</tr>
			<tr>
				<td>쪽지내용:</td>
				<td><input type="text" id="inputMessage"
					class="form-control float-left mr-1" style="width: 70%"
					onkeyup="enterkey();" /> <input type="button" value="쪽지전송"
					onclick="sendMessage();" class="btn btn-info float-left" /></td>
			</tr>
		</table>

		<script>
			$(document).ready(function() {
				//토스트 테스트
				$('#myBtn').click(function() {
					$('.toast').toast({
						delay : 5000
					});
					$('.toast').toast('show');
				});
			});
		</script>
		<button type="button" class="btn btn-primary" id="myBtn">Show
			Toast</button>
		<div class="toast mt-3">
			<div class="toast-header">쪽지가 왔습니다.(5초후 닫힙니다.)</div>
			<div class="toast-body">쪽지내용</div>
		</div>
	</div>
</body>

</html>