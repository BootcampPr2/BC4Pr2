<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%@ page import="pr2.loseweight.utils.*"%>
<%@ page import="java.util.List, java.util.ArrayList"%>
<%@ page import="pr2.loseweight.dbtables.*"%>
<%@ page import="java.sql.Timestamp"%>
<%
	User loggedUser = DBUserUtils.getUserByUsername(session.getAttribute("loggedUserUsername").toString());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>All users</title>
<meta charset="utf-8">
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" type="text/css" href="Style.css">
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>

<!-- <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<scrip src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script> -->
</head>
<body onClick="visibilityCheck('<%=loggedUser.getRole().getRoleName() %>')">
	<link rel='stylesheet prefetch' href='http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css'>
	<br>

	<div id="background">
		<img src="../Images/background.png" class="stretch" alt="" />
	</div>

	<div class="container text-left">
		<table>
			<tr>

				<td style="padding-bottom: 5px"><a href="control-panel_menu.jsp" class="btn btn-primary" role="button"><i class="glyphicon glyphicon-arrow-left"></i>&nbsp;Go back</a></td>
				<br>
			</tr>
			<tr>
				<td style="padding-right: 5px; display:block" id="onlyGod"><a href="#" class="btn btn-success" role="button"><i class="fa fa-graduation-cap"></i>&nbsp;Assign/Unassign an admin</a></td>
				<td style="padding-right: 5px"><a href="#" class="btn btn-warning" role="button"><i class="glyphicon glyphicon-ban-circle"></i>&nbsp;Ban/Unban user</a></td>
				<td><a href="#" class="btn btn-danger" role="button"><i class="fa fa-remove"></i>&nbsp;Delete user</a></td>
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
					<th scope="col">Banned</th>
				</tr>
			</thead>
			<tbody style="background: white">
				<% List<User> allUsers = (ArrayList) DBUserUtils.retrieveAllUsers();
			if (allUsers.size() != 0){	
			for (int i=0;i<allUsers.size();i++){
					%>
				<tr>
					<td scope="row"><input class="selectMessages" type="checkbox" name="SU" value="bar1"></td>
					<td><%=allUsers.get(i).getUsername() %></td>
					<td><%=allUsers.get(i).getRole().getRoleName() %></td>
					<% if (allUsers.get(i).getIsBanned() == 0){ %>
					<td>NO</td>
					<% }else { %>
					<td>YES</td>
				</tr>
				<%
					}
					}
			}
			%>
			</tbody>
		</table>

	</div>
	<script src='cp_menu_users.js'></script>
</body>
</html>