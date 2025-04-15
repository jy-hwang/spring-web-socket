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
	<div class="container">
		<script>
			function chatWin() {
				var id = document.getElementById("chatId");
				if (id.value == '') {
					alert('닉네임을 입력후 채팅창을 열어주세요');
					id.focus();
					return;
				}
				var room = document.getElementById("chatRoom");
				window.open("sendMessage?chatId=" + id.value
						+ "&chatRoom=" + room.value, room.value + "-"
						+ id.value, "width=550,height=700");
			}
		</script>

		<h2>SPRING WebSocket+Notification 활용한 실시간쪽지 보내기</h2>
		<table class="table table-hover" style="max-width: 700px">
			<tr>
				<td>채팅방</td>
				<td><select class ="form-control" id="chatRoom">
						<option value="myRoom1">myRoom</option>
				</select></td>
			</tr>
			<tr>
				<td>회원아이디[본인의아이디]</td>
				<td><input class ="form-control"  type="text" id="chatId" value="" /></td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: center;">
					<button class ="btn btn-primary"  type="button" onclick="chatWin();">쪽지보내기창열기</button>
				</td>
			</tr>
		</table>
	</div>
</body>

</html>