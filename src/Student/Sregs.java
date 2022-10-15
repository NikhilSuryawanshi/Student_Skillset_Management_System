package Student;


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

import Db.Dbcon;

/**
 * Servlet implementation class Sregs
 */
@WebServlet("/Sregs")
public class Sregs extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private PrintWriter out;
	private Connection con;
	private RequestDispatcher rd;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Sregs() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		out = response.getWriter();
		
		String roll=request.getParameter("roll");
		String name =Dbcon.capitalize(request.getParameter("first_name"));
		String last=Dbcon.capitalize(request.getParameter("last_name"));
		String dob=request.getParameter("dob");
		String sex=request.getParameter("sex");
		String sem=request.getParameter("sem");
		String email=request.getParameter("email");
		String mobile=request.getParameter("mobile");
		
		
		try {
			con = Db.Dbcon.setCon("Sregs.java");
			String sql=new String("insert into student values(?,?,?,?,?,?,?,?)");
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setString(1,roll);
			ps.setString(2,name);
			ps.setString(3,last);
			ps.setString(4,dob);
			ps.setString(5,sex);
			ps.setString(6,sem);
			ps.setString(7,email);
			ps.setString(8,mobile);
			
			int i=ps.executeUpdate();
			
			if (i>0)
			{
				sql=new String("insert into slogin values(?,?)");
				ps=con.prepareStatement(sql);
				ps.setString(1,roll);
				ps.setString(2,"root");
				i=ps.executeUpdate();
				if(i>0)
				{
				response.sendRedirect("Forgetpwd?roll="+roll);
				out.println("\n <script>window.alert(\"Your TEMPRARY PASSWORD is sent to your email , Please cheack your email \")</script>");
				}
				else
				{
					rd=request.getRequestDispatcher("Std_reg.html");
					rd.include(request, response);
					out.println("\n <script>window.alert(\"Password Not updated in db\")</script>");
				
				}
			}
			else {
				rd=request.getRequestDispatcher("Std_reg.html");
				rd.include(request, response);
				out.println("\n <script>window.alert(\"Registration Failed!\")</script>");
			}
			
			Db.Dbcon.closeCon("Sregs.java");				
		} 
		catch (Exception e) 
		{
		
			//out.println(e);
			rd=request.getRequestDispatcher("Std_reg.html");
			rd.include(request, response);
			out.println("\n <script>window.alert(\"Registration Failed! or Internet no available\")</script>");
		
		} 
	}
	}

