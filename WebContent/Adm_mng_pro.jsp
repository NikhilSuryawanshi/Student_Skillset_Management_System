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
    <title>SSSM | Admin - Project List</title>
    <link rel="stylesheet" href="style/style.css">
    <link rel="stylesheet" href="fontawesome/css/all.css">
 
 <style>
     .header_content
    {
        text-transform: uppercase;
        position: relative;
        color: rgba(255,255,255,0.8);
        font-family: cursive ;
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
th{
text-align: center;
padding: 20px 15px;
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
}tr:hover
{
  text-align: center;
  vertical-align:middle;
  font-size: 16px;
  color:black;
  border-bottom: solid 3px rgba(255,255,255,0.1);
  background-color: rgba(26, 168, 173, 0.8);
  transition: 0.4s ease;
}
.tbl-content a

{
  display: block;
 background-color:rgb(235, 131, 46); 
  line-height: 15px;
  width: 90px;
  border-radius: 20px;
  font-size: 15px;
  color: white; 
  padding: 4px;
  box-sizing: border-box;
  border:2px solid white; 
margin: 5px;
}
.tbl-content a:hover
{
    
  background-color: white;
  color: rgb(235, 131, 46);
  font-weight: bold;
  text-decoration: none;
  transition: 0.3s;
  border:2px solid rgb(235, 131, 46); 
  
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
    <header>Project List</header>
  <ul>
    <li><a href="Adm_home.jsp"><i class="fas fa-qrcode"></i> Dashboard</a></li>
    <li><a href="Adm_std_service.jsp"><i class="fas fa-user-graduate"></i>  Student Control</a></li>
    <li><a href="Adm_show_tea.jsp"><i class="fas fa-user-cog"></i>  Faculty Control</a></li>
    <li><a href="Adm_mng_pro.jsp"><i class="fas fa-tools"></i> Project Control</a></li>
    <li><a href="Adm_add_skill.jsp"><i class="far fa-sun"></i> Skill Control</a></li>
    <li><a href="Slogout"><i class="fas fa-power-off"></i>  logout</a></li>
  </ul>
</div>
 <section>


    <div class="header_content">
        <h2>Available Projects </h2>
        <div class="tbl-content">
           
            <table >
                
                  <tr class="tbl-header">
                    <th width="1%">Pro.No.</th><th>Project Name</th><th width="10%">Status</th><th width="10%">Action</th>
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
	con=Dbcon.setCon("Adm_mng_pro.jsp");
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
			
  <tr> <td><%= projno %></td>  <td><%= proj %></td><td><%if(acti.equals("1")){out.print("<p style=\"color: green; font-weight:bold;\" > Active</p>");}else{out.print("<p style=\"color: red; font-weight:bold;\"> Deactive </p>");}  %></td><td><a href="Adm_remove_pro?project_name=<%= proj %>&prno=<%= projno %>"> Remove</a></td> </tr>
			
			<%	
		}while(rs.next());
 
    }
    else
    {
    	out.print("Nothing to show ");
    }
    Dbcon.closeCon("Adm_mng_pro.jsp");
}catch(Exception e)
{
	e.printStackTrace();
}

%>
</table>
 </div>
 </div>
 </section>
</body>
</html>
