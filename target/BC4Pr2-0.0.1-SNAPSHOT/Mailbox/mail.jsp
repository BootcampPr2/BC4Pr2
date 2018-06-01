<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
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
	}
%>

<jsp:useBean id="receiver" class="pr2.loseweight.dbtables.User" scope="request" />
<jsp:useBean id="messageToBeSent" class="pr2.loseweight.dbtables.PrivateMessage" scope="request" />
<jsp:useBean id="loggedUser" class="pr2.loseweight.dbtables.User" scope="request" />
<% 
	loggedUser = DBUserUtils.getUserByUsername(session.getAttribute("loggedUserUsername").toString());
	if ((request.getParameter("inputTo") != null) && (request.getParameter("inputBody") != null)) {
		try {
			receiver = DBUserUtils.getUserByUsername(request.getParameter("inputTo").toString());
			messageToBeSent.setSender(loggedUser);
			messageToBeSent.setReceiver(receiver);
			messageToBeSent.setMessageData(request.getParameter("inputBody").toString());
			DBUtils.composeNewPrivateMessage(messageToBeSent.getSender(), messageToBeSent.getReceiver(),
					messageToBeSent.getMessageData());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	if (request.getParameter("CI") != null) {
		String[] checkedIds = request.getParameterValues("CI");
		DeleteFromDB.deleteSelectedMessages(checkedIds);
	}

	if (request.getParameter("CS") != null) {
		String[] checkedIds = request.getParameterValues("CS");
		DeleteFromDB.deleteSelectedMessages(checkedIds);
	}

	if (request.getParameter("inid") != null) {
		String[] checkedIds = request.getParameterValues("inid");
		DeleteFromDB.deleteSelectedMessages(checkedIds);
	}
	if (request.getParameter("senid") != null) {
		String[] checkedIds = request.getParameterValues("senid");
		DeleteFromDB.deleteSelectedMessages(checkedIds);
	}
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" type="text/css" href="Style.css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<script  type="text/javascript" src='coding.js'></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Mailbox</title>
</head>
<body>
	<!-- <div id="background">
		<img src="../Login_Create/background.png" class="stretch" alt="" />
	</div> -->
	<div class="container">
		<link rel='stylesheet prefetch' href='http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css'>
		<div class="mail-box">
			<aside class="sm-side">
			<div class="user-head">
				<a class="inbox-avatar" href="javascript:;"> <img width="64" height="60" src="http://bootsnipp.com/img/avatars/ebeb306fd7ec11ab68cbcaa34282158bd80361a7.jpg">
				</a>
				<div class="user-name">
					<h5><%=loggedUser.getUsername()%></h5>
				</div>
			</div>
			<div class="inbox-body">
				<a href="#">Go back</a>
			</div>

			<div class="inbox-body">
				<a href="#newMessage" id="NM" data-toggle="modal" title="Compose" class="btn btn-compose"> <i class="fa fa-edit"></i>New Message
				</a>
			</div>
			<%
				// get all received messages
				List<PrivateMessage> receivedMessages = DBUtils.displayIncomingMessages(loggedUser);
				int countUnread = 0;
				for (PrivateMessage myMessage : receivedMessages) {
					if (myMessage.getIsRead() == 0) {
						countUnread++;
					}
				}
			%>
			<ul class="inbox-nav inbox-divider">
				<li><a href="#inbox" id="IM" onclick="getIncoming()"><i class="fa fa-inbox"></i>Incoming Messages <span id="counter" class="label label-danger pull-right"><%=countUnread%></span></a></li>
				<li><a href="#sent" id="SM" onclick="getSent()"><i class="fa fa-external-link"></i>Sent Message</a></li>
				<li style="text-align:center">
					<form method="post" action="messages.txt">
						<button type="submit" class="btn btn-link"><i class="glyphicon glyphicon-save"></i> Download all messages</button> 
						<input type="hidden" name="username" value="<%=session.getAttribute("loggedUserUsername").toString()%>" />
					</form>
				</li>
				
			</ul>
			</aside>





			<aside class="lg-side">
			<div class="inbox-head">
				<h3>Mailbox</h3>
				<%
					List<User> userList = (ArrayList) DBUserUtils.retrieveAllUsers();
				%>
				<div id="divCheckbox" style="display: none;">
					var users =
					<%
					for (int i = 0; i < userList.size(); i++) {
				%><%=userList.get(i).getUsername()%><%=i + 1 < userList.size() ? "," : ""%>
					<%
						}
					%>
				</div>
				<form action="#" class="pull-right position">
					<div class="input-append">
						<input type="text" class="sr-input" id="search" onkeyup="findUser(<%=userList%>)" placeholder="Search Mail by Username">
						<button class="btn sr-btn" type="button">
							<i class="fa fa-search"></i>
						</button>
					</div>
				</form>
			</div>
			<!--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-->
			<div class="inbox-body inbox-incoming">
				<div class="mail-option">
					<form action="mail.jsp" method="post">
						<div style="margin-bottom: 10px">
							<div class="chk-all">
								<input type="checkbox" id="checkAll" class="mail-checkbox mail-group-checkbox">
								<div class="btn-group">
									<a href="#" class="btn mini all">All</a>
								</div>
							</div>

							<script>
						$("#checkAll").click(function() {
						$(".mail-checkbox.mail-inbox").prop('checked',$(this).prop('checked'));
						});
						</script>

							<div class="btn-group">
								<a onclick="getIncoming()" data-original-title="Refresh" data-placement="top" data-toggle="dropdown" href="#" class="btn mini tooltips"> <i class=" fa fa-refresh"></i>
								</a>
							</div>

							<div class="btn-group hidden-phone">
								<button type=submit class="btn btn-danger">
									<i class="fa fa-trash-o"></i> Delete selected messages
								</button>
							</div>
						</div>
						<div id="incomingMessages"><!-- Incoming messages will appear here --></div>
					</form>
				</div>
			</div>

			<!--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-->
			<div class="inbox-body inbox-sent">
				<div class="mail-option">
					<form action="mail.jsp" method="post">
						<div style="margin-bottom: 10px">
							<div class="chk-all">
								<input type="checkbox" id="checkAll_Sent" class="mail-checkbox mail-group-checkbox">
								<div class="btn-group">
									<a href="#" class="btn mini all">All</a>
								</div>
							</div>

							<script>
						$("#checkAll_Sent").click(function() {
						$(".mail-checkbox.mail-sent").prop('checked',$(this).prop('checked'));
						});
						</script>

							<div class="btn-group hidden-phone">
								<button type="submit" class="btn btn-danger">
									<i class="fa fa-trash-o"></i> Delete selected messages
								</button>
							</div>
						</div>
						<div id="sentMessages"><!-- Sent messages will appear here --></div>
					</form>
				</div>
			</div>
			<!--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-->
			<div class="inbox-body inbox-compose">
				<div class="mail-option">
					<form role="form" class="form-horizontal" action="mail.jsp" method="post">
						<div>
							<button type="submit" class="btn btn-primary">
								Send message&nbsp;<i class="fa fa-arrow-circle-right fa-lg"></i>
							</button>
						</div>
						<br>
						<div class="form-group">
							<label class="col-sm-2" for="inputTo">To</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="inputTo" id="inputTo" placeholder="type receiver's username">
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-12" for="inputBody">Message</label>
							<div class="col-sm-12">
								<textarea class="form-control" name="inputBody" id="inputBody" rows="12"></textarea>
							</div>
						</div>
					</form>
				</div>
			</div>

			<!--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-->
			<div class="inbox-body inbox-readInboxMessage">
				<div class="mail-option">
					<form class="form-horizontal" action="mail.jsp" method="post">
						<div class="form-group">
							<div class="col-sm-10">
								<button type="submit" class="btn btn-danger">
									<i class="fa fa-trash-o"></i> Delete incoming message
								</button>
								<input id="inid" name="inid" style="visibility: hidden;" />
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2" for="inputTo">From</label>
							<div class="col-sm-10">
								<input id="fromView" type="text" class="form-control" value="" style="background: white; cursor: pointer" readonly>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2" for="inputTo">Date</label>
							<div class="col-sm-10">
								<input id="dateView" type="text" class="form-control" value="" style="background: white; cursor: pointer" readonly>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-12" for="messageView">Message</label>
							<div class="col-sm-12">
								<textarea id="messageView" value="" class="form-control" style="background: white; cursor: pointer; white-space: pre-line" rows="12" readonly></textarea>
							</div>
						</div>
					</form>
				</div>
			</div>


			<!--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-->
			<div class="inbox-body inbox-readSentMessage">
				<div class="mail-option">
					<form class="form-horizontal" action="mail.jsp" method="post">
						<div class="form-group">
							<div class="col-sm-10">
								<button type="submit" class="btn btn-danger">
									<i class="fa fa-trash-o"></i> Delete incoming message
								</button>
								<input id="senid" name="senid" style="visibility: hidden;" />
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2" for="inputTo">To</label>
							<div class="col-sm-10">
								<input id="toView" type="text" class="form-control" value="" style="background: white; cursor: pointer" readonly>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2" for="inputTo">Date</label>
							<div class="col-sm-10">
								<input id="dateView1" type="text" class="form-control" value="" style="background: white; cursor: pointer" readonly>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-12" for="inputBody">Message</label>
							<div class="col-sm-12">
								<textarea id="messageView1" class="form-control" value="" style="background: white; cursor: pointer; white-space: pre-line" rows="12" readonly></textarea>
							</div>
						</div>
					</form>
				</div>
			</div>

			</aside>
		</div>
	</div>
</body>
</html>
