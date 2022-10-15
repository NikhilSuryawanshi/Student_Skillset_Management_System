<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="Db.Dbcon"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    
    
    <!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title>SSSM | Admin- Faculty_list</title>
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
    background: -webkit-linear-gradient(left, #25c481, #25b7c4);
  background: linear-gradient(to right, #25c481, #25b7c4);
  text-align: center;
 }
.tbl-content{
  height:560px;
  overflow-x:auto;
  margin-top: 0px;
  border: 1px solid rgba(255,255,255,0.3);

}
th{
text-align: center;
padding: 5px 10px;
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
  margin-left:5px;
}
.tbl-content a:hover
{
    
  background-color: white;
  color: rgb(235, 131, 46);
  font-weight: bold;
  text-decoration: none;
  transition: 0.3s;
  border: 1px solid rgb(235, 131, 46);
  
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
    <header>Faculty Control</header>
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
        
          
        <h2>Fetched Faculty</h2>

        <div class="tbl-content">
    
    
    <%
//allow access only if session exists
RequestDispatcher rd;
String usr = null;
if(session.getAttribute("usr") == null){
	response.sendRedirect("index.html");
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
%>
       <%!
       Connection con;
       PreparedStatement ps;
       ResultSet rs;
       RequestDispatcher rd;
       %>

		<table >
    
                <tr class="tbl-header">
                  <th width="2%">Sr. No.</th>
                  <th>Name</th>
                  <th>Last Name</th>
                  <th width="2%">Gender</th>
                  <th>Mobile</th>
                  <th>Email</th>
                  <th colspan="2" width="10%">Acion</th>
                </tr>
		 
<%

	con=Dbcon.setCon("Adm_show_tea.jsp");
	String sql=new String("select first_name,last_name,mobile,sex,email from teacher order by first_name");
	ps=con.prepareStatement(sql);
	rs=ps.executeQuery();
	
	if(rs.next())
	{
	int i=0;
		
		do
		{
			i++;
			String name=rs.getString("first_name");
			String last=rs.getString("last_name");
			String sex=rs.getString("sex");
			String mobile=rs.getString("mobile");
			String email=rs.getString("email");
			%>
			
			
					<tr>
			<td><%=i %></td>		
			<td><%=name %></td>
			<td><%=last %></td>
			<td><%=sex %></td>
			<td><%=mobile %></td>
			<td><%=email %></td>
			<td><a href="Profile_tea.jsp?email=<%= email %>">Show Profile</a></td>
			<td><a href="Remove_tea?email=<%= email %>">Remove</a></td>
			</tr>
			
			<%
		}while(rs.next());
		
	}
	else
	{	
		
	
	}
	Dbcon.closeCon("Adm_show_tea.jsp");
%>
		</table>
</div>
</div>
</section>
   </body>
</html>    
