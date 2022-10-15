package Teacher;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sun.mail.iap.Response;

import Db.Dbcon;

/**
 * Servlet implementation class Tea_update
 */
@WebServlet("/Tea_update")
public class Tea_update extends HttpServlet {
	private static final long serialVersionUID = 1L;
       private Connection con;
       private PreparedStatement ps;
       private RequestDispatcher rd;
     
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Tea_update() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		
		PrintWriter out=response.getWriter();
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
		
		try {
			
			con=Db.Dbcon.setCon("Tea_update.java");
		
			String email=request.getParameter("email");
			String name=request.getParameter("name");
			String last_name=request.getParameter("last_name");
			String sex=request.getParameter("sex");
			String mobile=request.getParameter("mobile");
			
			String qr="update teacher set first_name=?,last_name=?,sex=?,mobile=? where email=?";
			ps=con.prepareStatement(qr);
			
			ps.setString(1, name);
			ps.setString(2, last_name);
			ps.setString(3, sex);
			ps.setString(4, mobile);
			ps.setString(5, email);
			int i=ps.executeUpdate();
			if(i>0)
			{	
				rd=request.getRequestDispatcher("Tea_home.jsp");
				rd.include(request, response);
				out.println("<script>window.alert(\"Profile Updated! \")</script>");
			}
			else
			{	rd=request.getRequestDispatcher("Tea_home.jsp");
				rd.include(request, response);
				out.println("<script>window.alert(\"Profile not Updated! \")</script>");
				con.close();
			}
			
Dbcon.closeCon("Tea_update.java");
		} 
		catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
}
