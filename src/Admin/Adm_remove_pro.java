package Admin;

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
 * Servlet implementation class Adm_remove_pro
 */
@WebServlet("/Adm_remove_pro")
public class Adm_remove_pro extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Adm_remove_pro() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		RequestDispatcher rd;
		PrintWriter out;
		Connection con;
	       String sql;
	       String proj;
	       String prno;
		//session
		HttpSession session=request.getSession();
		String usr = null;
		out=response.getWriter();
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
			proj=request.getParameter("proj");
			prno=request.getParameter("prno");
			con= Dbcon.setCon("Adm_remove_pro.java");
			sql=new String("delete from project where project_no=? ");
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setString(1,prno);
			int i=ps.executeUpdate();
			if(i>0)
			{
				rd=request.getRequestDispatcher("Adm_mng_pro.jsp");
				rd.include(request, response);
				out.println("<script>window.alert(\""+proj+" Project Removed...!\");</script>");
			
			}
			
		Dbcon.closeCon("Adm_remove_pro.java");
		}
		
		catch(Exception e)
		{
			e.printStackTrace();
			rd=request.getRequestDispatcher("Adm_mng_pro.jsp");
			rd.include(request, response);
			out.println("<script>window.alert(\" Error...!\");</script>");
		}
		
		}


		}

	}