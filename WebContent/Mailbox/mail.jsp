<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
	<%@ page import="pr2.loseweight.utils.*"%>
	<%@ page import="java.util.List, java.util.ArrayList" %>
	<%@ page import="pr2.loseweight.dbtables.*" %>
	<%@ page import="java.sql.Timestamp" %>

<%!
public static String trimMessage(String myMessage){
	final int limit = 20;
	String newMessage;
	if (!myMessage.contains("<br>")){
		if (myMessage.length() <= limit)
			return myMessage;
		else
			return myMessage.substring(0,limit) + "...";
	}else{
		int brFoundOn = myMessage.indexOf("<br>");
		if (brFoundOn > limit){
			return myMessage.substring(0,limit) + "...";
		}else{
			return myMessage.substring(0, brFoundOn) + "...";
		}
	}
}
%>

<jsp:useBean id="receiver" class="pr2.loseweight.dbtables.User" scope="request" />
<jsp:useBean id="messageToBeSent" class = "pr2.loseweight.dbtables.PrivateMessage" scope="request"/>

<%
session.setAttribute("loggedUser", "user1");
%>

<jsp:useBean id="loggedUser" class="pr2.loseweight.dbtables.User" scope="request" />
<%
loggedUser = DBUtils.getUserByUsername(session.getAttribute("loggedUser").toString());
if ((request.getParameter("inputTo") != null) && (request.getParameter("inputBody") != null)){
	try{
	receiver = DBUtils.getUserByUsername(request.getParameter("inputTo").toString());
	messageToBeSent.setSender(loggedUser);
	messageToBeSent.setReceiver(receiver);
	messageToBeSent.setMessageData(request.getParameter("inputBody").toString());
	DBUtils.composeNewPrivateMessage(messageToBeSent.getSender(), messageToBeSent.getReceiver(), messageToBeSent.getMessageData());
	}catch(Exception e){
		e.printStackTrace();
	}
}
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src='coding.js'></script>
<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" type="text/css" href="Style.css">
<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Mailbox</title>
</head>
<body>
	<div class="container">
		<link rel='stylesheet prefetch'
			href='http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css'>
		<div class="mail-box">
			<aside class="sm-side">
			<div class="user-head">
				<a class="inbox-avatar" href="javascript:;"> <img width="64"
					height="60"
					src="http://bootsnipp.com/img/avatars/ebeb306fd7ec11ab68cbcaa34282158bd80361a7.jpg">
				</a>
				<div class="user-name">
					<h5><%=loggedUser.getUsername()%></h5>
				</div>
			</div>
			<div class="inbox-body">
				<a href="#">Go back</a>
			</div>

			<div class="inbox-body">
				<a href="#newMessage" id="NM" data-toggle="modal" title="Compose"
					class="btn btn-compose"> <i class="fa fa-edit"></i>New Message
				</a>
			</div>

			<ul class="inbox-nav inbox-divider">
				<li><a href="#inbox" id="IM"><i class="fa fa-inbox"></i>
				<% List<PrivateMessage> receivedMessages = DBUtils.displayIncomingMessages(loggedUser);
				int countUnread = 0;
				for (PrivateMessage myMessage : receivedMessages){
					if (myMessage.getIsRead() == 0){
						countUnread++;
					}
				}
				%>	Incoming Messages <span class="label label-danger pull-right"><%=countUnread %></span></a> 
				</li>
				<li><a href="#sent" id="SM"><i class="fa fa-external-link"></i>
						Sent Message</a></li>
				<li><a href="#" onClick="download()"><i
						class="glyphicon glyphicon-save"></i> Download all messages</a></li>
			</ul>
			</aside>



			<aside class="lg-side">
			<div class="inbox-head">
				<h3>Mailbox</h3>
				<%List<User> userList = (ArrayList)DBUserUtils.retrieveAllUsers();%>
				<form action="#" class="pull-right position">
					<div class="input-append">
						<input type="text" class="sr-input" id="search" onkeyup="findUser(<%=userList %>)"
							placeholder="Search Mail by Username">
						<button class="btn sr-btn" type="button">
							<i class="fa fa-search"></i>
						</button>
					</div>
				</form>
			</div>
			<!--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-->
			<div class="inbox-body inbox-incoming">
				<div class="mail-option">
					<div class="chk-all">
						<input type="checkbox" id="checkAll"
							class="mail-checkbox mail-group-checkbox">
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
						<a data-original-title="Refresh" data-placement="top"
							data-toggle="dropdown" href="mail.jsp" class="btn mini tooltips"> <i
							class=" fa fa-refresh"></i>
						</a>
					</div>

					<div class="btn-group hidden-phone">
						<a data-toggle="dropdown" href="#" class="btn mini blue"
							aria-expanded="false"> <i class="fa fa-trash-o"></i> Delete
							incoming messages
						</a>
					</div>

					<!-- <ul class="unstyled inbox-pagination">
                                 <li><span>1-50 of 234</span></li>
                                 <li>
                                     <a class="np-btn" href="#"><i class="fa fa-angle-left  pagination-left"></i></a>
                                 </li>
                                 <li>
                                     <a class="np-btn" href="#"><i class="fa fa-angle-right pagination-right"></i></a>
                                 </li>
                             </ul> -->
				</div>

				<table class="table table-inbox table-hover">
					
					<tbody>
					<tr class="readInb" style="font-weight:bold;background-color:#009999;color:white">
					<td></td>
					<td>ID</td>
					<td>USERNAME</td>
					<td>MESSAGE</td>
					<td class="view-message  text-right">DATE & TIME</td>
					</tr>
						<% 
						PrivateMessage myMessage;
						for (int i=0;i<receivedMessages.size();i++){
							myMessage = receivedMessages.get(i);
							String user = myMessage.getSender().getUsername();
							String message = myMessage.getMessageData();
							Timestamp date = myMessage.getDateSubmission();
							if (myMessage.getIsRead() == 0){%>
							<tr class="unread">
							<td class="inbox-small-cells"><input type="checkbox" class="mail-checkbox mail-inbox"></td>
								<td class="view-message  dont-show" onclick="openInboxMessage('<%=user %>','<%=message%>','<%=date %>')"><%=myMessage.getPrivateMessageID()%></td>
								<td class="view-message  dont-show" onclick="openInboxMessage('<%=user %>','<%=message %>','<%=date %>')"><%=user%></td>
								<td class="view-message messageStyle" onclick="openInboxMessage('<%=user %>','<%=message %>','<%=date %>')"><%=trimMessage(message) %></td>
								<td class="view-message  text-right" onclick="openInboxMessage('<%=user %>','<%=message %>','<%=date %>')"><%=date%></td>
						</tr><%
							}else{
								%>
								<tr class="readInb" onclick="openInboxMessage('<%=user %>','<%=message %>','<%=date %>')">
							<td class="inbox-small-cells"><input type="checkbox"
								class="mail-checkbox mail-inbox"></td>
							<td class="view-message  dont-show" onclick="openInboxMessage('<%=user %>','<%=message %>','<%=date %>')"><%=myMessage.getPrivateMessageID()%></td>
							<td class="view-message  dont-show" onclick="openInboxMessage('<%=user %>','<%=message %>','<%=date %>')"><%=user %></td>
							<td class="view-message messageStyle" onclick="openInboxMessage('<%=user %>','<%=message %>','<%=date %>')"><%=trimMessage(message) %></td>
							<td class="view-message  text-right" onclick="openInboxMessage('<%=user %>','<%=message %>','<%=date %>')"><%=date %></td>
						</tr><%
							}
						}
						%>

					</tbody>
				</table>
			</div>

			<!--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-->
			<div class="inbox-body inbox-sent">
				<div class="mail-option">
					<div class="chk-all">
						<input type="checkbox" id="checkAll_Sent"
							class="mail-checkbox mail-group-checkbox">
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
						<a href="#" class="btn mini blue" aria-expanded="false"> <i
							class="fa fa-trash-o"></i> Delete sent messages
						</a>
					</div>

					<!-- <ul class="unstyled inbox-pagination">
                                 <li><span>1-50 of 234</span></li>
                                 <li>
                                     <a class="np-btn" href="#"><i class="fa fa-angle-left  pagination-left"></i></a>
                                 </li>
                                 <li>
                                     <a class="np-btn" href="#"><i class="fa fa-angle-right pagination-right"></i></a>
                                 </li>
                             </ul> -->
				</div>
				<table class="table table-inbox table-hover">
					<tbody>
					<tr class="readInb" style="font-weight:bold;background-color:#009999;color:white">
					<td></td>
					<td>ID</td>
					<td>USERNAME</td>
					<td>MESSAGE</td>
					<td class="view-message  text-right">DATE & TIME</td>
					</tr>
						<% List<PrivateMessage> sentMessages = DBUtils.displaySentMessages(loggedUser);
						for (int i=0;i<sentMessages.size();i++){
							myMessage = sentMessages.get(i);
							String user = myMessage.getReceiver().getUsername();
							String message = myMessage.getMessageData();
							Timestamp date = myMessage.getDateSubmission();%>
							<tr class="readSent" onclick="openSentMessage('<%=user %>','<%=message %>','<%=date %>')">
							<td class="inbox-small-cells"><input type="checkbox"
								class="mail-checkbox mail-sent"></td>
							<td class="view-message 1 dont-show"><%=myMessage.getPrivateMessageID()%></td>
							<td class="view-message 1 dont-show"><%=user %></td>
							<td class="view-message 1 messageStyle"><%=trimMessage(message) %></td>
							<td class="view-message 1 text-right"><%=date %></td>
						</tr><%
						}
						%>

					</tbody>
				</table>
			</div>
