<%@page import="java.util.Arrays"%>
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
    <title>SSSM | Faculty - Create Group</title>
    <link rel="stylesheet" href="style/style.css">
    <link rel="stylesheet" href="fontawesome/css/all.css">
    <script type="text/javascript">
        // '.tbl-content' consumed little space for vertical scrollbar, scrollbar width depend on browser/os/platfrom. Here calculate the scollbar width .
      $(window).on("load resize ", function() {
        var scrollWidth = $('.tbl-content').width() - $('.tbl-content table').width();
        $('.tbl-header').css({'padding-right':scrollWidth});
      }).resize();
      </script>
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
    width: 90%;
    height: auto;
    box-sizing: border-box;
    background: rgba(0,0,0,0.8);
    padding-right: 30px;
    padding-left: 30px;
    padding-top: 10px;
    padding-bottom: 10px;
        
    }

      
        h2{
font-weight:bold;
  color: #fff;
  text-transform: uppercase;
  text-align: center;
  margin-bottom: 10px;
}
table{
  width:100%;
  table-layout:auto;
  margin-bottom: 30px;

}
.tbl-header{
  background-color: rgba(255,255,255,0.3);
 }
.tbl-content{
  height:400px;
  overflow-x:auto;
  margin-top: 0px;
  border: 1px solid rgba(255,255,255,0.3);
  margin-bottom: 10px;
}
th{
text-align: center;
padding: 10px 5px;
  font-size: 15px;
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
  font-size: 15px;
  color: #fff;
  border-bottom: solid 3px rgba(255,255,255,0.1);
}

.header_content select
        {
          border: none;
            width: auto;
            outline: none;
            height: 25px;
            color: black;
            font-size: 15px;
            text-align: center;
            overflow:hidden;
           -moz-border-radius: 9px 9px 9px 9px;
          -webkit-border-radius: 9px 9px 9px 9px;
            border-radius: 9px 9px 9px 9px;
            box-shadow: 1px 1px 11px #330033;
            background: white;
        font-weight: bold;
        margin-top: 5px;
        }
        .header_content option
        {
            
          color: black;
            outline: none;
           text-align: center;
        background: wheat;
        }
        .header_content select:hover
        {
          border: none;
            outline: none;
            color:black;
            text-align: center;
            overflow:hidden;
          background: white;
        }
        .header_content  button[type=submit]{
        border: none;
        height: 30px;
        width: 180px;
        outline: none;
        color:black;
       background: white;
        cursor: pointer;
        border-radius: 20px;
        font-family: cursive;
        font-size: 15px;
          border: 2px solid rgb(255, 116, 3);
margin-top: 10px;
       }
       .header_content button[type=submit]:hover{
        background: rgb(255, 116, 3);
        color:white;
        transition: 0.5s;
        font-size: 16px;
        border: 2px solid wheat;
        font-weight: bold;
        }
/* for custom scrollbar for webkit browser*/


  </style>
  
  
  </head>
  <body>
    <input type="checkbox" id="check">
    <label for="check">
      <i class="fas fa-bars" id="btn"></i>
      <i class="fas fa-times" id="cancel"></i>
    </label>
    <div class="sidebar">
    <header>Group Creation</header>
  <ul>
    <li><a href="Tea_home.jsp"><i class="fas fa-qrcode"></i>  Dashboard</a></li>
    <li><a href="Tea_add_project.jsp"><i class="fas fa-edit"></i>Add Projects</a></li>
    <li><a href="Tea_pro_group.jsp"><i class="fas fa-edit"></i>Group Filter</a></li>
    <li><a href="Slogout"><i class="fas fa-power-off"></i> Log Out</a></li>
  </ul>
</div>
 <section>


    <div class="header_content">
        <h2>Student Groups</h2>

        <div class="tbl-content">
 <table >
    
                <tr class="tbl-header">
                  <th width="1%">Sr.No.</th>
                  <th  width="12%">Roll No.</th>
                  <th >Name</th>
                  <th width="1%">Gender</th>
                  <th width="12%">Mobile</th>
                  <th >Email</th>
                  <th >Project</th>
                  <th width="1%">Semester</th>
                </tr>
<%
RequestDispatcher rd;
PreparedStatement ps;
ResultSet rs;
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
	String member =request.getParameter("member");
	String project=request.getParameter("project");

	Connection con=Dbcon.setCon("Tea_proj_assign1.jsp");
	String sem =request.getParameter("semester");
	String sql=new String("select roll,first_name,mobile,sex,email from student where sem=? order by roll");
	ps=con.prepareStatement(sql);
	ps.setString(1, sem);
	rs=ps.executeQuery();
	
	if(rs.next())
	{
	int i=0;
	do
		{ ++i;
			String roll=rs.getString("roll");
			String name=rs.getString("first_name");
			String sex=rs.getString("sex");
			String mobile=rs.getString("mobile");
			String email=rs.getString("email");
			%>
			
			
					<tr>
					<td><%=i %></td>
			<td><%=roll %></td>
			<td><%=name %></td>
			<td><%=sex %></td>
			<td><%=mobile %></td>
			<td><%=email %></td>
			<td><%= Arrays.toString(Dbcon.checkProjectAssignRoll(sem, roll,"Tea_proj_assign1.jsp")) %></td>
			<td><%=sem %></td>
			</tr>
			
			<%
		}while(rs.next());
		
		%>
		  </table>
        </div>
		<% //-------------------------------------------------------------------------------------------------------------------------------------- %>
		<form action="Tea_prroj_assign1" method="post">
		<input name="project" type="hidden" value=" <%=project%>">
		<input name="semester" type="hidden" value=" <%=sem%>">
		<%
		//System.out.println(project+sem);
		int a=Integer.parseInt(member);
		for(int x=1;x<=a;x++)
		{
			
			
			%>Member <%=x%>: 
			<select name="roll" required="required" title="plsease select a valid Roll Number">
	 					<option disabled selected hidden="hidden">Roll No.</option>
			
			<% sql=new String("select roll from student where sem=? order by roll");
			ps=con.prepareStatement(sql);
			ps.setString(1,sem);
			rs=ps.executeQuery();
			 if(rs.next()){
				 
				 do{
					 String roll=rs.getString("roll");
			%>        <option value="<%= roll %>"><%= roll %></option>
			<%		}while(rs.next());
				 
			 }
			 else{
				 System.out.print("else block! of Tea_proj_assign1.jsp");
			 }
			 %>
			 
				</select>
   	<%  } %>
			<h2>	
			<button type="submit">Create Group</button>
			</h2>
</form>			
</div>			
			<%

		
	}
	else
	{	
		
		%>
	
              <tr>
                
                <td colspan="8"><h3>No Data Available</h3></td>
          
              </tr>
             
              
		<%
	
	}
	Dbcon.closeCon("Tea_proj_assign1.jsp");
%>
</section>
</body>
</html>