package Student;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Db.Dbcon;

/**
 * Servlet implementation class Reg_net
 */
@WebServlet("/Reg_net")
public class Reg_net extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private String roll;
	private Connection con;
	private ResultSet rs;
	private RequestDispatcher rd;  
	private String email;
	private String usr;
	private String tempwd;
    PreparedStatement ps;
    private PrintWriter out;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public Reg_net() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// TODO Auto-generated method stub
		PrintWriter out=response.getWriter();
		roll=request.getParameter("roll");
		
		try {
			con = Db.Dbcon.setCon("Reg_net.java");
			String sql="select email,first_name from student where roll=?";
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setString(1, roll);
			rs = ps.executeQuery();
			if (rs.next())
			{	
				email=rs.getString("email");
				usr=rs.getString("first_name");
				tempwd=Db.SendMail.mail(usr, email);
				sql="update slogin set passwd=? where roll=?";
				ps=con.prepareStatement(sql);
				ps.setString(1,tempwd);
				ps.setString(2, roll);
				int i=ps.executeUpdate();
				if(i>0)
				{
					rd=request.getRequestDispatcher("Std_login.html");
					rd.include(request, response);
					out.println("\n <script>window.alert(\"Temporary Password Sent Sucessfully!\")</script>");
				}
			}
			else {
				
				rd=request.getRequestDispatcher("Std_reg.html");
				rd.include(request, response);
				out.println("\n <script>window.alert(\"Roll not Registered!\")</script>");
			}
			
			Db.Dbcon.closeCon("Reg_net.java");		
		}
		catch (Exception e) {
		
			out.println(e);
			try
			{
				con=Dbcon.setCon("Reg_net.java");
				String qr="delete from student where roll=? ";
				ps=con.prepareStatement(qr);
				ps.setString(1,roll);
				int i=ps.executeUpdate();
				if(i>0)
				{
		
					rd=request.getRequestDispatcher("index.html");
					rd.include(request, response);
					out.print("<script>window.alert(\"Internet not available try agan later\")</script>");
					
				}
				
				Dbcon.closeCon("Reg_net.java");
				}
			catch(Exception d)
			{
				rd=request.getRequestDispatcher("index.html");
				rd.include(request, response);
				out.print("<script>window.alert(\"Unknown Error contact to admin..!\")</script>");
			}
		}
			
		} 

	}
			
	

