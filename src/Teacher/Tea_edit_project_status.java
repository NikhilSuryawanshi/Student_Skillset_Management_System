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
 * Servlet implementation class Tea_edit_project_status
 */
@WebServlet("/Tea_edit_project_status")
public class Tea_edit_project_status extends HttpServlet {
	private static final long serialVersionUID = 1L;
	RequestDispatcher rd;
	PrintWriter out;
	Connection con;
       String sql;
       String status;
       String newstatus;
       String prno;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Tea_edit_project_status() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

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
		status=request.getParameter("status");
		prno=request.getParameter("prno");
		con= Dbcon.setCon("Tea_edit_project_status.java");
		
		if(status.equals("1"))
		{
		newstatus="0";
		}
		else
		{
			newstatus="1";
		}
		sql=new String("update project set active_status=? where project_no=? ");
		PreparedStatement ps=con.prepareStatement(sql);
		ps.setString(1,newstatus);
		ps.setString(2,prno);
		int i=ps.executeUpdate();
		if(i>0)
		{
			rd=request.getRequestDispatcher("Tea_add_project.jsp");
			rd.include(request, response);
			out.println("<script>window.alert(\" status updated...!\");</script>");
		
		}
		
	Dbcon.closeCon("Tea_edit_project_status.java");
	}
	
	catch(Exception e)
	{
		e.printStackTrace();
		rd=request.getRequestDispatcher("Tea_add_project.jsp");
		rd.include(request, response);
		out.println("<script>window.alert(\" Error...!\");</script>");
	}
	
	}


	}

}
