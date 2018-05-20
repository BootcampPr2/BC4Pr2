<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="Style.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Control Panel</title>
</head>
<body>
	<div id="background">
		<img src="../Login_Create/background.png" class="stretch" alt="" />
	</div>
	<link rel='stylesheet prefetch' href='http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css'>
	<div class="container text-left">
		<table id="goBack">
			<tr>
				<td style="padding-bottom: 5px"><a href="control-panel_menu.jsp" class="btn btn-primary" role="button"><i class="glyphicon glyphicon-arrow-left"></i>&nbsp;Go back</a></td>
			</tr>
		</table>
		<div id="welcome_tag">
			<h3>
				WELCOME TO THE CONTROL PANEL MENU
				<h3>
					<h4 style="margin-top: -10px">
						This is a page regarding all users and the modifications you make to them. Have fun!
						<h4>
		</div>
		<div id="control-panel_menu">
			<h4>Users</h4>
			<a href="control-panel_menu_users.jsp" class="btn btn-info" role="button"><i class="fa fa-group"></i> View All</a>
			<h4>Messages</h4>
			<a href="control-panel_menu_messages.jsp" class="btn btn-info" role="button"><i class="fa fa-comments"></i> View All</a>
		</div>
	</div>
</body>
</html>