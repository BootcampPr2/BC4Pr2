<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="pr2.loseweight.utils.*"%>
<%@ page import="java.util.List, java.util.ArrayList"%>
<%@ page import="pr2.loseweight.dbtables.*"%>
<%@ page import="java.sql.Timestamp"%>
<%@ page import="org.hibernate.SessionFactory"%>
<%@ page import="java.sql.Timestamp, java.text.SimpleDateFormat" %>

<%
HttpSession httpSession = request.getSession();
User loggedUser = DBUserUtils.getUserByUsername((SessionFactory)httpSession.getAttribute("sessionFactory"), session.getAttribute("loggedUserUsername").toString()); 
%>
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

<table class="table table-inbox table-hover">
	<tbody>
		<tr class="readInb"
			style="font-weight: bold; background-color: #00A8B3; color: white">
			<td></td>
			<td>SENDER</td>
			<td>MESSAGE</td>
			<td class="view-message text-right">DATE & TIME</td>
		</tr>
		<%
			List<PrivateMessage> receivedMessages = DBUtils.displayIncomingMessages((SessionFactory)httpSession.getAttribute("sessionFactory"), loggedUser);			
			PrivateMessage myMessage;
			SimpleDateFormat myFormat = new SimpleDateFormat ("dd/MM/yyyy HH:mm");
			for (int i = 0; i < receivedMessages.size(); i++) {
				myMessage = receivedMessages.get(i);
				String user = myMessage.getSender().getUsername();
				String message = myMessage.getMessageData();
				String messageReplaceQuotes = message.replace("&#39;","\\'");
				Timestamp date = myMessage.getDateSubmission();
				String formattedDate = myFormat.format(date);
				int id = myMessage.getPrivateMessageID();
				if (myMessage.getIsRead() == 0) {
		%>
					<tr class="unread">
		<%
				}else{
		%>
					<tr class="readInb">
		<%
				}
		%>			
						<td class="inbox-small-cells"><input type="checkbox"
							class="mail-checkbox mail-inbox" name="CI" value="<%=id%>"></td>
						<td class="view-message  dont-show"
							onclick="openInboxMessage('<%=user%>','<%=messageReplaceQuotes%>','<%=formattedDate%>', <%=id%>, <%=myMessage.getIsRead()%>)"><%=user%></td>
						<td class="view-message messageStyle"
							onclick="openInboxMessage('<%=user%>','<%=messageReplaceQuotes%>','<%=formattedDate%>', <%=id%>, <%=myMessage.getIsRead()%>)"><%=trimMessage(message)%></td>
						<td class="view-message  text-right"
							onclick="openInboxMessage('<%=user%>','<%=messageReplaceQuotes%>','<%=formattedDate%>', <%=id%>, <%=myMessage.getIsRead()%>)"><%=formattedDate%></td>
					</tr>

		<%
			}
		%>
	</tbody>
</table>
<%
System.out.println("message count: " + receivedMessages.size());
if (receivedMessages.size()==0){
	
%>
	<h3 style="text-align: center">You have received no messages yet!</h3>
<%
}
%>