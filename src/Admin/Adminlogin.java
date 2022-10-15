package Admin;

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
 * Servlet implementation class Adminlogin
 */
@WebServlet("/Adminlogin")
public class Adminlogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       private final String userID = "admin";
   	private final String password = "password";
   	private RequestDispatcher rd;
   	PrintWriter out;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Adminlogin() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out=response.getWriter();
		String usr = request.getParameter("id");
		String pwd = request.getParameter("passwd");
		
		if(userID.equals(usr) && password.equals(pwd)){
			HttpSession session = request.getSession();
			session.setAttribute("usr", "id");
			//setting session to expiry in 1 mins
			session.setMaxInactiveInterval(5*60);
			Cookie userName = new Cookie("usr", usr);
			userName.setMaxAge(1*60);
			response.addCookie(userName);
			response.sendRedirect("Adm_home.jsp");
		}
		else
		{
			rd=request.getRequestDispatcher("Adm_login.html");
			rd.include(request, response);
			out.println("\n <script>window.alert(\"Invalid Id or Password\")</script>");
		}

	}
}
