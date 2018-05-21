<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User Profile</title>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link href="Style.css" rel="stylesheet" id="custom-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
</head>
<body>
	<div id="background">
	    <img src="..//Images/background.png" class="stretch" alt="" />
	</div>
	<div class="container">
		<div class="row">
	    	<div class="col-md-7 ">
				<div class="panel panel-default">
	  				<div class="panel-heading">  <h4 >BMI Profile for Username</h4></div>
	  					<div class="panel-body">
	       					<div class="box box-info">
								<div class="box-body">
	                     			<div class="col-sm-6">
	                     				<div  align="center"> <img alt="User Pic" src="https://x1.xingassets.com/assets/frontend_minified/img/users/nobody_m.original.jpg" id="profile-image1" class="img-circle img-responsive"> 
	                						<input id="profile-image-upload" class="hidden" type="file">
											<div style="color:#999;" ></div>
	                						<!--Upload Image Js And Css--> 
	                						
	                						   
	                     				</div>
	                     				<br>
		       						<!-- /input-group -->
	            					</div>
	            					<div class="col-sm-6">
	            						<h4 style="color:#00b1b1;">Role</h4></span>
	              						<span><p>timestamp</p></span>            
	            					</div>
	            					<div class="clearfix"></div>
	            					<hr style="margin:5px 0 5px 0;">	
									<div class="col-sm-5 col-xs-6 tital " >Weight:</div><div class="col-sm-7">0.0</div>
									  <div class="clearfix"></div>
									<div class="bot-border"></div>	
									<div class="col-sm-5 col-xs-6 tital " >Height:</div><div class="col-sm-7">0.0</div>
									  <div class="clearfix"></div>
									<div class="bot-border"></div>	
									<div class="col-sm-5 col-xs-6 tital " >Age:</div><div class="col-sm-7">23</div>
									  <div class="clearfix"></div>
									<div class="bot-border"></div>	
									<div class="col-sm-5 col-xs-6 tital " >Gender:</div><div class="col-sm-7">female</div>
									  <div class="clearfix"></div>
									<div class="bot-border"></div>	
									<div class="col-sm-5 col-xs-6 tital " >EMR:</div><div class="col-sm-7">0.0</div>
									  <div class="clearfix"></div>
									<div class="bot-border"></div>	
									<div class="col-sm-5 col-xs-6 tital " >Exercise:</div><div class="col-sm-7">0.0</div>
									  <div class="clearfix"></div>
									<div class="bot-border"></div>	
									<div class="col-sm-5 col-xs-6 tital " >BMI:</div><div class="col-sm-7">text</div>
									 <div class="clearfix"></div>
									<div class="bot-border"></div>	
									<div class="col-sm-5 col-xs-6 tital " >Classification:</div><div class="col-sm-7">intense</div>
						       	<!-- /.box-body -->
						        </div>
					        <!-- /.box -->
					        </div>	            
	    				</div> 
    			</div>
			</div>  
    		<script>
            	$(function() {
    			$('#profile-image1').on('click', function() {
        			$('#profile-image-upload').click();
    				});
				});       
            </script>  
	   	</div>
	</div>
	
</body>
</html>