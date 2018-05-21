<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
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

<%
	if (request.getParameter("username0")!=null && request.getParameter("password0")!=null && Double.parseDouble(request.getParameter("weight"))!=0 && Double.parseDouble(request.getParameter("height"))!=0 && Integer.parseInt(request.getParameter("age"))!=0 && request.getParameter("RG")!= null && Integer.parseInt(request.getParameter("RE"))!=0) {
		String username = request.getParameter("username0");
		String password = request.getParameter("password0");
		double weight = Double.parseDouble(request.getParameter("weight"));
		double height = Double.parseDouble(request.getParameter("height"));
		int age = Integer.parseInt(request.getParameter("age"));
		String gender = request.getParameter("RG");
		int exercise = Integer.parseInt(request.getParameter("RE"));
		System.out.println (username);
		System.out.println (password);
		System.out.println (weight);
		System.out.println (height);
		System.out.println (age);
		System.out.println (gender);
		System.out.println (exercise);
		DBUserUtils.registerUser (username, password, weight, height, age, gender, exercise);
	}
%>
</head>
<body>
	<div id="background">
		<img src="..//Images/background.png" class="stretch" alt="" />
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
										<input type="text" name="username" id="username" tabindex="1" class="form-control" placeholder="Username" required>
									</div>
									<div class="form-group">
										<input type="password" name="password" id="password" tabindex="2" class="form-control" placeholder="Password" required>
									</div>

									<div class="form-group">
										<div class="row">
											<div class="col-sm-6 col-sm-offset-3">
												<input type="submit" name="login-submit" id="login-submit" tabindex="4" class="form-control btn btn-login" value="Log In">
											</div>
										</div>
									</div>
								</form>
								
	
								<form id="register-form" action="login-create-menu.jsp" method="post" role="form" style="display: none;">
									<div class="form-group">
										<input type="text" name="username0" id="username0" tabindex="1" class="form-control" placeholder="Username" required>
									</div>
									<div class="form-group">
										<input type="password" name="password0" id="password0" tabindex="2" class="form-control" placeholder="Password" required>
									</div>

									<div class="row">
										<div class="col-md-4">
											<div class="aro-pswd_info">
												<div id="pswd_info">
													<h5>Password should contain:</h5>
													<ul>
														<li id="letter" class="invalid">At least <strong>one letter</strong></li>
														<li id="capital" class="invalid">At least <strong>one capital letter</strong></li>
														<li id="number" class="invalid">At least <strong>one number</strong></li>
														<li id="length" class="invalid">Be at least <strong>8 characters</strong></li>
														<li id="space" class="invalid">At least one of <strong>[~!@#$%^&*-=.;']</strong></li>
													</ul>
												</div>
											</div>
										</div>
									</div>

									<div class="form-group">
										<input type="number" step="0.1" min="20" max="600" name="weight" id="weight" tabindex="2" class="form-control" placeholder="Weight in kg" required>
									</div>
									<div class="form-group">
										<input type="number" step="0.01" min="0.50" max="2.50" name="height" id="height" tabindex="2" class="form-control" placeholder="Height in meters" required>
									</div>
									<div class="form-group">
										<input type="number" step="1" min="10" max="80" name="age" id="age" tabindex="2" class="form-control" placeholder="Age in years" required>
									</div>
									<div class="form-group">
										<select class="form-control" name="RG" required>
											<option value="" disabled selected hidden>Gender</option>
											<option value="M">Male</option>
											<option value="F">Female</option>
										</select>
									</div>
									<div class="form-group">
										<select class="form-control" name="RE" required>
											<option value="" disabled selected hidden>Exercise</option>
											<option value="1">Sedentary</option>
											<option value="2">Lightly active</option>
											<option value="3">Moderately active</option>
											<option value="4">Very active</option>
											<option value="5">Extremely active</option>
										</select>
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