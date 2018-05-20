<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>All users</title>
<meta charset="utf-8">
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" type="text/css" href="Style.css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>

<!-- <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<scrip src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script> -->
</head>
<body>
	<link rel='stylesheet prefetch' href='http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css'>
	<br>
	<div class="container text-left">
		<table>
			<tr>

				<td style="padding-bottom: 5px"><a href="control-panel_menu.jsp" class="btn btn-primary" role="button"><i class="glyphicon glyphicon-arrow-left"></i>&nbsp;Go back</a></td>
				<br>
			</tr>
			<tr>
				<td style="padding-right: 5px"><a href="#" class="btn btn-success" role="button"><i class="fa fa-graduation-cap"></i>&nbsp;Assign/Unassign an admin</a></td>
				<td style="padding-right: 5px"><a href="#" class="btn btn-warning" role="button"><i class="glyphicon glyphicon-ban-circle"></i>&nbsp;Ban user</a></td>
				<td><a href="#" class="btn btn-danger" role="button"><i class="fa fa-remove"></i>&nbsp;Delete user</a></td>
			</tr>
		</table>
	</div>
	<br>

	<div class="container text-left">

		<div class="mail-option">
			<div class="chk-all">
				<input type="checkbox" onClick="toggle(this)" class="mail-checkbox mail-group-checkbox">
				<div class="btn-group">
					<a href="#" class="btn mini all">&nbsp;Select All</a>
				</div>
			</div>
		</div>
		<br>
		<table class="table">
			<thead class="thead-dark">
				<tr>
					<th scope="col">&nbsp;</th>
					<th scope="col">#</th>
					<th scope="col">Username</th>
					<th scope="col">Role</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td scope="row"><input type="checkbox" name="foo" value="bar1"></td>
					<td>1</td>
					<td>user1</td>
					<td>Admin</td>
				</tr>
				<tr>
					<td scope="row"><input type="checkbox" name="foo" value="bar1"></td>
					<td>2</td>
					<td>user2</td>
					<td>Standard user</td>
				</tr>
			</tbody>
		</table>

	</div>
	<script src='cp_menu_users.js'></script>
</body>
</html>