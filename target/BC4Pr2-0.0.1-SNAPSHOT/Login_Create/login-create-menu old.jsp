<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%@ page import="pr2.loseweight.utils.*"%>
<%@ page import="pr2.loseweight.dbtables.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="Style.css" rel="stylesheet" type="text/css">
<title>Home</title>

<%-- <%
String username = request.getParameter("username0");
String password = request.getParameter("password0");
double weight = Double.parseDouble(request.getParameter("weight"));
double height = Double.parseDouble(request.getParameter("height"));
int age = Integer.parseInt(request.getParameter("age"));
String gender = request.getParameter("RG");
int exercise = Integer.parseInt(request.getParameter("RE"));
	if (username!=null && password!=null && weight!=0 && height!=0 && age!=0 && gender!= null && exercise!=0) {
		DBUserUtils.registerUser (username, password, weight, height, age, gender, exercise);
	}
%> --%>
</head>
<body>
	<div id="background">
		<img src="background.png" class="stretch" alt="" />
	</div>
	<div class="container">
		<div class="row">
			<div class="col-md-6 col-md-offset-3">
				<div class="panel panel-login">
					<div class="panel-heading">
						<div class="row">
							<div class="col-xs-6">
								<a href="#" class="active" id="login-form-link">Login</a>
							</div>
							<div class="col-xs-6">
								<a href="#" id="register-form-link">Register</a>
							</div>
						</div>
						<hr>
					</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-lg-12">
								<form id="login-form" action="logincheck.jsp" method="post" role="form" style="display: block;">
									<div class="form-group">
										<input type="text" name="username" id="username" tabindex="1" class="form-control" placeholder="Username" value="">
									</div>
									<div class="form-group">
										<input type="password" name="password" id="password" tabindex="2" class="form-control" placeholder="Password">
									</div>

									<div class="form-group">
										<div class="row">
											<div class="col-sm-6 col-sm-offset-3">
												<input type="submit" name="login-submit" id="login-submit" tabindex="4" class="form-control btn btn-login" value="Log In">
											</div>
										</div>
									</div>
								</form>
								
								
								<form id="register-form" action="login-create-menu.jsp" method="get" role="form" style="display: none;">
									<div class="form-group">
										<input type="text" name="username0" id="username0" tabindex="1" class="form-control" placeholder="Username" value="">
									</div>
									<div class="form-group">
										<input type="password" name="password0" id="password0" tabindex="2" class="form-control" placeholder="Password">
									</div>
									<div class="row">
										<div class="col-md-4">
											<div class="aro-pswd_info">
												<div id="pswd_info">
													<h4>Password should contain:</h4>
													<ul>
														<li id="letter" class="invalid">At least <strong>one letter</strong></li>
														<li id="capital" class="invalid">At least <strong>one capital letter</strong></li>
														<li id="number" class="invalid">At least <strong>one number</strong></li>
														<li id="length" class="invalid">Be at least <strong>8 characters</strong></li>
														<li id="space" class="invalid">be<strong> use [~!@#$%^&*-=.;']</strong></li>
													</ul>
												</div>
											</div>
										</div>
									</div>
									<div class="form-group">
										<input type="number" step="0.1" min="20" max="600" name="weight" id="weight" tabindex="2" class="form-control" placeholder="Weight in kg">
									</div>
									<div class="form-group">
										<input type="number" step="0.01" min="0.50" max="2.50" name="height" id="height" tabindex="2" class="form-control" placeholder="Height in meters">
									</div>
									<div class="form-group">
										<input type="number" step="1" min="10" max="80" name="age" id="age" tabindex="2" class="form-control" placeholder="Age in years">
									</div>
									<div class="form-group">
										Gender:
										<input type="radio" name="RG" id="M" value="male">
										Male
										<input type="radio" name="RG" id="F" value="female">
										Female
									</div>
									<div class="form-group">
										Exercise:<br>
										<input type="radio" name="RE" id="1" value="Sedentary">
										Sedentary<br>
										<input type="radio" name="RE" id="2" value="Lightly">
										Lightly active<br>
										<input type="radio" name="RE" id="3" value="Moderately">
										Moderately active<br>
										<input type="radio" name="RE" id="4" value="Very">
										Very active<br>
										<input type="radio" name="RE" id="5" value="Extremely">
										Extremely active<br>
									</div>
									<div class="form-group">
										<div class="row">
											<div class="col-sm-6 col-sm-offset-3">
												<input type="submit" name="register-submit" id="register-submit" tabindex="4" class="form-control btn btn-register" value="Create account">
											</div>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script src='login-create-menu.js'></script>
</body>
</html>