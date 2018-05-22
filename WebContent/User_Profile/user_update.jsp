<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%@ page import="pr2.loseweight.utils.*"%>
<%@ page import="java.util.List, java.util.ArrayList"%>
<%@ page import="pr2.loseweight.dbtables.*"%>
<%@ page import="java.sql.Timestamp"%>

<%
	session.setAttribute("loggedUserUsername", "user1");
	User loggedUser = DBUserUtils.getUserByUsername(session.getAttribute("loggedUserUsername").toString());
	int role = loggedUser.getRole().getRoleID();
	session.setAttribute("roleID", role);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link href="Style.css" rel="stylesheet" id="custom-css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<title>Profile Update</title>
</head>
<body>
	<div id="background">
		<img src="..//Images/background.png" class="stretch" alt="" />
	</div>

	<!-- ............................NAVBAR MENU............................  -->
	<nav class="navbar navbar-default navbar-static-top">
	<div class="container-fluid">
		<div class="navbar-header">
			<a class="navbar-brand" href="#"><%=loggedUser.getUsername()%></a>
		</div>
		<ul class="nav navbar-nav">
			<li><a href="user_main.jsp">MY PROFILE</a></li>
			<li class="active"><a href="user_update.jsp">UPDATE PROFILE INFORMATION</a></li>
			<li><a href="#viewHistory">VIEW HISTORY</a></li>
			<li><a href="../Mailbox/mail.jsp">MAILBOX</a></li>
			<li id="god-admin" style="visibility: visible"><a href="../GodMenu/control-panel_menu.jsp">CONTROL PANEL</a></li>

		</ul>
		<ul class="nav navbar-nav navbar-right">
			<li><a href="login-create-menu.jsp"><span class="glyphicon glyphicon-log-out"></span> Log out</a></li>
		</ul>
	</div>
	</nav>

	<!-- ............................PROFILE UPDATE............................  -->
	<div class="container">
		<div class="row">
			<div class="col-md-5 ">
				<div class="well">
					<ul class="nav nav-tabs">
						<li class="active"><a href="#profile" data-toggle="tab">Profile</a></li>
						<li><a href="#password" data-toggle="tab">Password</a></li>
					</ul>
					<div id="myTabContent" class="tab-content">
						<div class="tab-pane fade in active" id="profile">
							<form id="tab">
								<table class="table">
									<tbody>
										<tr>
											<td><label for="weight">Weight:</label></td>
											<td><input id="weight" type="text" value="65" class="form-control"></td>
										</tr>
										<tr>
											<td><label for="height">Height:</label></td>
											<td><input id="height" type="text" value="1.63" class="form-control"></td>
										</tr>
										<tr>
											<td><label for="age">Age:</label></td>
											<td><input id="age" type="text" value="32" class="form-control"></td>
										</tr>
										<tr>
											<td><label for="gender">Gender:</label></td>
											<td><input id="gender" type="text" value="female" class="form-control"></td>
										</tr>
										<tr>
											<td><label for="exercise">Activity level:</label></td>
											<td><input id="exercise" type="text" value="Intense" class="form-control"></td>
										</tr>
									</tbody>
								</table>
								<div>
									<input type="submit" class="btn btn-primary mb-2" value="Update">
								</div>
							</form>
						</div>


						<div class="tab-pane fade" id="password">
							<form id="tab2">
								<div class="form-group">
									<label for="password">New Password:</label>
									<input type="password" value="jsmith" class="form-control">
								</div>
								<div>
									<input type="submit" class="btn btn-primary mb-2" value="Update">
								</div>
							</form>
						</div>
					</div>
				</div>
				<!-- end of class well -->
			</div>
			<!-- end of class col-md-5 -->
		</div>
		<!-- end of class row -->
	</div>
	<!-- end of class container -->
</body>
</html>