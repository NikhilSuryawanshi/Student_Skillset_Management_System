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
       
    	%>
    	<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title>SSSM | Teacher - View Group</title>
    <link rel="stylesheet" href="style/style.css">
    <link rel="stylesheet" href="fontawesome/css/all.css">
 
 <style>
     .header_content
    {
        text-transform: uppercase;
        position: relative;
        color: rgba(255,255,255,0.8);
        font-family: cursive ;
    top: 45%;
    left: 50%;
    transform: translate(-50%,-50%);
    width: 480px;
    height: auto;
    box-sizing: border-box;
    background: rgba(0,0,0,0.8);
    padding-right: 40px;
    padding-left: 40px;
    padding-top: 10px;
    padding-bottom: 20px;
        
    }
.header_content h2
{
text-align: center;
padding-bottom: 20px;
padding-top: 20px;
}


.header_content select
        {
          border: none;
            width: 150px;
            outline: none;
            height: 40px;
            color: black;
            font-size: 18px;
            text-align: center;
            overflow:hidden;
           -moz-border-radius: 9px 9px 9px 9px;
          -webkit-border-radius: 9px 9px 9px 9px;
            border-radius: 9px 9px 9px 9px;
            box-shadow: 1px 1px 11px #330033;
             background: linear-gradient(to right, #25acc4, #25c46d);
        
        }
        .header_content option
        {
            
          color: black;
            outline: none;
           text-align: center;
        
        }
        .header_content select:hover
        {
          border: none;
            outline: none;
            height: 43px;
            color:whitesmoke;
            font-size: 20px;
            text-align: center;
            overflow:hidden;
           -moz-border-radius: 9px 9px 9px 9px;
          -webkit-border-radius: 9px 9px 9px 9px;
            border-radius: 9px 9px 9px 9px;
            box-shadow: 1px 1px 11px #330033;
             background: linear-gradient(to right, #25acc4, #25c46d);
        transition: 0.4s;
        }
   
        .header_content input[type=submit]{
        border: none;
        height: 35px;
        width: 50%;
        outline: none;
        color:white;
        background: rgb(255, 94, 0);
        cursor: pointer;
        border-radius: 20px;
        font-family: cursive;
        font-size: 18px;
        border: 1px solid white;
       }

       .header_content input[type=submit]:hover{
        background: cornsilk;
        color:rgb(255, 94, 0);;
        font-weight: bold;
        transition: 0.4s;
        font-size: 19px;
        border: 2px solid rgb(255, 94, 0);
        }
table
{
margin-left: 2px;

}
table td 
{
    text-align:center;
    padding: 2px;
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
    <header>View Group</header>
  <ul>
    <li><a href="Tea_home.jsp"><i class="fas fa-qrcode"></i>  Dashboard</a></li>
    <li><a href="Tea_proj_assign.jsp"><i class="fas fa-edit"></i>Assign Projects</a></li>   
    <li><a href="Tea_add_project.jsp"><i class="fas fa-edit"></i>Add Project</a></li> 
    <li><a href="Tea_pro_group.jsp"><i class="fas fa-edit"></i>Group Filter</a></li>   
    <li><a href="Slogout"><i class="fas fa-power-off"></i>  Log Out</a></li>
  </ul>
</div>
 <section>


    <div class="header_content">
      <h2>View Group</h2>
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

<form action="Com_sem_pro.jsp" method="post">			
<table>
      <tr>
        <td>Select Semester :</td>
        <td><select name="semester" required="required" title="plsease select a valid semester">
          <option disabled selected hidden="hidden">Semester</option>
          <option value="1">I semester</option>
          <option value="2">II semester</option>
          <option value="3">III semester</option>
          <option value="4">IV semester</option>
          <option value="5">V semester</option>
          <option value="6">VI semester</option>
          <option value="7">VII semester</option>
          <option value="8">VIII semester</option>
        </select></td>
      </tr>
     </table>
     <h2><Input type="submit" value="Search"></Input></h2>
</form>



  <% String sem=request.getParameter("semester");%>
<form action="Com_proj_list.jsp" method="post">
  <table>
      <tr>
        <td>Select the Project:</td>
        <td>
 <select name="project" required="required" title="plsease select a valid Project">
 					<option disabled selected hidden="hidden">Project</option>
 					<%
	 
 					con=Dbcon.setCon("Com_proj_list_.jsp");
 				    sql="select * from project where active_status=? and sem=?" ;
 				    ps=con.prepareStatement(sql);
 				    ps.setString(1, "1");
 				    ps.setString(2, sem);
 					rs = ps.executeQuery();
 						while(rs.next())
		 			{
					String projno=rs.getString("project_no");
					String projname=rs.getString("project_name");
			
		
   		   	%>
					<option value="<%= projno %> "><%= projno %>.  <%= projname %> </option>		
 		<%
 
  		}
 						Dbcon.closeCon("Com_sem_pro.jsp");
   		   	%>
   
   		   	</select>
   		   	</td>
   		   	</tr>
   		   	</table>
<h2><Input type="submit" value="Show"></Input></h2>
</form>
  </div>


 </section>

  </body>
</html>
