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
 * Servlet implementation class UppassStd
 */
@WebServlet("/UppassStd")
public class UppassStd extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private PrintWriter out;
	private String usr;
	private String oldpass;
	private String newpass;
	private Connection con;
	private RequestDispatcher rd;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UppassStd() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		out=response.getWriter();
		oldpass = request.getParameter("oldpass");
		newpass = request.getParameter("newpass");
		usr = request.getParameter("roll");
		try
		{
			con=Dbcon.setCon("UppassStd.java");
			String sql=new String("update slogin set passwd=? where roll=? and passwd=?");
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setString(1,newpass);
			ps.setString(2,usr);
			ps.setString(3,oldpass);
			int i=ps.executeUpdate();
			if(i>0) 
			{
				rd=request.getRequestDispatcher("index.html");
				rd.include(request, response);
				out.println("\n <script>window.alert(\"Password Changed! Please log in with new Password...!\")</script>");
			}
			else
			{
				rd=request.getRequestDispatcher("UppassSTd.jsp");
				rd.include(request, response);
				out.println("\n <script>window.alert(\"Old password doesn't correct...!\")</script>");
				
			}
			Db.Dbcon.closeCon("UppassStd.java");
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}

	}
