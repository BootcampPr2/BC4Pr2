<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page import="pr2.loseweight.utils.*"%>
<%@ page import="java.util.List, java.util.ArrayList"%>
<%@ page import="pr2.loseweight.dbtables.*"%>
<%@ page import="java.sql.Timestamp"%>
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
		DeleteFromDB.deleteSelectedMessages(checkedIds);
	}
%>
<jsp:useBean id="messageToBeSent" class="pr2.loseweight.dbtables.PrivateMessage" scope="request" />
<jsp:useBean id="loggedUser" class="pr2.loseweight.dbtables.User" scope="request" />
<%
	session.setAttribute("loggedUserUsername", "admin"); //AFAIREITAI
	loggedUser = DBUserUtils.getUserByUsername(session.getAttribute("loggedUserUsername").toString());
%>
<title>All messages</title>
<meta charset="utf-8">
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" type="text/css" href="Style.css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>

<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<scrip src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"> </script> <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
</head>
<body>
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
				<thead class="thead-dark">
					<tr>
						<th scope="col">&nbsp;</th>
						<th scope="col">From</th>
						<th scope="col">To</th>
						<th scope="col">Message</th>
						<th scope="col">Date</th>
					</tr>
				</thead>
				<tbody>
					<%
						List<PrivateMessage> allMessages = DBAdminUtils.displayAllPrivateMessages();
						PrivateMessage myMessage;
						for (int i = 0; i < allMessages.size(); i++) {
							myMessage = allMessages.get(i);
							String sender = myMessage.getSender().getUsername();
							String receiver = myMessage.getReceiver().getUsername();
							String message = myMessage.getMessageData();
							Timestamp date = myMessage.getDateSubmission();
							int id = myMessage.getPrivateMessageID();
					%>
					<tr style="cursor: pointer">
						<td scope="row"><input class="selectMessages" type="checkbox" name="CA" value="<%=id%>"></td>
						<td><%=sender%></td>
						<td><%=receiver%></td>
						<td class="CellWithComment"><%=trimMessage(message)%> <span class="CellComment"><%=message%></span></td>
						<td><%=date%></td>
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