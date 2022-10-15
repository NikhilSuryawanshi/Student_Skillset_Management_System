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
 * Servlet implementation class Tea_prroj_assign1
 */
@WebServlet("/Tea_prroj_assign1")
public class Tea_prroj_assign1 extends HttpServlet {
	private static final long serialVersionUID = 1L;
	RequestDispatcher rd;
	PrintWriter out;
	Connection con;
       String sql;
      
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Tea_prroj_assign1() {
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
			String sem=request.getParameter("semester");
			String project=request.getParameter("project");
			String ar[]=request.getParameterValues("roll");
			 String st="";
			
			for(int i=0;i<ar.length;i++)
			{
				st=st+ar[i]+" ";
			}
			System.out.println(st+project+sem);
			st=Dbcon.removeLastCharacter(st);
			con= Dbcon.setCon("Tea_prroj_assign1.java");
			sql=new String("update project set students=?,sem=? where project_no=?");
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setString(1,st);
			ps.setString(2,sem);
			ps.setString(3,project);
			int i=ps.executeUpdate();
			if(i>0)
			{
				rd=request.getRequestDispatcher("Tea_proj_assign.jsp");
				rd.include(request, response);
				out.print("<script>window.alert(\"Done !\")</script>");
				//Dbcon.redirect(request, response, "Tea_proj_assign.jsp", "Done..!");

			}
			else
			{
				System.out.println("else of Tea_prroj.java");
			}
		Dbcon.closeCon("Tea_prroj_assign1.java");
		}
		
		catch(Exception e)
		{
			e.printStackTrace();
			rd=request.getRequestDispatcher("Tea_proj_assign.jsp");
			rd.include(request, response);
			out.println("<script>window.alert(\" not Done..!\");</script>");
		}
		}
	}

}