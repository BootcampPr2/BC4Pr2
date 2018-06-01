<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link href="Style.css" rel="stylesheet" id="custom-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<title>Profile Update</title>
</head>
<body>
	<div id="background">
	    <img src="..//Images/background.png" class="stretch" alt="" />
	</div>
	<div class="container">
		<div class="row">
	    	<div class="col-md-5 ">
				<div class="well">
				   <ul class="nav nav-tabs">
				     <li class="active"><a href="#home" data-toggle="tab">Profile</a></li>
				     <li><a href="#profile" data-toggle="tab">Password</a></li>
				   </ul>
				   <div id="myTabContent" class="tab-content">
				     <div class="tab-pane active in" id="home">
				       <form id="tab">
				       
					       <table class="table">
						    <tbody>
						      <tr>
						        <td><label for="weight">Weight:</label></td>
						        <td><input id="weight" type="text" value="63" class="form-control"></td>
						      </tr>
						      <tr>
						        <td><label for="height">Height:</label></td>
						        <td><input id="height" type="text" value="1.63" class="form-control"></td>
						      </tr>
						      <tr>
						        <td><label for="age">Age:</label></td>
						        <td><input type="text" value="32" class="form-control"></td>
						      </tr>
						      <tr>
						        <td><label for="gender">Gender:</label></td>
						        <td><input id="gender" type="text" value="female" class="form-control"></td>
						      </tr>
						      <tr>
						        <td><label for="emr">EMR:</label></td>
						        <td><input id="emr" type="text" value="0.0" class="form-control"></td>
						      </tr>
						      <tr>
						        <td><label for="exercise">Exercise:</label></td>
						        <td><input id="exercise" type="text" value="Intense" class="form-control"></td>
						      </tr>
						      <tr>
						        <td><label for="bmi">BMI:</label></td>
						        <td><input id="bmi" type="text" value="0.0" class="form-control"></td>
						      </tr>
						      <tr>
						        <td><label for="classification">Classification:</label></td>
						        <td><input id="classification" type="text" value="fgs" class="form-control"></td>
						      </tr>
						    </tbody>
						  </table>      	
				            
				          </div>  
				          <div>
				        	 <input type="submit" class="btn btn-primary mb-2" value="Update">
				          </div>
				        </form>
				      </div>
				      <div class="tab-pane fade" id="profile">
				    	<form id="tab2">
				    		<div class="form-group">
					          	<label for="password">New Password:</label>
					            <input type="password" value="jsmith" class="form-control">
				          	</div> 
				        	<div>
				        	    <input type="submit" class="btn btn-primary mb-2" value="Update">
				        	</div>
				    	</form>
				      </div>
				  </div>
	  			</div><!-- end of class well -->
	    	</div><!-- end of class col-md-7 -->
		</div><!-- end of class row -->  
	</div><!-- end of class container --> 		  
</body>
</html>