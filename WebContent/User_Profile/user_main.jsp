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
<body onload="visibility('<%=loggedUser.getRole().getRoleName() %>')">
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
			<li class="active"><a href="user_main.jsp">MY PROFILE</a></li>
			<li><a href="user_update.jsp">UPDATE PROFILE INFORMATION</a></li>
			<li><a href="bmi_history.jsp">VIEW HISTORY</a></li>
			<li><a href="../Mailbox/mail.jsp">MAILBOX</a></li>
			<li id="godAdmin" style="display:block;"><a href="../GodMenu/control-panel_menu.jsp">CONTROL PANEL</a></li>

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
						<h4>BMI Profile for <%=loggedUser.getUsername() %></h4>
					</div>
					<div class="panel-body">
						<div class="box box-info">
							<div class="box-body">
								<div class="col-sm-6">
									<div id="userImg" align="center">
										<img alt="User Pic" src="https://i2.wp.com/beebom.com/wp-content/uploads/2016/01/Reverse-Image-Search-Engines-Apps-And-Its-Uses-2016.jpg?resize=640%2C426" class="img-rounded img-responsive">
										<input id="profile-image-upload" class="hidden" type="file">
										<div style="color: #999;"></div>
										<!--Upload Image Js And Css-->


									</div>
									<br>
									<!-- /input-group -->
								</div>
								<div class="col-sm-6">
									<h4 style="color: #00b1b1;" id="role"><%=loggedUser.getRole().getRoleName() %></h4>
									</span> <span><p><%=bmi.getDateTimePosted() %></p></span>
								</div>
								<div class="clearfix"></div>
								<hr style="margin: 5px 0 5px 0;">
								<div class="col-sm-5 col-xs-6 tital ">Weight:</div>
								<div class="col-sm-7"><%=bmi.getWeight() %></div>
								<div class="clearfix"></div>
								<div class="bot-border"></div>
								<div class="col-sm-5 col-xs-6 tital ">Height:</div>
								<div class="col-sm-7"><%=bmi.getHeight() %></div>
								<div class="clearfix"></div>
								<div class="bot-border"></div>
								<div class="col-sm-5 col-xs-6 tital ">Age:</div>
								<div class="col-sm-7"><%=bmi.getAge() %></div>
								<div class="clearfix"></div>
								<div class="bot-border"></div>
								<div class="col-sm-5 col-xs-6 tital ">Gender:</div>
								<div class="col-sm-7"><%=bmi.getGender() %></div>
								<div class="clearfix"></div>
								<div class="bot-border"></div>
								<div class="col-sm-5 col-xs-6 tital ">BMI:</div>
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
								<div class="col-sm-5 col-xs-6 tital ">BMR:</div>
								<div class="col-sm-7"><%=bmi.getBmr() %></div>
								<div class="clearfix"></div>
								<div class="bot-border"></div>
								<div class="col-sm-5 col-xs-6 tital ">Activity level:</div>
								<div class="col-sm-7"><%=bmi.getMetarate().getDescription() %></div>
								<div class="clearfix"></div>
								<div class="bot-border"></div>
								<div class="col-sm-5 col-xs-6 tital ">EMR:</div>
								<div class="col-sm-7"><%=bmi.getEmr() %></div>
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