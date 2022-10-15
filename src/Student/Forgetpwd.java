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

/**
 * Servlet implementation class Forgetpwd
 */
@WebServlet("/Forgetpwd")
public class Forgetpwd extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private String roll;
	private Connection con;
	private ResultSet rs;
	private RequestDispatcher rd;  
	private String email;
	private String usr;
	private String tempwd;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Forgetpwd() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */  
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	
	{
		// TODO Auto-generated method stub
		PrintWriter out=response.getWriter();
		roll=request.getParameter("roll");
		
		try {
			con = Db.Dbcon.setCon("Forgetpwd.java");
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
			
			Db.Dbcon.closeCon("Forgetpwd.java");		
		}
		catch (Exception e) {
		
			//out.println(e);
			rd=request.getRequestDispatcher("index.html");
			rd.include(request, response);
			out.println("\n <script>window.alert(\"No internet ! temporary PASSWORD is 'root' "
					+"Please use this password to log in your account"
					+ "and change your password IMIDIATLY\\!\")</script>");
			
		} 

		
		
		
	}

}
