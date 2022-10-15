<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="Db.Dbcon"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>



















<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title>SSSM | Admin - Student-List</title>
    <link rel="stylesheet" href="style/style.css">
    <link rel="stylesheet" href="fontawesome/css/all.css">
 
 <style>
     .header_content
    {
        text-transform: uppercase;
        position: relative;
        color: rgba(255,255,255,0.8);
        font-family: cursive ;
    top: 55%;
    left: 50%;
    transform: translate(-50%,-50%);
    width: 95%;
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
   
  background: linear-gradient(to right, #25c481, #25b7c4);
  text-align: center;
 }
.tbl-content{
  height:550px;
  overflow-x:auto;
  margin-top: 0px;
  border: 2px solid rgba(255,255,255,0.3);
}
th{
text-align: center;
padding: 5px 12px;
  font-size: 18px;
  color: #fff;
  text-transform: uppercase;
  overflow-x:auto;
  
  
}
td{
 
   padding: 12px;
  text-align: center;
  vertical-align:middle;
  font-size: 16px;
  color: #fff;
  border-bottom: solid 3px rgba(255,255,255,0.1);
}
tr:hover
{
  text-align: center;
  vertical-align:middle;
  font-size: 16px;
  color:black;
  border-bottom: solid 3px rgba(255,255,255,0.1);
  background-color: rgba(26, 168, 173, 0.8);
  transition: 0.4s ease;
}



.header_content h2
{
text-align: center;
padding: 10px;
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
border: 1px solid white;
}
.tbl-content a:hover
{
    
background-color: white;
  color: rgb(235, 131, 46);
  font-weight: bold;
  text-decoration: none;
  transition: 0.3s;
  border: 2px solid rgb(255, 166, 0);
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
    <header>Student List</header>
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
        
          
        <h2>Fetched Students</h2>

        <div class="tbl-content">
<table>
		 <tr class="tbl-header">
                  <th width="1%">Sr. No.</th>
                  <th>Roll No.</th>
                  <th>Name</th>
                  <th>Last Name</th>
                  <th width="1%">Gender</th>
                  <th>DOB</th>
                  <th>Mobile</th>
                  <th>Email</th>
                  <th width="1%">Semester</th>
                  <th colspan="2">Action</th>
                </tr>
			<%!
RequestDispatcher rd;
PreparedStatement ps;
ResultSet rs;
%>
<%
String usr = null;
if(session.getAttribute("usr") == null)
{
	rd = request.getRequestDispatcher("/index.html");
	rd.include(request, response);
	out.println("<script>window.alert(\"Please Log in first...!\");</script>");
	
}
else
{
	usr = (String) session.getAttribute("usr");
String userName = null;
String sessionID = null;
Cookie[] cookies = request.getCookies();

if(cookies !=null)
{
for(Cookie cookie : cookies)
{
	if(cookie.getName().equals("usr")) userName = cookie.getValue();
	if(cookie.getName().equals("JSESSIONID")) sessionID = cookie.getValue();
}
}




	Connection con=Dbcon.setCon("Adm_std_list.jsp");
	String sem =request.getParameter("semester");
	String sql=new String("select roll,dob ,first_name,last_name,mobile,sex,email from student where sem=? order by first_name");
	ps=con.prepareStatement(sql);
	ps.setString(1, sem);
	rs=ps.executeQuery();
	
	if(rs.next())
	{	int i=0;
	do
		{ i++;
			String roll=rs.getString("roll");
			String name=rs.getString("first_name");
			String last=rs.getString("last_name");
			String sex=rs.getString("sex");
			String mobile=rs.getString("mobile");
			String email=rs.getString("email");
			String dob=rs.getString("dob");
			%>
			
			
					<tr>
			<td><%=i %></td>
			<td><%=roll %></td>
			<td><%=name %></td>
			<td><%=last %></td>
			<td><%=sex %></td>
			<td><%=dob %></td>
			<td><%=mobile %></td>
			<td><%=email %></td>
			<td><%=sem %></td>
			<td><a href="Profile_std.jsp?roll=<%=roll %>">Show Profile</a></td>
			<td><a href="Remove_std?roll=<%=roll %>&sem=<%=sem%>">Remove</a></td>
			</tr>
			
			<%
		}while(rs.next());
	
	}
	else
	{	
		%>
		
		<tr>
			<td colspan="10"><h3>No Records Found</h3> </td>
			</tr>
		
		<%
	}
	Dbcon.closeCon("Adm_std_list.jsp");
}

%>
	</table>
	</div>
	</div>
	</section>


</body>
</html>