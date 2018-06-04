<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%@ page import="pr2.loseweight.utils.*"%>
<%@ page import="java.util.List, java.util.ArrayList"%>
<%@ page import="pr2.loseweight.dbtables.*"%>
<%@ page import="java.sql.Timestamp"%>
<%@ page import="org.hibernate.SessionFactory"%>
<%@ page import="java.sql.Timestamp, java.text.SimpleDateFormat" %>

<%
HttpSession httpSession = request.getSession();
User loggedUser = DBUserUtils.getUserByUsername((SessionFactory)httpSession.getAttribute("sessionFactory"), httpSession.getAttribute("loggedUserUsername").toString());
Bmi bmi = DBUserUtils.getUserBmiByUsername((SessionFactory)httpSession.getAttribute("sessionFactory"), httpSession.getAttribute("loggedUserUsername").toString());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>User Profile</title>

<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" type="text/css" href="Style.css">

<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<script src='user_profile.js'></script>
</head>
<body>
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
			<li class="active"><a href="user_main.jsp">MY PROFILE</a></li>
			<li><a href="user_update.jsp">UPDATE PROFILE INFORMATION</a></li>
			<li><a href="bmi_history.jsp">VIEW HISTORY</a></li>
			<li><a href="../Mailbox/mail.jsp">MAILBOX</a></li>
			<% if (loggedUser.getRole().getRoleID() ==  1 || loggedUser.getRole().getRoleID() == 2){ %>
				<li><a href="../GodMenu/control-panel_menu.jsp">CONTROL PANEL</a></li> 
			<% } %>
		</ul>
		<ul class="nav navbar-nav navbar-right">
			<li><a href="../Login_Create/login-create-menu.jsp"><span class="glyphicon glyphicon-log-out"></span> Log out</a></li>
		</ul>
	</div>
	</nav>


<!-- ............................PROFILE INFORMATION............................  -->
	<div class="container">
		<div class="row">
			<div class="col-md-7 ">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h4>MY PROFILE</h4>
					</div>
					<div class="panel-body">
						<div class="box box-info">
							<div class="box-body">
								<div class="col-sm-6">
									<div id="userImg" align="center">
										<img alt="User Pic" src="<%=loggedUser.getProfilePicUrl()%>" class="img-rounded img-responsive" width="200">
									</div>
									<br>
									<!-- /input-group -->
								</div>
								<div class="col-sm-6">
								<% if (loggedUser.getRole().getRoleName().equals("STANDARD_USER")){
									String rolename = "STANDARD USER";%>
									<h4 style="color: #00b1b1;" id="role">Role: <%=rolename %></h4>
									<% } else { %>
									<h4 style="color: #00b1b1;" id="role">Role: <%=loggedUser.getRole().getRoleName() %></h4>
									<% } %>
									<%
									SimpleDateFormat myFormat = new SimpleDateFormat ("dd/MM/yyyy HH:mm");
									String date = myFormat.format(bmi.getDateTimePosted());%>
									<span><p>Last BMI update: <%=date %></p></span>
								</div>
								<div class="clearfix"></div>
								<hr style="margin: 5px 0 5px 0;">
								<div class="col-sm-5 col-xs-6 tital ">Weight:</div>
								<div class="col-sm-7"><%=bmi.getWeight() %> kg</div>
								<div class="clearfix"></div>
								<div class="bot-border"></div>
								<div class="col-sm-5 col-xs-6 tital ">Height:</div>
								<div class="col-sm-7"><%=bmi.getHeight() %> m</div>
								<div class="clearfix"></div>
								<div class="bot-border"></div>
								<div class="col-sm-5 col-xs-6 tital ">Age:</div>
								<div class="col-sm-7"><%=bmi.getAge() %> years old</div>
								<div class="clearfix"></div>
								<div class="bot-border"></div>
								<div class="col-sm-5 col-xs-6 tital ">Gender:</div>
								<% if (bmi.getGender().equals("F")){%>
									<div class="col-sm-7"><img src="../Images/female.jpg" height="25px"></div>
								<% }else { %>
								<div class="col-sm-7"><img src="../Images/male.png" height="25px"></div>
								<% } %>
								<div class="clearfix"></div>
								<div class="bot-border"></div>
								<div class="col-sm-5 col-xs-6 tital " title="Body mass index; ratio of height/weight">BMI:</div>
								<div class="col-sm-7"><%=bmi.getBmi() %></div>
								<div class="clearfix"></div>
								<div class="bot-border"></div>
								<div class="col-sm-5 col-xs-6 tital ">Classification:</div>
								<div class="col-sm-7">
								<input type="hidden" id="classification" value="<%=bmi.getClassification() %>" />
								<table style="text-align: center;">
								<tr>
									<td id="underweight">Underweight&nbsp;</td>
									<td id="optimal">&nbsp;Optimal&nbsp;</td>
									<td id="overweight">&nbsp;Overweight&nbsp;</td>
									<td id="obese">&nbsp;Obese</td>
								</tr>
								</table>
								</div>
								<div class="clearfix"></div>
								<div class="bot-border"></div>
								<div class="col-sm-5 col-xs-6 tital " title="Basal metabolic rate; rate of energy used at rest">BMR:</div>
								<div class="col-sm-7"><%=bmi.getBmr() %> calories</div>
								<div class="clearfix"></div>
								<div class="bot-border"></div>
								<div class="col-sm-5 col-xs-6 tital ">Activity level:</div>
								<div class="col-sm-7"><%=bmi.getMetarate().getDescription() %></div>
								<div class="clearfix"></div>
								<div class="bot-border"></div>
								<div class="col-sm-5 col-xs-6 tital " title="Exercise metabolic rate">EMR:</div>
								<div class="col-sm-7"><%=bmi.getEmr() %> calories</div>
								<div class="clearfix"></div>
								<div class="bot-border"></div>
								
								<!-- /.box-body -->
							</div>
							<!-- /.box -->
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>