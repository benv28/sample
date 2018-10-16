<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.google.api.services.calendar.model.Event" %>
<%@ page import="com.google.api.client.util.DateTime" %>
<link rel="stylesheet" href="cstyle.css">
<!DOCTYPE html>


<html>
<head>
	<meta charset="UTF-8">
	<title>Profile</title>
</head>
<body>

<div class="top">
<ul>
	<li><a class="l" href="loggedIn.jsp">Sycamore Calendar</a></li>
	<li><a class="r" href="profilePage.jsp" >Profile</a></li>
	<li><a class="r"href="home.jsp">Home</a></li>
</ul>
</div>
<h1>Upcoming Events</h1>
	<% ServletContext context = request.getServletContext();  
	String[] MO = {"January", "February", "March", "April", "May", "June",
			"July", "August", "September", "October", "November", "December" };
	%>
<div class= "main">

	

	<div class="righthalf">
	<img src="<%=context.getAttribute("imgUrl")%>"></img> 
	<h2><%=context.getAttribute("name") %></h2>
	</div>
	<div class="lefthalf">
	
	<div style="overflow-x:auto;">
	<table id="myTable" >
		<tr>
			<th>Date</th>
			<th>Time</th>
			<th>Event Summary</th>
		</tr>
		<tbody>
		<% 
		// Display events list
	    	List<Event> event = (List<Event>)context.getAttribute("calendar");
			for(int i = 0; i < event.size(); i++) { 
				String summary = event.get(i).getSummary();

				//begin parsing datetime string
				DateTime datetime = event.get(i).getStart().getDateTime();
				String date = datetime.toString().substring(0,10);
				String time = datetime.toString().substring(11,16);
				int dateIndex = Integer.parseInt(date.toString().substring(5,7));
				String fdate = MO[dateIndex-1] + " " + date.toString().substring(8,10) +", " + date.toString().substring(0,4);
				int hr = Integer.parseInt(time.toString().substring(0,2));
				String ftime = hr%12 + ":" + time.toString().substring(3,5) + " " + ((hr>=12) ? "PM" : "AM");
			%>
			<tr>
				<td><%=fdate %></td>
				<td><%=ftime %></td>
				<td><%=summary %></td>
		    </tr>
		   </tbody>
			<%}%>
	</table>
	</div>
	</div>
	
	
</div>
<div class="bottom"></div>
</body>
</html>