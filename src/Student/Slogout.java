package Student;


import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Slogout
 */
@WebServlet("/Slogout")
public class Slogout extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private RequestDispatcher rd;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Slogout() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out=response.getWriter();
		 response.setContentType("text/html");
			Cookie[] cookies = request.getCookies();
			if(cookies != null)
			{	
			for(Cookie cookie : cookies)
			{
				if(cookie.getName().equals("usr"))
				{
					System.out.println("Logout="+cookie.getValue());
					break;
				}
			}
			}
			HttpSession session=request.getSession();
		
		String usr=(String)session.getAttribute("usr");
		
			if(usr==null)
			{
				rd=request.getRequestDispatcher("index.html");
				rd.include(request, response);
				out.println("\n <script>window.alert(\"You are not logged in\")</script>");
			}
			else
			{
				//invalidate the session if exists
				session = request.getSession(false);
				//System.out.println("User="+session.getAttribute("usr"));
				if(session != null){
					session.invalidate();
				}
				rd=request.getRequestDispatcher("index.html");
				rd.include(request, response);
				out.println("\n <script>window.alert(\"Successfully logged out\")</script>");	
			}
			
	}

	}

