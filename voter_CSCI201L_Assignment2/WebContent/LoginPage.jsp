<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

	
<!DOCTYPE html>
<html>
<head>
	<meta name="google-signin-client_id" content="849815206667-i5415t28ko60ea8i6aair7c089cn5lrf.apps.googleusercontent.com">
	<script src="https://apis.google.com/js/platform.js" async defer></script>
	<link rel="stylesheet" href="bstyle.css">
	<title>Login</title>
<style>

</style>
</head>
<body>
<div class="top">
<ul>
	<li class="He">Sycamore Calendar</li>
</ul>
</div>
	<img src="leaf.png">
	<h1>Sycamore Calendar</h1>
	<!-- Add google sign in button: -->
	<div class="g-signin2" data-onsuccess="onSignIn" data-theme="light"></div>
	
	
<script>
	function onSignIn(googleUser) {
	
		var profile = googleUser.getBasicProfile();
		var promise = googleUser.grant({'scope':'https://www.googleapis.com/auth/calendar'});
		promise.then(function() {
			
			var access_token = googleUser.getAuthResponse().access_token;
			var id_token = profile.getId();
			
			console.log("made to promise.then ");
			
			var xhr = new XMLHttpRequest();
			xhr.open('POST', 'CServlet2');
			xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');	
			xhr.send('accesstoken=' + access_token + '&userid=' + id_token + '&name=' + profile.getName()
					+ '&imgUrl=' + profile.getImageUrl());
			
			setTimeout(function() { 
			 	 window.location.href = "profilePage.jsp";  
				}, 500);
		});

	}
</script>
<div id="bottom"></div>

<script>
  function signOut() {
    var auth2 = gapi.auth2.getAuthInstance();
    auth2.signOut();
  }
</script>
</body>
</html>

