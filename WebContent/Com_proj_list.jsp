<%@page import="Db.Dbcon"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title>SSSM | Faculty - Memeber List</title>
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
    top: 55%;
    left: 50%;
    transform: translate(-50%,-50%);
    width: 85%;
    height: 640px;
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
  height:520px;
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
.header_content button {
      border: none;
        height: 26px;
        width: 100px;
        text-align: center;
        outline: none;
        color:black;
        background: rgb(235, 131, 46);
        cursor: pointer;
        border-radius: 20px;
        font-family: cursive;
        font-size: 16px;
        border: 2px solid white;
       }

    .header_content button:hover{
      background: aliceblue;
        color:rgb(235, 131, 46);
        transition: 0.4s;
        font-size: 17px;
        font-weight: bold;
        height: 27px;
       border:  2px solid rgb(235, 131, 46);
    } 
      .header_content h3 
      {
        text-align: center;
        padding: 10px 0px 0px 0px ;
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
    <li><a href="Tea_home.jsp"><i class="fas fa-qrcode"></i>  Dashboard</a></li>
    <li><a href="Tea_proj_assign.jsp"><i class="fas fa-edit"></i>Assign Projects</a></li>   
    <li><a href="Tea_add_project.jsp"><i class="fas fa-caret-square-down"></i>Add Project</a></li>
    <li><a href="Tea_pro_group.jsp"><i class="fas fa-users-cog"></i>Group Filter</a></li>      
    <li><a href="Slogout"><i class="fas fa-power-off"></i>  Log Out</a></li>
  </ul>
</div>
 <section>


    <div class="header_content">
        
          
        <h2>Team Members</h2>

        <div class="tbl-content">
        <table >
   
    
                <tr class="tbl-header">
                 <th>Sr.No.</th>
                  <th>Roll No.</th>
                  <th>Name</th>
                  <th>Last Name</th>
                  <th>Gender</th>
                  <th>Semester</th>
                  <th>Mobile</th>
    
                </tr>

 <%!
 String pro;
       Connection con;
       PreparedStatement ps;
       ResultSet rs;
       RequestDispatcher rd;
       String sql;
       String roll;	 
       int i;
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

String pro_no=request.getParameter("project");
try
{
	

con=Dbcon.setCon("Proj_list.jsp");
sql=new String("select *from project where project_no=?");
ps=con.prepareStatement(sql);
ps.setString(1, pro_no );
rs=ps.executeQuery();
if(rs.next())
{	 i=0;
	do
	{ 
		roll=rs.getString("students");
		 pro=rs.getString("project_name");
		
	}
	while(rs.next());
	
}
String rolls[]=roll.split(" ");
for(String r:rolls)
{
	

	sql=new String("select *from student where roll=?");
	ps=con.prepareStatement(sql);
	ps.setString(1,r);
	rs=ps.executeQuery();
	if(rs.next())
	{
		
		do
		{	++i;
			String name=rs.getString("first_name");
			String last=rs.getString("last_name");
			String sex=rs.getString("sex");
			String mobile=rs.getString("mobile");
			String sem=rs.getString("sem");
		
		%>
	
	<tr>
	<td><%=i %></td>
	<td><%=r %></td>
	<td><%=name %></td>
	<td><%=last %></td>
	<td><%=sex %></td>
	<td><%=sem %></td>
	<td><%=mobile %></td>
	
	</tr>
		
		<% 
		}
		while(rs.next());
		
		
	}	
}
		Dbcon.closeCon("Com_proj_list.jsp");
} 
catch(Exception e )
{
	e.printStackTrace();
	%>
	<tr>
	<td colspan="6" ><h3>No Records Found</h3></td>
	</tr>
	<%
}	
%>
</table>
</div>
<h3>Project Name:<%=pro %></h3>
  <h3> <button onclick="window.print() ">Export</button></h3> 
</div>
</section>
</body>
</html>
  