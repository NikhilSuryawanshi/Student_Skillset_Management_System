<%@page import="Db.Dbcon"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

 <%!
 
       Connection con;
       PreparedStatement ps;
       ResultSet rs;
       RequestDispatcher rd;
       String sql;
       String roll;	      
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
    <title>SSSM | Student - Memeber List</title>
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
    top: 53%;
    left: 50%;
    transform: translate(-50%,-50%);
    width: 85%;
    height: 650px;
    box-sizing: border-box;
    background: rgba(0,0,0,0.8);
    padding-right: 30px;
    padding-left: 30px;
    padding-top: 10px;        
    }

    table{
  width:100%;
  table-layout:auto;
}
.tbl-header{
    background: -webkit-linear-gradient(left, #25c481, #25b7c4);
  background: linear-gradient(to right, #25c481, #25b7c4);
  text-align: center;
 }
.tbl-content{
  height:580px;
  overflow-x:auto;
  margin-top: 0px;
  border: 1px solid rgba(255,255,255,0.3);
}
th{
text-align: center;
padding: 10px 10px;
  font-size: 18px;
  color: #fff;
  text-transform: uppercase;
  overflow-x:auto;  
}
tr:hover
{
  text-align: center;
  font-size: 16px;
  background-color: rgba(26, 168, 173, 0.8);
  transition: 0.4s ease;
}

td{
 
   padding: 10px;
  text-align: center;
  vertical-align:middle;
  font-size: 16px;
  color: #fff;
  border-bottom: solid 3px rgba(255,255,255,0.1);
}
.header_content h2
{
text-align: center;
padding: 10px;
}
  </style>
  
  
  </head>
  <body>
    <input type="checkbox" id="check">
    <label for="check">
      <i class="fas fa-bars" id="btn"></i>
      <i class="fas fa-times" id="cancel"></i>
    </label>
    <div class="sidebar">
    <header>Team Members</header>
  <ul>
    <li><a href="Std_home.jsp"><i class="fas fa-home"></i> Home</a></li>
    <li><a href="Std_update_pro.jsp"><i class="fas fa-user-edit"></i>Edit Profile</a></li>
    <li><a href="Std_skill_panel.jsp"><i class="fas fa-tools"></i>Skill Panel</a></li>
    <li><a href="Std_select_proj.jsp"><i class="fas fa-users"></i>  Projct Panel</a></li>
    <li><a href="UppassSTd.jsp"><i class="fas fa-user-shield"></i>Reset Password</a></li>
    <li><a href="Slogout"><i class="fas fa-sign-out-alt"></i>  Log Out</a></li>
  </ul>
</div>
 <section>


    <div class="header_content">
        
     
<%
String pro_no=request.getParameter("project");
try
{
	

con=Dbcon.setCon("Proj_list.jsp");
sql=new String("select *from project where project_no=?");
ps=con.prepareStatement(sql);
ps.setString(1, pro_no );
rs=ps.executeQuery();
if(rs.next())
{
	do
	{
		roll=rs.getString("students");
		
	}
	while(rs.next());
	
}
String rolls[]=roll.split(" ");

%>
	
	<h2>Team Members</h2>

        <div class="tbl-content">
			<table>
		
<tr class="tbl-header">
                  <th>Roll No.</th>
                  <th>Name</th>
                  <th>Last Name</th>
                  <th>Gender</th>
                  <th>Semester</th>
                  <th>Email</th>
    
                </tr>
		
		
<%

for(String r:rolls)
{
	

	sql=new String("select *from student where roll=?");
	ps=con.prepareStatement(sql);
	ps.setString(1,r);
	rs=ps.executeQuery();
	if(rs.next())
	{
		
		do
		{
			String name=rs.getString("first_name");
			String last=rs.getString("last_name");
			String sex=rs.getString("sex");
			String email=rs.getString("email");
			String sem=rs.getString("sem");
		
		%>
		 <tr>
                <td><%=r %></td>
                <td><%=name %></td>
                <td><%=last %></td>
                <td><%=sex %></td>
                <td><%=sem %></td>
                <td><%=email %></td>
              </tr>
		
		<% 
		}
		while(rs.next());
		
		
	}	
}
		%>
		</table>
		<%
		Dbcon.closeCon("Std_proj_list.jsp");
} 
catch(Exception e )
{
	rd=request.getRequestDispatcher("Std_select_proj.jsp");
	rd.include(request, response);
	out.println("\n <script>window.alert(\"No records Found\")</script>");
}	
%>
     </div>
             
    
     </div>


 </section>

  </body>
</html>
  