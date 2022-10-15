package Teacher;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
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
 * Servlet implementation class Updatepass
 */
@WebServlet("/Updatepass")
public class Updatepass extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private PrintWriter out;
	private String usr;
	private String oldpass;
	private String newpass;
	private Connection con;
	private RequestDispatcher rd;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public Updatepass() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		
		
		out=response.getWriter();
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
		
		oldpass = request.getParameter("oldpass");
		newpass = request.getParameter("newpass");
		usr = request.getParameter("email");
		try
		{
			con=Dbcon.setCon("Updatepass.java");
			String sql=new String("update tlogin set passwd=? where email=? and passwd=?");
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setString(1,newpass);
			ps.setString(2,usr);
			ps.setString(3,oldpass);
			int i=ps.executeUpdate();
			if(i>0) 
			{
				rd=request.getRequestDispatcher("index.html");
				rd.include(request, response);
				out.println("\n <script>window.alert(\"Password Changed! Please log in with new Password\")</script>");
			}
			else
			{
				rd=request.getRequestDispatcher("Tea_update_pass.jsp");
				rd.include(request, response);
				out.println("\n <script>window.alert(\"Old password doesn't correct...!\")</script>");
				
			}
			Db.Dbcon.closeCon("Updatepass.java");
			
		}catch(Exception e)
		{
			
			e.printStackTrace();
		}
	}

}
}