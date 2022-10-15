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
 * Servlet implementation class Tea_add_project
 */
@WebServlet("/Tea_add_project")
public class Tea_add_project extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	RequestDispatcher rd;
	PrintWriter out;
	Connection con;
       String sql;
       String prj;
      
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Tea_add_project() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


out=response.getWriter();
		
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
		try
		{
			prj=request.getParameter("project_name");
			con= Dbcon.setCon("Tea_add_project.java");
			sql=new String("insert into project (`project_name`) values(?)");
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setString(1,prj);
			int i=ps.executeUpdate();
			if(i>0)
			{
				rd=request.getRequestDispatcher("Tea_add_project.jsp");
				rd.include(request, response);
				out.println("<script>window.alert(\" "+prj +" Project added...!\");</script>");
			
			}
			else
			{
				
			}
		Dbcon.closeCon("Tea_add_project.java");
		}
		
		catch(Exception e)
		{
			e.printStackTrace();
			rd=request.getRequestDispatcher("Tea_add_project.jsp");
			rd.include(request, response);
			out.println("<script>window.alert(\" "+prj +" Already Exists...!\");</script>");
		}
		
		}
		
	}
}
