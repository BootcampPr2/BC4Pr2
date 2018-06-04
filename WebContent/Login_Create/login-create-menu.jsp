<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="pr2.loseweight.utils.*"%>
<%@ page import="pr2.loseweight.dbtables.*"%>
<%@ page import="org.hibernate.SessionFactory"%>
<%
HttpSession httpSession = request.getSession();
if (httpSession.getAttribute("loggedUserUsername") != null) {
/* 	SessionFactory sessionFactory = (SessionFactory)httpSession.getAttribute("sessionFactory");
	sessionFactory.close(); */
	httpSession.invalidate();
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
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
								<a href="#login" class="active" id="login-form-link">Login</a>
							</div>
							<div class="col-xs-6">
								<a href="#register" id="register-form-link">Sign up</a>
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
												<input type="submit" name="login-submit" id="login-submit" tabindex="3" class="form-control btn btn-login" value="Log In">
											</div>
										</div>
									</div>
								</form>
<% 
String userName =  (String)request.getAttribute("username0");
if (request.getParameter("username0") == null){
	request.setAttribute("username0","");
}else{
	request.setAttribute("username0", request.getParameter("username0"));
}%>
								<form id="register-form" action="registercheck.jsp" method="post" role="form" style="display: none;">
									<input class="form-control" id="errorLog" name="errorLog" value="<%=request.getParameter("errorLog") %>" style="display:none" disabled></input>
									<div class="form-group">									
										USERNAME:
										<input type="text" name="username0" id="username0" tabindex="1" class="form-control" placeholder="Username" value= "<%=request.getAttribute("username0") %>" required>
									</div>
									<div class="form-group">
										PASSWORD:
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

									<div class="form-group">
										WEIGHT:
										<input type="number" step="0.1" min="20" max="600" name="weight" id="weight" tabindex="3" class="form-control" value= "<%= request.getParameter("weight") %>"placeholder="Weight in kg" required>
									</div>
									<div class="form-group">
										HEIGHT:
										<input type="number" step="0.01" min="0.50" max="2.50" name="height" id="height" tabindex="4" class="form-control" value= "<%= request.getParameter("height") %>"placeholder="Height in meters" required>
									</div>
									<div class="form-group">
										AGE:
										<input type="number" step="1" min="10" max="80" name="age" id="age" tabindex="5" class="form-control" value= "<%= request.getParameter("age") %>"placeholder="Age in years" required>
									</div>
									<div class="form-group">
										GENDER: <select class="form-control" name="RG" tabindex="6" required>
											<option value="" disabled selected hidden>Gender</option>
											<option value="M">Male</option>
											<option value="F">Female</option>
										</select>
									</div>
									<div class="form-group">
										EXERCISE: <select class="form-control" tabindex="7" name="RE" required>
											<option value="" disabled selected hidden>Activity level</option>
											<option value="1">Sedentary (Little or no exercise)</option>
											<option value="2">Lightly active (light exercise or sports 1-3 days per week)</option>
											<option value="3">Moderately active (moderate exercise or sports 3-5 days per week)</option>
											<option value="4">Very active (hard exercise or sports 6-7 days per week)</option>
											<option value="5">Extremely active (very hard exercise or sports and a physical job or 2x training)</option>
										</select>
									</div>
									<div class="form-group">
										<div class="row">
											<div class="col-sm-6 col-sm-offset-3">
												<input type="submit" name="register-submit" id="register-submit" tabindex="8" class="form-control btn btn-register" value="Create account">
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