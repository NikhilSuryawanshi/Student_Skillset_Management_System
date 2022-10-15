<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="Db.Dbcon"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%!
RequestDispatcher rd;
String sql;
Connection con;
ResultSet rs;
PreparedStatement ps;

%>

<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title>SSSM | Teacher - Add / Edit Project</title>
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
    top: 52%;
    left: 50%;
    transform: translate(-50%,-50%);
    width: 90%;
    height: auto;
    box-sizing: border-box;
    background: rgba(0,0,0,0.8);
    padding-right: 30px;
    padding-left: 30px;
    padding-top: 20px;
    padding-bottom: 20px;
        
    }
.header_content h2
{
    text-align: center;
    padding-bottom: 10px;
}
    table{
  width:100%;
  table-layout:auto;
}
.tbl-header{
  background-color: rgba(255,255,255,0.3);
 }
.tbl-content{
  height:500px;
  overflow-x:auto;
  margin-top: 0px;
  border: 1px solid rgba(255,255,255,0.3);
}
tr:hover
{
  text-align: center;
  font-size: 16px;
  background-color: rgba(26, 168, 173, 0.8);
  transition: 0.4s ease;
}
th{
text-align: center;
padding: 5px 8px;
  font-size: 18px;
  color: #fff;
  text-transform: uppercase;
  overflow-x:auto;
}
td{
    
  padding: 10px;
  text-align: center;
  vertical-align:middle;
  font-size: 16px;
  color: #fff;
  border-bottom: solid 3px rgba(255,255,255,0.1);
}
.tbl-content a

{
    display: block;
   background: rgb(255, 123, 0);
  line-height: 25px;
  padding: 4px;
  font-size: 16px;
  color: white; 
  box-sizing: border-box;
border: 2px solid rgba(255,255,255);
border-radius: 20px;
}
.tbl-content a:hover
{
  
  color: rgb(255, 94, 0);
  background: white;
  text-decoration: none;
  font-weight: bold;
  transition: 0.4s;
  border: 2px solid rgb(255, 94, 0);
  border-radius: 20px;
}
form
{
text-align: center;
padding: 15px;
color: whitesmoke;
}
form input[type=text]
{
border: none;
border-bottom: 1px solid #ffffff;
background-color: transparent;
outline: none;
height: 20px;
width: 50%;
color: white;
font-size: 18px ;

}
form button[type=submit]{
        border: none;
        outline: none;
        color:#ffffff;
        width: 100px;
        background-color:#e67300;
        cursor: pointer;
        border-radius:20px;
        font-family: cursive;
        font-size: 15px;
        border: 2px solid white;
       }

    form button[type=submit]:hover{
        background-color: #ffffff;
        color:#e67300;
        transition: 0.4s;
        font-weight: bold;
      border: 2 px solid #e67300 ;
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
    <header>Add / Edit Project</header>
  <ul>
    <li><a href="Tea_home.jsp"><i class="fas fa-qrcode"></i>  Dashboard</a></li>
    <li><a href="Tea_proj_assign.jsp"><i class="fas fa-edit"></i>Assign Projects</a></li>   
    <li><a href="Tea_pro_group.jsp"><i class="fas fa-users-cog"></i>Group Filter</a></li>   
    <li><a href="Slogout"><i class="fas fa-power-off"></i>  Log Out</a></li>
  </ul>
</div>
 <section>


    <div class="header_content">
        <h2>Added Projects </h2>
        <div class="tbl-content">
           
            <table >
                
                  <tr class="tbl-header">
                    <th width="5%">Pro.No.</th><th>Project Name</th><th width="15%">Status</th> <th width="15%">Change Status</th><th width="15%">Action</th>
                  </tr>
       <%
//allow access only if session exists
String usr = null;
if(session.getAttribute("usr") == null)
{
	RequestDispatcher rd = request.getRequestDispatcher("/index.html");
	rd.include(request, response);
	out.println("<script>window.alert(\"Time out\")</script>");
	
}else usr = (String) session.getAttribute("usr");
String userName = null;
String sessionID = null;
Cookie[] cookies = request.getCookies();
if(cookies !=null){
for(Cookie cookie : cookies){
	if(cookie.getName().equals("usr")) userName = cookie.getValue();
	if(cookie.getName().equals("JSESSIONID")) sessionID = cookie.getValue();
}
}

try
{
	con=Dbcon.setCon("Tea_add_prject.jsp");
	String sql=new String("select *from project order by project_no");
	ps=con.prepareStatement(sql);
	rs=ps.executeQuery();
    if(rs.next())
    {
    	    	
 
		
    	do
		{
			
			String projno=rs.getString("project_no");
			String proj=rs.getString("project_name");
			String acti=rs.getString("active_status");
			
			%>
			
  <tr> <td><%= projno %></td>  <td><%= proj %></td>   <td><%if(acti.equals("1")){out.print("<h3 style=\"color: green;\" > Active</h3>");}else{out.print("<h3 style=\"color: red;\"> Deactive </h3>");}  %></td><td><a  href="Tea_edit_project_status?status=<%= acti %>&prno=<%= projno %>"> Change Status</a></td><td><a href="Tea_edit_project.jsp?project_name=<%= proj %>"> Edit</a></td></tr>
			
			<%	
		}while(rs.next());
    	
    	   }
    else
    {
    	%>
    	<tr>
                    <td colspan="5">No Projects Available...!</td>
                  </tr>
    	
    	<%
    	
    }
    Dbcon.closeCon("Tea_add_prject.jsp");
}catch(Exception e)
{
	e.printStackTrace();
}

%>
</table>
</div>
<form action="Tea_add_project" method="post">
  Add Project : <input type="text" name="project_name" required ><button type="submit">Add</button>
</form>
     </div>


 </section>

  </body>
</html>
