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
 * Servlet implementation class Add_skill
 */
@WebServlet("/Add_skill")
public class Add_skill extends HttpServlet {
	private static final long serialVersionUID = 1L;
	RequestDispatcher rd;
	PrintWriter out;
	Connection con;
       String sql;
       String skil;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Add_skill() {
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
			skil=request.getParameter("skill");
			con= Dbcon.setCon("Add_skill.java");
			sql=new String("insert into skills values(?)");
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setString(1,skil);
			int i=ps.executeUpdate();
			if(i>0)
			{
				rd=request.getRequestDispatcher("Adm_add_skill.jsp");
				rd.include(request, response);
				out.println("<script>window.alert(\" "+skil +" Skill added...!\");</script>");
			
			}
		Dbcon.closeCon("Add_skill.java");
		}
		
		catch(Exception e)
		{
			e.printStackTrace();
			rd=request.getRequestDispatcher("Adm_add_skill.jsp");
			rd.include(request, response);
			out.println("<script>window.alert(\" "+skil +" Skill Already Exists...!\");</script>");
		}
		}
				
	}

}
