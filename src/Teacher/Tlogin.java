package Teacher;


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
@WebServlet("/Tlogin")
public class Tlogin extends HttpServlet {
	
	private PrintWriter out;
	private String email;
	private String pwd;
	private Connection con;
	private ResultSet rs;
	private RequestDispatcher rd;
	private HttpSession session;

	
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Tlogin() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		out = response.getWriter();
		email = request.getParameter("email");
		pwd = request.getParameter("pwd");
		
		try {
			con = Db.Dbcon.setCon("Tlogin.java");
			String sql="select * from tlogin where email=? and passwd=?";
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setString(1, email);
			ps.setString(2, pwd);
			rs = ps.executeQuery();
			
			if (rs.next())
			{	session=request.getSession();
				session.setAttribute("usr", email);
				//30 second
				session.setMaxInactiveInterval(5*60);
				Cookie cookie = new Cookie("usr",email);
				response.addCookie(cookie);
				rd=request.getRequestDispatcher("Tea_home.jsp");
				rd.include(request, response);
				out.println("<script>window.alert(\"login sucessful ! \")</script>");
								
			}
			else {
				rd=request.getRequestDispatcher("Tea_login.html");
				rd.include(request, response);
				out.println("\n <script>window.alert(\"Invalid Id or Password\")</script>");
			}
			Db.Dbcon.closeCon("Tlogin.java");
						
		} catch (Exception e) {
		
			out.println(e);
		} 
	}

}
