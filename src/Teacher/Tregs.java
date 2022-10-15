package Teacher;


import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Tregs
 */
@WebServlet("/Tregs")
public class Tregs extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private PrintWriter out;
	private Connection con;
	private RequestDispatcher rd;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Tregs() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
out = response.getWriter();
		
		String name=request.getParameter("first_name");
		String last=request.getParameter("last_name");
		String sex=request.getParameter("sex");
		String email=request.getParameter("email");
		String mobile=request.getParameter("mobile");
		try {
			con = Db.Dbcon.setCon("Tregs.java");
			String sql=new String("insert into teacher values(?,?,?,?,?)");
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setString(1,email);
			ps.setString(2,name);
			ps.setString(3,last);
			ps.setString(4,sex);
			ps.setString(5,mobile);
			
			int i=ps.executeUpdate();
			
			if (i>0)
			{	
				sql=new String("insert into tlogin values(?,?)");
				ps=con.prepareStatement(sql);
				ps.setString(1,email);
				ps.setString(2,"root");
				i=ps.executeUpdate();
				if(i>0)
				{
				response.sendRedirect("Forgetpwdtea?email="+email);
				out.println("\n <script>window.alert(\"Your TEMPRARY PASSWORD is sent to your email , Please cheack your email \")</script>");
		
				}
				else
				{
					rd=request.getRequestDispatcher("Tea_login.html");
					rd.include(request, response);
					out.println("\n <script>window.alert(\"Password Not updated in db\")</script>");
				}
			}
			else {
				rd=request.getRequestDispatcher("Tea_reg.html");
				rd.include(request, response);
				out.println("\n <script>window.alert(\"Registration Failed!\")</script>");
			}
			Db.Dbcon.closeCon("Tregs.java");
						
		} 
		catch (Exception e) {
		
		
			rd=request.getRequestDispatcher("Tea_reg.html");
			rd.include(request, response);
			out.println("\n <script>window.alert(\"Registration Failed! or Id Already Exists\")</script>");
		
		} 
	}

}
