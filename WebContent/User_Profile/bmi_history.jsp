<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%@ page import="pr2.loseweight.utils.*"%>
<%@ page import="java.util.List, java.util.ArrayList"%>
<%@ page import="pr2.loseweight.dbtables.*"%>
<%@ page import="java.sql.Timestamp"%>
<%@ page import="org.hibernate.SessionFactory"%>
<%@ page import="java.sql.Timestamp, java.text.SimpleDateFormat"%>
<%
	HttpSession httpSession = request.getSession();
	User loggedUser = DBUserUtils.getUserByUsername((SessionFactory) httpSession.getAttribute("sessionFactory"),
			httpSession.getAttribute("loggedUserUsername").toString());
	Bmi bmi = DBUserUtils.getUserBmiByUsername((SessionFactory) httpSession.getAttribute("sessionFactory"),
			httpSession.getAttribute("loggedUserUsername").toString());

	if (request.getParameter("checked") != null) {
		String[] checkedIds = request.getParameterValues("checked");
		DeleteFromDB.deleteSelectedBmis((SessionFactory) httpSession.getAttribute("sessionFactory"),
				checkedIds);
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

<script src='user_profile.js'></script>
</head>
<body>
	<link rel='stylesheet prefetch' href='http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css'>
	<br>

	<div id="background">
		<img src="../Images/background.png" class="stretch" alt="" />
	</div>

	<!-- ............................NAVBAR MENU............................  -->
	<nav class="navbar navbar-default navbar-fixed-top">
	<div class="container-fluid">
		<div class="navbar-header">
			<a class="navbar-brand" href="#"><span style="font-weight: bold"><%=loggedUser.getUsername()%></span></a>
		</div>
		<ul class="nav navbar-nav">
			<li><a href="user_main.jsp">MY PROFILE</a></li>
			<li><a href="user_update.jsp">UPDATE PROFILE INFORMATION</a></li>
			<li class="active"><a href="bmi_history.jsp">VIEW HISTORY</a></li>
			<li><a href="../Mailbox/mail.jsp">MAILBOX</a></li>
			<%
				if (loggedUser.getRole().getRoleID() == 1 || loggedUser.getRole().getRoleID() == 2) {
			%>
			<li><a href="../GodMenu/control-panel_menu.jsp">CONTROL PANEL</a></li>
			<%
				}
			%>

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
				<button type=submit class="btn btn-danger">
					<i class="fa fa-trash-o"></i> Delete
				</button>
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
				<thead class="thead-dark" style="background: #F5F5F5; color: black">
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
						List<Bmi> bmiList = (ArrayList) DBUserUtils.bmiHistory((SessionFactory)httpSession.getAttribute("sessionFactory"), loggedUser);
						if (bmiList.size() != 0) {
							SimpleDateFormat myFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
							String date;
							for (int i = 0; i < bmiList.size(); i++) {
					%>
					<tr>
						<%
							if (i != 0) {
						%>
						<td scope="row"><input type="checkbox" class="tickbox" name="checked" value="<%=bmiList.get(i).getBmiID()%>"></td>
						<%
							} else {
						%>
						<td scope="row"></td>
						<%
							}
						%>
						<%
							date = myFormat.format(bmiList.get(i).getDateTimePosted());
						%>
						<td><%=date%></td>
						<td><%=bmiList.get(i).getWeight()%></td>
						<td><%=bmiList.get(i).getHeight()%></td>
						<td><%=bmiList.get(i).getAge()%></td>

						<%
							if (bmiList.get(i).getGender().equals("F")) {
						%>
						<td><img src="../Images/female.jpg" height="25px"></td>
						<%
							} else {
						%>
						<td><img src="../Images/male.png" height="25px"></td>
						<%
							}
						%>
						<td><%=bmiList.get(i).getBmi()%></td>
						<td><%=bmiList.get(i).getClassification()%></td>
						<td><%=bmiList.get(i).getBmr()%></td>
						<td><%=bmiList.get(i).getMetarate().getDescription()%></td>
						<td><%=bmiList.get(i).getEmr()%></td>
					</tr>
					<%
						}
						}
					%>
				</tbody>
			</table>

		</div>
</body>
</html>