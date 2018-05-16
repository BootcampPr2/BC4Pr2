<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
	<%@ page import="pr2.loseweight.utils.*"%>
	<%@ page import="java.util.List" %>
	<%@ page import="pr2.loseweight.dbtables.*" %>
<jsp:useBean id="loggedUser" class="pr2.loseweight.dbtables.User" scope="request" />
<jsp:useBean id="receiver" class="pr2.loseweight.dbtables.User" scope="request" />
<jsp:useBean id="messageToBeSent" class = "pr2.loseweight.dbtables.PrivateMessage" scope="request"/>

<%
session.setAttribute("loggedUser", "admin");
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
						Incoming Messages <span class="label label-danger pull-right">2</span></a>
				</li>
				<li><a href="#sent" id="SM"><i class="fa fa-external-link"></i>
						Sent Message</a></li>
				<li><a href="#" onClick="download()"><i
						class="glyphicon glyphicon-save"></i> Download all messages</a></li>
			</ul>
			</aside>



			<aside class="lg-side">
			<div class="inbox-head">
				<h3>Inbox</h3>
				<form action="#" class="pull-right position">
					<div class="input-append">
						<input type="text" class="sr-input"
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
							data-toggle="dropdown" href="#" class="btn mini tooltips"> <i
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
						<% List<PrivateMessage> receivedMessages = DBUtils.displayIncomingMessages(loggedUser);
						for (PrivateMessage myMessage : receivedMessages){
							if (myMessage.getIsRead() == 1){%>
							<tr class="unread">
							<td class="inbox-small-cells"><input type="checkbox"
								class="mail-checkbox mail-inbox"></td>
							<td class="view-message  dont-show"><%=myMessage.getSender().getUsername()%></td>
							<td class="view-message" style="white-space: pre-line"><%=myMessage.getMessageData()%></td>
							<td class="view-message  text-right"><%=myMessage.getDateSubmission()%></td>
						</tr><%
							}else{
								%>
								<tr class="">
							<td class="inbox-small-cells"><input type="checkbox"
								class="mail-checkbox mail-inbox"></td>
							<td class="view-message  dont-show"><%=myMessage.getSender().getUsername()%></td>
							<td class="view-message" style="white-space: pre-line"><%=myMessage.getMessageData()%></td>
							<td class="view-message  text-right"><%=myMessage.getDateSubmission()%></td>
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

					<div class="btn-group">
						<a data-original-title="Refresh" data-placement="top"
							data-toggle="dropdown" href="#" class="btn mini tooltips"> <i
							class=" fa fa-refresh"></i>
						</a>
					</div>

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
						<% List<PrivateMessage> sentMessages = DBUtils.displaySentMessages(loggedUser);
						for (PrivateMessage myMessage : sentMessages){
							%>
							<tr class="">
							<td class="inbox-small-cells"><input type="checkbox"
								class="mail-checkbox mail-sent"></td>
							<td class="view-message  dont-show"><%=myMessage.getReceiver().getUsername()%></td>
							<td class="view-message" style="white-space: pre-line"><a href ="#"><%=myMessage.getMessageData()%></a></td>
							<td class="view-message  text-right"><%=myMessage.getDateSubmission()%></td>
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
								<textarea class="form-control" name="inputBody" id="inputBody" rows="10"></textarea>
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
