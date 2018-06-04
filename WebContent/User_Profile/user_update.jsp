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
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link href="Style.css" rel="stylesheet" id="custom-css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>Profile Update</title>
<script src='user_profile.js'></script>

<!-- ...............UPDATE PASSWORD............... -->
<%
	if (request.getParameter("password0") != null) {
		String password = request.getParameter("password0");
		String pattern = "(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=\\S+$).{8,}";
		if (password.matches(pattern)) {
			boolean updatedSuccessfully = DBUserUtils.updatePassword((SessionFactory)httpSession.getAttribute("sessionFactory"), loggedUser, request.getParameter("password0"));
			if (updatedSuccessfully){%>
				<script> alert ("Updated successfully") </script>
			<%}else { %>
				<script> alert ("Something went wrong. Try again!") </script>
			<%}
		}else {
			%>
			<script> alert ("Password is not fulfilling the requirements.") </script>
		<%
		}
	} %>
	<% if ((Boolean)request.getAttribute("picUploaded") != null ) {
		if ((Boolean)request.getAttribute("picUploaded") == true) {
		%>
		<script> alert ("Picture was uploaded successfully.") </script>
	<% 
		}else{
	%>
		<script> alert ("Picture wasn't uploaded.") </script>
	<% 	
		}
		} 
	%>
<%
if (request.getParameter("weight") == null 
&& request.getParameter("height") == null 
&& request.getParameter("age") == null 
&& request.getParameter("RG") == null 
&& request.getParameter("RE") == null) {
}else if (request.getParameter("weight") == "" 
		&& request.getParameter("height") == "" 
		&& request.getParameter("age") == "" 
		&& request.getParameter("RG") == null 
		&& request.getParameter("RE") == null) {
	%> <script> alert ("No change occured. At least one field should be updated.") </script> <%
}else {
	bmi = DBUserUtils.getUserBmiByUsername((SessionFactory)httpSession.getAttribute("sessionFactory"), httpSession.getAttribute("loggedUserUsername").toString());
	double weight = bmi.getWeight();
	double height = bmi.getHeight();
	int age = bmi.getAge();
	String gender = bmi.getGender();
	int exerciseID = bmi.getMetarate().getMetaID();
	if (request.getParameter("weight") != "") {
		weight = Double.parseDouble(request.getParameter("weight"));
	}
	if (request.getParameter("height") != "") {
		height = Double.parseDouble(request.getParameter("height"));
	}
	if (request.getParameter("age") != "") {
		age = Integer.parseInt(request.getParameter("age"));
	}
	if (request.getParameter("RG") != null) {
		gender = request.getParameter("RG");
	}
	if (request.getParameter("RE") != null) {
		exerciseID = Integer.parseInt(request.getParameter("RE"));
	}
	boolean updateSuccessful = DBUserUtils.updateUser((SessionFactory)httpSession.getAttribute("sessionFactory"), loggedUser, weight, height, age, gender, exerciseID);
	if (updateSuccessful) {%>
		<script> alert ("Updated successfully") </script>
	<%}else { %>
		<script> alert ("Something went wrong. Try again!") </script>
	<%}
}
%>
</head>
<body>
	<div id="background">
		<img src="..//Images/background.png" class="stretch" alt="" />
	</div>

	<!-- ............................NAVBAR MENU............................  -->
	<nav class="navbar navbar-default navbar-fixed-top">
	<div class="container-fluid">
		<div class="navbar-header">
			<a class="navbar-brand" href="#"><span style="font-weight: bold"><%=loggedUser.getUsername()%></span></a>
		</div>
		<ul class="nav navbar-nav">
			<li><a href="user_main.jsp">MY PROFILE</a></li>
			<li class="active"><a href="user_update.jsp">UPDATE PROFILE INFORMATION</a></li>
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

	<!-- ............................PROFILE UPDATE............................  -->
	<div class="container">
		<div class="row">
			<div class="col-md-5 ">
				<div class="well">
					<ul class="nav nav-tabs">
						<li class="active"><a href="#profile" data-toggle="tab">Profile</a></li>
						<li><a href="#password" data-toggle="tab">Password</a></li>
						<li><a href="#profilepic" data-toggle="tab">Picture</a></li>
					</ul>
					<div id="myTabContent" class="tab-content">
						<div class="tab-pane fade in active" id="profile">
							<form id="tab">
								<table class="table">
									<tbody>
											<td><label for="weight">Weight:</label></td>
											<td><input type="number" step="0.1" min="20" max="600" name="weight" id="weight" tabindex="1" class="form-control" placeholder="Weight in kg"></td>
										</tr>
										<tr>
											<td><label for="height">Height:</label></td>
											<td><input type="number" step="0.01" min="0.50" max="2.50" name="height" id="height" tabindex="2" class="form-control" placeholder="Height in meters"></td>
										</tr>
										<tr>
											<td><label for="age">Age:</label></td>
											<td><input type="number" step="1" min="10" max="80" name="age" id="age" tabindex="3" class="form-control" placeholder="Age in years"></td>
										</tr>
										<tr>
											<td><label for="gender">Gender:</label></td>
											<td><select class="form-control" name="RG" tabindex="4">
													<option value="" disabled selected hidden>Gender</option>
													<option value="M">Male</option>
													<option value="F">Female</option>
											</select></td>
										</tr>
										<tr>
											<td><label for="exercise">Activity level:</label></td>
											<td><select class="form-control" tabindex="5" name="RE">
													<option value="" disabled selected hidden>Activity level</option>
													<option value="1">Sedentary (Little or no exercise)</option>
													<option value="2">Lightly active (light exercise or sports 1-3 days per week)</option>
													<option value="3">Moderately active (moderate exercise or sports 3-5 days per week)</option>
													<option value="4">Very active (hard exercise or sports 6-7 days per week)</option>
													<option value="5">Extremely active (very hard exercise or sports and a physical job or 2x training)</option>
											</select></td>
										</tr>
									</tbody>
								</table>
								<div>
									<input type="submit" class="btn btn-primary mb-2" tabindex="6" value="Update">
								</div>
							</form>
						</div>


						<div class="tab-pane fade" id="password">
							<form id="tab2" action="user_update.jsp" method="post">
								<div class="form-group">
									<label for="password">New Password:</label>
									<input type="password" name="password0" id="password0" tabindex="2" class="form-control" placeholder="Password" required>
								</div>
								<div class="row">
									<div class="col-md-4">
										<div class="aro-pswd_info">
											<div id="pswd_info">
												<h5>Password should contain:</h5>
												<ul>
													<li id="letter" class="invalid">At least <strong>one lowercase letter</strong></li>
													<li id="capital" class="invalid">At least <strong>one capital letter</strong></li>
													<li id="number" class="invalid">At least <strong>one number</strong></li>
													<li id="length" class="invalid">Be at least <strong>8 characters</strong></li>
												</ul>
											</div>
										</div>
									</div>
								</div>
								<div>
									<input type="submit" class="btn btn-primary mb-2" value="Update">
								</div>
							</form>
						</div>
						
						<div class="tab-pane fade" id="profilepic">
							<div class="currentProfilePic">
								<img src="<%=loggedUser.getProfilePicUrl()%>" width="200">
							</div>
							<form method="post" action="uploadpic" enctype="multipart/form-data">
								Select file to upload:
								<input type="file" name="dataFile" id="fileChooser" accept="image/*" /><br/><br/>
								<input type="submit" value="Upload" /> <span style="color:red">Max file size: 2mb</span>
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