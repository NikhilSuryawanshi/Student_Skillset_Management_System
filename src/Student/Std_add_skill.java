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
 * Servlet implementation class Std_add_skill
 */
@WebServlet("/Std_add_skill")
public class Std_add_skill extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Std_add_skill() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		RequestDispatcher rd;
		PrintWriter out=response.getWriter();
		Connection con;
	       String sql;
	       PreparedStatement ps;
	       String skill="";
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
		String sk[]=request.getParameterValues("skill");
		try
		{
			con=Dbcon.setCon("std_sdd_skill.java");
			sql=new String("delete from student_skill where roll=?");
			ps=con.prepareStatement(sql);
			ps.setString(1,usr);
			int j=ps.executeUpdate();
			if(j>0)
			{
					
			}
			for (int i=0;i<sk.length;i++)
			{
				skill=skill+sk[i]+" ";
			}
			
		skill=Dbcon.removeLastCharacter(skill);
		
		sql=new String("insert into student_skill values(?,?)");
		ps=con.prepareStatement(sql);
		ps.setString(1, usr);
		ps.setString(2, skill);
		j=ps.executeUpdate();
		
		if(j>0)
		{
			rd=request.getRequestDispatcher("Std_add_skill.jsp");
			rd.include(request, response);
			out.println("<script>window.alert(\"Skill added\");</script>");
		}
				
		Dbcon.closeCon("std_sdd_skill.java");	
		}
		
		catch(Exception e)
		{
			e.printStackTrace();
			rd=request.getRequestDispatcher("Std_add_skill.jsp");
			rd.include(request, response);
			out.println("<script>window.alert(\"Please Select Atleast one skill\");</script>");
		}
		}
	}

}
