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
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="Style.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Control Panel</title>
</head>
<body>

	<!-- ............................NAVBAR MENU............................  -->
	<nav class="navbar navbar-default navbar-fixed-top">
	<div class="container-fluid">
		<div class="navbar-header">
			<a class="navbar-brand" href="#"><span style="font-weight: bold"><%=loggedUser.getUsername()%></span></a>
		</div>
		<ul class="nav navbar-nav">
			<li><a href="../User_Profile/user_main.jsp">MY PROFILE</a></li>
			<li><a href="../User_Profile/user_update.jsp">UPDATE PROFILE INFORMATION</a></li>
			<li><a href="../User_Profile/bmi_history.jsp">VIEW HISTORY</a></li>
			<li><a href="../Mailbox/mail.jsp">MAILBOX</a></li>
			<li class="active"><a href="../GodMenu/control-panel_menu.jsp">CONTROL PANEL</a></li>

		</ul>
		<ul class="nav navbar-nav navbar-right">
			<li><a href="../Login_Create/login-create-menu.jsp"><span class="glyphicon glyphicon-log-out"></span> Log out</a></li>
		</ul>
	</div>
	</nav>
	
	
	<!-- ............................CONTROL PANEL MENU............................  -->
	<div id="background">
		<img src="../Images/background.png" class="stretch" alt="" />
	</div>
	<link rel='stylesheet prefetch' href='http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css'>
	<div class="container text-left">
		<div id="welcome_tag" style="background: #4B4446;color: white">
			<h3>
				WELCOME TO THE CONTROL PANEL MENU
				<h3>
					<h4 style="margin-top: -10px">
						This is a page regarding all users and the modifications you make to them. Have fun!
						<h4>
		</div>
		<div id="control-panel_menu">
			<h4>Users</h4>
			<% if (loggedUser.getRole().getRoleID() == 1) {%>
				<a href="control-panel_godMenu_users.jsp" class="btn btn-info" role="button"><i class="fa fa-group"></i> View All</a>
			<%}else { %>
				<a href="control-panel_adminMenu_users.jsp" class="btn btn-info" role="button"><i class="fa fa-group"></i> View All</a>
			<%} %>
			<h4>Messages</h4>
			<a href="control-panel_menu_messages.jsp" class="btn btn-info" role="button"><i class="fa fa-comments"></i> View All</a>
		</div>
	</div>
</body>
</html>