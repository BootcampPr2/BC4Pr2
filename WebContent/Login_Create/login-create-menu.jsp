<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    <%@ page import = "java.util.ArrayList" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
	<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
	<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="Style.css" rel="stylesheet" type="text/css">
	<title>Home</title>
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
									<form id="login-form" action="login-ckeck.jsp" method="post" role="form" style="display: block;">
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
									<% 	
										ArrayList <String> list = new ArrayList();
										list.add("user1");
										list.add("maria");
										for (int i=0;i<list.size();i++){
											if (request.getParameter("username0")==list.get(i)){
												
											}
										}
									%>
									<form id="register-form" action=""https://phpoll.com/login/process" method="post" role="form" style="display: none;">
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
														<h4>Password should contain:</h4>
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
											<input type="number" step="any" min="20" max="600" name="weight" id="weight" tabindex="2" class="form-control" placeholder="Weight in kg" required>
										</div>
										<div class="form-group">
											<input type="number" step="any" min="0.50" max="2.50" name="height" id="height" tabindex="2" class="form-control" placeholder="Height in meters" required>
										</div>
										<div class="form-group">
											<input type="number" step="1" min="10" max="80" name="age" id="age" tabindex="2" class="form-control" placeholder="Age in years" required>
										</div>
										<div class="form-group">
											<select class="form-control" required>
													<option value="" disabled selected hidden>Gender</option>
													<option value="male">Male</option>
													<option value="female">Female</option>
											</select>
										</div>
										<div class="form-group">
											<select class="form-control" required>
												<option value="" disabled selected hidden>Exercise</option>
												<option value="Sedentary">Sedentary</option>
											 	<option value="Lightly">Lightly active</option>
											 	<option value="Moderately">Moderately active</option>
												<option value="Very">Very active</option>
												<option value="Extremely">Extremely active</option>
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