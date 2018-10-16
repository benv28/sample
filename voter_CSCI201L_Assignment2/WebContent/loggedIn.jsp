<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

	
<!DOCTYPE html>
<html>
<head>
	<meta name="google-signin-client_id" content="849815206667-i5415t28ko60ea8i6aair7c089cn5lrf.apps.googleusercontent.com">
	<script src="https://apis.google.com/js/platform.js" async defer></script>
	<link rel="stylesheet" href="bstyle.css">
	<title>Logged In</title>
<style>


</style>
</head>
<body>
<div class="top">
<ul>
	<li class="He">Sycamore Calendar</li>
 	<li><a href="profilePage.jsp" >Profile</a></li>
	<li><a href="home.jsp">Home</a></li> 
</ul>
</div>
	<img src="leaf.png">
	<h1>Sycamore Calendar</h1>
	<div class="g-signin2" onclick="signOut();" data-theme="light"></div>


<script>
  function signOut() {
    var auth2 = gapi.auth2.getAuthInstance();
    auth2.signOut().then(function () {
      console.log('User signed out.');
      window.location.href = "LoginPage.jsp";
    }); 
  }
</script>

<div id="bottom"></div>
</body>
</html>

