<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<form action="tea_create_grp.jsp" method="post">
<select name="sem" required="required" >
<option disabled="disabled" selected="selected" >semester</option>
<option value="1">I semester</option>
<option value="2">II semester</option>
<option value="3">III semester</option>
<option value="4">IV semester</option>
<option value="5">V semester</option>
<option value="6">VI semester</option>
<option value="7">VII semester</option>
<option value="8">VIII semester</option>
</select>
<input type="text" name="number" required="required" pattern="[3-10]{1}" title="Max 10 or MIn 3 student to be selected" >
<button type="submit">Add</button>
</form>
</body>
</html>