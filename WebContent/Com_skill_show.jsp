<%@page import="java.util.Arrays"%>
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
    <title>SSSM | Faculty - Student List</title>
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
        position: relative;
    top: 49%;
    left: 50%;
    transform: translate(-50%,-50%);
    width: 90%;
    height: 590px;
    box-sizing: border-box;
    background: rgba(0,0,0,0.8);
    padding-right: 30px;
    padding-left: 30px;
    padding-top: 20px;
    padding-bottom: 20px;
        
    }

    .header_content select
        {
            border: none;
            width: 50%;
            border-bottom: 1px solid #ffffff;
            background-color: transparent;
            outline: none;
            height: 40px;
            color: #ffffff;
            font-size: 15px;
            text-align: center;
        
        }
        .header_content option
        {
            
            background-color:transparent;
            outline: none;
           text-align: center;
        
        }
        .header_content h2
        {
text-align: center;
padding-bottom: 20px;
        }
        h1{
  font-size: 30px;
  color: #fff;
  text-transform: uppercase;
  font-weight: 300;
  text-align: center;
  margin-bottom: 15px;
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
padding: 5px 10px;
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
    <header>Student List</header>
  <ul>
    <li><a href="Tea_home.jsp"><i class="fas fa-qrcode"></i> Dashboard</a></li>
    <li><a href="Com_skill_filter.jsp"><i class="fas fa-pen-alt"></i>Skill Filter</a></li>
    <li><a href="Com_sem_skill_filter.jsp"><i class="fas fa-drafting-compass"></i>Semster filter</a></li>
    <li><a href="Tea_std_search_service.jsp"><i class="fas fa-users-cog"></i>Student filter</a></li>
    <li><a href="Slogout"><i class="fas fa-power-off"></i>  Log Out</a></li>
  </ul>
</div>
 <section>


    <div class="header_content">
        <h2>Skill information</h2>

        <div class="tbl-content">
    
    
    <%
//allow access only if session exists
RequestDispatcher rd;
String usr = null;
if(session.getAttribute("usr") == null){
	response.sendRedirect("index.html");
	out.println("<script>window.alert(\"Login First...!\");</script>");
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
       String sql;
    	%>

	<table>
	 <tr class="tbl-header">
                  <th width="6%">Sr. No.</th>
                  <th>Roll No.</th>
                  <th width="5%">Semester</th>
                  <th>Name</th>
                  <th>Skill</th>
                  <th>Gender</th>
                  <th>Mobile</th>
                </tr>

    	<%
    	String skil=request.getParameter("skill");
    	con=Dbcon.setCon("Com_skill_show.jsp");
    	sql="select student.roll,student.first_name,student.mobile,student.sex ,student.sem,student_skill.skill_name from student inner join student_skill on student.roll=student_skill.roll order by student.roll";
    	ps=con.prepareStatement(sql);
    	rs = ps.executeQuery();
    	if(rs.next()){
    		int i=0;	
    		do{
    			
    			String roll=rs.getString("roll");
    			String name=rs.getString("first_name");
    			String skill=rs.getString("skill_name");
    			String sem=rs.getString("sem");
    			String gen=rs.getString("sex");
    			String mobile=rs.getString("mobile");
    			String sk[]=skill.split(" ");
    			for(byte a=0;a<sk.length;a++)
    			{
    				
    				if(skil.equals(sk[a])){
    					i++;
    			%>
    			<tr>
    				<td><%= i %></td><td><%= roll %></td><td><%=  sem %></td><td><%= name %></td><td><%= Arrays.toString(skill.split(" ")) %></td><td><%= gen %></td><td><%= mobile %></td>
    			</tr>
    			<%
    				}
    			}
    		}while(rs.next());
    
    	}
    	 else{
    		
    		//rd=request.getRequestDispatcher("Com_skill_filter.jsp");
    		//rd.include(request, response);
    	
%>
<tr>
    				<td colspan="7" ><h3>NO Data Available For This Skill</h3></td>    			
    				</tr>
  <%  		
    	}
    	Dbcon.closeCon("Com_skill_show.jsp");
    	
    	%>
    	</table>
        </div>
   
     </div>


 </section>

  </body>
</html>