<!--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-->
			<div class="inbox-body inbox-compose">
				<div class="mail-option">


				</div>

				<div>
					<form role="form" class="form-horizontal" action="mail.jsp" method="get">
					<div>
						<button type="submit" class="btn btn-primary">Send message&nbsp;<i class="fa fa-arrow-circle-right fa-lg"></i></button>
					</div><br>
						<div class="form-group">
							<label class="col-sm-2" for="inputTo">To</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="inputTo" id="inputTo"
									placeholder="type receiver's username">
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
				<div>
					<form role="form" class="form-horizontal" action="mail.jsp" method="get">
					<div class="btn-group hidden-phone">
						<a href="#" class="btn mini blue" aria-expanded="false"> <i
							class="fa fa-trash-o"></i> Delete incoming message
						</a>
						</div>
					</div><br>
						<div class="form-group">
							<label class="col-sm-2" for="inputTo">From</label>
							<div class="col-sm-10">
								<input id="fromView" type="text" style="background: white;cursor: pointer" class="form-control" value="" readonly>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2" for="inputTo">Date</label>
							<div class="col-sm-10">
								<input id="dateView" type="text" style="background: white;cursor: pointer" class="form-control" value="" readonly>
							</div>
						</div>
					
						<div class="form-group">
							<label class="col-sm-12" for="messageView">Message</label>
							<div class="col-sm-12">
								<textarea id="messageView" style="background: white;cursor: pointer;white-space: pre-line" class="form-control" name="messageView" rows="12" readonly></textarea>
							</div>
						</div>
					</form>
				</div>

			</div>
			
	
				<!--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-->
			<div class="inbox-body inbox-readSentMessage">
				<div class="mail-option">
				<div>
					<form role="form" class="form-horizontal" action="mail.jsp" method="get">
					<div class="btn-group hidden-phone">
						<a href="#" class="btn mini blue" aria-expanded="false"> <i
							class="fa fa-trash-o"></i> Delete sent message
						</a>
						</div>
					</div><br>
						<div class="form-group">
							<label class="col-sm-2" for="inputTo">To</label>
							<div class="col-sm-10">
								<input id="toView" type="text" style="background: white;cursor: pointer" class="form-control" value="" readonly>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2" for="inputTo">Date</label>
							<div class="col-sm-10">
								<input id="dateView1" type="text" style="background: white;cursor: pointer" class="form-control" value="" readonly>
							</div>
						</div>
					
						<div class="form-group">
							<label class="col-sm-12" for="inputBody">Message</label>
							<div class="col-sm-12">
								<textarea id="messageView1" style="background: white;cursor: pointer;white-space: pre-line" class="form-control" name="inputBody" rows="12" readonly></textarea>
							</div>
						</div>
					</form>
				</div>

			</div>
			
		</aside>
		</div>
	</div>
<script src='coding.js'></script>
</body>
</html>
