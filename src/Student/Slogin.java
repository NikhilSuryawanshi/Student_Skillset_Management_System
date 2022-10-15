package Student;


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

/**
 * Servlet implementation class Slogin
 */
@WebServlet("/Slogin")
public class Slogin extends HttpServlet {
	
	private PrintWriter out;
	private String roll;
	private String pwd;
	private Connection con;
	private ResultSet rs;
	private RequestDispatcher rd;
	private HttpSession session;
	String sem;

	
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Slogin() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		out = response.getWriter();
		roll = request.getParameter("usr");
		pwd = request.getParameter("pwd");
		
		try {
			con = Db.Dbcon.setCon("Slogin.java");
			String sql="select * from slogin where roll=? and passwd=?";
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setString(1, roll);
			ps.setString(2, pwd);
			rs = ps.executeQuery();
			
			if (rs.next())
				
			{	
				session=request.getSession();
				session.setAttribute("usr", roll);
				//settings for timing in session
				session.setMaxInactiveInterval(10*60);
				Cookie cookie = new Cookie("usr",roll);
				cookie.setMaxAge(30*60);
				response.addCookie(cookie);
				rd=request.getRequestDispatcher("Std_home.jsp");
				rd.include(request, response);
				out.println("<script>window.alert(\"login sucessful ! \")</script>");
								
			}
			else {
				rd=request.getRequestDispatcher("Std_login.html");
				rd.include(request, response);
				out.println("\n <script>window.alert(\"Invalid Id or Password\")</script>");
			}
			Db.Dbcon.closeCon("Slogin.java");
						
		} catch (Exception e) {
		
			e.printStackTrace();
		} 
	}

}
