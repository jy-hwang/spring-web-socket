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
		<h2>Web Notification01</h2>
		<button onclick="calculate();">버튼을 누르면 1초 후에 WebNotification
			이 뜹니다.</button>
	</div>
	<script>
		window.onload = function() {
			if (window.Notification) {
				Notification.requestPermission();
			} else {
				alert("웹 노티를 지원하지 않습니다.");
			}
		}

		function calculate() {
			setTimeout(function() {
				notify();
			}, 1000);
		}

		function notify() {
			if (Notification.permission !== 'granted') {
				alert("웹 노티를 지원하지 않습니다.");
			} else {
				var notification = new Notification(
						'Title',
						{
							icon : 'http://cfile201.uf.daum.net/image/235BFD3F5937AC17164572',
							body : '여긴내용입니다. 클릭하면 naver 로 이동합니다.',
						});
				notification.onclick = function() {
					window.open('https://www.naver.com');
				}
			}
		}
	</script>
	<ul>
		<li>웹노티 Browser compatibility ->
			https://developer.mozilla.org/ko/docs/Web/API/notification</li>
		<li>Chrome, Firefox지원됨. IE지원안됨</li>
	</ul>

</body>
</html>