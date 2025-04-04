<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container">
		<h2>SPRING WebSocket 활용한 채팅</h2>
		<table border=1 cellpadding="10" cellspacing="0">
			<tr>
				<td>채팅방</td>
				<td><select id="chat_room">
						<option value="myRoom1">myRoom1 대화방</option>
				</select></td>
			</tr>
			<tr>
				<td>회원아이디</td>
				<td><input type="text" id="chat_id" placeholder="본인의 닉네임을 쓰세요" />
				</td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: center;">
					<button type="button" onclick="chatWin('normal');"
						class="btn btn-primary">채팅창열기</button>
					<button type="button" onclick="chatWin('ui');"
						class="btn btn-primary">UI적용된채팅창열기</button>
				</td>
			</tr>
		</table>
	</div>


	<script>
		function chatWin(skin) {
			var id = document.getElementById("chat_id");
			if (id.value == '') {
				alert('채팅 닉네임을 입력 후 채팅창을 열어주세요');
				id.focus();
				return;
			}

			var room = document.getElementById("chat_room");

			if (skin == 'normal') {
				window.open("webChat?chat_id=" + id.value + "&chat_room="
						+ room.value, room.value + "-" + id.value,
						"width=500, height=700");
			} else {
				window.open("webChatUI?chat_id=" + id.value + "&chat_room="
						+ room.value, room.value + "-" + id.value,
						"width=500, height=700");
			}

		}
	</script>

</body>
</html>