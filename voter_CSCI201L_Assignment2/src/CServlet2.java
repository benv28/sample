


import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.security.GeneralSecurityException;
import java.util.Collections;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.api.client.auth.oauth2.Credential;
import com.google.api.client.auth.oauth2.TokenResponse;
import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeFlow;
import com.google.api.client.googleapis.auth.oauth2.GoogleClientSecrets;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.HttpTransport;
//import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.gson.GsonFactory;
import com.google.api.client.util.DateTime;
import com.google.api.client.util.store.MemoryDataStoreFactory;
import com.google.api.services.calendar.Calendar;
import com.google.api.services.calendar.CalendarScopes;
import com.google.api.services.calendar.model.Event;
import com.google.api.services.calendar.model.Events;


@WebServlet("/CServlet2")
public class CServlet2 extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    private static final GsonFactory JSON_FACTORY = GsonFactory.getDefaultInstance();
    private static  HttpTransport HTTP_TRANSPORT;
    private static final List<String> SCOPES = Collections.singletonList(CalendarScopes.CALENDAR);
    
    private boolean loggedin = false;
    private String nextPage = "";

    public CServlet2() {
        super();

    }

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//login, authorize
		Credential cred = null;
		if(!loggedin) {
			cred = auth(request, response);
			if(cred == null) return;
			loggedin = true;
		}
		
        Calendar service = new Calendar.Builder(HTTP_TRANSPORT, JSON_FACTORY, cred)
                .setApplicationName("CALENDAR")
                .build();
        


        // List the next 10 events from the primary calendar.
        DateTime now = new DateTime(System.currentTimeMillis());
        
        Events events = service.events().list("primary")
                .setMaxResults(10)
                .setTimeMin(now)
                .setOrderBy("startTime")
                .setSingleEvents(true)
                .execute();
        
        List<Event> items = events.getItems();
        if (items.isEmpty()) {
            System.out.println("No upcoming events found.");
        } else {
            System.out.println("Upcoming events");
            for (Event event : items) {
                DateTime start = event.getStart().getDateTime();
                if (start == null) {
                    start = event.getStart().getDate();
                }
                System.out.printf("%s (%s)\n", event.getSummary(), start);
            }
        }
		String name = request.getParameter("name");
		String imgUrl = request.getParameter("imgUrl");


		ServletContext sc = request.getSession().getServletContext();
		sc.setAttribute("calendar", items);
		sc.setAttribute("name", name);
		sc.setAttribute("imgUrl", imgUrl);
		sc.setAttribute("service", service);
		
		nextPage = "/profilePage.jsp";

		System.out.println("exiting");
		return;
	}
	
    protected Credential auth(HttpServletRequest request, HttpServletResponse response) throws IOException {

		try {
			HTTP_TRANSPORT = GoogleNetHttpTransport.newTrustedTransport();
		} catch (GeneralSecurityException e) {
			e.printStackTrace();
		}
		

		String at = request.getParameter("accesstoken");
		String USER_ID = request.getParameter("userid");

		if(at == null) return null;
		if(USER_ID == null) return null;
		response.setContentType("text/html");

		InputStream in = CServlet2.class.getResourceAsStream("credentials2.json");
		
        GoogleClientSecrets clientSecrets = GoogleClientSecrets.load(JSON_FACTORY, new InputStreamReader(in));
        
        GoogleAuthorizationCodeFlow flow = new GoogleAuthorizationCodeFlow.Builder(
                HTTP_TRANSPORT, JSON_FACTORY, clientSecrets, SCOPES)
                .setDataStoreFactory(new MemoryDataStoreFactory())
                .setAccessType("online")
                .build();

		
		TokenResponse tokenresponse = new TokenResponse();
		tokenresponse.setAccessToken(at);
		return flow.createAndStoreCredential(tokenresponse, USER_ID);
    }
    
}
