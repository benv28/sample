

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.api.client.util.DateTime;
import com.google.api.services.calendar.Calendar;
import com.google.api.services.calendar.model.Event;
import com.google.api.services.calendar.model.EventDateTime;

/**
 * Servlet implementation class eventServlet
 */
@WebServlet("/eventServlet")
public class eventServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public eventServlet() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ServletContext context = getServletContext();
		System.out.println(request.getParameter("startTime"));
		System.out.println(context.getAttribute("imgUrl"));
		System.out.println("In Event Servlet");
		Calendar service = (Calendar) context.getAttribute("service");
		
		String SDT = (request.getParameter("startDate") + 'T' + request.getParameter("startTime"));
		String EDT = (request.getParameter("endDate") + 'T' + request.getParameter("endTime"));
		SDT += ":00-07:00";
		EDT += ":00-07:00";

		
		Event event = new Event()
			    .setSummary(request.getParameter("eventTitle"));

		DateTime startDateTime = new DateTime(SDT);
		EventDateTime start = new EventDateTime()
		    .setDateTime(startDateTime)
		    .setTimeZone("America/Los_Angeles");
		event.setStart(start);

		DateTime endDateTime = new DateTime(EDT);
		EventDateTime end = new EventDateTime()
		    .setDateTime(endDateTime)
		    .setTimeZone("America/Los_Angeles");
		event.setEnd(end);

		
		String calendarId = "primary";
		event = service.events().insert(calendarId, event).execute();
		System.out.printf("Event created: %s\n", event.getHtmlLink());
		
        DateTime now = new DateTime(System.currentTimeMillis());

		List<Event> items = service.events().list("primary")
                .setMaxResults(10)
                .setTimeMin(now)
                .setOrderBy("startTime")
                .setSingleEvents(true)
                .execute().getItems();
		context.setAttribute("calendar", items);
	}

}
