<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%@ page import="pr2.loseweight.utils.*"%>
<%@ page import="java.util.List, java.util.ArrayList"%>
<%@ page import="pr2.loseweight.dbtables.*"%>
<%@ page import="java.sql.Timestamp"%>
<%@ page import="org.hibernate.SessionFactory"%>
<%@ page import="java.sql.Timestamp, java.text.SimpleDateFormat" %>

<%
	HttpSession httpSession = request.getSession();
	User loggedUser = DBUserUtils.getUserByUsername((SessionFactory)httpSession.getAttribute("sessionFactory"), httpSession.getAttribute("loggedUserUsername").toString());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%!public static String trimMessage(String myMessage) {
		final int limit = 60;
		myMessage = myMessage.replace("&nbsp;", " ");
		String newMessage;
		if (!myMessage.contains("<br>")) {
			if (myMessage.length() <= limit)
				return myMessage;
			else
				return myMessage.substring(0, limit) + "...";
		} else {
			int brFoundOn = myMessage.indexOf("<br>");
			if (brFoundOn > limit) {
				return myMessage.substring(0, limit) + "...";
			} else {
				return myMessage.substring(0, brFoundOn) + "...";
			}
		}
	}%>
<%
	if (request.getParameter("CA") != null) {
		String[] checkedIds = request.getParameterValues("CA");
		DeleteFromDB.deleteSelectedMessages((SessionFactory)httpSession.getAttribute("sessionFactory"), checkedIds);
	}
%>
<title>All messages</title>
<meta charset="utf-8">
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" type="text/css" href="Style.css">
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<scrip src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"> 
</script> <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
</head>
<body>

	<div id="background">
		<img src="../Images/background.png" class="stretch" alt="" />
	</div>

	<link rel='stylesheet prefetch' href='http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css'>
	<br>
	<form action="control-panel_menu_messages.jsp" method="post">
		<div class="container text-left">
			<table>
				<tr>
					<td style="padding-bottom: 5px"><a href="control-panel_menu.jsp" class="btn btn-primary" role="button"><i class="glyphicon glyphicon-arrow-left"></i>&nbsp;Go back</a></td>
				</tr>
			</table>

			<div>
				<button type=submit class="btn btn-danger">
					<i class="fa fa-trash-o"></i> Delete
				</button>
			</div>

		</div>
		<br>

		<div class="container text-left">

			<div class="mail-option">
				<div class="chk-all">
					<input type="checkbox" id="checkAll" class="mail-checkbox mail-group-checkbox">
					<div class="btn-group">
						<a href="#" class="btn mini all">&nbsp;Select All</a>
					</div>
				</div>
			</div>
			<br>
			<table class="table">
				<thead class="thead-dark" style="background: #4B4446;color: white">
					<tr>
						<th scope="col">&nbsp;</th>
						<th scope="col">From</th>
						<th scope="col">To</th>
						<th scope="col">Message</th>
						<th scope="col">Date</th>
					</tr>
				</thead>
				<tbody style="background: white">
					<%
						List<PrivateMessage> allMessages = DBAdminUtils.displayAllPrivateMessages((SessionFactory)httpSession.getAttribute("sessionFactory"));
						PrivateMessage myMessage;
						SimpleDateFormat myFormat = new SimpleDateFormat ("dd/MM/yyyy HH:mm");
						for (int i = 0; i < allMessages.size(); i++) {
							myMessage = allMessages.get(i);
							String sender = myMessage.getSender().getUsername();
							String receiver = myMessage.getReceiver().getUsername();
							String message = myMessage.getMessageData();
							Timestamp date = myMessage.getDateSubmission();
							String formattedDate = myFormat.format(date);
							int id = myMessage.getPrivateMessageID();
					%>
					<tr style="cursor: pointer">
						<td scope="row"><input class="selectMessages" type="checkbox" name="CA" value="<%=id%>"></td>
						<td><%=sender%></td>
						<td><%=receiver%></td>
						<td class="CellWithComment"><%=trimMessage(message)%> <span class="CellComment"><%=message%></span></td>
						<td><%=formattedDate%></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>

		</div>
	</form>
	<script src='cp_menu_users.js'></script>
</body>
</html>