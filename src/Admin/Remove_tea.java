package Admin;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Db.Dbcon;

/**
 * Servlet implementation class Remove_tea
 */
@WebServlet("/Remove_tea")
public class Remove_tea extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection con;
    PreparedStatement ps;
    ResultSet rs;
    RequestDispatcher rd;
    String email;
     PrintWriter out;
       HttpServlet session;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Remove_tea() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//session
				HttpSession session=request.getSession();
				String usr = null;
				if(session.getAttribute("usr") == null)
				{
					rd = request.getRequestDispatcher("/index.html");
					rd.include(request, response);
					out.println("<script>window.alert(\"Please Log in first...!\");</script>");
					
				}
				else
				{
					usr = (String) session.getAttribute("usr");
				String userName = null;
				String sessionID = null;
				Cookie[] cookies = request.getCookies();
				
				if(cookies !=null)
				{
				for(Cookie cookie : cookies)
				{
					if(cookie.getName().equals("usr")) userName = cookie.getValue();
					if(cookie.getName().equals("JSESSIONID")) sessionID = cookie.getValue();
				}
				}
		out = response.getWriter();
		try
		{
			con=Dbcon.setCon("Remove_tea.java");
			email=request.getParameter("email");
			String qr="delete from teacher where email=? ";
			ps=con.prepareStatement(qr);
			ps.setString(1,email);
			int i=ps.executeUpdate();
			if(i>0)
			{

				rd=request.getRequestDispatcher("Adm_show_tea.jsp");
				rd.include(request, response);
				out.print("<script>window.alert("+email+"\" Profile deleted\")</script>");
			}
			else
				
			{	
				rd=request.getRequestDispatcher("Adm_home.jsp");
				rd.include(request, response);
				out.print("<script>window.alert(\"Profile Not deleted !\")</script>");
				
			}
			
			Dbcon.closeCon("Remove_tea.java");
			}
		catch(Exception e)
		{
				out.print(e);
		}
}
	}
}
