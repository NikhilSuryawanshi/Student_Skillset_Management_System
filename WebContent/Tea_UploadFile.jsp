<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*" %>


    <%
    RequestDispatcher rd;
   //allow access only if session exists

String usr = null;
if(session.getAttribute("usr") == null)
{
	rd=request.getRequestDispatcher("index.html");
	rd.include(request, response);
	out.println("\n <script>window.alert(\"Login First...!\")</script>");
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
<%
String contentType = request.getContentType();
// System.out.println("Content type is :: " + contentType);
String imageSave=null;
byte dataBytes[]=null;
String saveFile=null;
if ((contentType != null) && (contentType.indexOf("multipart/form-data") >= 0))
{
DataInputStream in = new DataInputStream(request.getInputStream());
int formDataLength = request.getContentLength();
dataBytes = new byte[formDataLength];
int byteRead = 0;
int totalBytesRead = 0;
while (totalBytesRead < formDataLength)
{
byteRead = in.read(dataBytes, totalBytesRead, formDataLength);
totalBytesRead += byteRead;
}
String file = new String(dataBytes);
/*saveFile = file.substring(file.indexOf("filename=\"") + 10);
saveFile = saveFile.substring(0, saveFile.indexOf("\n"));
saveFile = saveFile.substring(saveFile.lastIndexOf("\\") + 1, saveFile.indexOf("\"")); */
//System.out.println(saveFile);
saveFile=usr+".jpg";
// out.print(dataBytes);
int lastIndex = contentType.lastIndexOf("=");
String boundary = contentType.substring(lastIndex + 1, contentType.length());
// out.println(boundary);
int pos;
pos = file.indexOf("filename=\"");
pos = file.indexOf("\n", pos) + 1;
pos = file.indexOf("\n", pos) + 1;
pos = file.indexOf("\n", pos) + 1;
int boundaryLocation = file.indexOf(boundary, pos) - 4;
int startPos = ((file.substring(0, pos)).getBytes()).length;
int endPos = ((file.substring(0, boundaryLocation)).getBytes()).length;
try
{
FileOutputStream fileOut = new FileOutputStream(getServletContext().getRealPath("")+"USR\\"+saveFile);
// fileOut.write(dataBytes);
fileOut.write(dataBytes, startPos, (endPos - startPos));
fileOut.flush();
fileOut.close();
imageSave="Success";
}catch (Exception e)
{
System.err.println ("Error writing to file");
imageSave="Failure";
}
}
%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title>SSSM | Admin - Student-List</title>
    <link rel="stylesheet" href="style/style.css">
    <link rel="stylesheet" href="fontawesome/css/all.css">
    <META name="GENERATOR" content="IBM WebSphere Studio">
	<TITLE>File Upload Success/Failure</TITLE>
 
 <style>
     .header_content
    {
        text-transform: uppercase;
        position: relative;
        color: rgba(255,255,255,0.8);
        font-family: cursive ;
        position: relative;
    top: 45%;
    left: 50%;
    transform: translate(-50%,-50%);
    width: 500px;
    height: auto;
    box-sizing: border-box;
    background: rgba(0,0,0,0.8);
  padding: 25px 0px 20px 60px ;
        
    }
       
 table{

     color: rgb(176, 173, 173);
     margin-bottom: 10px;
     margin-left: 69px;
 }
 td{

        padding-bottom: 8px;  
        text-align: left;
        padding-left: 9px;
 }
 th
 {
  text-align: left;

 }

  </style>
  
 
<body>
    <input type="checkbox" id="check">
    <label for="check">
      <i class="fas fa-bars" id="btn"></i>
      <i class="fas fa-times" id="cancel"></i>
    </label>
    <div class="sidebar">
    <header>Faculty Home</header>
  <ul>
    <li><a href="Tea_home.jsp"><i class="fas fa-home"></i> Home</a></li>
    <li><a href="Tea_update_pro.jsp"><i class="fas fa-pen-alt"></i>Edit Profile</a></li>
    <li><a href="Tea_std_search_service.jsp"><i class="fas fa-users-cog"></i>Student Panel</a></li>
    <li><a href="Tea_add_project.jsp"><i class="fas fa-drafting-compass"></i>  Project Panel</a></li>
    <li><a href="Tea_update_pass.jsp"><i class="fas fa-lock"></i>Reset Password</a></li>
    <li><a href="Slogout"><i class="fas fa-power-off"></i>  Log Out</a></li>
  </ul>
</div>
 <section>


    <div class="header_content">
    
    <table align="center" width="300" height="100" style="color:#fff;">
<tbody>
<tr>
<th width="85">Image Name:</th>
<td width="60"><%=saveFile%></td>
</tr>
<tr>
<th width="85">No Of Bytes:</th>
<td width="60"><%=dataBytes.length%></td>
</tr>
<tr>
<th width="85">Image Save:</th>
<td width="60"><%=imageSave%></td>
</tr>
</tbody>
</table>
    
    </div>
</section>
</body>
</html> 