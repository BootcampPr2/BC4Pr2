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
	Bmi bmi = DBUserUtils.getUserBmiByUsername(session.getAttribute("loggedUserUsername").toString());
	
	if (request.getParameter("checked") != null) {
		String[] checkedIds = request.getParameterValues("checked");
		DeleteFromDB.deleteSelectedBmis(checkedIds);
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Bmi history</title>

<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" type="text/css" href="Style.css">

<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>

<!-- <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<scrip src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script> -->

<script src='user_profile.js'></script>
</head>
<body onload="visibility('<%=loggedUser.getRole().getRoleName() %>')">
	<link rel='stylesheet prefetch' href='http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css'>
	<br>

	<div id="background">
		<img src="../Images/background.png" class="stretch" alt="" />
	</div>

	<!-- ............................NAVBAR MENU............................  -->
	<nav class="navbar navbar-default navbar-static-top">
	<div class="container-fluid">
		<div class="navbar-header">
			<a class="navbar-brand" href="#"><%=loggedUser.getUsername()%></a>
		</div>
		<ul class="nav navbar-nav">
			<li><a href="user_main.jsp">MY PROFILE</a></li>
			<li><a href="user_update.jsp">UPDATE PROFILE INFORMATION</a></li>
			<li class="active"><a href="bmi_history.jsp">VIEW HISTORY</a></li>
			<li><a href="../Mailbox/mail.jsp">MAILBOX</a></li>
			<li id="godAdmin" style="display: block;"><a href="../GodMenu/control-panel_menu.jsp">CONTROL PANEL</a></li>

		</ul>
		<ul class="nav navbar-nav navbar-right">
			<li><a href="../Login_Create/login-create-menu.jsp"><span class="glyphicon glyphicon-log-out"></span> Log out</a></li>
		</ul>
	</div>
	</nav>


	<!-- ............................BMI HISTORY............................  -->
	<form action="bmi_history.jsp" method="post" id="modifyView">
		<div class="container text-left">
			<div>
				<button type=submit class="btn btn-danger"><i class="fa fa-trash-o"></i> Delete</button>
			</div>
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
						<th scope="col">Date</th>
						<th scope="col">Weight</th>
						<th scope="col">Height</th>
						<th scope="col">Age</th>
						<th scope="col">Gender</th>
						<th scope="col">BMI</th>
						<th scope="col">Classification</th>
						<th scope="col">BMR</th>
						<th scope="col">Activity Level</th>
						<th scope="col">EMR</th>
					</tr>
				</thead>
				<tbody style="background: white">
				<%
					List<Bmi> bmiList = (ArrayList) DBUserUtils.bmiHistory(loggedUser);
				if (bmiList.size() != 0) {
					for (int i=0;i<bmiList.size();i++){
						%> 
					<tr>
						<td scope="row"><input type="checkbox" class="tickbox" name="checked" value="<%=bmiList.get(i).getBmiID() %>"></td>
						<td><%=bmiList.get(i).getDateTimePosted() %></td>
						<td><%=bmiList.get(i).getBmi() %></td>
						<td><%=bmiList.get(i).getHeight() %></td>
						<td><%=bmiList.get(i).getAge() %></td>
						<td><%=bmiList.get(i).getGender() %></td>
						<td><%=bmiList.get(i).getBmi() %></td>
						<td><%=bmiList.get(i).getClassification() %></td>
						<td><%=bmiList.get(i).getBmr() %></td>
						<td><%=bmiList.get(i).getMetarate().getDescription() %></td>
						<td><%=bmiList.get(i).getEmr() %></td>
					</tr>
					<%
					}
				}
				%>
				</tbody>
			</table>

		</div>
		<script src='user_profile.js'></script>
</body>
</html>