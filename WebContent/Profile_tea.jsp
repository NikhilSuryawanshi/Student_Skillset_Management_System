<%@page import="Db.Dbcon"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%!
       String sql;
       RequestDispatcher rd;
       PreparedStatement ps;
       ResultSet rs;
       String usr = null;
       Connection con;
       String first_name;
   	String last_name;
   	String mobile;
   	String dob;
   	String sem;
   	String email;
   	String sex;
       %>    
        
        
        
        
        <%
//allow access only if session exists
session=request.getSession();
String usr = null;
if(session.getAttribute("usr") == null){
	response.sendRedirect("index.html");
	out.println("\n <script>window.alert(\"session expired\")</script>");
}
else usr = (String) session.getAttribute("usr");
String userName = null;
String sessionID = null;
Cookie[] cookies = request.getCookies();
if(cookies !=null){
for(Cookie cookie : cookies){
	if(cookie.getName().equals("usr")) userName = cookie.getValue();
	if(cookie.getName().equals("JSESSIONID")) sessionID = cookie.getValue();
}
}
%>
    
<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title>SSSM | Admin -Teacher Profile</title>
    <link rel="stylesheet" href="style/style.css">
    <link rel="stylesheet" href="fontawesome/css/all.css">
 
 <style>
     .header_content
    {
        text-transform: uppercase;
        position: relative;
        color: rgba(255,255,255,0.8);
        font-family: cursive ;
        position: relative;
    top: 50%;
    left: 47%;
    transform: translate(-50%,-50%);
    width: 500px;
    height: auto;
    box-sizing: border-box;
    /* background: rgba(0,0,0,0.8); */
    padding-right: 40px;
    padding-left: 40px;
    padding-top: 10px;
        
    }

    .card {
        font-size: 18px;
        box-shadow: 0 8px 8px 10px rgba(145, 143, 143, 0.4);
        width: 500px;
        padding: 10px;
       
        text-align: center;
        background: rgba(0,0,0,0.8);
      }
    .card h1{
        color: rgb(121, 121, 121);
        text-align: center;
        padding-bottom: 10px;
    }
    h1:hover{
        color: rgb(255,255,255); 
    }
         img {
        box-shadow: 0 8px 8px 10px rgba(95, 89, 89, 0.4);
        width: 250px;
        height:250px;
        border: 1px solid black;
        border-radius:130px;
        margin-bottom: 30px;
      }
      img:hover
      {
        width: 250px;
        height:250px;
        border: 2px solid black;
        border-radius:70px;
        transition: 0.3s;
      }
 table{color: rgb(176, 173, 173);
     text-align: left;
     margin-bottom: 30px;
     padding-left: 20px ;
 }
 td{
    padding-left: 20px ;
    padding-bottom: 5px;
     padding-right: 30px;
 }
 td:hover{
     font-size: 19px;
     color: rgb(247, 149, 57);
     transition: 0.3s;
 }
    


  </style>
  
  
  </head>
  <body>
 <section>


    <div class="header_content">
            
       <%String mail=request.getParameter("email"); %> 
 
            <div class="card">
                <h1>Teacher Profile Page</h1>
                <img src="<%=Dbcon.imgLoc(mail) %>" alt="<%= mail%>"/>
                <table> 
<%

con=Dbcon.setCon("Teacher_profile.jsp");
	sql=new String("select *from teacher where email=?");
	ps=con.prepareStatement(sql);
	ps.setString(1, mail);
	rs=ps.executeQuery();
	if(rs.next())
	{
		first_name=rs.getString("first_name");
		  last_name=rs.getString("last_name");
		  sex=rs.getString("sex");
		  email=rs.getString("email");
		  mobile=rs.getString("mobile");
  	%>	
  	
  	
  	 <tr><th>Name</th><td><%= first_name %></td></tr>
     <tr><th>Last_name</th><td><%= last_name %></td></tr>
     <tr><th>Gender</th><td><%=sex %></td></tr>
	 <tr><th>Email</th><td><%=email %></td></tr>
	 <tr><th >Mobile</th><td><%= mobile %></td></tr>
		
<%
Dbcon.closeCon("Teahcer_profile.jsp");
	}

%>
                </table>
                    
            </div>
    </div>


 </section>

  </body>
</html>
