<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%@ page import="pr2.loseweight.utils.*"%>
<%@ page import="java.util.List, java.util.ArrayList"%>
<%@ page import="pr2.loseweight.dbtables.*"%>
<%@ page import="java.sql.Timestamp"%>
<%@ page import="org.hibernate.SessionFactory"%>
<%
	HttpSession httpSession = request.getSession();
	User loggedUser = DBUserUtils.getUserByUsername((SessionFactory)httpSession.getAttribute("sessionFactory"), httpSession.getAttribute("loggedUserUsername").toString());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>All users</title>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" type="text/css" href="Style.css">
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<link rel='stylesheet prefetch' href='http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css'>
<script src='cp_menu_users.js'></script>
</head>
<body>
	
	<br>

	<div id="background">
		<img src="../Images/background.png" class="stretch" alt="" />
	</div>
	<form action="modifyuser" method="post">
	<div class="container text-left">
		<table>
			<tr>
				<td style="padding-bottom: 5px"><a href="control-panel_menu.jsp" class="btn btn-primary"><i class="glyphicon glyphicon-arrow-left"></i>&nbsp;Go back</a></td>
			</tr>
			<tr>
				<td style="padding-right: 5px"><button type="submit" name="assign" class="btn btn-success"><i class="fa fa-graduation-cap"></i>&nbsp;Assign/Unassign an admin</button></td>
				<td style="padding-right: 5px"><button type="submit" name="ban" class="btn btn-warning"><i class="glyphicon glyphicon-ban-circle"></i>&nbsp;Ban/Unban user</button></td>
				<td><button type="submit" name="delete" class="btn btn-danger"><i class="fa fa-remove"></i>&nbsp;Delete user</button></td>
			</tr>
		</table>
	</div>
	<br>

	<div class="container text-left">

		<div class="mail-option">
			<div class="chk-all">
				<input type="checkbox" id="checkAll" class="mail-checkbox mail-group-checkbox">
				<div class="btn-group">
					<a href="#" class="btn mini all">&nbsp;Select All</a>
				</div>
			</div>
		</div>
		<br>
		<table class="table">
			<thead class="thead-dark" style="background: #4B4446; color: white">
				<tr>
					<th scope="col">&nbsp;</th>
					<th scope="col">Username</th>
					<th scope="col">Role</th>
					<th scope="col">Gender</th>
					<th scope="col">Age</th>
				</tr>
			</thead>
			<tbody style="background: white">
				<% List<User> allUsers = (ArrayList) DBUserUtils.retrieveAllUsers((SessionFactory)httpSession.getAttribute("sessionFactory"));
			if (allUsers.size() != 0){
				Bmi bmi;
				for (int i=0;i<allUsers.size();i++){
				bmi = DBUserUtils.getUserBmiByUsername((SessionFactory)httpSession.getAttribute("sessionFactory"),allUsers.get(i).getUsername());
					%>
				<tr>
					<% if (i !=0) { %>
					<td scope="row"><input class="selectMessages" type="checkbox" name="SU" value="<%=allUsers.get(i).getUserID()%>"></td>
					<% }else { %>
					<td><img src="../Images/god.png" width="20" /></td>
					<% } %>
					<% if (allUsers.get(i).getIsBanned() == 1){ %>
					<td><%=allUsers.get(i).getUsername() %> <span style="color: red; font-weight: bold">(banned)</span></td>
					<% }else {%>
					<td><%=allUsers.get(i).getUsername() %></td>
					<% } 
					%>
					<td><%=allUsers.get(i).getRole().getRoleName() %></td>
					<td><%=bmi.getGender() %></td>
					<td><%=bmi.getAge() %></td>
				</tr>
				<%}
			}%>
			</tbody>
		</table>

	</div>
	</form>
</body>
</html>