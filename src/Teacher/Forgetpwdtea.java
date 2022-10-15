package Teacher;


import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Forgetpwdtea
 */
@WebServlet("/Forgetpwdtea")
public class Forgetpwdtea extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Connection con;
	private ResultSet rs;
	private RequestDispatcher rd;  
	private String email;
	private String usr;
	private String tempwd; 
	private String sql;
	private PreparedStatement ps;
	HttpSession session;
    PrintWriter out;
	/**
     * @see HttpServlet#HttpServlet()
     */
    public Forgetpwdtea() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		out=response.getWriter();
		 usr = null;
		 request.getSession();

	
		email=request.getParameter("email");
		
		try {
			con = Db.Dbcon.setCon("Forgetpwdtea.java");
			sql= new String("select first_name,email from teacher where email=?");
			ps=con.prepareStatement(sql);
			ps.setString(1, email);
			rs = ps.executeQuery();
			if (rs.next())
			{	
				email=rs.getString("email");
				usr=rs.getString("first_name");
				tempwd=Db.SendMail.mail(usr, email);
				sql="update tlogin set passwd=? where email=?";
				ps=con.prepareStatement(sql);
				ps.setString(1,tempwd);
				ps.setString(2,email);
				int i= ps.executeUpdate();
				if(i>0)
				{
					rd=request.getRequestDispatcher("index.html");
					rd.include(request, response);
					out.println("\n <script>window.alert(\"Temporary Password sent successfully to your email!\")</script>");
				}
			}
			
			else {
				rd=request.getRequestDispatcher("index.html");
				rd.include(request, response);
				out.println("\n <script>window.alert(\"Email not Registered!\")</script>");
			}
			
			Db.Dbcon.closeCon("Forgetpwdtea.java");	
		} 
		catch (Exception e) 
		
		{
			e.printStackTrace();
			rd=request.getRequestDispatcher("index.html");
			rd.include(request, response);
			
			out.print("\n <script>window.alert(\"Internet not available! your temporary PASSWORD is set as 'root' please use this password to log in your account and change your password IMIDIATLY\")</script>");
		
		} 
	}

}
