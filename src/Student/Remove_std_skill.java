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

import Db.Dbcon;

/**
 * Servlet implementation class Remove_std_skill
 */
@WebServlet("/Remove_std_skill")
public class Remove_std_skill extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Remove_std_skill() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		Connection con;
		RequestDispatcher rd;
		PrintWriter out=response.getWriter();
	       PreparedStatement ps;
		out=response.getWriter();
		//session
		HttpSession session=request.getSession();
		if(session.getAttribute("usr") == null)
		{
			rd = request.getRequestDispatcher("/index.html");
			rd.include(request, response);
			out.println("<script>window.alert(\"Please Log in first...!\");</script>");
			
		}
		else
		{
		String	usr = (String) session.getAttribute("usr");
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
		
		 String skill=request.getParameter("skill");
		 String roll= (String) session.getAttribute("usr");
		try
		{
			con=Dbcon.setCon("Remove_std_skill.java");
			String qr="delete from student_skill where roll=? and skill_name=? ";
			ps=con.prepareStatement(qr);
			ps.setString(1,roll);
			ps.setString(2,skill);
			int i=ps.executeUpdate();
			if(i>0)
			{
						rd=request.getRequestDispatcher("Std_add_skill.jsp");
						rd.include(request, response);
						out.println("<script>window.alert("+skill+"\" Skill Deleted... !\")</script>");
						
			}
			else	
			{	
	
				rd=request.getRequestDispatcher("Std_add_skill.jsp");
				rd.include(request, response);
				out.print("<script>window.alert(\"No Skill Data Found... !\")</script>");
				
			}
	Dbcon.closeCon("Remove_std_skill.java");
			}
		catch(Exception e)
		{
				e.printStackTrace();
		}
	}

}
}

