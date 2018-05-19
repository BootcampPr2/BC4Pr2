<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="pr2.loseweight.utils.*"%>
<%@ page import="java.util.List, java.util.ArrayList"%>
<%@ page import="pr2.loseweight.dbtables.*"%>
<%@ page import="java.sql.Timestamp"%>

<jsp:useBean id="loggedUser" class="pr2.loseweight.dbtables.User"/>
<%
session.setAttribute("loggedUser", "admin");
loggedUser = DBUtils.getUserByUsername(session.getAttribute("loggedUser").toString());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script src='coding.js'></script>
<title>Insert title here</title>
</head>
<body>

<% List<PrivateMessage> receivedMessages = DBUtils.displayIncomingMessages(loggedUser);  %>
<table class="table table-inbox table-hover">

							<tbody>
								<tr class="readInb"
									style="font-weight: bold; background-color: #00A8B3; color: white">
									<td></td>
									<td>USERNAME</td>
									<td>MESSAGE</td>
									<td class="view-message text-right">DATE & TIME</td>
								</tr>
								<%
									PrivateMessage myMessage;
									for (int i = 0; i < receivedMessages.size(); i++) {
										myMessage = receivedMessages.get(i);
										String user = myMessage.getSender().getUsername();
										String message = myMessage.getMessageData();
										Timestamp date = myMessage.getDateSubmission();
										int id = myMessage.getPrivateMessageID();
										if (myMessage.getIsRead() == 0) {
								%>
								<tr class="unread" id="<%=id%>"
									onclick="openInboxMessage('<%=user%>','<%=message%>','<%=date%>', <%=id%>)">
									<td class="inbox-small-cells"><input type="checkbox"
										class="mail-checkbox mail-inbox" name="CI" value="<%=id%>"></td>
									<td class="view-message  dont-show"><%=user%></td>
									<td class="view-message messageStyle"><%=message%></td>
									<td class="view-message  text-right"><%=date%></td>
								</tr>
								<%
									} else {
								%>
								<tr class="readInb"
									onclick="openInboxMessage('<%=user%>','<%=message%>','<%=date%>', <%=id%>)">
									<td class="inbox-small-cells"><input type="checkbox"
										class="mail-checkbox mail-inbox" name="CI" value="<%=id%>"></td>
									<td class="view-message  dont-show"><%=user%></td>
									<td class="view-message messageStyle"><%=message%></td>
									<td class="view-message  text-right"><%=date%></td>
								</tr>
								<%
									}
									}
								%>

							</tbody>
						</table>
</body>
</html>