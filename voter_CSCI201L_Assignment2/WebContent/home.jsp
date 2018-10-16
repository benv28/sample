<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.text.SimpleDateFormat" %>
<link rel="stylesheet" href="dstyle.css">


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="google-signin-client_id" content="849815206667-i5415t28ko60ea8i6aair7c089cn5lrf.apps.googleusercontent.com">
<script src="https://apis.google.com/js/platform.js" async defer></script>

 <title>Home</title>


</head>

<body>
<!-- Top header menu -->
<div class="top">
<ul>
	<li><a class="l" href="loggedIn.jsp">Sycamore Calendar</a></li>
	<li><a class="r" href="profilePage.jsp" >Profile</a></li>
	<li><a class="r">Home</a></li>
</ul>
</div>
<!-- retrieve session variables -->
<% ServletContext context = request.getServletContext();  %>

<h2 class="home">Home</h2>

<div class="outer">

<img src="<%=context.getAttribute("imgUrl")%>">
<h2 class="name"><%= context.getAttribute("name") %></h2>

<div class="botform">
<!-- form to input new calendar event. submitt to eventServlet. -->
<form id="eventForm">
	<input type="text" name="eventTitle" placeholder="Event Title"><br><br>
	<input placeholder="Start Time" class="textbox-n left" type="text" onfocus="(this.type='time')" name="startTime">
	<input placeholder="End Time" class="textbox-n right" type="text" onfocus="(this.type='time')" name="endTime"><br><br>
	<input placeholder="Start Date" class="textbox-n left" type="text" onfocus="(this.type='date')" name="startDate">
	<input placeholder="End Date" class="textbox-n right" type="text" onfocus="(this.type='date')" name="endDate"><br>
	<p id="error"> </p>

</form>
	<input type="button" name="submit" value="Add Event" onclick="addEvent();">
	</div>


</div>

<!-- forward event to backend -->
<script>

function addEvent() {
	if(eventForm.elements['eventTitle'].value == "" ||
		eventForm.elements['startTime'].value == "" ||
		eventForm.elements['endTime'].value == "" ||
		eventForm.elements['startDate'].value == "" ||
		eventForm.elements['endDate'].value == "") 
	{
		document.getElementById('error').innerHTML = "Error: all fields must be filled! Please try again.";
	} else {

		var xhr = new XMLHttpRequest();
		xhr.open('POST', 'eventServlet');
		xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');	
		xhr.send('eventTitle=' + eventForm.elements['eventTitle'].value + 
				'&startTime=' + eventForm.elements['startTime'].value + 
				'&endTime=' + eventForm.elements['endTime'].value +
				'&startDate=' + eventForm.elements['startDate'].value + 
				'&endDate=' + eventForm.elements['endDate'].value);

		document.getElementById('error').innerHTML = "Success! Event added.";
	}
}
</script>
<!-- Purely CSS purposes. Dynamically sized bar to match the theme of the top bar. -->
<div class="bottom"></div>

</body>
</html>