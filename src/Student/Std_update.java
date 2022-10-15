package Student;

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

import com.mysql.jdbc.MysqlDataTruncation;

import Db.Dbcon;


/**
 * Servlet implementation class Std_update
 */
@WebServlet("/Std_update")
public class Std_update extends HttpServlet {
	private static final long serialVersionUID = 1L;
	 
       RequestDispatcher rd;
       Connection con;
       HttpSession session;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Std_update() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out; 
		out=response.getWriter();
	//session
		
		String usr = null;
		session=request.getSession();
		if(session.getAttribute("usr") == null)
		{
			rd = request.getRequestDispatcher("index.html");
			rd.include(request, response);
			out.println("<script>window.alert(\"Log in First...!\")</script>");
		}
		else usr = (String) session.getAttribute("usr");
		String userName = null;
		String sessionID = null;
		Cookie[] cookies = request.getCookies();
		if(cookies !=null){
		for(Cookie cookie : cookies){
			if(cookie.getName().equals("usr")) userName = cookie.getValue();
			if(cookie.getName().equals("JSESSIONID")) sessionID = cookie.getValue();
		}
		}
		
	
		String roll=request.getParameter("roll");
		String name=request.getParameter("name");
		String last_name=request.getParameter("last_name");
		String sex=request.getParameter("sex");
		String mobile=request.getParameter("mobile");
		String sem=request.getParameter("semester");
		String dob=request.getParameter("dob");
		
		try
		{	
			
			con=Db.Dbcon.setCon("std_update.java");
			String sql=new String("update student set first_name=?,last_name=?,dob=?,sex=?,sem=?,mobile=? where roll=?");
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setString(1,name);
			ps.setString(2,last_name);
			ps.setString(3,dob);
			ps.setString(4,sex);
			ps.setString(5,sem);
			ps.setString(6,mobile);
			ps.setString(7,roll);
			int i=ps.executeUpdate();
			if(i>0)
			{	
				rd=request.getRequestDispatcher("Std_home.jsp");
				rd.include(request, response);
				out.print("<script>window.alert(\"Profile Updated! \")</script>");
				
			}
			else
			{
				rd=request.getRequestDispatcher("Std_home.jsp");
				rd.include(request, response);
				out.println("<script>window.alert(\"Profile Not Updated....! \")</script>");
				
			}
			Db.Dbcon.closeCon("std_update.java");
		}
		catch(MysqlDataTruncation e)
		{
			rd=request.getRequestDispatcher("Std_update_pro.jsp");
			rd.include(request, response);
			out.println("<script>window.alert(\"Mobile No. is too long \")</script>");
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		
		}

}