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
    <title>SSSM | Faculty - Student_list</title>
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
    height: 620px;
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
.tbl-content a

{
  display: block;
 background-color:rgb(235, 131, 46); 
  line-height: 15px;
  width: 100px;
  border-radius: 20px;
  font-size: 15px;
  color: white; 
  padding: 4px;
  box-sizing: border-box;
border: 1px solid white;
margin-left: 8px;
margin-right: 8px;
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
th{
text-align: center;
padding: 13px 8px;
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
 
   padding: 5px;
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
    <header>Student List</header>
  <ul>
    <li><a href="Tea_home.jsp"><i class="fas fa-qrcode"></i> Dashboard</a></li>
    <li><a href="Com_skill_filter.jsp"><i class="fas fa-eject"></i>Skill Filter</a></li>   
    <li><a href="Com_sem_skill_filter.jsp"><i class="fas fa-bezier-curve"></i>Semster filter</a></li>
    <li><a href="Tea_std_search_service.jsp"><i class="fas fa-users-cog"></i>Student filter</a></li>
    <li><a href="Slogout"><i class="fas fa-power-off"></i>  Log Out</a></li>
  </ul>
</div>
 <section>


    <div class="header_content">
        
          
        
<%!
RequestDispatcher rd;
PreparedStatement ps;
ResultSet rs;
Connection con;
%>
<%
String usr = null;
if(session.getAttribute("usr") == null)
{
	rd=request.getRequestDispatcher("index.html");
	rd.include(request, response);
	out.println("\n <script>window.alert(\"Login first...!\")</script>");
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
<h2>Fetched Students</h2>
 <div class="tbl-content">
          <table >
    
                <tr class="tbl-header">
                  <th width="8%">Sr. No.</th>
                  <th>Roll No.</th>
                  <th>Name</th>
                  <th>Last Name</th>
                  <th width="5%">DOB</th>
                  <th>Mobile</th>
                  <th width="8%">Action</th>
                </tr>
<%
String sem =request.getParameter("semester");
con=Dbcon.setCon("Tea_show_std.jsp");
try
{
	
	String sql=new String("select dob,roll,first_name,last_name,mobile,sex from student where sem=? order by roll");
	ps=con.prepareStatement(sql);
	ps.setString(1, sem);
	rs=ps.executeQuery();
	
	if(rs.next())
	{	
		int i=0;
	do
		{ i++;
			String roll=rs.getString("roll");
			String name=rs.getString("first_name");
			String last=rs.getString("last_name");
			String sex=rs.getString("sex");
			String mobile=rs.getString("mobile");
			String dob=rs.getString("dob");
			%>
			<tr>
                <td><%=i %></td>
                <td><%=roll %></td>
                <td><%=name %></td>
                <td><%=last %></td>
                <td><%=dob %></td>
                <td><%=mobile %></td>
                <td><a href="Profile_std.jsp?roll=<%=roll %>">Profile</a></td>
              </tr>
			
			<%
		}while(rs.next());
		
	
	
	}

	else
	{	
		//rd=request.getRequestDispatcher("Tea_std_search_service.jsp");
		//rd.include(request, response);
		//out.println("\n <script>window.alert(\"No Records Found\")</script>");
	%>
	
	<tr >
                <td  colspan="7"><h3>No Data Available for this Semester</h3></td>  
              </tr>
	<%
	}
	Dbcon.closeCon("Tea_show_std.jsp");
}
catch(Exception e)
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

